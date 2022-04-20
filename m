Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0FBC433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 20:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382142AbiDTUdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 16:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382138AbiDTUdK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 16:33:10 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37DE340F7
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1650486611;
        bh=QyQ7tcbPQcdDs/ihYrKk8dymXTfjG/3Dszdf3HNVLPQ=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=T9KEl6aN2hLQ80/PRvHk4WA7lF2LHWPGo/jyoNOOxAfMrI/UnC7YsnTxEVhJOr8x7
         VgyDzgN8lJpGQOeNf6ot7mvuxCyOncM7MlpU2fqx0RkcwlIvh1wd4b+eCL6wLzjXga
         /9sM50tu5GUZoF3DFub1Hiap53Gz0LN4dK3zNXDA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.144]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4bUg-1niv7l12bG-001ngQ; Wed, 20
 Apr 2022 22:30:11 +0200
Message-ID: <2ad1dd80-e79f-7304-219c-db24bb269c4d@web.de>
Date:   Wed, 20 Apr 2022 22:30:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: [PATCH 2/2] diff: use mks_tempfile_dt()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <1c07dad1-3d3d-c52b-4440-631b46520254@web.de>
In-Reply-To: <1c07dad1-3d3d-c52b-4440-631b46520254@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4dbF2SmFO/Hb9mCZhwhO8yKcecyIxltq3aOAblzuzwUaK+DXT6T
 Ic0PuCkA48qcWYYDlxRlXuxo/phv9ynCuYRWylo6dzqLMQLGOick3gUbSkjG5xKLRagjNSr
 V2X4z6hmC66iKpsc1baWSnDSNeTU7bxF81uVEAZVon/3Vq1vBBHfRs1iXQhTSeN3aM1u+9j
 ghN+r2pHVjdP1KwlEHzrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7OMOL9Wujzo=:FTHU98dc/LuYO7IEcV40jN
 SWlTPYaJpZipZuGv9/MtQOYk9pGqV2zJY/8M6bdDxYUmo9okVuUa5DguiSq1id0q7ohF9tKDQ
 /M9R5zGI+6FPiOvbE2UA+xJ6XdngH8QgLEbsiZDdUv+JJZNH7MtTAHfoAD9yLSfcTxLjxBc9O
 tyJ1Ags/sVtgLH28iOP2/ahE5zkSCryVeC6+hw+Dch75Q35R3IEjPGbVptE0GXpn1rPmgfbYZ
 SBCnaiuHKLbd45J0aSQhDp1sLgEBCtkj6STu3EPI81mjGZTucHwXQ+VUt6un8oLfmB6FiVlnA
 VENIPCTpfkNGcmvkzjFW1yt9CWWtllPf9rwgMKbLu8Bob/c5c3gGf2Zbx46haKDzK4mnhoZR4
 ROMJCK/lbUOco5AbYGgvZ8jSTbqoali8PmtrEQTjTNvOBswSNLiRXq0xOEWPgIbDGIYTOkdBP
 N6QBwmB5oiVKjxIMUpQYCC+c5WMUXkOV5gSB5c76d8ysuKN6iFEpF6GgRfIXuLoeGbbRoFTLL
 QHdbJIGPVCTn0XuBHP07R52lgEplctf7x/o4weFx5ZemYoqgT7rzZRGcjS6rZQPfVIIaIVStX
 3L3xheFcAAnDqzIhw/4eopI0vAjKtnDOwuCPE/KAWmgnDvPGoAvPbi636oGoy08vI360uTkUb
 uE3Gd2Yv9bPImvTrd2hentDMQ6mtt7Nvv2EuTSZQnlBqcdECwoYzo0FfQS1wPVyPlxjnWGlVw
 jHRknwjbvPRAUczQ8pYhS2t+XR4DHrYEmz7tllTzrn70FDUDVr/d/loa+snrsRjhaT1N4n1xm
 6u2Nx8iBCHwXzqpZijbo0u0Q53KHl1xSC2537Fbi0FpZ/bEvMviG8vhqsIndYfH2awr7R89Do
 Sj4HqC4RnMpfEKFdpqCplPA1xO92zKE36CJTX/RDBQTqU7sG87e5URJXXgmc6LQw3WEQ4LJqc
 +u58U4liNnusm9RXon+haa3hO0NXYQed8QaLAWgHj9QCn0XslcX2MS8GQ1U2xqsX4+tmMTFyO
 0G9GNbfLCZlIfsE5H5ntkqyLc2QxdCHvdoCJcx0qwJaGOITm8lKgoke5157z/0jAGg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git uses temporary files to pass the contents of blobs to external diff
programs and textconv filters.  It calls mks_tempfile_ts() to create
them, which puts them all in the same directory.  This requires adding
a random name prefix.

Use mks_tempfile_dt() instead, which allows the files to have arbitrary
names, each in their own separate temporary directory.  This way they
can have the same basename as the original blob, which looks nicer in
graphical diff programs.

The test in t4020 to check the prettiness of the temporary paths was
neutered by 5476bdf0e8 (diff tests: don't ignore "git diff" exit code in
"read" loop, 2022-03-07), which removed its grep check without replacing
it with an equivalent test_cmp check.  Add one that only checks the
basename of the temporary file and nothing else.

And make the test more robust while at it, by using test_when_finished
to get rid of the added file even if the test fails.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 diff.c                   | 8 +-------
 t/t4020-diff-external.sh | 8 ++++----
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index ef7159968b..e71cf75886 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -4136,18 +4136,13 @@ static void prep_temp_blob(struct index_state *ist=
ate,
 			   int mode)
 {
 	struct strbuf buf =3D STRBUF_INIT;
-	struct strbuf tempfile =3D STRBUF_INIT;
 	char *path_dup =3D xstrdup(path);
 	const char *base =3D basename(path_dup);
 	struct checkout_metadata meta;

 	init_checkout_metadata(&meta, NULL, NULL, oid);

-	/* Generate "XXXXXX_basename.ext" */
-	strbuf_addstr(&tempfile, "XXXXXX_");
-	strbuf_addstr(&tempfile, base);
-
-	temp->tempfile =3D mks_tempfile_ts(tempfile.buf, strlen(base) + 1);
+	temp->tempfile =3D mks_tempfile_dt("git-blob-XXXXXX", base);
 	if (!temp->tempfile)
 		die_errno("unable to create temp-file");
 	if (convert_to_working_tree(istate, path,
@@ -4162,7 +4157,6 @@ static void prep_temp_blob(struct index_state *istat=
e,
 	oid_to_hex_r(temp->hex, oid);
 	xsnprintf(temp->mode, sizeof(temp->mode), "%06o", mode);
 	strbuf_release(&buf);
-	strbuf_release(&tempfile);
 	free(path_dup);
 }

diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 1219f8bd4c..858a5522f9 100755
=2D-- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -206,17 +206,17 @@ test_expect_success 'GIT_EXTERNAL_DIFF path counter/=
total' '
 '

 test_expect_success 'GIT_EXTERNAL_DIFF generates pretty paths' '
+	test_when_finished "git rm -f file.ext" &&
 	touch file.ext &&
 	git add file.ext &&
 	echo with extension > file.ext &&

 	cat >expect <<-EOF &&
-	file.ext file $(git rev-parse --verify HEAD:file) 100644 file.ext $(test=
_oid zero) 100644
+	file.ext
 	EOF
 	GIT_EXTERNAL_DIFF=3Decho git diff file.ext >out &&
-	cut -d" " -f1,3- <out >actual &&
-	git update-index --force-remove file.ext &&
-	rm file.ext
+	basename $(cut -d" " -f2 <out) >actual &&
+	test_cmp expect actual
 '

 echo "#!$SHELL_PATH" >fake-diff.sh
=2D-
2.35.3
