Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AB3A1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 12:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753024AbdFMMEv (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 08:04:51 -0400
Received: from mout.gmx.net ([212.227.17.20]:64584 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752489AbdFMMEt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 08:04:49 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJSuF-1dHjl10VEh-0036JA; Tue, 13
 Jun 2017 14:04:36 +0200
Date:   Tue, 13 Jun 2017 14:04:34 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 5/6] t7006: demonstrate a problem with aliases in
 subdirectories
In-Reply-To: <cover.1497355444.git.johannes.schindelin@gmx.de>
Message-ID: <b4a9d03aa663c00e3f068ab2e2be37868825ead2.1497355444.git.johannes.schindelin@gmx.de>
References: <cover.1497355444.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:iByu9zNFmZ8495kTZmgHoB2D/nwtdpwXNSrZZKEEjfsgcdLuD4J
 2/HKrwIucD0YT7I60k4ZorS4Vf1dG1tnY0Pcd7T2k0Vtzzzc9uSvQin+xamGB+Wax9RJ6mP
 CWRpfPhNSz61rY7GskDQaL0hjeYQQEEBlW5j/GyFJh6VydFGMnw7vvea2Fkh2qoTBgJxDZc
 4mEPpa9uv+ZSaBxWk+xtA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HcXbbCcjhYw=:5sbVLTObqfhMXaccJfTn8Q
 gLKjbIaQp04Hyiik5ES3coPO+6SZMG37zc6ssWq5IpddD0BstQO+YCTfc8oiVbNQoWRyMFgax
 wYNvTVFjs5zU87N9sabZDMZl41bwK13CVTTP35uqYv3eA+LXC8qEkxThL6TISmz/1EfQ7KPXg
 L9mHjjNuPWby3DCDRllMSzeCVr2JqnNeLRcQ08oh7uN1GJ7E0RdiMWQ/E9xJtjBzBYuI7j9WT
 v3sPrYYFAHerheDQB+p1BG0BtBsMmx00gSJCBoOq0RGIBOtBF/J5TnexgVUiadY9uGpdXAlRV
 eT/B2D27w6aMJPXexbU7x4WssOKIYj6s/QHA3FD+/irwYZWo3NfZSkX+wI6rV/qLhzp97dM0C
 POSOBourpE66Ln/yCv1uUhOD0EvB4FkTmfN6BtQmx6HVmbomOmDSWuBMZxSUoPT20eZOFi+sC
 R+RTDM3PQ3pbxbs5gCmZ8XaAxQYbRqNI6+YQCQwi4oDoPQUmVhZHcqb+p8QswnMtP8yYNuBGK
 CSeMultgManKGX1rIMVSL0+Q3o0QjSR4aqWFUbgtMhr/AE8USFdgZc4KHAgOQGlJqmm7AHX42
 4WJzdTmXKybllv6Q5ScxqIUMJ3/5PWF9fp8lUDdXKv777t4EYBNcnJorMOR6Oo/uKoJOEK3tX
 88emkhVcraCWzxKE4QXmR/A3dJMPseR1jImomiDLVQug9P6y0n1LlFpD8X5/RW0yuVya6xf8S
 3srcQ1fiV4SHebWw0nLk10McTiNAOl/eTYeeE+IueNl0QimVgluu5MQRG41BcK9XZdpN8oJyd
 NZlf8/U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When expanding aliases, the git_dir is set during the alias expansion
(by virtue of running setup_git_directory_gently()).

This git_dir may be relative to the current working directory, and
indeed often is simply ".git/".

When the alias expands to a shell command, we restore the original
working directory, though, yet we do not reset git_dir.

As a consequence, subsequent read_early_config() runs will mistake the
git_dir to be populated properly and not find the correct config.

Demonstrate this problem by adding a test case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7006-pager.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 4f3794d415e..83881ec3a0c 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -391,6 +391,17 @@ test_expect_success TTY 'core.pager in repo config works and retains cwd' '
 	)
 '
 
+test_expect_failure TTY 'core.pager is found via alias in subdirectory' '
+	sane_unset GIT_PAGER &&
+	test_config core.pager "cat >via-alias" &&
+	(
+		cd sub &&
+		rm -f via-alias &&
+		test_terminal git -c alias.r="-p rev-parse" r HEAD &&
+		test_path_is_file via-alias
+	)
+'
+
 test_doesnt_paginate      expect_failure test_must_fail 'git -p nonsense'
 
 test_pager_choices                       'git shortlog'
-- 
2.13.0.windows.1.460.g13f583bedb5


