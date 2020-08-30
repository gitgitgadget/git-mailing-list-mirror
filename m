Return-Path: <SRS0=qAd/=CI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDD7C433E6
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 10:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6148207DA
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 10:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="L4TAUaM6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgH3K4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Aug 2020 06:56:52 -0400
Received: from mout.web.de ([212.227.15.4]:58047 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgH3K4r (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Aug 2020 06:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1598784977;
        bh=i1vz6Amu2MN/qM75AGZ/RGjygu9iii0MzjFRBrGlxMI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=L4TAUaM6wkOpQNUkEU7kGxoWzwDwz2pDVwJ2Z3I+GSzn80PCBMKlljEZ/CRjlvQkj
         s+HZDR5tqbrKnqxoEV6kGLjN3W7KUKuc87DOkC1Dq4HqIuXanoLDjOiCVxQXgYnJAn
         cepZn1Tv51gZi0AbXzAzSx7FOkHImenAj2IAXVuo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.149.245]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MP2Sl-1kH1hW13Kx-006QPU; Sun, 30
 Aug 2020 12:56:17 +0200
Subject: Re: [PATCH] Avoid infinite loop in malformed packfiles
To:     ori@eigenstate.org, gitster@pobox.com, peff@peff.net
Cc:     git@vger.kernel.org
References: <A1CA9D499EDDACBA275BA61E114645F0@eigenstate.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <59efeeab-49de-17e7-8b1c-355d6ef31b5d@web.de>
Date:   Sun, 30 Aug 2020 12:56:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <A1CA9D499EDDACBA275BA61E114645F0@eigenstate.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Rov8Xb0TiScqqAZZar8UJxFBA9wyNG6+AdZpm4yXniTnkb/H3Uy
 Fu5RG+UHSMbUUVsqdM/5J8SnzQeice7xBvmDj9mKvPFD6XUb52ZqMwUXdnIaR2xoRN417hW
 wS3aAYjo2MThuKo+hVDPVfwqFrhObVAp/Acxt6vjku4R+dA1WRGbAszwKQRJe0YQnnCRDrb
 6AjtveJyUXQ/69KylDdBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W8PbzNMhsXo=:nCkKFc1TmEf/LuDLvCsUSG
 BGaEvS9g7Vbmq/4Nc9tK5visdHb+Oduex8f1UCi8meOZ4li9ZU0rTjVlxYrgdl0XqFuzqqxoG
 VLTKJySvbLJ9N8/Lj6/UTr4ac4jufHwBoR0817geGix/+sLpxJWvK9dYiteMN0MH4jwNTsdGo
 XgwW4jh6Wtfr4a4MH1Iu/x/E6hiPRwcgJqnQpwzMYaBX1XkvzjvOxmUtVJW4jrE0i0ORFzjX/
 D5imL2f05Lyg5LiUOlRABS/Bsi+dygNMDo7sIFr4yOOydn7j0I7eoX92m/YVFbeF0uhD6mNXP
 Y/UY/7uh/Af8P9qrTkCs8uAsekprNSgDuU0U8nmZwtWjCQpoyc9j7G3Cqh7Ni1sv2pxeOWoUt
 S788jNenDrPQUuakRaFZCINZGaLVilLK2sbzl7b5mjVKcRrLlYJr5BWxVNzoMfQS0lApP90S/
 znQqBJD2Yl/6JjAmgk/3L+GBe47uUifN18/BU+U8omvJ1y3/3h3YU+k5lqVwubbJMKvAHaPqM
 W7sw/8SOOAQ7kHL/8J7QM75kzzGZ6aoOq04ldd7PsKKHAxz1HWk0HAegFyzw6V83rlrihrihv
 5yH0iFHy+mkKiHXLJu/6W6whflX6oVH8GKyd6+8dIAaMUWxRTDwV9gIsWwEr+fujhhTYwpfFM
 3j5xeWM7Tdylf6qZXo3oY2DN6x36HNNtgRX5nrQdqMY01vZc6PhKLubhWqx+udhkb4faaMziJ
 RhHgbQI3RKxEWBenCXiPUqFJ1b9K6p2qAaw5MlhnVxgz0dhRGMzJM/tZeTJxSh6gAIqxUGJqO
 +K9aQQRJW9c5ZAipq8lkTEMZN1qpIukLSNWZ9uU8EZC7QLWqJO//GxuOoDmQhUoEqps91KNCe
 UjBObY7QOMSen9/m/yqLzdukIz6dB+2oVU3AJH23bVg+LcBAGTldS3AvwUi96AbUz4Fyu1yvc
 RngAruAUDjuEshzlkkVz2FGho2x/86wjHbRFJqfBuZMUV1Msu2Sof8YmmbvfZgAn7TPuu2n74
 s7B9mzAmDMGY4raRQKI47BZWMC4OsQrzBKc5wPxpYVQunqCdXf3KSPHQVeH5plmX69RI6uu3v
 Duy6W0UOw1XsdtG17GFRjhiyKifhdke9XLG3JNyaxTqVvrSdvZcQBMzZkSHxHuA/jz45jTHZj
 MZ2PUY0emG8WMhBubLar218CfHNGdYcAmgE/FaMxgq7F9PEnV93eI1SoVrq4K3oNFPGoKAFqm
 dcsep0utenDJIomuZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.08.20 um 05:33 schrieb ori@eigenstate.org:
>> Jeff King <peff@peff.net> writes:
>>
>>> It may be hard to test, as I suspect modern versions of Git are not
>>> happy to create such a deep chain. We could test with a lowered value =
of
>>> the config option, though.
>>
>> Yes, that was what I meant.  Start from a 1KB text, create 50
>> revisions of the file by adding a single line at its end at a time,
>> pack with depth limit of 100, and then see "git log -p" die when the
>> allowed max lowered to 10, or something like that.
>
> Sorry about the delay -- most of my time to poke at this is over the wee=
kend.
>
> Will that work? I'd expect that modern pack files end up being
> offset deltas, rather than reference deltas.

True, but going down all the way would work:

diff --git a/t/t5316-pack-delta-depth.sh b/t/t5316-pack-delta-depth.sh
index 0f06c40eb1..7fd21cd3ce 100755
=2D-- a/t/t5316-pack-delta-depth.sh
+++ b/t/t5316-pack-delta-depth.sh
@@ -94,4 +94,15 @@ test_expect_success '--depth limits depth' '
 	test_i18ncmp expect actual
 '

+test_expect_success 'maxAllowedDeltaDepth is respected' '
+	git clone . clone1 &&
+	(
+		cd clone1 &&
+		git repack -a -d &&
+		test_config core.maxAllowedDeltaDepth 0 &&
+		test_must_fail git fsck 2>err &&
+		test_i18ngrep "overlong delta chain" err
+	)
+'
+
 test_done


