Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AA0C4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 19:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AFFD21D7F
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 19:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="L3u9slEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438403AbgJTTyA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 15:54:00 -0400
Received: from mail-02.mail-europe.com ([51.89.119.103]:39464 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbgJTTyA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 15:54:00 -0400
X-Greylist: delayed 44950 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Oct 2020 15:53:58 EDT
Date:   Tue, 20 Oct 2020 19:53:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1603223635;
        bh=gI+7SUKAeuZ0xrC3XdupDhUfvvdSBCt62A+DbMkIGW8=;
        h=Date:To:From:Reply-To:Subject:From;
        b=L3u9slEvlArIpr6Rv0ZqROVhlBljoHmGHdANpflU3lnVJfiKqxmNDTQt95Xf2AL5U
         nJkl9op6Xe6cA1qI+TrfwCHPxBrmNNoO0lLabN9am0wFSoCbSM0pitZgLFO+WJOBCh
         Ah3EaKamTo6dVGSunJ6hDh93nGSPI2tZm13eRQgU=
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Joey S <jgsal@protonmail.com>
Reply-To: Joey S <jgsal@protonmail.com>
Subject: [OUTREACHY][PATCH v2] t7006: Use test_path_is_* functions in test script
Message-ID: <KHJW7elqEfVsIp1V0WKPRVAB5xqCDJjjqLv8flthlDiSsSWjND-VVGG2zL-xOYMstk-q0JR3OiSggcMlFgzkIKm2podjzAyamb0pW-wx1ZY=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Modernize the test by replacing `test -e` instances with
`test_path_is_file` helper functions, and `! test -e` with
`test_path_is_missing`, for better readability and diagnostic messages.

Signed-off-by: Joey Salazar <jgsal@protonmail.com>
---
 t/t7006-pager.sh | 84 ++++++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 00e09a375c..fdb450e446 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -19,7 +19,7 @@ test_expect_success 'setup' '
 test_expect_success TTY 'some commands use a pager' '
 =09rm -f paginated.out &&
 =09test_terminal git log &&
-=09test -e paginated.out
+=09test_path_is_file paginated.out
 '

 test_expect_failure TTY 'pager runs from subdir' '
@@ -65,49 +65,49 @@ test_expect_success !MINGW,TTY 'LESS and LV envvars set=
 by git-sh-setup' '
 test_expect_success TTY 'some commands do not use a pager' '
 =09rm -f paginated.out &&
 =09test_terminal git rev-list HEAD &&
-=09! test -e paginated.out
+=09test_path_is_missing paginated.out
 '

 test_expect_success 'no pager when stdout is a pipe' '
 =09rm -f paginated.out &&
 =09git log | cat &&
-=09! test -e paginated.out
+=09test_path_is_missing paginated.out
 '

 test_expect_success 'no pager when stdout is a regular file' '
 =09rm -f paginated.out &&
 =09git log >file &&
-=09! test -e paginated.out
+=09test_path_is_missing paginated.out
 '

 test_expect_success TTY 'git --paginate rev-list uses a pager' '
 =09rm -f paginated.out &&
 =09test_terminal git --paginate rev-list HEAD &&
-=09test -e paginated.out
+=09test_path_is_file paginated.out
 '

 test_expect_success 'no pager even with --paginate when stdout is a pipe' =
'
 =09rm -f file paginated.out &&
 =09git --paginate log | cat &&
-=09! test -e paginated.out
+=09test_path_is_missing paginated.out
 '

 test_expect_success TTY 'no pager with --no-pager' '
 =09rm -f paginated.out &&
 =09test_terminal git --no-pager log &&
-=09! test -e paginated.out
+=09test_path_is_missing paginated.out
 '

 test_expect_success TTY 'configuration can disable pager' '
 =09rm -f paginated.out &&
 =09test_unconfig pager.grep &&
 =09test_terminal git grep initial &&
-=09test -e paginated.out &&
+=09test_path_is_file paginated.out &&

 =09rm -f paginated.out &&
 =09test_config pager.grep false &&
 =09test_terminal git grep initial &&
-=09! test -e paginated.out
+=09test_path_is_missing paginated.out
 '

 test_expect_success TTY 'configuration can enable pager (from subdir)' '
@@ -122,107 +122,107 @@ test_expect_success TTY 'configuration can enable p=
ager (from subdir)' '
 =09=09test_terminal git bundle unbundle ../test.bundle
 =09) &&
 =09{
-=09=09test -e paginated.out ||
-=09=09test -e subdir/paginated.out
+=09=09test_path_is_file paginated.out ||
+=09=09test_path_is_file subdir/paginated.out
 =09}
 '

 test_expect_success TTY 'git tag -l defaults to paging' '
 =09rm -f paginated.out &&
 =09test_terminal git tag -l &&
-=09test -e paginated.out
+=09test_path_is_file paginated.out
 '

 test_expect_success TTY 'git tag -l respects pager.tag' '
 =09rm -f paginated.out &&
 =09test_terminal git -c pager.tag=3Dfalse tag -l &&
-=09! test -e paginated.out
+=09test_path_is_missing paginated.out
 '

 test_expect_success TTY 'git tag -l respects --no-pager' '
 =09rm -f paginated.out &&
 =09test_terminal git -c pager.tag --no-pager tag -l &&
-=09! test -e paginated.out
+=09test_path_is_missing paginated.out
 '

 test_expect_success TTY 'git tag with no args defaults to paging' '
 =09# no args implies -l so this should page like -l
 =09rm -f paginated.out &&
 =09test_terminal git tag &&
-=09test -e paginated.out
+=09test_path_is_file paginated.out
 '

 test_expect_success TTY 'git tag with no args respects pager.tag' '
 =09# no args implies -l so this should page like -l
 =09rm -f paginated.out &&
 =09test_terminal git -c pager.tag=3Dfalse tag &&
-=09! test -e paginated.out
+=09test_path_is_missing paginated.out
 '

 test_expect_success TTY 'git tag --contains defaults to paging' '
 =09# --contains implies -l so this should page like -l
 =09rm -f paginated.out &&
 =09test_terminal git tag --contains &&
-=09test -e paginated.out
+=09test_path_is_file paginated.out
 '

 test_expect_success TTY 'git tag --contains respects pager.tag' '
 =09# --contains implies -l so this should page like -l
 =09rm -f paginated.out &&
 =09test_terminal git -c pager.tag=3Dfalse tag --contains &&
-=09! test -e paginated.out
+=09test_path_is_missing paginated.out
 '

 test_expect_success TTY 'git tag -a defaults to not paging' '
 =09test_when_finished "git tag -d newtag" &&
 =09rm -f paginated.out &&
 =09test_terminal git tag -am message newtag &&
-=09! test -e paginated.out
+=09test_path_is_missing paginated.out
 '

 test_expect_success TTY 'git tag -a ignores pager.tag' '
 =09test_when_finished "git tag -d newtag" &&
 =09rm -f paginated.out &&
 =09test_terminal git -c pager.tag tag -am message newtag &&
-=09! test -e paginated.out
+=09test_path_is_missing paginated.out
 '

 test_expect_success TTY 'git tag -a respects --paginate' '
 =09test_when_finished "git tag -d newtag" &&
 =09rm -f paginated.out &&
 =09test_terminal git --paginate tag -am message newtag &&
-=09test -e paginated.out
+=09test_path_is_file paginated.out
 '

 test_expect_success TTY 'git tag as alias ignores pager.tag with -a' '
 =09test_when_finished "git tag -d newtag" &&
 =09rm -f paginated.out &&
 =09test_terminal git -c pager.tag -c alias.t=3Dtag t -am message newtag &&
-=09! test -e paginated.out
+=09test_path_is_missing paginated.out
 '

 test_expect_success TTY 'git tag as alias respects pager.tag with -l' '
 =09rm -f paginated.out &&
 =09test_terminal git -c pager.tag=3Dfalse -c alias.t=3Dtag t -l &&
-=09! test -e paginated.out
+=09test_path_is_missing paginated.out
 '

 test_expect_success TTY 'git branch defaults to paging' '
 =09rm -f paginated.out &&
 =09test_terminal git branch &&
-=09test -e paginated.out
+=09test_path_is_file paginated.out
 '

 test_expect_success TTY 'git branch respects pager.branch' '
 =09rm -f paginated.out &&
 =09test_terminal git -c pager.branch=3Dfalse branch &&
-=09! test -e paginated.out
+=09test_path_is_missing paginated.out
 '

 test_expect_success TTY 'git branch respects --no-pager' '
 =09rm -f paginated.out &&
 =09test_terminal git --no-pager branch &&
-=09! test -e paginated.out
+=09test_path_is_missing paginated.out
 '

 test_expect_success TTY 'git branch --edit-description ignores pager.branc=
h' '
@@ -232,8 +232,8 @@ test_expect_success TTY 'git branch --edit-description =
ignores pager.branch' '
 =09=09touch editor.used
 =09EOF
 =09EDITOR=3D./editor test_terminal git -c pager.branch branch --edit-descr=
iption &&
-=09! test -e paginated.out &&
-=09test -e editor.used
+=09test_path_is_missing paginated.out &&
+=09test_path_is_file editor.used
 '

 test_expect_success TTY 'git branch --set-upstream-to ignores pager.branch=
' '
@@ -242,13 +242,13 @@ test_expect_success TTY 'git branch --set-upstream-to=
 ignores pager.branch' '
 =09test_when_finished "git branch -D other" &&
 =09test_terminal git -c pager.branch branch --set-upstream-to=3Dother &&
 =09test_when_finished "git branch --unset-upstream" &&
-=09! test -e paginated.out
+=09test_path_is_missing paginated.out
 '

 test_expect_success TTY 'git config ignores pager.config when setting' '
 =09rm -f paginated.out &&
 =09test_terminal git -c pager.config config foo.bar bar &&
-=09! test -e paginated.out
+=09test_path_is_missing paginated.out
 '

 test_expect_success TTY 'git config --edit ignores pager.config' '
@@ -257,33 +257,33 @@ test_expect_success TTY 'git config --edit ignores pa=
ger.config' '
 =09=09touch editor.used
 =09EOF
 =09EDITOR=3D./editor test_terminal git -c pager.config config --edit &&
-=09! test -e paginated.out &&
-=09test -e editor.used
+=09test_path_is_missing paginated.out &&
+=09test_path_is_file editor.used
 '

 test_expect_success TTY 'git config --get ignores pager.config' '
 =09rm -f paginated.out &&
 =09test_terminal git -c pager.config config --get foo.bar &&
-=09! test -e paginated.out
+=09test_path_is_missing paginated.out
 '

 test_expect_success TTY 'git config --get-urlmatch defaults to paging' '
 =09rm -f paginated.out &&
 =09test_terminal git -c http."https://foo.com/".bar=3Dfoo \
 =09=09=09  config --get-urlmatch http https://foo.com &&
-=09test -e paginated.out
+=09test_path_is_file paginated.out
 '

 test_expect_success TTY 'git config --get-all respects pager.config' '
 =09rm -f paginated.out &&
 =09test_terminal git -c pager.config=3Dfalse config --get-all foo.bar &&
-=09! test -e paginated.out
+=09test_path_is_missing paginated.out
 '

 test_expect_success TTY 'git config --list defaults to paging' '
 =09rm -f paginated.out &&
 =09test_terminal git config --list &&
-=09test -e paginated.out
+=09test_path_is_file paginated.out
 '


@@ -392,7 +392,7 @@ test_default_pager() {
 =09=09=09export PATH &&
 =09=09=09$full_command
 =09=09) &&
-=09=09test -e default_pager_used
+=09=09test_path_is_file default_pager_used
 =09"
 }

@@ -406,7 +406,7 @@ test_PAGER_overrides() {
 =09=09PAGER=3D'wc >PAGER_used' &&
 =09=09export PAGER &&
 =09=09$full_command &&
-=09=09test -e PAGER_used
+=09=09test_path_is_file PAGER_used
 =09"
 }

@@ -432,7 +432,7 @@ test_core_pager() {
 =09=09export PAGER &&
 =09=09test_config core.pager 'wc >core.pager_used' &&
 =09=09$full_command &&
-=09=09${if_local_config}test -e core.pager_used
+=09=09${if_local_config}test_path_is_file core.pager_used
 =09"
 }

@@ -464,7 +464,7 @@ test_pager_subdir_helper() {
 =09=09=09cd sub &&
 =09=09=09$full_command
 =09=09) &&
-=09=09${if_local_config}test -e core.pager_used
+=09=09${if_local_config}test_path_is_file core.pager_used
 =09"
 }

@@ -477,7 +477,7 @@ test_GIT_PAGER_overrides() {
 =09=09GIT_PAGER=3D'wc >GIT_PAGER_used' &&
 =09=09export GIT_PAGER &&
 =09=09$full_command &&
-=09=09test -e GIT_PAGER_used
+=09=09test_path_is_file GIT_PAGER_used
 =09"
 }

@@ -489,7 +489,7 @@ test_doesnt_paginate() {
 =09=09GIT_PAGER=3D'wc >GIT_PAGER_used' &&
 =09=09export GIT_PAGER &&
 =09=09$full_command &&
-=09=09! test -e GIT_PAGER_used
+=09=09test_path_is_missing GIT_PAGER_used
 =09"
 }

--
2.29.0.rc2
