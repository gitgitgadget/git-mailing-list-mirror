From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH/RFC 04/10] ref-filter: skip deref specifier in match_atom_name()
Date: Thu, 12 Nov 2015 01:14:30 +0530
Message-ID: <1447271075-15364-5-git-send-email-Karthik.188@gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
Cc: matthieu.moy@grenoble-inp.fr, gitster@pobox.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 11 20:44:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwbJt-00062Z-CE
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 20:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbbKKToa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 14:44:30 -0500
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36594 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449AbbKKTo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 14:44:29 -0500
Received: by pabfh17 with SMTP id fh17so5361036pab.3
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 11:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/ukZIW7kqVlD+sbx9a6hyHJYpBEk7CWs+NHzPjqsh3w=;
        b=NUDaBbnGlHp+/Is7ylRqsdeuR4Z5wZkx596NsJgomtzneumZ8dmM7f9/FRLcHco1qB
         rw9Sl7rHfx66FO3I7eh5M+ghET0tQxRMlGJwZyw86PImNzdn4gqbeQxOCQ2nevejD/qR
         dIBFcUarWMLRoaKLItSKXzpZBkfv11rmGAh9ZJfFHbMBkpYAnPEEvCLT+YGMtLFxmL8F
         J3BV+zBe02FgFuHPT1HDYpDVkVFXlL2FO+W++uhOmZkZPd8V3XzaxhfqH5ZAuAYfxaBl
         LiNYu7BNG2p2a7l8HV2esL9UCCf9Y2YZ9kzaSM3qffJe13F8CPvDAHbmu9xpQz8aVgZQ
         lgiA==
X-Received: by 10.66.63.104 with SMTP id f8mr3898749pas.101.1447271068769;
        Wed, 11 Nov 2015 11:44:28 -0800 (PST)
Received: from ashley.localdomain ([106.51.241.110])
        by smtp.gmail.com with ESMTPSA id j5sm278998pbq.74.2015.11.11.11.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Nov 2015 11:44:28 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281184>

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index 1542f5f..4af28ef 100644
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
2.6.2
