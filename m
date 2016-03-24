From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/4] apply: add --whole to apply git patch without prefix filtering
Date: Thu, 24 Mar 2016 18:56:18 +0700
Message-ID: <1458820579-31621-4-git-send-email-pclouds@gmail.com>
References: <CACsJy8CTix-ZwN04MwYTB+JEtDCV27QVf7_0vWmhUSVCwU29Jg@mail.gmail.com>
 <1458820579-31621-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
	mehul.jain2029@gmail.com, sandals@crustytoothpaste.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 12:57:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj3tZ-0001HZ-Ho
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 12:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbcCXL5f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2016 07:57:35 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35647 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607AbcCXL5d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 07:57:33 -0400
Received: by mail-pf0-f181.google.com with SMTP id n5so55202307pfn.2
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 04:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bBviN7gUOvCcrqKIyEj7XAgkdUy+gntpneLaMDXMCh0=;
        b=U6ux19Jo4PoKqBk9/B4ntRg3qk8COeImrrRaKIU7KROShWKv5Ns6SKLd7HyxduaxE1
         jW4G0aEtwy8o7aqnHIV0NXYjVBuiiGa38fTuEPULUoM8/3CP5aCKScOKnZNhMObPDPMk
         iYX1iuO68d3VK2RxWCG0HhDvvttFgHREB8oVB00nUuurn1/Fb8i8I+SpNncSPeM4coKI
         FCC1VXUy6I9ktTbl+xp3dtR0AkZ4a+Yv3bo8zKkPIJxsSlvD63FXO5oryn86TSKBeCZt
         zT3VYksfQmI1dBJkoqr1mSLMuUqtqIcLcX6ReFdUJDIrhmjGvatYseTArU+tS9J9xnQd
         QfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bBviN7gUOvCcrqKIyEj7XAgkdUy+gntpneLaMDXMCh0=;
        b=H4Iodip7uyuYa9Gd7LRkWr6dwPhr9IJunWt7OyTl0TWQpEvLVbq8f75+gYmgHG6BhY
         +4W7MW/8HbWBikx+zAEQiwZW+FbXmQX3bJa1tEaQHyf/c3voIuJ1OVBTkwwIYly5nXDJ
         ypCPl/49eHqOd07w9yai2B6yt9Es8bZJniOvE+AOdwUkcQ/4F4izDMlZpN+vdwS8Pmco
         dabxy2ET/TAKmX332C7pYkTMdQGh2+RUvgsXW0UHhXPulNiuEXbqfwf5/ZTxxOw3PdXL
         MrufCnT8ZyXEHB5K7NjyYKo+wkg3knUBv6YtgxKWliRvaQtfYcOOhxqQSS9hCZL0gtsK
         HW8g==
X-Gm-Message-State: AD7BkJLOpcQgUZjL42HtPLgKdhSF8G4TXhpmx53LOtdwBBx8+zyC4z5fNOx1/BXsvwLm2g==
X-Received: by 10.98.80.10 with SMTP id e10mr12026316pfb.141.1458820652682;
        Thu, 24 Mar 2016 04:57:32 -0700 (PDT)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id w62sm9962693pfa.79.2016.03.24.04.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Mar 2016 04:57:31 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 24 Mar 2016 18:57:45 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1458820579-31621-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289740>

Back in edf2e37 (git-apply: work from subdirectory. - 2005-11-25),
git-apply is made to work from a subdir of a worktree. When applying a
git patch this way, only paths in the subdir are patched, the rest is
filtered out. To apply without filtering, the user has to move back to
toplevel. Add --whole to make it more convenient to do so without movin=
g
cwd around.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-apply.txt |  8 +++++++-
 builtin/apply.c             |  4 +++-
 t/t4111-apply-subdir.sh     | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 8ddb207..47cea57 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	  [--apply] [--no-add] [--build-fake-ancestor=3D<file>] [-R | --rever=
se]
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
 	  [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--cached]
-	  [--ignore-space-change | --ignore-whitespace]
+	  [--ignore-space-change | --ignore-whitespace] [--whole]
 	  [--whitespace=3D(nowarn|warn|fix|error|error-all)]
 	  [--exclude=3D<path>] [--include=3D<path>] [--directory=3D<root>]
 	  [--verbose] [--unsafe-paths] [<patch>...]
@@ -154,6 +154,12 @@ discouraged.
 	flag was the way to do so.  Currently we always allow binary
 	patch application, so this is a no-op.
=20
+--whole::
+	Normally when running inside a subdirectory of a working area,
+	patched files outside current directory is filtered out. This option
+	makes `git apply` to apply them all. All paths are still subject
+	to `--exclude` and `--include` fitlering if present.
+
 --exclude=3D<path-pattern>::
 	Don't apply changes to files matching the given path pattern. This ca=
n
 	be useful when importing patchsets, where you want to exclude certain
diff --git a/builtin/apply.c b/builtin/apply.c
index 42c610e..01e1d5e 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -80,6 +80,7 @@ static const char *patch_input_file;
 static struct strbuf root =3D STRBUF_INIT;
 static int read_stdin =3D 1;
 static int options;
+static int apply_whole;
=20
 static void parse_whitespace_option(const char *option)
 {
@@ -1956,7 +1957,7 @@ static int use_patch(struct patch *p)
 	int i;
=20
 	/* Paths outside are not touched regardless of "--include" */
-	if (0 < prefix_length) {
+	if (!apply_whole && 0 < prefix_length) {
 		int pathlen =3D strlen(pathname);
 		if (pathlen <=3D prefix_length ||
 		    memcmp(prefix, pathname, prefix_length))
@@ -4565,6 +4566,7 @@ int cmd_apply(int argc, const char **argv, const =
char *prefix_)
 		OPT_BIT(0, "recount", &options,
 			N_("do not trust the line counts in the hunk headers"),
 			RECOUNT),
+		OPT_BOOL(0, "whole", &apply_whole, N_("apply whole patch")),
 		{ OPTION_CALLBACK, 0, "directory", NULL, N_("root"),
 			N_("prepend <root> to all filenames"),
 			0, option_parse_directory },
diff --git a/t/t4111-apply-subdir.sh b/t/t4111-apply-subdir.sh
index 1618a6d..e5cd019 100755
--- a/t/t4111-apply-subdir.sh
+++ b/t/t4111-apply-subdir.sh
@@ -153,4 +153,36 @@ test_expect_success 'apply --cached from subdir of=
 .git dir' '
 	test_cmp expected.subdir actual.subdir
 '
=20
+test_expect_success 'setup a git patch' '
+	cat >gitpatch <<-\EOF &&
+	diff --git a/file b/file
+	--- a/file
+	+++ b/file
+	@@ -1 +1,2 @@
+	 1
+	+2
+	EOF
+	gitpatch=3D"$(pwd)/gitpatch"
+'
+
+test_expect_success 'apply a git patch from subdir of toplevel' '
+	reset_subdir other preimage &&
+	(
+		cd sub/dir &&
+		git apply "$gitpatch"
+	) &&
+	test_cmp preimage sub/dir/file &&
+	test_cmp preimage file
+'
+
+test_expect_success 'apply the whole git patch from subdir of toplevel=
' '
+	reset_subdir other preimage &&
+	(
+		cd sub/dir &&
+		git apply --whole "$gitpatch"
+	) &&
+	test_cmp preimage sub/dir/file &&
+	test_cmp postimage file
+'
+
 test_done
--=20
2.8.0.rc0.210.gd302cd2
