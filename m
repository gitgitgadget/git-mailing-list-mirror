From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 10/16] ref-filter: introduce symref_atom_parser()
Date: Sun, 10 Apr 2016 00:15:09 +0530
Message-ID: <1460227515-28437-11-git-send-email-Karthik.188@gmail.com>
References: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 20:45:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoxtM-0003o8-Q2
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 20:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759116AbcDISpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 14:45:47 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:35704 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759100AbcDISpq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 14:45:46 -0400
Received: by mail-ig0-f194.google.com with SMTP id fn8so6500925igb.2
        for <git@vger.kernel.org>; Sat, 09 Apr 2016 11:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1YbsZpok67topzFzWpnpME0dtsLa78qzGDSjambtqcs=;
        b=MHcgVLteLAu5rEbEYSm5dnarNucaKdP+C6OUYfzomzRtlpks7uw5cd472+Kg0jJCP+
         e3RCmebSaJ5/VxFINwhbZDuLeyMkqDUlvMqUIOj5H1LwUV0IEas1no3p55VPGQSdTwo+
         hIQv9afkaXBIWrW95wxTiRE8tXzA5QbuNYeiCWB6fAW4qX8m2qwwFOUAY+fHRd/YUbAy
         cX/MPFtrQ3xNwl02js1h1MgbVEdjx++XsW4T9nJ8PEEbroN4QWBh7tARA8jhfU5gUHqn
         EcwN9VpZPXQLZnCGMjL1MjIGLsgX9xEGTOYKzDW4bcNLfpLsSMQvZJ+Qif+hGPa5F++y
         +9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1YbsZpok67topzFzWpnpME0dtsLa78qzGDSjambtqcs=;
        b=hoX7ZZIBvl0xksdSTcXsU6G1EKgTQlSik7c3RpHA7/tqOOzUx7JCYK8stf7KsKUZle
         DmFpyE+SE2ZiOMr3w6GrukIG36udgDt3WoogDn5R/aAn2NkQyAP+/DLd+rCMx3Mlqs17
         Sei8B1z3EvpDXV1xqq6proQoS8lfCB4TWdFi9upZY4zRyST0G7DZ9RG81ZaGs5Y7YT0v
         4cumPwj02XMdm6zJtr7iPH6ZwKrm29dKqaavRLyJxuSfzk33eyqq4zhqp+m/4yLMQLx1
         b52/XaotHHGLUCYK+CK9tQXn8Ddw1OTn4ioQRgwcvapHLt9M3onLdiOnlY0tMboVPOnG
         b45Q==
X-Gm-Message-State: AD7BkJJ6NEStcnWXmn3WL/wpNU2kLO7Oy3QL9UvFfYBJ+iiC6UihDRZmYPnWKMV0D2ZLEA==
X-Received: by 10.50.67.36 with SMTP id k4mr10447148igt.89.1460227545192;
        Sat, 09 Apr 2016 11:45:45 -0700 (PDT)
Received: from localhost.localdomain ([106.51.241.12])
        by smtp.gmail.com with ESMTPSA id be7sm7132351igb.1.2016.04.09.11.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Apr 2016 11:45:44 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291115>

Introduce symref_atom_parser() which will parse the '%(symref)' atom and
store information into the 'used_atom' structure based on the modifiers
used along with the atom.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 5c59b17..7b35e4f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -62,6 +62,7 @@ static struct used_atom {
 			enum { O_FULL, O_LENGTH, O_SHORT } option;
 			unsigned int length;
 		} objectname;
+		enum { S_FULL, S_SHORT } symref;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -217,6 +218,15 @@ static void if_atom_parser(struct used_atom *atom, const char *arg)
 		die(_("unrecognized %%(if) argument: %s"), arg);
 }
 
+static void symref_atom_parser(struct used_atom *atom, const char *arg)
+{
+	if (!arg)
+		atom->u.symref = S_FULL;
+	else if (!strcmp(arg, "short"))
+		atom->u.symref = S_SHORT;
+	else
+		die(_("unrecognized %%(symref) argument: %s"), arg);
+}
 
 static struct {
 	const char *name;
@@ -252,7 +262,7 @@ static struct {
 	{ "contents", FIELD_STR, contents_atom_parser },
 	{ "upstream", FIELD_STR, remote_ref_atom_parser },
 	{ "push", FIELD_STR, remote_ref_atom_parser },
-	{ "symref" },
+	{ "symref", FIELD_STR, symref_atom_parser },
 	{ "flag" },
 	{ "HEAD" },
 	{ "color", FIELD_STR, color_atom_parser },
@@ -1132,6 +1142,17 @@ char *get_head_description(void)
 	return strbuf_detach(&desc, NULL);
 }
 
+static const char *get_symref(struct used_atom *atom, struct ref_array_item *ref)
+{
+	if (!ref->symref)
+		return "";
+	else if (atom->u.symref == S_SHORT)
+		return shorten_unambiguous_ref(ref->symref,
+					       warn_ambiguous_refs);
+	else
+		return ref->symref;
+}
+
 /*
  * Parse the object referred by ref, and grab needed value.
  */
@@ -1176,7 +1197,7 @@ static void populate_value(struct ref_array_item *ref)
 			if (ref->kind & FILTER_REFS_DETACHED_HEAD)
 				refname = get_head_description();
 		} else if (starts_with(name, "symref"))
-			refname = ref->symref ? ref->symref : "";
+			refname = get_symref(atom, ref);
 		else if (starts_with(name, "upstream")) {
 			const char *branch_name;
 			/* only local branches may have an upstream */
-- 
2.8.0
