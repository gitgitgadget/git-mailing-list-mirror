From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 10/16] ref-filter: introduce symref_atom_parser()
Date: Wed, 30 Mar 2016 15:09:54 +0530
Message-ID: <1459330800-12525-11-git-send-email-Karthik.188@gmail.com>
References: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 11:40:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alCcJ-0001nn-Cs
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 11:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbcC3Jkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 05:40:36 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34071 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233AbcC3Jke (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 05:40:34 -0400
Received: by mail-pf0-f169.google.com with SMTP id x3so37992886pfb.1
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 02:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RzVw3U0ukUFavrLf3UHEYJvLS3Q50WZOhDgNf9/DkjQ=;
        b=c+PwLq030ZhhfeMCwerJ2U963o+kVyA8enqcVh9vnbsdRKM/HWYbfXY1AFrWIBc8Dw
         WGgMQAbq/1YA+Rn32H2lfeuPjLi6el+4JPbur0yxQtEoou88pykFO1leA+B3bvns0CcV
         5nN2ZGB5azL82gv9PZtwBzoJ0LQ/ZnvuKKoKaSS4wjC25NHFO3cysUPu1CWIsjP9rEM9
         ouD68lgS37MbmcVfmiFFc8oIDW7wHgGTQ4rEyR3PZeaARCDLXXpr/Xp1EMLfujhvMx/X
         ndcY0IXtLwBC/hmrioy/qnkDfV8O6lSJrYDrWjd8dYlRiMlBR5HrNULfcFClOIPLJBna
         +YWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RzVw3U0ukUFavrLf3UHEYJvLS3Q50WZOhDgNf9/DkjQ=;
        b=ShcNZjjzVz1a0ujLzktH62ZmDzAvS0gZxCRwgr3w8y2RDEQkAZxD6P7GajIAVIfHYI
         h/dOQITP5h3/RN80DuZHjjYqLNAWvEfymiohRozOzHwP2fyVnL235alEcaR8VZiC2UPC
         L8kWO4TZxjCMsSzV4Uy1WnSRKqYaH35mxq5883BcLaOTQ1cyP54HEMK90rt1PuHOWFao
         qNLia2ZMMgpuIbDIUVZJYLPSOIkmibDNzZB/oE1SmmsMc/OyA0uCxZMe9JMNiNgBxUyj
         BLBFQ31t6T8KLsjzN7rb04TxWHKGYdA5Dq62rxVyNuePgxuZGg9WDyMKb1mULm9F+ywQ
         s4Tg==
X-Gm-Message-State: AD7BkJIgtURyyJHqU+A4FPNwj1kWmI0sBBcIBkabHCQ+azoOuOegmtiq+kP+zQ/lzB34eA==
X-Received: by 10.98.80.70 with SMTP id e67mr11535510pfb.136.1459330833755;
        Wed, 30 Mar 2016 02:40:33 -0700 (PDT)
Received: from localhost.localdomain ([106.51.243.45])
        by smtp.gmail.com with ESMTPSA id r65sm4402606pfa.27.2016.03.30.02.40.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Mar 2016 02:40:33 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290290>

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
2.7.4
