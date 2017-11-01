Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6F582055E
	for <e@80x24.org>; Wed,  1 Nov 2017 17:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754846AbdKARKg (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 13:10:36 -0400
Received: from mout.gmx.net ([212.227.15.19]:50612 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752363AbdKARKe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 13:10:34 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mgc0l-1dora82Nnj-00O2Ql; Wed, 01
 Nov 2017 18:10:27 +0100
Date:   Wed, 1 Nov 2017 18:10:25 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 1/3] mingw: add experimental feature to redirect standard
 handles
In-Reply-To: <cover.1509556153.git.johannes.schindelin@gmx.de>
Message-ID: <21f71a95fbb1626ad5b98065571175c06e858f92.1509556153.git.johannes.schindelin@gmx.de>
References: <cover.1509382976.git.johannes.schindelin@gmx.de> <cover.1509556153.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Ngnj1O7l4OOMI1QkXJalM1gJxC1GrikaHwcyLdkta/xN208O4H0
 bTCZgOd/yPV85WsUHOEqBekcjDJDPu41amWCmq0SC6OaMCJ7M4a5+7yH3DW4yjFXNoG2P/c
 ofLIvyopr0TsM87h/s+tXWfjDJaB+L296h1qvGaaP6stqASYUdxW2E0YQ1HnFSyphaqVGdV
 1ut4Aj63z8L57fV2vnWjQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wpfq/7UCQPw=:QJc7dTS/mF0J7pT0WPFElv
 1YuKkAv4ww2PeCOlhbw6Lzskvv+XlnuJhtjEtXkNqE5d6VsBPNPQ3+F1urOC53bW2RxivyNVL
 Ug31Gty8pGoo5xjQ/JzNwmBS/s9Jm2BZ+fIRW6RMKp3MQHAUERwEOucxHJ5CRJ1gV40ibpZKq
 b7kKs2ressEci1gw84cBXwCTeaFQibZWf20A2IxSRJlQNqkwmScDXJQ6MXtv5FoKzrn74BLpx
 f9zjz/jzDqDcnXHOnR2Kgm7itkzVlSunyF7T4ATg8ZHSA8RbieGxckCkBRyl6OA4oa+yPwd2d
 FGmqNOc2vS1vY4TkDjzxoB3HYLrMEJoyTpKNuyHvlhyuVXZjHjdIzE68k6TUf4Xmgn4GQNDsM
 zLn6VUF+kVRvFfGcson088uS6vrXlNoZyH/fwEjDE1MAtw+s9t54tapx/9vpU5Twp1bTHTA8r
 joj0+sftLekPkc70zN7ZhCtLyNOTZTkIPmJkaz8kiLC7vaQALW2ZdoGVaVe1lAkaZ2WS9oNFx
 ZOTXrljTTB+13ejVhSestU7aNXBrmUUccDxpJGb1aErSSxF/Hs0/YtZyKl8De+Y5geEgmAjgS
 p34XAnCWmHikuYDN+mQUO/owogKU/63VfRdyRD0j/y39pM9U6bvuKiinp5fpOXddLv3Q4yfna
 SI4gqEiqh+pfnRR0U8gvkY/38rYjGFliHF2C8DF9yqXki1oyPB9ZbzO4OWpyMxoxdQrYa+3zd
 QixDGXnGX/pwn2YC7TFDTSiswbIs8FHGmLi2HDdidSsBR4PqJHl5puuz7Ga7HRX2Ad1n3CiK+
 9Bs4zBjeHSJiW5RTHCMXdovFuKan27xs0BnIMbjcp84uMrk3fmV2xutGWy2LC+cCKjiWfmZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Particularly when calling Git from applications, such as Visual Studio's
Team Explorer, it is important that stdin/stdout/stderr are closed
properly. However, when spawning processes on Windows, those handles
must be marked as inheritable if we want to use them, but that flag is a
global flag and may very well be used by other spawned processes which
then do not know to close those handles.

Let's introduce a set of environment variables (GIT_REDIRECT_STDIN and
friends) that specify paths to files, or even better, named pipes (which
are similar to Unix sockets) and that are used by the spawned Git
process.  This helps work around above-mentioned issue: those named
pipes will be opened in a non-inheritable way upon startup, and no
handles are passed around (and therefore no inherited handles need to be
closed by any spawned child).

This feature shipped with Git for Windows (marked as experimental) since
v2.11.0(2), so it has seen some serious testing in the meantime.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
 t/t0001-init.sh |  6 ++++++
 2 files changed, 49 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 8b6fa0db446..6c6c7795a70 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2139,6 +2139,47 @@ static char *wcstoutfdup_startup(char *buffer, const wchar_t *wcs, size_t len)
 	return memcpy(malloc_startup(len), buffer, len);
 }
 
+static void maybe_redirect_std_handle(const wchar_t *key, DWORD std_id, int fd,
+				      DWORD desired_access, DWORD flags)
+{
+	DWORD create_flag = fd ? OPEN_ALWAYS : OPEN_EXISTING;
+	wchar_t buf[MAX_PATH];
+	DWORD max = ARRAY_SIZE(buf);
+	HANDLE handle;
+	DWORD ret = GetEnvironmentVariableW(key, buf, max);
+
+	if (!ret || ret >= max)
+		return;
+
+	/* make sure this does not leak into child processes */
+	SetEnvironmentVariableW(key, NULL);
+	if (!wcscmp(buf, L"off")) {
+		close(fd);
+		handle = GetStdHandle(std_id);
+		if (handle != INVALID_HANDLE_VALUE)
+			CloseHandle(handle);
+		return;
+	}
+	handle = CreateFileW(buf, desired_access, 0, NULL, create_flag,
+			     flags, NULL);
+	if (handle != INVALID_HANDLE_VALUE) {
+		int new_fd = _open_osfhandle((intptr_t)handle, O_BINARY);
+		SetStdHandle(std_id, handle);
+		dup2(new_fd, fd);
+		close(new_fd);
+	}
+}
+
+static void maybe_redirect_std_handles(void)
+{
+	maybe_redirect_std_handle(L"GIT_REDIRECT_STDIN", STD_INPUT_HANDLE, 0,
+				  GENERIC_READ, FILE_ATTRIBUTE_NORMAL);
+	maybe_redirect_std_handle(L"GIT_REDIRECT_STDOUT", STD_OUTPUT_HANDLE, 1,
+				  GENERIC_WRITE, FILE_ATTRIBUTE_NORMAL);
+	maybe_redirect_std_handle(L"GIT_REDIRECT_STDERR", STD_ERROR_HANDLE, 2,
+				  GENERIC_WRITE, FILE_FLAG_NO_BUFFERING);
+}
+
 void mingw_startup(void)
 {
 	int i, maxlen, argc;
@@ -2146,6 +2187,8 @@ void mingw_startup(void)
 	wchar_t **wenv, **wargv;
 	_startupinfo si;
 
+	maybe_redirect_std_handles();
+
 	/* get wide char arguments and environment */
 	si.newmode = 0;
 	if (__wgetmainargs(&argc, &wargv, &wenv, _CRT_glob, &si) < 0)
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 86c1a51654f..0fd2fc45385 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -453,4 +453,10 @@ test_expect_success 're-init from a linked worktree' '
 	)
 '
 
+test_expect_success MINGW 'redirect std handles' '
+	GIT_REDIRECT_STDOUT=output.txt git rev-parse --git-dir &&
+	test .git = "$(cat output.txt)" &&
+	test -z "$(GIT_REDIRECT_STDOUT=off git rev-parse --git-dir)"
+'
+
 test_done
-- 
2.15.0.windows.1


