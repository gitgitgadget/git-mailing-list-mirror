Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78FA71FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 17:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756085AbcKVRBp (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 12:01:45 -0500
Received: from mout.gmx.net ([212.227.17.20]:50430 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755994AbcKVRBm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 12:01:42 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LxLcc-1cpaaY3FWM-017007; Tue, 22
 Nov 2016 18:01:28 +0100
Date:   Tue, 22 Nov 2016 18:01:27 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] difftool: add a feature flag for the builtin vs scripted
 version
In-Reply-To: <cover.1479834051.git.johannes.schindelin@gmx.de>
Message-ID: <598dcfdbeef4e15d2d439053a0423589182e5f30.1479834051.git.johannes.schindelin@gmx.de>
References: <cover.1479834051.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Wct9EMzeefc2TPS2TJooQHlVpu+xLubh2LXPyq5VYw7tp+wfXE9
 6kLqyvxe7hntUrz+a9J0LaBgmgGKQhr7Wrrc0bSZkHwJIOJJMQJQtLxKE6olDqYp0vY1LHj
 h5uM7JNbZdKjdhrT2SrvgV2m1xj7tAPlyBBp9WGook4SHrsbIitaSwdMSc+RAjLAERym0CJ
 2R4J1osJodneL1IHbUdSA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:izT2DGWx5LI=:N4uoHbu0swkZ/N1GD5NPNP
 7acdB3sxBU+AsEAUId+ndNaScqrim4IMpjr1+f2T8Rms5OTNyTLi0C9cMKXmXlePuMjNszEEl
 G4qTlHNPzZLNfGCYphXeya6oFC4YSgwWVe0UAIm74PyL6JwiSwhHTDyyAAkYs0Bcu8HdqqURE
 V+UhV9I1+UqVvJYuZYyrZcZVjrT/CL/ai4vFRUaTZLlKSYe2qS/N3hdIMfSNYSjpQ0Bv1k3wJ
 HHd7HdIuX7UKBmFMixmG7NKKkG74w5DF6u3G1GzMg5rhlM6Hq5dsh2wl29mLP+4o05JjqqmAh
 wQfM9AB/ncC6zz1xeE7DTLYQDj9aH+Z+1Y69XQFGi6xBHY/o+lewcY8xAVeUbZhMI+uCdp6NN
 M8rx3MjMq2XItpv4oQUBe8r8E/hvGQ29v6kZZWvw8RWYnZkX1+xt1fwIqeuT4EDmB6XyEUMGK
 gZZgDwWhiYYAfo7LOanbRs/8nFTRLGesmVWKbe2ywd0CQmC+5dUxc06HI6m+q1drlrQFCOXKp
 7uNwJ638sUg+iqLGdmwRV3KoPGcdLiu78Hmk8noXLeinqJHTPHiJZqXPNNXmqLCSm2vdC0chT
 HHyy67k90CQv1o6HVtL8w/W5R+u+8nBVACRoH1dje4HAXdnwI2w7RKVKpCAbDsj1JwjB9BYfF
 a88KJi9QuL0hWl2Z8b8WH+gCrwzm2BILqgkO7jo0c7nmYqBxObkGG18a9giTlhppNNcTaM6J3
 nyDQ+WUBeIfEBG5CZ8u7VHSzrSDnCm0bMNzV3i14kV7PE+j3Dt4zsLxELZAE2osOhknwp0FDQ
 yeFp4dG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The popular difftool command was just converted into a builtin, for
better performance on Windows as well as to reduce the number of Perl
scripts (so that we may, in the very long run, be able to ship Git for
Windows without any Perl interpreter at all).

However, it would be sloppy practice to simply switch over from the
tried-and-tested (albeit slow) scripted version to the spanking new
builtin version that has not seen a whole lot of real-world testing.

So let's add a feature flag.

If the file `use-builtin-difftool` exists in Git's exec path, Git will
now automagically use the builtin version of the difftool, without
requiring the user to call `git builtin-difftool <args>`. This comes in
particularly handy when the difftool command is used from within
scripts.

If the file `use-builtin-difftool` is absent from Git's exec path, which
is the default, Git will use the scripted version as before.

The original idea was to use an environment variable
GIT_USE_BUILTIN_DIFFTOOL, but the test suite resets those variables, and
we do want to use that feature flag to run the tests with, and without,
the feature flag.

Besides, the plan is to add an opt-in flag in Git for Windows'
installer. If we implemented the feature flag as an environment
variable, we would have to modify the user's environment, in order to
make the builtin difftool the default when called from Git Bash, Git CMD
or third-party tools.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore        |  1 +
 git-difftool.perl |  7 +++++++
 git.c             | 20 ++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/.gitignore b/.gitignore
index 4f54531..91bfd09 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,4 @@
+/use-builtin-difftool
 /GIT-BUILD-OPTIONS
 /GIT-CFLAGS
 /GIT-LDFLAGS
diff --git a/git-difftool.perl b/git-difftool.perl
index a5790d0..28e47d8 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -23,6 +23,13 @@ use File::Temp qw(tempdir);
 use Getopt::Long qw(:config pass_through);
 use Git;
 
+if (-e Git::exec_path() . '/use-builtin-difftool') {
+	unshift(@ARGV, "builtin-difftool");
+	unshift(@ARGV, "git");
+	exec(@ARGV);
+	die("Could not execute builtin difftool");
+}
+
 sub usage
 {
 	my $exitcode = shift;
diff --git a/git.c b/git.c
index eaa0f67..7a0df7a 100644
--- a/git.c
+++ b/git.c
@@ -2,6 +2,7 @@
 #include "exec_cmd.h"
 #include "help.h"
 #include "run-command.h"
+#include "dir.h"
 
 const char git_usage_string[] =
 	"git [--version] [--help] [-C <path>] [-c name=value]\n"
@@ -542,6 +543,22 @@ static void strip_extension(const char **argv)
 #define strip_extension(cmd)
 #endif
 
+static int use_builtin_difftool(void)
+{
+	static int initialized, use;
+
+	if (!initialized) {
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_addf(&buf, "%s/%s", git_exec_path(),
+			    "use-builtin-difftool");
+		use = file_exists(buf.buf);
+		strbuf_release(&buf);
+		initialized = 1;
+	}
+
+	return use;
+}
+
 static void handle_builtin(int argc, const char **argv)
 {
 	struct argv_array args = ARGV_ARRAY_INIT;
@@ -551,6 +568,9 @@ static void handle_builtin(int argc, const char **argv)
 	strip_extension(argv);
 	cmd = argv[0];
 
+	if (!strcmp("difftool", cmd) && use_builtin_difftool())
+		cmd = "builtin-difftool";
+
 	/* Turn "git cmd --help" into "git help --exclude-guides cmd" */
 	if (argc > 1 && !strcmp(argv[1], "--help")) {
 		int i;
-- 
2.10.1.583.g721a9e0
