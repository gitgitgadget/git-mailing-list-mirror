From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 10/16] ref-filter: introduce symref_atom_parser()
Date: Tue, 15 Mar 2016 22:17:10 +0530
Message-ID: <1458060436-1215-11-git-send-email-Karthik.188@gmail.com>
References: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 17:48:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afs8a-000108-0G
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 17:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965267AbcCOQrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 12:47:51 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34750 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965214AbcCOQrr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 12:47:47 -0400
Received: by mail-pf0-f177.google.com with SMTP id x3so35799248pfb.1
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 09:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7aWM0NKT+NtpcQ0jMhP4uymtTPV1kiiyUpSD4SmdMe8=;
        b=cmKKkxExzuihiZLLxwjdcRGzvzpiF7EBHUSVCRYA3iGjGMkjpm4e4z2EbeJbJj/Ju4
         cMjnJ681s7Qq8KY8VDqj2yRHBqpwLzn3jOiG/3kr3VimO2i8m9yJXGosmZsnqg+VF20Z
         GuJqUkOW572APAqBVy8znhSd3D9HkwBR/L0zZ7VfBNGC4CjtbTYrjHYV3+XmaINl2sB6
         XcB5Vhe4k8xVCeECt75522e6EzAev0ug+btBR77piWSxBK9ctqWKK5tngugW0LqM5gGf
         gzYztVr2vJ7vzNim3CJb/qr3jNVzd1J3JxbhlxZSZ1AbTbZtSY3HuJvHD24QoA23JJYu
         AuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7aWM0NKT+NtpcQ0jMhP4uymtTPV1kiiyUpSD4SmdMe8=;
        b=k97/VTrhz+J8mce/o6Nr3jwpZESAjX0m69TBYcWtfj5ENbMGGpFnpdcBGK+Xqh5OTG
         mfl5vJ6xBdXu0NAM0diYrZTrci5TSk0pm8HYvVD5PqCuudW6fBsTJBv2NT5WE29eg9UL
         OobziIXA20EzSZTUaqKn+diKTZBYm5XU5QCMpzaGLco4J/enkZYUj1+hST4AJW4yukOL
         mR4vvdkuqUkrQKPf7O3pcBaEYJtpusjLQngTqZTGHS/04zPR0F6XtgCuUGtCdRVPyUo0
         k3ahkFukwHAQkgtgTceKV2/Xt2M2HwvFl8/HbIJGw5dE+2bRnBdNnpJtvBzUQW029xVo
         xluw==
X-Gm-Message-State: AD7BkJJvQpbZNxg9X9Z3l0pja5fBw9FcttHaCRfzBGN9rTPPEkCRnd3hiw03FnwUYPa9Zw==
X-Received: by 10.98.17.151 with SMTP id 23mr39340224pfr.37.1458060466783;
        Tue, 15 Mar 2016 09:47:46 -0700 (PDT)
Received: from localhost.localdomain ([106.51.243.87])
        by smtp.gmail.com with ESMTPSA id i1sm40874361pfj.17.2016.03.15.09.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Mar 2016 09:47:46 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288874>

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
2.7.3
