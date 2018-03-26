Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 083B31FAE2
	for <e@80x24.org>; Mon, 26 Mar 2018 21:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbeCZVbo (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 17:31:44 -0400
Received: from mout.gmx.net ([212.227.17.20]:37619 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751903AbeCZVbn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 17:31:43 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LymjL-1eXCJg0UhL-0168MV; Mon, 26
 Mar 2018 23:31:39 +0200
Date:   Mon, 26 Mar 2018 23:31:38 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Dan Jacques <dnj@google.com>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH 1/2] exec_cmd: provide a new-style RUNTIME_PREFIX helper for
 Windows
In-Reply-To: <20180325205120.17730-1-dnj@google.com>
Message-ID: <nycvar.QRO.7.76.6.1803262331370.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180325205120.17730-1-dnj@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RxqKNifM5wC0Gmd69M1SNsB3CWyYK5KDh5X/4U0G9uCCbiQ2oBV
 7usFQsR+x/tc0fiaWts457G/PhdHeLH37Bo9PFOkHCSd+L99Z+aAfxn1DC/ZF0PXdWgp75j
 uNxhXIqKzwpgiSxCZ/Vns5gq5l5l5M6BQ8T6x4IWfoQbkRK4R2Ch3+exdXAo+iB6LxxkIT9
 3rAK0/1LRneQbNOiKbW9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WWxa5Xv2LEY=:EQu1X7R8Pab0rxt7We+3KB
 ZYar8gEdA/0ytNgFnfQfv0dEcsgzqIjJUSN4Zk1KQMCuZA2YUa5Jj0UwauqDPaWZX07OMGDEL
 sA5vfLjc4IArS3knYz7Z2dBtBT3CbMFU9ol7aLMI949RhbvGbM0R6j3d9ZR6GC3kYVU8HJSav
 UxKMdMVmSE566kAu2TRZp74ITsGVuRzjFMLUpxA6xGApnTZYtji/DV3cURbMEe4kj7fAZapxX
 YImyyO4Zwoeul6C/2dyaFzM5l5i0MXAWxuyTTBA00b4XFPk/D5giLBwMU0Kvm+xlgvGiq8Sk5
 UoB25hdrCqbtv2fTZaN5J1+wSY9YoX81pWXp3Hd17CVlCIn2XwAmCwVzfuxb+fsrrEcvE4MJr
 JNu6fhR5IZpPlM+oW4w/1TMNixIVTexprg/ih8gCgvinXIuLjT1A55bW1o/8UhVbgd7RLljNO
 Bw+A/UIQxdQPIW66OJtPCqOkjadKv69+pY4QFe5SyzWBod/NIIiHC7Jmztxn3mHWEHRg4JbVb
 GmKHzMMw3NWAtNoCGFSpIwSAmZmsPPcHHM8abv1qh8jIDHkmShZO5OQXdgqAeaijwRictZ6To
 yTfJI+gYUrK79fyqhbw1bHv9f6cv36hhUNDqaxmAT4rF4UU5YPdlDFddHtG378bY44stRJQRa
 Weq3vXYeZOB/yHunRObT109zJbBwnYKdmuEB9SULsZzOTyQ88//AVdrfVPGThvi1ajPOh721+
 CrukWF8+nitveKVXUSRtYhhboWG4HJPtfbZCtUM+vesnD29vaHQKWnrXIZKrLn8D8/P+T9VqW
 HaVOGsHe+X05j1WsGUJ5tUVw57j7lqX8fi/5SBgV7qLVHlyxo/MQsUI8tHgIYKH4k2Ynhb+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The RUNTIME_PREFIX feature comes from Git for Windows, but it was
enhanced to allow support for other platforms. While changing the
original idea, the concept was also improved by not forcing argv[0] to
be adjusted.

Let's allow the same for Windows by implementing a helper just as for
the other platforms.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile   |  8 ++++++++
 exec_cmd.c | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/Makefile b/Makefile
index f84e816..c944168 100644
--- a/Makefile
+++ b/Makefile
@@ -453,6 +453,10 @@ all::
 # When using RUNTIME_PREFIX, define HAVE_NS_GET_EXECUTABLE_PATH if your platform
 # supports calling _NSGetExecutablePath to retrieve the path of the running
 # executable.
+#
+# When using RUNTIME_PREFIX, define HAVE_WPGMPTR if your platform offers
+# the global variable _wpgmptr containing the absolute path of the current
+# executable (this is the case on Windows).
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1693,6 +1697,10 @@ ifdef HAVE_NS_GET_EXECUTABLE_PATH
 	BASIC_CFLAGS += -DHAVE_NS_GET_EXECUTABLE_PATH
 endif
 
+ifdef HAVE_WPGMPTR
+	BASIC_CFLAGS += -DHAVE_WPGMPTR
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
diff --git a/exec_cmd.c b/exec_cmd.c
index 38d52d9..6e114f8 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -144,6 +144,24 @@ static int git_get_exec_path_darwin(struct strbuf *buf)
 }
 #endif /* HAVE_NS_GET_EXECUTABLE_PATH */
 
+#ifdef HAVE_WPGMPTR
+/*
+ * Resolves the executable path by using the global variable _wpgmptr.
+ *
+ * Returns 0 on success, -1 on failure.
+ */
+static int git_get_exec_path_wpgmptr(struct strbuf *buf)
+{
+	int len = wcslen(_wpgmptr) * 3 + 1;
+	strbuf_grow(buf, len);
+	len = xwcstoutf(buf->buf, _wpgmptr, len);
+	if (len < 0)
+		return -1;
+	buf->len += len;
+	return 0;
+}
+#endif /* HAVE_WPGMPTR */
+
 /*
  * Resolves the absolute path of the current executable.
  *
@@ -178,6 +196,10 @@ static int git_get_exec_path(struct strbuf *buf, const char *argv0)
 		git_get_exec_path_procfs(buf) &&
 #endif /* PROCFS_EXECUTABLE_PATH */
 
+#ifdef HAVE_WPGMPTR
+		git_get_exec_path_wpgmptr(buf) &&
+#endif /* HAVE_WPGMPTR */
+
 		git_get_exec_path_from_argv0(buf, argv0)) {
 		return -1;
 	}
-- 
2.7.4

