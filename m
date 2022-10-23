Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE05C433FE
	for <git@archiver.kernel.org>; Sun, 23 Oct 2022 06:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiJWGrp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Oct 2022 02:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJWGrn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2022 02:47:43 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197CF69BFF
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 23:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1666507656; bh=zzF7YZrBndneTtRDpbRlOeJEhIkdTGPHsB3i4QHpBmI=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=pYZM9Pdn8t2nMzxePQTHRFgUp+Ge9gBPxkt20y1hwdINgZjibqqvlf7t/guPhCSqN
         i5OzluVGGgPNH2tijoxWRo5BNrmS8NfVe/IgSkUEaK+n4g6UBjTFs+UmQ9QsVKWDNa
         DBXmJtiIR8e8JTuUdrAV23NmeUxMEIoJmXJTlqjHlUYd50fJCstmgXiZ2Oq97O4Lp5
         AZVqLECnQTMVnXPDw62dx5f2FQ8mFX6U1OvnuUCXjRBbcLF3CUoBweLmESMart8Go+
         QAhxPMfN1kufu8xswVngXC6gcqwBnhPT1d7Co4HhYN9Ul91YskjERpdJwMxn57goem
         l0m7UF2ezR8Hw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.161]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2PdU-1oo9jC3MNy-004J1G; Sun, 23
 Oct 2022 08:47:36 +0200
Message-ID: <7a4e2fc6-3e01-5683-2be5-13b7e67c7fe5@web.de>
Date:   Sun, 23 Oct 2022 08:47:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] submodule: use strvec_pushf() for --super-prefix
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:muHf1zd69nFuUzvCTuB6kkmAJ732ITKtU0nycVtjABMqCY35oDK
 k1STczznrl6ycCZjuISO3JLq34HIP+pOPNNJYlxv2z+Z5wcNSbKGM5EuM54/e0kB2C7ZwLR
 qkIPf73zheosUDGzPiph5IYE9yS+tHrUhEv7MNsRRjm2b6XpGZM/m5nyqT5gS47/A3XDmmT
 jEum2nnBmw0SJeclN4BdQ==
UI-OutboundReport: notjunk:1;M01:P0:fdJz6kSGWNQ=;t/QXQItqHhHtpPFF9tHcaCjqF0M
 5W1yQwgyx2RKvTyiLn4m5gTBZ8fzxpK2PkmifclUddYi32l08BS2P7FZTx+HLFy8uZ8rplaVn
 ovih/5hdw0kutzxTA6ZDIhwXTuAjXtYtOiqpMHzZ6N9bFAMi7swbX3SGf6eH4Ww63prnBxHo5
 l2sQPZg//QThtaX850u/0UzbXtARgBF95JRo5PDBGi1IFGi/tfwqAolqsxpwPvPYXSOQPMi0m
 E56Ft1mwDn9Z4Ancg+cmP1YN1s2745lcoYytUuYP2kXi8WRHwMATqNJnPdaUB4PaGUhq3S0mg
 ZkVgK+WIW46pWHTB0J+LxNRDjWLEepaNKsKNx+bKNpZzkTUsenO6lFMEWQPJQzNePIF7T+97t
 ZWh8qSwWUO1RZU+XfmXeP3MvAHJehSsBoO/2BFq99SCXneSy54a6NZ+GnFanDHLhwlKWp+K1R
 EViZUGpxI2MnDE/1MrAq3UYY6Qo4oqRuNGRPa/jnIOtBFSyfTGq6RucwPKKxGbOhB/Flelc7t
 fMpoYJNrf+W99OP9MLnZYx6daoNqsDlC4DW1zfTnF7lTHsxeDpL1NKExF9It18YLeAWcfrWdH
 BQIbHgLTcRzIu2FUb5z79+/K0V9z8QClAak6WZEjzSPXsd1LYWJGU6ARFhrXdvA7MD6jZe2kz
 vJCe0mIRxWr+nN3p7x6Kh5/zs+BLWagdYI6W5Zun5VOhD1rHCRfocLWdiG/nZJbXUV9xi+b7b
 ZCaa5fiV9cLwUFC4U+VJJQYCvoPgyaYAkWxk7NmbNKQjZRwibM7NhSmyedNiu7NcrUkkHbKqV
 hRQY7lVvt3o5OqomioVyRLZmU8zqIHZ/JnsO1K7IfsJTnAh6JSXGDXP6tA4T7ebKCfeCfujh8
 Z/DzRbDRCA1yciXjlghB7SrjiopmDp4gDgrXJj1hLeTWfiektxKeKKM9dzd6nWmkZrh7ElKKD
 X6DZk3dj3Zx9/c8wyQytekJedCM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

absorb_git_dir_into_superproject() uses a strbuf and strvec_pushl() to
build and add the --super-prefix option and its argument.  Use a single
strvec_pushf() call to add the stuck form instead, which reduces the
code size and avoids a strbuf allocation and release.  The same is
already done in submodule_reset_index() and submodule_move_head().

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 submodule.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/submodule.c b/submodule.c
index bf7a2c7918..0a82aa9bdd 100644
=2D-- a/submodule.c
+++ b/submodule.c
@@ -2361,26 +2361,20 @@ void absorb_git_dir_into_superproject(const char *=
path,

 	if (flags & ABSORB_GITDIR_RECURSE_SUBMODULES) {
 		struct child_process cp =3D CHILD_PROCESS_INIT;
-		struct strbuf sb =3D STRBUF_INIT;

 		if (flags & ~ABSORB_GITDIR_RECURSE_SUBMODULES)
 			BUG("we don't know how to pass the flags down?");

-		strbuf_addstr(&sb, get_super_prefix_or_empty());
-		strbuf_addstr(&sb, path);
-		strbuf_addch(&sb, '/');
-
 		cp.dir =3D path;
 		cp.git_cmd =3D 1;
 		cp.no_stdin =3D 1;
-		strvec_pushl(&cp.args, "--super-prefix", sb.buf,
-			     "submodule--helper",
+		strvec_pushf(&cp.args, "--super-prefix=3D%s%s/",
+			     get_super_prefix_or_empty(), path);
+		strvec_pushl(&cp.args, "submodule--helper",
 			     "absorbgitdirs", NULL);
 		prepare_submodule_repo_env(&cp.env);
 		if (run_command(&cp))
 			die(_("could not recurse into submodule '%s'"), path);
-
-		strbuf_release(&sb);
 	}
 }

=2D-
2.38.1
