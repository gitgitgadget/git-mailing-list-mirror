From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 07/15] ref-filter: skip deref specifier in match_atom_name()
Date: Tue,  5 Jan 2016 13:33:06 +0530
Message-ID: <1451980994-26865-8-git-send-email-Karthik.188@gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 09:03:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGMaI-0007yM-NJ
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 09:03:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbcAEIDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 03:03:05 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33216 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598AbcAEIC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 03:02:59 -0500
Received: by mail-pf0-f178.google.com with SMTP id q63so180370184pfb.0
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 00:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mCMJgccgH7IN0kc0pPJCKUaSY2iHzbK41TM3jknLlF0=;
        b=woreUdJJ4YcX/1Hqw4SuOZ6hukpbgS71COeGDa6/o4niXGwml0y9HbfFT4WOKuAnZF
         pjdXzZ7OlaAObB+qfPqktBC6cIZSoDKOivYkKkO1TJatjeOMlC7hq5GfbAE/fCs8TtUM
         6Dtu71ntRoDvFpuWespvqYi/smhGfv1k5SoZzHpxdTNGuCdKiqBpd0yZBgFi4yhwP2rG
         J6lW+GVB4MbU4L+2vCWWwuEBt/8t88Nw/81a3S0PGoBD9+3l6MFNQWmRML9ySrr85Qv3
         Aafw5qPR9BKgbawCUlXoBSHdBq3XZiBqNFt+9bFKbexOraHEBP1BMvRCK6uzqrxnvMe2
         O1mA==
X-Received: by 10.98.7.92 with SMTP id b89mr132026895pfd.69.1451980978529;
        Tue, 05 Jan 2016 00:02:58 -0800 (PST)
Received: from ashley.localdomain ([106.51.242.38])
        by smtp.gmail.com with ESMTPSA id q190sm125814275pfq.59.2016.01.05.00.02.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Jan 2016 00:02:58 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283360>

In upcoming patches we make calls to match_atom_name() with the '*'
deref specifier still attached to the atom name. Subsequent patches
will call match_atom_name() with the '*' deref specifier still
attached to the atom name so, as a convenience, skip over it on their
behalf.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index 575d293..b54c872 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -37,6 +37,10 @@ static int match_atom_name(const char *name, const char *atom_name, const char *
 {
 	const char *body;
 
+	/* skip the deref specifier */
+	if (name[0] == '*')
+		name++;
+
 	if (!skip_prefix(name, atom_name, &body))
 		return 0; /* doesn't even begin with "atom_name" */
 	if (!body[0]) {
-- 
2.6.4
