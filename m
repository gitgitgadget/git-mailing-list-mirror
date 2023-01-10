Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FFAC46467
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 18:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239719AbjAJSzT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 13:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239762AbjAJSyl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 13:54:41 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96654D48C
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 10:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1673376747; bh=cKt1P/JyBV0egOlR4TqmFHS3DcXtzdlLwVXgdt5S/qc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=eyrufTCHgSP4zOjIrOPG16BE9RBYDXEBPl/P6PFVJgWY55g1H+LN9T1UgTXauW1jE
         bMs2lhmztE0lcCIQggfM6uPhDHa+mLm43IUxG/ilJ9nSf7sQRlE6Wvo/6eZYhuPmf4
         X9VGG9SA5QkYQNII+wYb+EV5qE1scpm6U6a1rP0niFSxPkeE2yyJdcoyYnJ0iUVEBa
         lctc81RAC1zqhiBWNfEJDPOc+cz2TU9/AeCROrezqIEWKScXxLA+r8zZ1SNFpEn+ke
         6JDmO4uvNdwR6/caoPg3C0v+okLjfkEem54zcZVg0mSlXWl3EEMeqH3f5aVt+TKnXx
         bbPzGEwe/3ioA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.69]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7xeZ-1okfai3PRT-01545b; Tue, 10
 Jan 2023 19:52:27 +0100
Message-ID: <71e7d424-b785-9f9e-8b09-955b56fa19b0@web.de>
Date:   Tue, 10 Jan 2023 19:52:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 13/19] builtin/merge.c: always free "struct strbuf msg"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
 <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
 <patch-v3-13.19-6d99fdcc44e-20230110T054138Z-avarab@gmail.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-v3-13.19-6d99fdcc44e-20230110T054138Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4nBNL25XINLKGUE3ZuONCY6KUXGCHdeBdFcAIAydYsmAUT1iHXx
 PmwhVu60UtEO8wDU0R8dQ1OjIGFmZ4O3saseRruaNr1hoxPSrQhuQpBfQoPN/XChAaCAeXt
 TrVLMSOhD0uSgjO7j2XQ81qgjaJcyb4awoVUO92PkHpUfKGBbvA6DjB180ScGwzLg/hHXb/
 A3rmycdVC3yGyCWhbGM+Q==
UI-OutboundReport: notjunk:1;M01:P0:v1Osa3/hXVI=;pVRRjyi9cNKs2XretNTUPWroOT7
 vGHmfb19UdOpnuBbHTdTaIUcMpnm+iic1NLuLA2BAuottJj45gRsa9csf0exz8QW/jC0Aafr+
 CqSq7nEr2W7gF3sLhRuiFDl71crzkdMIni2HapsSBAzRlOIYVRqIvBucLgXL+ELcfsA3ygILk
 mNC9I+LzvX5DyeZe/34FEhM/JV3Gv7HFHxp+2+xtZfqKyo7lh0H8B2Ecsao24B3Ahefu9YMQY
 qqYI6rA1HfcZQyV0vh7xq1hF5MsyJSmlq7nh4VtGQNcYeSIIBKoLgnYwLEOH9cVBb+RQlItry
 sCBi4v0+uLxCH4HUty1MaajOtT3rfjx+bn1hS+KEPp2ubdeI8z2fOF8tGf7q3EQqV9cOwKfjU
 CZJb0lgKgeSPNwvqzInzq0ORIFS1CpVfnjt2v8W+cDMcE3nuJiAHMv722eY3VNUM01H329Zdt
 RQa+ilxFtaePPaDcyG8ZWSA+e0lLqWqmzOFyrFtqeToXVYZowh+Ls25Xg9cCDoDNsyT5IcfRh
 0zQge2BEqfAUGL/NI8Ye+ktzmxagBdh0mpEOQqRbUieTQZO/DbosiJykUPSip41K5PgsH7+x/
 qqMlhUdSFEPjSyg9lpdmQInjvBgfCvPNgvStbU5SclEZPgRV6yfCck2XkTjmpxbXFvgCGiwYj
 FPxNoTYE6jnuRG1OW7kHFm36ehwgd4k7TZ2SsEnG5O7m97SRmbIeWekSZxXsgaJQA/8e4KyZY
 mVQStpoDZYulyrQni/C0lB/cv5cCnAsuUGrIU3ziASwD/xi2UWv6qhuH/akCZi/2uLYlZbQhK
 ib9oOju3CfoKnf+hNMQqUQ5wY/s2a5De720mEX+S03NvWkSdrRrCfUS3lxWZaYqNEaGQrbogz
 T5DQZQAxAX4yjMHjJLVUOaUdINLZKGhO3AHzniBBn9Y1MAtyIEfle4+N0+PdlfXtwWrK8/30J
 B4FlDPtO6uLmkqwfL+LtRBu+dlU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.01.23 um 06:43 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Follow-up 465028e0e25 (merge: add missing strbuf_release(),
> 2021-10-07) and address the "msg" memory leak in this block. We could
> free "&msg" before the "goto done" here, but even better is to avoid
> allocating it in the first place.

So contrary to the subject we don't need to free it anymore.

>
> By repeating the "Fast-forward" string here we can avoid using a
> "struct strbuf" altogether.
>
> Suggested-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/merge.c                | 11 ++++-------
>  t/t6439-merge-co-error-msgs.sh |  1 +
>  2 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 0f093f2a4f2..91dd5435c59 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1560,7 +1560,9 @@ int cmd_merge(int argc, const char **argv, const c=
har *prefix)
>  			!common->next &&
>  			oideq(&common->item->object.oid, &head_commit->object.oid)) {
>  		/* Again the most common case of merging one remote. */
> -		struct strbuf msg =3D STRBUF_INIT;
> +		const char *msg =3D have_message ?
> +			"Fast-forward (no commit created; -m option ignored)" :
> +			"Fast-forward";
>  		struct commit *commit;
>
>  		if (verbosity >=3D 0) {
> @@ -1570,10 +1572,6 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
>  			       find_unique_abbrev(&remoteheads->item->object.oid,
>  						  DEFAULT_ABBREV));
>  		}
> -		strbuf_addstr(&msg, "Fast-forward");
> -		if (have_message)
> -			strbuf_addstr(&msg,
> -				" (no commit created; -m option ignored)");
>  		commit =3D remoteheads->item;
>  		if (!commit) {
>  			ret =3D 1;
> @@ -1592,9 +1590,8 @@ int cmd_merge(int argc, const char **argv, const c=
har *prefix)
>  			goto done;
>  		}
>
> -		finish(head_commit, remoteheads, &commit->object.oid, msg.buf);
> +		finish(head_commit, remoteheads, &commit->object.oid, msg);
>  		remove_merge_branch_state(the_repository);
> -		strbuf_release(&msg);
>  		goto done;
>  	} else if (!remoteheads->next && common->next)
>  		;
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
