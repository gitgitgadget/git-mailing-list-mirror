Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F28021F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 12:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058AbcHOMnm (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 08:43:42 -0400
Received: from mout.gmx.net ([212.227.15.18]:64844 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752786AbcHOMnl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 08:43:41 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Me8di-1bqNJn15t0-00Prjw; Mon, 15 Aug 2016 14:43:21
 +0200
Date:	Mon, 15 Aug 2016 14:43:18 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>, ryenus <ryenus@gmail.com>,
	=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] rev-parse: respect core.hooksPath in --git-path
Message-ID: <520a941f7472ac1cb4fa41e6bba33a0afc2f5999.1471264971.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cMsptMn7DuAHAdCbE3DiiOTqzJnSbVrkJVJzSHOdLiBKE+5xjBZ
 hKvpHeYDzo2PXXROAzMYVZTA6seliyIzlrcrU6Awr+YlDw/0FxLXaEtQLLWYspnJUW2P7Us
 LhViFaoAQPSlFRzws81EzKe9jo3SiYukkf7HqnhZ9OU4OPRqXZLcpp+991OhpRC2GtTH4Bs
 DOYk0OMsbJ4SoJiyExFGw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:rV54s5Ott3w=:uglf9LwfIIDdmo7P1597JR
 7Yy8ysXnfXBrYcLNsxmRAlz35fkqsEuidoMMlJiBGUESghlNvLg2RG/bjjEeRJ2co6WGbD23U
 Dk/kz1U9SxqFlDKBqw1SDveEmH389QE+bAUC9fXXkessoNXYMQGshgKx4iirhFu3xGmWov6mP
 Gfuurv3iluXCaX1iL8JeAFXsOhEp27oDyUZD18U98uyeo3+sGcuyT+mEAOdZd4LCbgDIwLER2
 p9MNI6rwUojkx4/FzTFq0fp5qfgxStphzJrKlVckwR3TVU1uxw/we4iFKwvaCIVbtWsVRrauE
 n9NMZ/yWVTc7o8fxBHXEqFmo6foPI+nt/OnL+CCUEhBnJoQdG2ADFhT/hcgvQA1su6dE8xM+P
 2X7MByGZ+cCnkl+Gi6IOyEYf85A8LAhGeVYMmYRd6nkDQbvNnG4Tpfy9x/51DtJaCk4nsq4WM
 EVB/GowKZyN9MKEacAPTyj0kSOm8/5cjJqyfGR2tCqOWqMK9T+3qXSiwmPASLAGfkcHt2Ce2/
 1RzglUb+F4n1Atbj6ruPeDO1LY1m0wNzC6+tDMMvNhA0X3gsiPP2FpaMS0dzrlTNCXXytxpLk
 fUc2nUMrK5XTkpmsWxBiG61iKh5fObw7TgOte2HVl9YqMEeNOe0vQCvs9MBCuEUhBK7+nhSRQ
 0vBgX0YiyMdo6JwyTk8K1nLL6HuQdg8QmntrtZBgnw5MxzjP5KUMC9z4iJ9bHeAFIObGL9skH
 YppbZOWwrn713VKTFOYkTH0Iw+/epBADDGLj2kNFnJ3j/dGJqzk71ELpwwDi7FIw7DucXGGob
 exsdSEF
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The idea of the --git-path option is not only to avoid having to
prefix paths with the output of --git-dir all the time, but also to
respect overrides for specific common paths inside the .git directory
(e.g. `git rev-parse --git-path objects` will report the value of
the environment variable GIT_OBJECT_DIRECTORY, if set).

When introducing the core.hooksPath setting, we forgot to adjust
git_path() accordingly. This patch fixes that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/git-path-hooks-v1
Fetch-It-Via: git fetch https://github.com/dscho/git git-path-hooks-v1

 path.c                       | 2 ++
 t/t1350-config-hooks-path.sh | 6 ++++++
 2 files changed, 8 insertions(+)

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

base-commit: 726cc2ba12c4573ab2e623077479c51019e1f3cd
