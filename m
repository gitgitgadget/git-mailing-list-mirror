From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 09/15] ref-filter: introduce symref_atom_parser()
Date: Sun,  6 Mar 2016 17:34:56 +0530
Message-ID: <1457265902-7949-10-git-send-email-Karthik.188@gmail.com>
References: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 06 13:05:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acXRa-0002Bg-3n
	for gcvg-git-2@plane.gmane.org; Sun, 06 Mar 2016 13:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbcCFMFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 07:05:50 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33593 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbcCFMF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 07:05:28 -0500
Received: by mail-pa0-f51.google.com with SMTP id fl4so61871697pad.0
        for <git@vger.kernel.org>; Sun, 06 Mar 2016 04:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=38CmoW7hRiuc6j1uX2KYB6y/Pgosooek4JAa3s9H90s=;
        b=WHLPkf9xI6hw2hp7HkMF0mILcQyvIQCbBHZWUd7mo1rH6Q1E0+GV3/ABPYfxA63A0y
         IUI9Kn0gVyW24luY7y6jIZGhB6myeh/e0HOVo6+9SkmYnU+r//PkvzGGHCYN0D5NzaUo
         O86sx/A2J683ljCvsvJPwglD5JyKmim6nPNH2uQ7YEqILh4DpK1og5Yi6KYCKg7mHezl
         eo5dMwuNz8ACxhY8m1Un9y5zeNBoQndRBpsF1fokzYAOvR6VulhS/wZb7XRdf4YXxdL1
         ANlpb+KwJny6FxkrmKBmZclL+XcY687CEGWxVrA9XepNUsLw49XnHcJwLx6cISZTWl+Q
         Bzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=38CmoW7hRiuc6j1uX2KYB6y/Pgosooek4JAa3s9H90s=;
        b=NEMQpZR0o8D1RUkvqfBUiktTXqeFDToNuJ8wiiIoGMNAH91RP5tnXYavZcn7A4TRHF
         epnBLmcKVUK00orPeJo1JIQA8dCDzwKhDL5z2IAJPZKLC7UtlFN7oBylVIxhXf8+XqNV
         YQ85dlaBzTmO3ZnOUj0XSEkCzlNAwYfYz8Nk4yMZKG2kS1tefzdFdT45sPZ01ksiDt1V
         8fx+R7rjoyHkefBa3r5wIQGRGJ1Frvg/1BYbb9E1bnsm7DltaBaIfjCJ9SlEjkBgUhj3
         9tsRnU96GLiuknKt1W2x9uk7lXgMlDUm8ujYoPDFZpntjcNUbt5M38V6MQxjRzalIXLH
         ppVw==
X-Gm-Message-State: AD7BkJL86ykTL63v3sqMh54PaZHXrjb+2rRuW6AGxFjB/qZI1K5fQ4FMmst3AnS6U+7TTw==
X-Received: by 10.66.191.104 with SMTP id gx8mr25880547pac.21.1457265927442;
        Sun, 06 Mar 2016 04:05:27 -0800 (PST)
Received: from localhost.localdomain ([106.51.240.143])
        by smtp.gmail.com with ESMTPSA id n66sm17536850pfj.39.2016.03.06.04.05.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Mar 2016 04:05:26 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288355>

Introduce symref_atom_parser() which will parse the '%(symref)' atom and
store information into the 'used_atom' structure based on the modifiers
used along with the atom.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index ab860a3..59eb280 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -58,6 +58,7 @@ static struct used_atom {
 			enum { O_FULL, O_LENGTH, O_SHORT } option;
 			unsigned int length;
 		} objectname;
+		enum { S_FULL, S_SHORT } symref;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -201,6 +202,16 @@ static void align_atom_parser(struct used_atom *atom, const char *arg)
 	string_list_clear(&params, 0);
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
+
 static struct {
 	const char *name;
 	cmp_type cmp_type;
@@ -235,7 +246,7 @@ static struct {
 	{ "contents", FIELD_STR, contents_atom_parser },
 	{ "upstream", FIELD_STR, remote_ref_atom_parser },
 	{ "push", FIELD_STR, remote_ref_atom_parser },
-	{ "symref" },
+	{ "symref", FIELD_STR, symref_atom_parser },
 	{ "flag" },
 	{ "HEAD" },
 	{ "color", FIELD_STR, color_atom_parser },
@@ -1122,6 +1133,17 @@ char *get_head_description(void)
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
@@ -1165,7 +1187,7 @@ static void populate_value(struct ref_array_item *ref)
 			if (ref->kind & FILTER_REFS_DETACHED_HEAD)
 				refname = get_head_description();
 		} else if (starts_with(name, "symref"))
-			refname = ref->symref ? ref->symref : "";
+			refname = get_symref(atom, ref);
 		else if (starts_with(name, "upstream")) {
 			const char *branch_name;
 			/* only local branches may have an upstream */
-- 
2.7.2
