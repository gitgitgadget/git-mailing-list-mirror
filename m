Return-Path: <SRS0=NZH0=7G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E51C433E1
	for <git@archiver.kernel.org>; Sun, 24 May 2020 07:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 074D1207C3
	for <git@archiver.kernel.org>; Sun, 24 May 2020 07:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="bDyAkGoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgEXHXL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 May 2020 03:23:11 -0400
Received: from mout.web.de ([212.227.15.3]:56725 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728017AbgEXHXK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 May 2020 03:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590304981;
        bh=5XsSGRkefCBrSr2wIT1XymQ8bBHImPeFy4dYis7yyTA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bDyAkGoHNNKxSbHMaWUqM+Xj146+yiixjC1CyYLdlbei1Vhqj+aTaFxo/2+Xjkhm7
         zqCVHZo4QN7SrSN33fcny9zd6KULzXUDfu6Fk2QHFJ5haFFF0kv2Ey2YaOHeJCup5o
         zANT+53j3BqOMLksan6pi3rS1oOGReFDl/QRnNkI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.155.84]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MUBPu-1jTRZ90TKM-00R3oQ; Sun, 24
 May 2020 09:23:01 +0200
Subject: [PATCH 2/2] checkout: improve error messages for -b with extra
 argument
To:     Jeff King <peff@peff.net>
Cc:     Dana Dahlstrom <dahlstrom@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <CACqwCQiLpZ1HFzgJw0p0KR3jXNsxkhjXmF_huzhv+qkMZmybBQ@mail.gmail.com>
 <20200521191626.GC1308489@coredump.intra.peff.net>
 <9f26099a-e77b-ede4-bee3-27382a5a0875@web.de>
 <20200523162914.GA2178752@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c5e797b8-4b80-f9fa-e746-95f7f39e74f8@web.de>
Date:   Sun, 24 May 2020 09:23:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200523162914.GA2178752@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:loyDl4L+QsUBhlr0bqYQKvdEJn4h8WC70O8hEVCBXR3XYmgUp01
 M7kSwGOxUl0pFX6XdNrtniQ/MGd6/fHRckMTOFiX8JSvzElUgzl8digAmYNub2PRCJhS17q
 JS5JmLluZfcfvLympWv4jghIt214lP/xGtdEqQnRAToZj96OwgkSlrJYb72WjnJoDCdVehO
 nnGW5OA3/nxD9ZwAIdTaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uRTtILVJf3Q=:zA9S7kvoOM8BLKf2WmTRdY
 4l6mmupB7TJxrni8P/m77+1IBy1ljs0Ft57QRB0ofisX/zr/Txv9gmxM6bci8ypcSZSla//JI
 /fJCh92MZK6q64PXyQcFW0c7YuMWh1h+G/lVgFr9qywZS0kXLjEpd61i+2KpLFtdCQ/wMmdqS
 UTiZhNBJd9X2nwkQxLN0dwcC15kRU3F0rIVfiKwmzsggDflSVeJzw6yYCQp89XKPX6/icuSxq
 zsdOmjYamggF5EcE8puzMKMyZ63RNLUdD09W0GG0jlymbBPIXkKvUcbjFZ+qCS1B2I0cyfE+6
 1tJA4NqBhWXKi8xBn0fc9hXdk5Y08zC696yYSmcSkdBRDhcNk9UZrU7vluzILtuq9d/5v606X
 aozThAI3MExxMtOpyrD3pVoZG2Kw3PqjZPCJWWXKYdk08rQR7N39zP7uUQDyvWP3jBp7EeZXS
 5oNzvh2tnTUbqA2PMIxInv6fhAVyCeZMzyFc2SDzu3nYqQNIFUnHrmuRKe4EMIqOKm8z8tEPx
 7wW0Ns0gGEMj4K6JQEHbZLw4k0X0KkDpmDJRxVsoLTZ0MBAY8xaC45YGqGj00uQWswfeZnw5n
 72u5n9d5mJB/m2+PqTYV7rR35IW/l/Jfx6//cCdtfHyWEPJSgqr4mxV56d8CTJCKoMEMFsQJl
 lgoWnE0RY4oXpj8IM0IIjLcpu3guBnUtYpJRhUdK3r6Sh4X0Kq6edK3JwIpAkP4mv8K0YzxHB
 m51EZq5LPOspr5Urk7ho+n04Y7amHcjP91KuTSfFxryTJCoRzuP201+84eI0EjIK/eVZum4JA
 Ul6+DnVc9Gaxnx16CdtLfy8oqB74/V1sInmUoJrxsIuHUv8GRzjBGx75+3eqjryPWnO+roNzN
 3te1an6JZs0vfpbNifHjX/jBSfnC/Yhs/4oCME+fh0sjrlTFzKqy710AYDDiLuEF07gqXLreF
 slWFKaNu7D9pMd8VbACRxF4bTbTZESxXG7OPH7QEYUUnaoQNQFtq9rBxWGm0C9FYobNplK8tD
 5UoX7SXaZU8NnDlf3WpXNGiTLuGQ7qRWOQtJXOTxGxfLklKqfp+BbArtBMPoYOXO2neXuOkcW
 NpQPzeqX91CE6sHRnBT/ufQ066FS70rr4nanTocY6fyrBF1SwkPVGtbytZ4LZYqE2yp63ri5g
 cAVQzXlNH29VjJ2Fz0vcDUuXwgcXio8yal8vx7HV/Qc7vGmiKXqsRsCY5643PavhRtkpeUB6W
 fo4yKaC813yz+HCxM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we try to create a branch "foo" based on "origin/master" and give
git commit -b an extra unsupported argument "bar", it confusingly
reports:

   $ git checkout -b foo origin/master bar
   fatal: 'bar' is not a commit and a branch 'foo' cannot be created from =
it

   $ git checkout --track -b foo origin/master bar
   fatal: 'bar' is not a commit and a branch 'foo' cannot be created from =
it

That's wrong, because it very well understands that "origin/master" is
supposed to be the start point for the new branch and not "bar".  Check
if we got a commit and show more fitting messages in that case instead:

   $ git checkout -b foo origin/master bar
   fatal: Cannot update paths and switch to branch 'foo' at the same time.

   $ git checkout --track -b foo origin/master bar
   fatal: '--track' cannot be used with updating paths

Original-patch-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/checkout.c         | 2 +-
 t/t2018-checkout-branch.sh | 2 +-
 t/t2027-checkout-track.sh  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index e9d111bb83..24336e1017 100644
=2D-- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1689,7 +1689,7 @@ static int checkout_main(int argc, const char **argv=
, const char *prefix,
 		 * Try to give more helpful suggestion.
 		 * new_branch && argc > 1 will be caught later.
 		 */
-		if (opts->new_branch && argc =3D=3D 1)
+		if (opts->new_branch && argc =3D=3D 1 && !new_branch_info.commit)
 			die(_("'%s' is not a commit and a branch '%s' cannot be created from i=
t"),
 				argv[0], opts->new_branch);

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index d99b699396..5b8c042997 100755
=2D-- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -265,7 +265,7 @@ test_expect_success 'checkout -b rejects an invalid st=
art point' '
 	test_i18ngrep "is not a commit" err
 '

-test_expect_failure 'checkout -b rejects an extra path argument' '
+test_expect_success 'checkout -b rejects an extra path argument' '
 	test_must_fail git checkout -b branch4 branch1 file1 2>err &&
 	test_i18ngrep "Cannot update paths and switch to branch" err
 '
diff --git a/t/t2027-checkout-track.sh b/t/t2027-checkout-track.sh
index d0b41d7cd0..bcba1bf90c 100755
=2D-- a/t/t2027-checkout-track.sh
+++ b/t/t2027-checkout-track.sh
@@ -16,7 +16,7 @@ test_expect_success 'checkout --track -b creates a new t=
racking branch' '
 	test $(git config --get branch.branch1.merge) =3D refs/heads/master
 '

-test_expect_failure 'checkout --track -b rejects an extra path argument' =
'
+test_expect_success 'checkout --track -b rejects an extra path argument' =
'
 	test_must_fail git checkout --track -b branch2 master one.t 2>err &&
 	test_i18ngrep "cannot be used with updating paths" err
 '
=2D-
2.26.2
