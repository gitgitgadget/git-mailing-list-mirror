Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41917C4332F
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 22:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiL1WN4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 17:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbiL1WNw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 17:13:52 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31E9E7
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 14:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672265622; bh=aCfB+cFQeHPv+OINjuuf8R/M2jJ7YvOrnMPkZNE47Pw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Q66qIKXFZpShUZs71V5E48/fGZjZb0DcF5bCzT5EWwaR2G2jqy/oBhADbUWUgbbc7
         dUNwaYzQZRpqAr1LcqdS2dkx5e59IB+iwK80BBZxQ7gGSxeLQJpgCW9rpHo3/+aKtD
         HsMqJNRsNawX8Of31eKiatUnBbc3NLfnqUHpI59KF7AMQiISPgEvJ3Ddajk44jmlix
         AP9lL870FILPl8UI5qhdHzBm9VAsX95YmAV/uqzP9WXng0ybq7SjuIQqMlvBICFF6n
         mr+u+iYMD5ji6+tdUsj8X/K23yWAT4ha4MUy/H8DMVjZ/iW/sOt9Z3Wxj05x/gTBaV
         vXwglu8nHSaiA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIL0Q-1p56F002Xk-00EnII; Wed, 28
 Dec 2022 23:13:42 +0100
Message-ID: <24cd9d7c-2eb5-e17b-3cd2-98a2c6bd1424@web.de>
Date:   Wed, 28 Dec 2022 23:13:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 16/20] builtin/merge.c: free "&buf" on "Your local
 changes..." error
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
 <patch-16.20-95d59b914d0-20221228T175512Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-16.20-95d59b914d0-20221228T175512Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Lq7pAd6NDrFjnA6Ucn8gE4aSR7rOL1yNy0lmxbwrsSnYGjUukm0
 t42smZszWD5jhjv9PGbUMow1wEu3kgSu1kyvOu2Zy1C2M/0S6pt+ZKZ2dLo2CFPVq+Vpz0+
 Pc8bbnj+R7ap78cU3H6No9HUIapDTUZND/bUU/yR7MLXcdG/oh2IFTAcMcEqRgYk8r88wKQ
 VDNpBta26XHWG7QBMCD3w==
UI-OutboundReport: notjunk:1;M01:P0:osaVVsxghOY=;blKftwiTHczsTxw87uUZb5hcoyO
 axJa4WCOmyxgEFW0SN+vjWkRHPjdnJ4ZM5CuVQdYYw9azOSBBTN24dty3msXImwRLL2AClEOj
 Ph618C5SPerxtQXy84Bh4F7qWB34Ed09Fk2poQN1NQZuszbaD8MM9Egi5CDRfjg35Va5nuZQ+
 E8Fc7qAaP7Hv8+faskyWJ3g25kzkd4JqSlNOnIJr9B/LUIboMDgxG2dcD4XS4kb1NB/8R0Jlv
 QT02Vi2VTOdNnXjhtxPAyXCvRr6jc4GTJRETa8WimgaaA1yOkbtxyOYMz4cBD5lC022dOjGRy
 Q4UBbWDX28BxTgPOvueN9/teoxbJCZd2fWSGRL7oa+FO1UnsgTYLYW9Bw6eDyY5+OzqmeA8a8
 MHB+zHtaLv1dw+ImK+u3Z9UeccVVAOmltgzcWrqVavnK/w/Kl9CkUiAKO4IF4FXvNcDguj2KU
 KbRBVsCW/ohkQX12SWCe2yit7WVPeVtlmp0cCpIHfobHuQkNad99EDuD42z22ajPCWJ44QyPQ
 pyx0Iw1KV7+nmfVbV0RhpXQbmWG993/xqSVf5eUH7rcdozAmUHl4hPofBFTqLAmK3t/8ruxOe
 DhoeCi+OzauvXWeqDRJuz2kPZ6/iSW5Ei7dgIVJZ35ngEbCwscmKknVc3FRlODDAOJ2BfaYQz
 /iZlp34H64nz9rlJIJNmxv7O+r57wQQTcZHjJ9/KXgVTN4fxE4WckfR5vUorkrLnaayVkaY+L
 C+AhEOvhM3I7764TjiaVfDz88KfTQbKmajUhpRgRd1OaWJerJhtOLfOHYIUZxtroo+C+W808s
 MIYyYAT68q8oelLxmUab0GE4IisKR3jx7h6+S7diKcdMKY11mEm/J26ZebmfR2GzJ9n/hcFTC
 VpwPmvReNRAdEsrD5DbPg+qX+pm1oGF8nTGtfwsmG/4RVSNxkWE4/flDKPG9bq3SvqxeWUc3Q
 FH/yMGm9yZJ8/vC5iDzIpXnH4kI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.12.22 um 19:00 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Plug a memory leak introduced in [1], since that change didn't follow
> the "goto done" pattern introduced in [2] we'd leak the "&buf" memory.
>
> 1. e4cdfe84a0d (merge: abort if index does not match HEAD for trivial
>    merges, 2022-07-23)
> 2. d5a35c114ab (Copy resolve_ref() return value for longer use,
>    2011-11-13)
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/merge.c                | 3 ++-
>  t/t6439-merge-co-error-msgs.sh | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 8f78f326dbe..e29b456f92c 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1623,7 +1623,8 @@ int cmd_merge(int argc, const char **argv, const c=
har *prefix)
>  				error(_("Your local changes to the following files would be overwri=
tten by merge:\n  %s"),
>  				      sb.buf);
>  				strbuf_release(&sb);
> -				return 2;
> +				ret =3D 2;
> +				goto done;

Good change -- only a single return remains, which is easier to handle.

If it was only about "buf" then moving its strbuf_release() call way up to
free it immediately after its last use would work as well.

>  			}
>
>  			/* See if it is really trivial. */
> diff --git a/t/t6439-merge-co-error-msgs.sh b/t/t6439-merge-co-error-msg=
s.sh
> index 52cf0c87690..0cbec57cdab 100755
> --- a/t/t6439-merge-co-error-msgs.sh
> +++ b/t/t6439-merge-co-error-msgs.sh
> @@ -5,6 +5,7 @@ test_description=3D'unpack-trees error messages'
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>
