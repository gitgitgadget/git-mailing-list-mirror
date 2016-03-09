From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] dir.c: fix dir re-inclusion rules with "NODIR" and "MUSTBEDIR"
Date: Wed,  9 Mar 2016 18:08:13 +0700
Message-ID: <1457521693-26141-1-git-send-email-pclouds@gmail.com>
References: <xmqqy49siin2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
	Charles Strahan <charles@cstrahan.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 12:08:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adbys-0000Um-6l
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 12:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306AbcCILIe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2016 06:08:34 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35364 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058AbcCILIb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 06:08:31 -0500
Received: by mail-pa0-f48.google.com with SMTP id td3so10388937pab.2
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 03:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UiwfjotvxYM5d8CrPpovvfs3b3bVWOiLcNmEa22Bank=;
        b=st28zbrxq6pfX0wAwLXm2XHG+dIlZi/byJZvkbESd3e7zhlrLFZz/HkVA0AfBi+zP/
         RVCtFQm+AT+3un8Z99o+EkQtOCNNKs7MPLlO+cvvvUXsoryDZ+lfdgRp+DykKho28PrI
         R+KXUAb4YaL4OLF8eL1EgtGcUmlE2nbB1uSlBy0rOcB74aNFBSBaVRvCtU/rr/1kx3Bi
         7TQk0/OaNXYsSRvLhm7WK0c7V1CUORn8NDusm8qdtG6l6HDh2y2+WMi6eNK7K3oMqm6f
         a5IF15gyEA4Kf/xEqNCzQ+Odd/3bmEsEHE5UGN74vukPd17z9coj3KE/bMM5//ld5arn
         4bAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UiwfjotvxYM5d8CrPpovvfs3b3bVWOiLcNmEa22Bank=;
        b=nAs8yQvOs8MRJ5aVPVZa9DykWcDTF3DC6GeLh0RdOrzvpuQ7S1mIpkAHUpcX+nWK3t
         pepvXJ7vSJE3NMaDa85nYRpZQM+WlYyHxbIae9GwIU5qJ+FVUFmUIidRwsSBy7nwtd5A
         QF6BlQWQIhNUwtkel6p0xyfWYauveIqAnrhE5Xtwwx2dPo4V/TUJ/+0N76NqCjpSOmEv
         pIneMv4jBClnPGA9LLudVrzr1cPW1YSCf3e1t7KeerlOZaDteU9Zzes3k0RI5rsu4HSj
         ImzWXUZbSQFKIpVoHtodOh1oIp7kDf8x2Rr28LvGsPKzSYuvBMLAYd8mIHlZUS2HA1w+
         6okQ==
X-Gm-Message-State: AD7BkJJXbAzK8RqWy0ZFDX0wHq6OjHzofHgSENKZNZHzJHGdWTqE0B+Lur/EUS5MG3KUFQ==
X-Received: by 10.66.124.226 with SMTP id ml2mr48913153pab.90.1457521710964;
        Wed, 09 Mar 2016 03:08:30 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id p5sm11563877pfi.94.2016.03.09.03.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Mar 2016 03:08:29 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Mar 2016 18:08:25 +0700
X-Mailer: git-send-email 2.8.0.rc0.208.g69d9f93
In-Reply-To: <xmqqy49siin2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288479>

=46or NODIR case, the patterns look like this

    *          # exclude dir, dir/file1 and dir/file2..
    !dir       # ..except that dir and everything inside is re-included=
=2E.
    dir/file2  # ..except (again!) that dir/file2 is excluded
               # ..which means dir/file1 stays included

When we stay at topdir and test "dir", everything is hunky dory, curren=
t
code returns "re-include dir" as expected. When we stay in "dir" and
examine "dir/file1", however, match_basename() checks if the base name
component, which is "file1", matches "dir" from the second rule.

This is wrong. We contradict ourselves because earlier we decided to
re-include dir/file1 (from the second rule) when we were at toplevel.
Because the second rule is ignored, we hit the first one and return
"excluded" even though "dir/file1" should be re-included.

Side note, it's probably a bad idea to use basename matching on a
negative rule (ie. no slashes in the pattern) because what the pattern
says is "re-include _any_ directory named 'dir'", not just the director=
y
"dir" at right below this directory.

In the MUSTBEDIR case, the patterns look like this

    *          # exclude dir, dir/file1 and dir/file2..
    !dir/      #  ..except that dir and everything inside is re-include=
d..
    dir/file2  # ..except (again!) that dir/file2 is excluded
               # ..which means dir/file1 stays included

Again, we're ok at the toplevel, then we enter "dir" and test
"dir/file1". The MUSTBEDIR code tests if the _full_ path (ie. "dir/file=
1")
is a directory. We want it to test the "dir" part from "dir/file1"
instead.

In both cases, we want to test if the pattern matches a parent
directory. match_dir_component() is for this purpose.

We do want to be careful not to get back too far. Given the file
foo/bar/.gitignore, we should only check as far back as foo/bar because
this .gitignore file can never match outside that directory, which is
"toplevel" in the above paragraphs, to begin with.

The remaining matching case (neither NODIR nor MUSTBEDIR is set) is
already fixed in a60ea8f (dir.c: fix match_pathname() - 2016-02-15)

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 The fix may look like this (I didn't think about the "**" trick in
 wildmatch, which makes things simpler).

 No it's not meant for 2.8.0. I didn't even optimize for the
 no-wildcard case, or add tests. But we can still stare at it in the
 meantime to see if I analyzed anything wrong. I almost thought I was
 wrong to the declare the bug while I was on my ride back home..

 dir.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 69e0be6..5123483 100644
--- a/dir.c
+++ b/dir.c
@@ -992,6 +992,51 @@ static struct exclude *should_descend(const char *=
pathname, int pathlen,
 }
=20
 /*
+ * Given a "NODIR" pattern, check if it matches any directory
+ * component after the x->base part.
+ *
+ * If the pattern is not NODIR (ie. pathname matching) _and_ is
+ * MUSTBE, check if it matches a directory as well.
+ *
+ * Note that "path" and "len" must cover the basename part as well,
+ * looking from last_exclude_matching_from_list(), not just the dirnam=
e.
+ */
+static int match_dir_component(const char *path, int len, struct exclu=
de *x)
+{
+	struct strbuf new_pattern =3D STRBUF_INIT;
+	int ret;
+
+	if (x->flags & EXC_FLAG_NODIR) {
+		if (!x->baselen) {
+			strbuf_addf(&new_pattern, "%s/**", x->pattern);
+			ret =3D !fnmatch_icase_mem(new_pattern.buf, new_pattern.len,
+						 path, strlen(path),
+						 WM_PATHNAME);
+			strbuf_reset(&new_pattern);
+			if (ret)
+				return ret;
+		}
+
+		strbuf_addf(&new_pattern, "%.*s**/%s/**", x->baselen, x->base, x->pa=
ttern);
+		ret =3D !fnmatch_icase_mem(new_pattern.buf, new_pattern.len,
+					 path, strlen(path),
+					 WM_PATHNAME);
+		strbuf_reset(&new_pattern);
+		return ret;
+	}
+
+	assert(x->flags & EXC_FLAG_MUSTBEDIR);
+	strbuf_addf(&new_pattern, "%.*s%s/**",
+		    x->baselen, x->base,
+		    *x->pattern =3D=3D '/' ? x->pattern+1 : x->pattern);
+	ret =3D !fnmatch_icase_mem(new_pattern.buf, new_pattern.len,
+				 path, strlen(path),
+				 WM_PATHNAME);
+	strbuf_release(&new_pattern);
+	return ret;
+}
+
+/*
  * Scan the given exclude list in reverse to see whether pathname
  * should be ignored.  The first match (i.e. the last on the list), if
  * any, determines the fate.  Returns the exclude_list element which
@@ -1033,7 +1078,8 @@ static struct exclude *last_exclude_matching_from=
_list(const char *pathname,
 		if (x->flags & EXC_FLAG_MUSTBEDIR) {
 			if (*dtype =3D=3D DT_UNKNOWN)
 				*dtype =3D get_dtype(NULL, pathname, pathlen);
-			if (*dtype !=3D DT_DIR)
+			if (*dtype !=3D DT_DIR &&
+			    !match_dir_component(pathname, strlen(pathname), x))
 				continue;
 		}
=20
@@ -1041,7 +1087,8 @@ static struct exclude *last_exclude_matching_from=
_list(const char *pathname,
 			if (match_basename(basename,
 					   pathlen - (basename - pathname),
 					   exclude, prefix, x->patternlen,
-					   x->flags)) {
+					   x->flags) ||
+			    match_dir_component(pathname, strlen(pathname), x)) {
 				exc =3D x;
 				break;
 			}
--=20
2.8.0.rc0.208.g69d9f93
