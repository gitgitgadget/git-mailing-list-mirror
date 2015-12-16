From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 05/11] ref-filter: skip deref specifier in match_atom_name()
Date: Wed, 16 Dec 2015 20:59:56 +0530
Message-ID: <1450279802-29414-6-git-send-email-Karthik.188@gmail.com>
References: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 16:30:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9E1l-0001k8-D1
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 16:30:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934079AbbLPP34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 10:29:56 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34064 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933118AbbLPP3z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 10:29:55 -0500
Received: by mail-pf0-f181.google.com with SMTP id 68so13627287pfc.1
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 07:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eQwKD6+HJBksoNIOAJrTqC2GsJoe6zRpcM21UVbRoOA=;
        b=tKaGZ7t7u2imhQ6Nvap84tvCgd0LDMnGAp/ZVw/3//90jnsT4otyJWK3VooTUFo7LZ
         SgXKRb4QPIsHkZRqCn4ic/eFYbDdI2YUGXsSsKaP/Re+oX8/hJSJVxxdTBkRCax8/6bz
         f6hrKjjIazqZUeEB+pSIOkTc5i5Y1LVSAZsAsxl1oHfK+M4+Gbxr30cAwIOeDNVgHoVE
         JpoaA6IcJ6irC8kt3bIDszvtVarnZ+pq51CEx8MdNJV0KUhysRbpm/lOE9nx98yB8e8V
         RD1lSkP16G7+G8XR+28lJH5ZDrg7c48c1Luwhf9DlplZBqe8nBL7ckqhXgm3qnY/RDiY
         /jtg==
X-Received: by 10.98.42.205 with SMTP id q196mr6271628pfq.74.1450279794648;
        Wed, 16 Dec 2015 07:29:54 -0800 (PST)
Received: from ashley.localdomain ([106.51.233.145])
        by smtp.gmail.com with ESMTPSA id x12sm5620612pfi.95.2015.12.16.07.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Dec 2015 07:29:54 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282569>

In upcoming patches we make calls to match_atom_name() with the '*'
deref specifier still attached to the atom name. This causes
undesirable errors, hence, if present skip over the '*' deref
specifier in the atom name.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index f4a6414..7d33b83 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -37,6 +37,10 @@ static int match_atom_name(const char *name, const char *atom_name, const char *
 {
 	const char *body;
 
+	/*  skip the deref specifier*/
+	if (name[0] == '*')
+		name++;
+
 	if (!skip_prefix(name, atom_name, &body))
 		return 0; /* doesn't even begin with "atom_name" */
 	if (!body[0]) {
-- 
2.6.4
