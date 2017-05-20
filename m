Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ABCA201A7
	for <e@80x24.org>; Sat, 20 May 2017 19:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756550AbdETTfq (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 15:35:46 -0400
Received: from mout.web.de ([217.72.192.78]:54942 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756535AbdETTfp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 15:35:45 -0400
Received: from [192.168.178.36] ([79.213.117.211]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lylrf-1e0R6z1g5X-0167Mq; Sat, 20
 May 2017 21:35:38 +0200
Subject: [PATCH v2] mingw: simplify PATH handling
To:     Git List <git@vger.kernel.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <c5b7292f-6367-e4a9-2ee0-96b93b1b587f@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f4119dba-0e25-0a0b-0796-dc4c3d4d1cc5@web.de>
Date:   Sat, 20 May 2017 21:35:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <c5b7292f-6367-e4a9-2ee0-96b93b1b587f@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:bNy9G03GMb6/lr5zZHpxOVpQW9GW5dHlcNyCr0ZsS0K7qFBlGK3
 hCEGn83js3bUy4zLNtzjw9wLgJhbB8wRuzgukUfxUC2KdC3jvB/5TAFXWuaY9iOcyya9aIO
 n0m7/biEpxCQTycTacG/vR9m9ZqL438tjoQEwyD21Cio3CM7HIdSFyoBK7i1E55x9NXfQtd
 ys+tRN0tMuvrzUKhAmxtQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zc5NkX3PjL4=:p5gj83bFV8taH6CIZILq7R
 +pZXW6GJts30LUxPVMud3I3QHfKz0GN5FeCPnvp35UJyKMw/sWc62vWP3/jxtb/Jwsy1lKk+w
 SY/MT6sRKCZwHXOPm70N41v6rkSmt1fPieI6PKTtfIH6aeDH2cGV4+oHcftC7gPe9Ic7qkRgz
 EsO6K29EW8jD+3+qoewNHnazX7tO1kohdNUMLKQgKEeFcuB7VyeUMH57qyAXuFRijnj7TTCGz
 yyQrsdq3h/3hjJCTW+WH6iP4m1ZGrx7dPqfQZteTQt3fQR0wM96tlIl7f5GvayXm0e4w1ZtQo
 BgdCr++HoGaPWlCy7rAqwj42FM/ixDDsmgDn1Nze8q0ZXwiWriVfhgbyjOJGw4u3LDqZDS7FE
 P+FdetqiE4+fva1OPYIXtisD5eUw2ev7/YxHLQjG6F9PlBvAsH2BeX1WNpGYdmuuof6O4eJbj
 qKp/LbR9qccKpVmfkvkpG+RCIptBXpI6ZaVKwo1GeNzLlfTA+n9oRiocooMMROqfar7rEr0A/
 ArhvFI3mhfgJqafwRmhA2aivaqraTi5dI+XKw8FQyv44VdFojOJZK+HzwR+qWR47te3DCMQ3+
 /K3oTaZVrhI5l19m9eSK628HKVws9O5LAsiPH//S0QtUxIZcVThOQ4+C8exScF4p80K+p2+z4
 wDHi63yfBYjbuGW2qOKbThm8yL1bJvGvqSf5l7bLPTIGJQ0LOV4etKyL872tDjafYAfAeEKGo
 9BrWwvQ1jtI781+Jr/dRRRVw2qM+/2g12HYmOWrYzpwBK95/jN+8vo77sy0HDxrdkYjwzX+LJ
 z4Psame
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Windows the environment variable PATH contains a semicolon-separated
list of directories to search for, in order, when looking for the
location of a binary to run.  get_path_split() parses it and returns an
array of string copies, which is iterated by path_lookup(), which in
turn passes each entry to lookup_prog().

Change lookup_prog() to take the directory name as a length-limited
string instead of as a NUL-terminated one and parse PATH directly in
path_lookup().  This avoids memory allocations, simplifying the code.

Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Rebased against Junio's master, fixed string overrun.  Can hold and
resubmit in a few months if it gets in the way right now.

 compat/mingw.c | 91 +++++++++++++++-------------------------------------------
 1 file changed, 23 insertions(+), 68 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 3fbfda5978..c6134f7c81 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -941,64 +941,14 @@ static const char *parse_interpreter(const char *cmd)
 }
 
 /*
- * Splits the PATH into parts.
- */
-static char **get_path_split(void)
-{
-	char *p, **path, *envpath = mingw_getenv("PATH");
-	int i, n = 0;
-
-	if (!envpath || !*envpath)
-		return NULL;
-
-	envpath = xstrdup(envpath);
-	p = envpath;
-	while (p) {
-		char *dir = p;
-		p = strchr(p, ';');
-		if (p) *p++ = '\0';
-		if (*dir) {	/* not earlier, catches series of ; */
-			++n;
-		}
-	}
-	if (!n)
-		return NULL;
-
-	ALLOC_ARRAY(path, n + 1);
-	p = envpath;
-	i = 0;
-	do {
-		if (*p)
-			path[i++] = xstrdup(p);
-		p = p+strlen(p)+1;
-	} while (i < n);
-	path[i] = NULL;
-
-	free(envpath);
-
-	return path;
-}
-
-static void free_path_split(char **path)
-{
-	char **p = path;
-
-	if (!path)
-		return;
-
-	while (*p)
-		free(*p++);
-	free(path);
-}
-
-/*
  * exe_only means that we only want to detect .exe files, but not scripts
  * (which do not have an extension)
  */
-static char *lookup_prog(const char *dir, const char *cmd, int isexe, int exe_only)
+static char *lookup_prog(const char *dir, int dirlen, const char *cmd,
+			 int isexe, int exe_only)
 {
 	char path[MAX_PATH];
-	snprintf(path, sizeof(path), "%s/%s.exe", dir, cmd);
+	snprintf(path, sizeof(path), "%.*s\\%s.exe", dirlen, dir, cmd);
 
 	if (!isexe && access(path, F_OK) == 0)
 		return xstrdup(path);
@@ -1013,17 +963,29 @@ static char *lookup_prog(const char *dir, const char *cmd, int isexe, int exe_on
  * Determines the absolute path of cmd using the split path in path.
  * If cmd contains a slash or backslash, no lookup is performed.
  */
-static char *path_lookup(const char *cmd, char **path, int exe_only)
+static char *path_lookup(const char *cmd, int exe_only)
 {
+	const char *path;
 	char *prog = NULL;
 	int len = strlen(cmd);
 	int isexe = len >= 4 && !strcasecmp(cmd+len-4, ".exe");
 
 	if (strchr(cmd, '/') || strchr(cmd, '\\'))
-		prog = xstrdup(cmd);
+		return xstrdup(cmd);
+
+	path = mingw_getenv("PATH");
+	if (!path)
+		return NULL;
 
-	while (!prog && *path)
-		prog = lookup_prog(*path++, cmd, isexe, exe_only);
+	while (!prog) {
+		const char *sep = strchrnul(path, ';');
+		int dirlen = sep - path;
+		if (dirlen)
+			prog = lookup_prog(path, dirlen, cmd, isexe, exe_only);
+		if (!*sep)
+			break;
+		path = sep + 1;
+	}
 
 	return prog;
 }
@@ -1190,8 +1152,7 @@ pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **deltaenv,
 		     int fhin, int fhout, int fherr)
 {
 	pid_t pid;
-	char **path = get_path_split();
-	char *prog = path_lookup(cmd, path, 0);
+	char *prog = path_lookup(cmd, 0);
 
 	if (!prog) {
 		errno = ENOENT;
@@ -1202,7 +1163,7 @@ pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **deltaenv,
 
 		if (interpr) {
 			const char *argv0 = argv[0];
-			char *iprog = path_lookup(interpr, path, 1);
+			char *iprog = path_lookup(interpr, 1);
 			argv[0] = prog;
 			if (!iprog) {
 				errno = ENOENT;
@@ -1220,21 +1181,18 @@ pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **deltaenv,
 					       fhin, fhout, fherr);
 		free(prog);
 	}
-	free_path_split(path);
 	return pid;
 }
 
 static int try_shell_exec(const char *cmd, char *const *argv)
 {
 	const char *interpr = parse_interpreter(cmd);
-	char **path;
 	char *prog;
 	int pid = 0;
 
 	if (!interpr)
 		return 0;
-	path = get_path_split();
-	prog = path_lookup(interpr, path, 1);
+	prog = path_lookup(interpr, 1);
 	if (prog) {
 		int argc = 0;
 		const char **argv2;
@@ -1253,7 +1211,6 @@ static int try_shell_exec(const char *cmd, char *const *argv)
 		free(prog);
 		free(argv2);
 	}
-	free_path_split(path);
 	return pid;
 }
 
@@ -1275,8 +1232,7 @@ int mingw_execv(const char *cmd, char *const *argv)
 
 int mingw_execvp(const char *cmd, char *const *argv)
 {
-	char **path = get_path_split();
-	char *prog = path_lookup(cmd, path, 0);
+	char *prog = path_lookup(cmd, 0);
 
 	if (prog) {
 		mingw_execv(prog, argv);
@@ -1284,7 +1240,6 @@ int mingw_execvp(const char *cmd, char *const *argv)
 	} else
 		errno = ENOENT;
 
-	free_path_split(path);
 	return -1;
 }
 
-- 
2.12.1.windows.1
