Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5931209F2
	for <e@80x24.org>; Wed,  1 Feb 2017 12:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbdBAMBR (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 07:01:17 -0500
Received: from mout.gmx.net ([212.227.17.21]:59411 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751950AbdBAMBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 07:01:16 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mb31L-1cstPw1aRv-00KcwQ; Wed, 01
 Feb 2017 13:01:03 +0100
Date:   Wed, 1 Feb 2017 13:01:00 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Segev Finer <segev208@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 1/4] connect: handle putty/plink also in GIT_SSH_COMMAND
In-Reply-To: <cover.1485950225.git.johannes.schindelin@gmx.de>
Message-ID: <fc511a35a8663f98e1da96d4be9991f7814b8874.1485950225.git.johannes.schindelin@gmx.de>
References: <cover.1485442231.git.johannes.schindelin@gmx.de> <cover.1485950225.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7ZC9zj6PVaySz7CBADBMVN5x44EBCZGOZiCtmb61A8R6WJ7hx+t
 vaDGDES6WckPRxetycMIPnlAvqy3bvASWemRsqtbKWz+S409ADxX2WO76+ulBOo/kDiS6rL
 Yh2pVOzqy1PNWckJ2zuybVf1DMbggYsUDXYyDW1G7egRM1bKSmj1RpTVjVSLnEqhzpaGYS+
 gQ7EeKVUMtzC13NGVvFUw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:afxbVDEHs3c=:NTVh3x5dsLrMHmaCEVbP0b
 j013F0Df55WCZpQIfZspGShDoPkMALPEPzP33Qz5pv7tFmUXpnnKAH39M6FBjAjuuNsWp7tTH
 HjxrfTfxqhjMe7f596QE6D3jvOoYXZ0euiQF8JoECr3/5gHCzVQWflp1VDUim3K0YkBv9H/vL
 zNsw5pu6YN/JlcApxoQIWPyfnuMKorWThRSbwEBnBtDoOwLUcHIv+o1KScM+xU+60pVwaRkBv
 XAFzwPgbjIsGon8L/zQvnMQIKRsOBjEnrJs6IYKchjK/bm9dQNEIpZvdiwoSsuN4Dya5DUX+y
 Q3Dj+doP+EUb2XzsK12HtE4u2pF32iEV9a7Mt4zT2ln4UtK4V6JGPRJ8bf9JxMXibke+CdUpw
 tjQApXhqGGlOiBPUUVJtZluOaxBuGm4x0uitXZ8QXFwqOhJdFkgc5Qzd/qy8LH/Tow3Q/5/14
 /d8pjAMvgreAjIwPxl9WouV/MZzrqowa6MqQpWyPtbffZ3I5biXV324aMZzq67PKD4T9LoWNO
 +E38FZg6acJ3ONetLX/1vFRZeBn2HwHmnGyIWR1WwskiSdgivkBTpDhT/2eBC4Zwc7E5iA/u6
 X5y7Kqt04xrUFKUQxjPzi4hHYk6Z1f6ZFkHNMfRO6/hcKGIvVSoSsgq1jROlaC+ypEKGhUt6h
 UMz6vAr3C9epVpR9s+Y4n96P4eQOecvJYt5ELQ6CV0sR3TZ2hlYYPRgH0lAzV8xqvYLedrTKl
 YYN0p2UQ31lfD1t5QbArrm+ONtMXcXVuWUqyE7Q2FSH2KDA1AM6PQjnoSJm94lDgmF/qbezTF
 uRlo6wLyjrqmVpSxhkPcfC8mX02uw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Segev Finer <segev208@gmail.com>

Git for Windows has special support for the popular SSH client PuTTY:
when using PuTTY's non-interactive version ("plink.exe"), we use the -P
option to specify the port rather than OpenSSH's -p option. TortoiseGit
ships with its own, forked version of plink.exe, that adds support for
the -batch option, and for good measure we special-case that, too.

However, this special-casing of PuTTY only covers the case where the
user overrides the SSH command via the environment variable GIT_SSH
(which allows specifying the name of the executable), not
GIT_SSH_COMMAND (which allows specifying a full command, including
additional command-line options).

When users want to pass any additional arguments to (Tortoise-)Plink,
such as setting a private key, they are required to either use a shell
script named plink or tortoiseplink or duplicate the logic that is
already in Git for passing the correct style of command line arguments,
which can be difficult, error prone and annoying to get right.

This patch simply reuses the existing logic and expands it to cover
GIT_SSH_COMMAND, too.

Note: it may look a little heavy-handed to duplicate the entire
command-line and then split it, only to extract the name of the
executable. However, this is not a performance-critical code path, and
the code is much more readable this way.

Signed-off-by: Segev Finer <segev208@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 connect.c        | 23 ++++++++++++++++-------
 t/t5601-clone.sh | 15 +++++++++++++++
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/connect.c b/connect.c
index 8cb93b0720..c81f77001b 100644
--- a/connect.c
+++ b/connect.c
@@ -772,6 +772,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 			int putty = 0, tortoiseplink = 0;
 			char *ssh_host = hostandport;
 			const char *port = NULL;
+			char *ssh_argv0 = NULL;
 			transport_check_allowed("ssh");
 			get_host_and_port(&ssh_host, &port);
 
@@ -792,10 +793,15 @@ struct child_process *git_connect(int fd[2], const char *url,
 			}
 
 			ssh = get_ssh_command();
-			if (!ssh) {
-				const char *base;
-				char *ssh_dup;
-
+			if (ssh) {
+				char *split_ssh = xstrdup(ssh);
+				const char **ssh_argv;
+
+				if (split_cmdline(split_ssh, &ssh_argv))
+					ssh_argv0 = xstrdup(ssh_argv[0]);
+				free(split_ssh);
+				free((void *)ssh_argv);
+			} else {
 				/*
 				 * GIT_SSH is the no-shell version of
 				 * GIT_SSH_COMMAND (and must remain so for
@@ -807,8 +813,11 @@ struct child_process *git_connect(int fd[2], const char *url,
 				if (!ssh)
 					ssh = "ssh";
 
-				ssh_dup = xstrdup(ssh);
-				base = basename(ssh_dup);
+				ssh_argv0 = xstrdup(ssh);
+			}
+
+			if (ssh_argv0) {
+				const char *base = basename(ssh_argv0);
 
 				tortoiseplink = !strcasecmp(base, "tortoiseplink") ||
 					!strcasecmp(base, "tortoiseplink.exe");
@@ -816,7 +825,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 					!strcasecmp(base, "plink") ||
 					!strcasecmp(base, "plink.exe");
 
-				free(ssh_dup);
+				free(ssh_argv0);
 			}
 
 			argv_array_push(&conn->args, ssh);
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 4241ea5b32..9335e10c2a 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -386,6 +386,21 @@ test_expect_success 'tortoiseplink is like putty, with extra arguments' '
 	expect_ssh "-batch -P 123" myhost src
 '
 
+test_expect_success 'double quoted plink.exe in GIT_SSH_COMMAND' '
+	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink.exe" &&
+	GIT_SSH_COMMAND="\"$TRASH_DIRECTORY/plink.exe\" -v" \
+		git clone "[myhost:123]:src" ssh-bracket-clone-plink-3 &&
+	expect_ssh "-v -P 123" myhost src
+'
+
+SQ="'"
+test_expect_success 'single quoted plink.exe in GIT_SSH_COMMAND' '
+	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink.exe" &&
+	GIT_SSH_COMMAND="$SQ$TRASH_DIRECTORY/plink.exe$SQ -v" \
+		git clone "[myhost:123]:src" ssh-bracket-clone-plink-4 &&
+	expect_ssh "-v -P 123" myhost src
+'
+
 # Reset the GIT_SSH environment variable for clone tests.
 setup_ssh_wrapper
 
-- 
2.11.1.windows.prerelease.2.9.g3014b57


