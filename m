Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0D9A1F859
	for <e@80x24.org>; Tue, 16 Aug 2016 13:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444AbcHPNPW (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 09:15:22 -0400
Received: from mout.gmx.net ([212.227.15.15]:58581 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753302AbcHPNOu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 09:14:50 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lee2I-1aqAYc1pra-00qVCF; Tue, 16 Aug 2016 15:14:28
 +0200
Date:	Tue, 16 Aug 2016 15:14:27 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>, ryenus <ryenus@gmail.com>,
	=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2] rev-parse: respect core.hooksPath in --git-path
In-Reply-To: <520a941f7472ac1cb4fa41e6bba33a0afc2f5999.1471264971.git.johannes.schindelin@gmx.de>
Message-ID: <ce8891377cec31cada49208f2d192dda86658e40.1471353054.git.johannes.schindelin@gmx.de>
References: <520a941f7472ac1cb4fa41e6bba33a0afc2f5999.1471264971.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:BZSQfnsgm8ZW9w1YM8RSlNDuy7vuBFcttwSxJFAS4x8PThBfE2G
 ovtztqTCPuXwuKBt6XCxvIVgZSrWQ1MhoJV9udzkY5X6pBjUYHq7U7mbyxiqMkvBkPtNijq
 JZaWL2AbwstsDFZOEwE7rw+r6dw8WqiHuqKaTpKf5vP6Bc5zDJXCVqlzwKOfZd9TUxgg3iK
 IRIsy7RyJi1brs6c05c2Q==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Y/7hc42uRmw=:x2yYlynYr9fGsLdMeh9pyb
 EFpfOtrlFuh3W4OJub5h6DPeXmrrX8M1v3qVufwOVecw2pRO3TMEPTkY56wN02+8MbT5m0dwX
 socv+V0TTWUKwapc79nmZUWAt8yCimX4qaiKyFtUtadypIZqnb9rkmgSSrwDKvu2+J3l26nXi
 E8KkGc7LkN3j4CJ2K3lGO80WcpKFPfi96Hwxb/cHIZ0TfeOoqn8NRZ16ByD17EQKbcQKfFLDV
 eqA+Vd2Q5T8q8QPSkfMb5KmPb/B/RAlaQlKLnWY3JYZOFzm5Gha3srNSfvsrww2ihOx+p3Lr/
 Lnh9EZrzeYMZIZp+akMZjdj9YxZXzk3ZwaucXTwNtsBj0RyN8gDsO+jlb3W9XSbx9kVPbPld0
 80hARQQMLO9t8xsSevfwtM121luGcQYAKasIWFERUN/+N+FHkn9ABiD6TJWynNQseLVzCUfQP
 DKoB9DC3a4KIVLbpgPZfJ5omOSpA8l53Jc+kwcsIOyxT2He5Mm+Qt2PzwRvacDHuTWXd6LcVH
 gIAvSOMgx/yn7BB8bLnNQRl19GWoSdvhp5Lr9/E0neeatWS2GtnQ7LpgxEbdqLeiK0/KlDp5A
 VCsgOK6zbSy4pj4dHctl82X/OHXlnN10EGVTUUP5FDdecx44yc+hTash6ZcWeHieLzZdSkkPW
 RNGsaCQGwuuk9lXELjZVqPnnaDa8gxBi1gli/ScBVYxmjWpsbtPGI3gsOw4K+Hvc6jiDZ9ueU
 zP5Uqag6FL3N+I6sEsxZTDz+2Ngf93QMlxB3idKgfVNAoyd4gXOxMlIougnP7vDyAKtfog4ro
 tWsRXU1
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The idea of the --git-path option is not only to avoid having to
prefix paths with the output of --git-dir all the time, but also to
respect overrides for specific common paths inside the .git directory
(e.g. `git rev-parse --git-path objects` will report the value of the
environment variable GIT_OBJECT_DIRECTORY, if set).

When introducing the core.hooksPath setting, we forgot to adjust
git_path() accordingly. This patch fixes that.

While at it, revert the special-casing of core.hooksPath in
run-command.c, as it is now no longer needed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/git-path-hooks-v2
Fetch-It-Via: git fetch https://github.com/dscho/git git-path-hooks-v2
Interdiff vs v1:

 diff --git a/run-command.c b/run-command.c
 index 33bc63a..5a4dbb6 100644
 --- a/run-command.c
 +++ b/run-command.c
 @@ -824,10 +824,7 @@ const char *find_hook(const char *name)
  	static struct strbuf path = STRBUF_INIT;
  
  	strbuf_reset(&path);
 -	if (git_hooks_path)
 -		strbuf_addf(&path, "%s/%s", git_hooks_path, name);
 -	else
 -		strbuf_git_path(&path, "hooks/%s", name);
 +	strbuf_git_path(&path, "hooks/%s", name);
  	if (access(path.buf, X_OK) < 0)
  		return NULL;
  	return path.buf;


 path.c                       | 2 ++
 run-command.c                | 5 +----
 t/t1350-config-hooks-path.sh | 6 ++++++
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/path.c b/path.c
index 17551c4..fe3c4d9 100644
--- a/path.c
+++ b/path.c
@@ -380,6 +380,8 @@ static void adjust_git_path(struct strbuf *buf, int git_dir_len)
 			      get_index_file(), strlen(get_index_file()));
 	else if (git_db_env && dir_prefix(base, "objects"))
 		replace_dir(buf, git_dir_len + 7, get_object_directory());
+	else if (git_hooks_path && dir_prefix(base, "hooks"))
+		replace_dir(buf, git_dir_len + 5, git_hooks_path);
 	else if (git_common_dir_env)
 		update_common_dir(buf, git_dir_len, NULL);
 }
diff --git a/run-command.c b/run-command.c
index 33bc63a..5a4dbb6 100644
--- a/run-command.c
+++ b/run-command.c
@@ -824,10 +824,7 @@ const char *find_hook(const char *name)
 	static struct strbuf path = STRBUF_INIT;
 
 	strbuf_reset(&path);
-	if (git_hooks_path)
-		strbuf_addf(&path, "%s/%s", git_hooks_path, name);
-	else
-		strbuf_git_path(&path, "hooks/%s", name);
+	strbuf_git_path(&path, "hooks/%s", name);
 	if (access(path.buf, X_OK) < 0)
 		return NULL;
 	return path.buf;
diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-path.sh
index 5e3fb3a..f1f9aee 100755
--- a/t/t1350-config-hooks-path.sh
+++ b/t/t1350-config-hooks-path.sh
@@ -34,4 +34,10 @@ test_expect_success 'Check that various forms of specifying core.hooksPath work'
 	test_cmp expect actual
 '
 
+test_expect_success 'git rev-parse --git-path hooks' '
+	git config core.hooksPath .git/custom-hooks &&
+	git rev-parse --git-path hooks/abc >actual &&
+	test .git/custom-hooks/abc = "$(cat actual)"
+'
+
 test_done
-- 
2.9.2.691.g78954f3

base-commit: 07c92928f2b782330df6e78dd9d019e984d820a7
