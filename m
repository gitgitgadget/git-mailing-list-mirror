From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 11/15] ref-filter: convert variable 'width' to an unsigned int
Date: Tue,  5 Jan 2016 13:33:10 +0530
Message-ID: <1451980994-26865-12-git-send-email-Karthik.188@gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 09:03:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGMaJ-0007yM-VR
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 09:03:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbcAEIDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 03:03:10 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35083 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbcAEIDH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 03:03:07 -0500
Received: by mail-pa0-f46.google.com with SMTP id do7so1664771pab.2
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 00:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FilZ3O5kyXxF5W04Ye1d1ylQzC8RTmDA12bC2t3iqy0=;
        b=tlATs84imhYVpObTQMTzl1wMpXj6KrTUlV6HR4LoLW8xM/upisRX16xfe/SfSk2C2a
         VWWijiGR8dBAvR19E/Xs90iLzywYrve79IWDkUoxjzQXFRuXIOtbRDhpXz53A6ZqCVm9
         ilSXXFq2TC1CcmDaXgUXpPhqCooPjLLuayE+BxgpYgL2w4AGIX3SX41ScuoALWXcbsCv
         NTl9+znXzLkjUz21b9MfaG1S1LQec80FJnoDEMDvUVJrz/+hczsgHxJJuof78GGT+DSv
         RZ5caBeytLOyLVeTtsb3MgfZshvDFqsADOsvCXYyh/3D+bAwnjVAqZmRujv6vlZ3WnEG
         k8aw==
X-Received: by 10.66.221.228 with SMTP id qh4mr131487110pac.68.1451980986628;
        Tue, 05 Jan 2016 00:03:06 -0800 (PST)
Received: from ashley.localdomain ([106.51.242.38])
        by smtp.gmail.com with ESMTPSA id q190sm125814275pfq.59.2016.01.05.00.03.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Jan 2016 00:03:06 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283359>

In align_atom_parser() the 'width' variable is an int, which requires
an explicit type conversion when used in strtoul_ui(). Hence make it
an unsigned int.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index ccad4c3..4f623a0 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -90,7 +90,7 @@ static void align_atom_parser(struct used_atom *atom)
 	struct align *align = &atom->u.align;
 	const char *buf = NULL;
 	struct strbuf **s, **to_free;
-	int width = -1;
+	unsigned int width = ~0U;
 
 	if (!match_atom_name(atom->name, "align", &buf))
 		die("BUG: parsing non-'align'");
@@ -104,7 +104,7 @@ static void align_atom_parser(struct used_atom *atom)
 		int position;
 		buf = s[0]->buf;
 
-		if (!strtoul_ui(buf, 10, (unsigned int *)&width))
+		if (!strtoul_ui(buf, 10, &width))
 			;
 		else if ((position = parse_align_position(buf)) >= 0)
 			align->position = position;
@@ -113,7 +113,7 @@ static void align_atom_parser(struct used_atom *atom)
 		s++;
 	}
 
-	if (width < 0)
+	if (width == ~0U)
 		die(_("positive width expected with the %%(align) atom"));
 	align->width = width;
 	strbuf_list_free(to_free);
-- 
2.6.4
