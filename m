Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF2FC6FD1C
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 12:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjCYMQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 08:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjCYMQk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 08:16:40 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36084AD
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 05:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1679746592; i=l.s.r@web.de;
        bh=D2xeTccEZcOqt3Vh9mbMgMH1ch7jmdq1G2T/vbAKkg8=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=I/Wcapj+Xp/E169s8HCRzR+VHw9Sfm6KO9oVemkgoS9i/RgMXthIYtCod72IkxTML
         J6OIY7+sfXFas6GqURjP3L5vC8pN1/zWpUYQ9gaEWSkRfk1V7w30jFH7jT34I2K1bf
         LWtU11Ahx4mTtTSB/6xP9+ythtIokGe1j6BT7Bk5ScBoRZW3ew/j/x/vEoI3apjnrn
         EULfS0lS7adliEc/nlyGMUB5ZFm1iCsMzML6jeJXhWa3g4GfapCrOuzXBluy40fsP2
         UfXfTjGHX9uqEdnYotm0jPR1Qk0O6OKOAg2YS4IYgEU0EVpO/NHtSn+SUUZFHZ6cSh
         XOiny/vxhy7xg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.31.43]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mfc8o-1q8X1M3Oki-00g9Xj; Sat, 25
 Mar 2023 13:16:32 +0100
Message-ID: <233edbbe-35c1-9b5b-7578-4c70c6d24449@web.de>
Date:   Sat, 25 Mar 2023 13:16:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] t5000: use check_mtime()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C7W2W8kDnlPxikpSgUCHzFQzqhurcyEaIxxaLUnvGUQtivfukQr
 FelBjkET8gaOoV3aESZ295M2WuNH6zjI9+qhs+5YGuhOhCqWVX5Tt92dMp7ev/MSEJQrAWR
 BWoLs5UNtfVnvmGDbGmmpxdJB2F8u2h4v7vSYTIT0nwCBFPZ2ffK8z90V9B7dX3L1s1FziY
 xcyTDbRAz/J6q6lJnC9kA==
UI-OutboundReport: notjunk:1;M01:P0:VPeS6Y9oKrs=;X/IJPPaei6euXCFFOqDCNV754bB
 D1rEcvz6neNc6uU13mAhEC90G42JvwaGbY5hCkrNXDCXFP0/c4YcZHRZ8Y3AqDzGFUAOfBg7X
 oMs4jdIWMswh3t0yaEazGgEdvrO7kGl00a/J3iY5uJfPxRf1t8XUL6tV1isg6aq6I7gbGrc0z
 h+WQu+udzk/nxTkHHILAxbjZnywAr9PhC73EZmLMFVhm2ZD1uVzVbFeyu2fJpVaG1pSLE0dgM
 RawsyCRiHlZk5mC+PhzBNaMj+XEsBZ068l6orIfmGCXcuo2RmhuCBKZGmzpuar9jWQcrtBqMH
 i44d+zOtklJA4pXwJmGdzx03v21rA0et7/IdBjy7n/RxuVRFNVa9Xfv7yupJO6lMvicnhau+a
 x1nglf8pPBnFkLRpqlV4IJEQsFayqnraRMgc3ISeJYqlqIyt4pd/S+//Ky5IdjmRXvBj5+fay
 NIKdvB/8m0Hn8wq5U9Kl+X1/Cz4JJIKTBVjEE+/LfDAPurYWv3duFiH3R+m3XHpqeQwAe37C3
 ca6SMR7LAN2684EFHQKteG3/94DF8rpcjcGO9TBySbAZwLruLikuJ95AmQVuNpJFxC+PHxV0w
 z6mlBwpoET0senyh1tIT7RLR13JeI6q0U7h6tGjYr/eFQ0OaWjlrF1FrsmGTK63Z//QM/ZldV
 WkFEeXfxLTeciS7cBT7yrj1p0fmuR9JMWLuGPboR5mD9yZMTCYl1BtWJvA9ulYnKfw7IcT4Fr
 hLsiEkb/McPjbxWeb4p7mbWat0PwKLeCfUK6/RHd9+0FaDJfWJwgkz5Y1VrH/sNZvkGS8VNPk
 1j3QjlxXCS/XfZw0ttGS0Rmp82SmrGbStIf2KAqQCJi90G2/z878dm577/fv3EIGjB4VSXbtl
 Kr7fqkvlyDeg3scq8h7iJ0mNFvfGaVfw/D8dyHPV1WDn0dxZP5LT6hZMNyi7f2I40w+un8ANV
 +phfFtQ4sE331J42INZOgd4M0sA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fd2da4b1ea (archive: add --mtime, 2023-02-18) added a helper function
for checking the file modification time of an extracted entry.  Use it
for the older mtime test as well to shorten the code and piggyback on
the archive extraction done to validate file contents.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t5000-tar-tree.sh | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 918a2fc7c6..f0bd70dbd6 100755
=2D-- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -185,6 +185,7 @@ test_expect_success 'git archive' '
 '

 check_tar b
+check_mtime b a/a 1117231200

 test_expect_success 'git archive --mtime' '
 	git archive --mtime=3D2002-02-02T02:02:02-0200 HEAD >with_mtime.tar
@@ -257,14 +258,6 @@ test_expect_success 'git archive --remote with config=
ured remote' '
 	test_cmp_bin b.tar b5-nick.tar
 '

-test_expect_success 'validate file modification time' '
-	mkdir extract &&
-	"$TAR" xf b.tar -C extract a/a &&
-	test-tool chmtime --get extract/a/a >b.mtime &&
-	echo "1117231200" >expected.mtime &&
-	test_cmp expected.mtime b.mtime
-'
-
 test_expect_success 'git get-tar-commit-id' '
 	git get-tar-commit-id <b.tar >actual &&
 	git rev-parse HEAD >expect &&
=2D-
2.40.0
