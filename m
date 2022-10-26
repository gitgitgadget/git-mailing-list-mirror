Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42456ECDFA1
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 11:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbiJZLB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 07:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbiJZLBY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 07:01:24 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE56B14DE
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 04:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1666782071; bh=Ha17sq/n8NCVcpTIFIRJHKi75DG9/fOI0BPblK4ikdQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=C4fjGqCrhC5QXzJbjJp38iu5ayImo5nnUJ/ULPr2KNwpqCtODxXIA+1M1lSPKFFvd
         PIETAzqYazcFxxlkO0yuTh8+5fYFu+5RBdVMJ8DnNqDHjOHfPrIm3NjkJThlFrNhen
         DMjPMe1fKt9QxnakF74z4eDt8jPhyic3n8DnDtqYg0Mp/gqi36NGT+cxtW9xpykfTt
         ljiTFTTAz9u6q9Rsk2hwnT4vqxkyg5cans/jen3mSjLDonN7lp3eI0LHIwzBPG4/b8
         +qWM3HMcQwcdaPyKhSYuOvlG92TAn5gLBEQus3vGpH+nGlSmiizM1/Ts/nFm1dYN6U
         NoA21FHjDZf/Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.161]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MwR0J-1p6HR40lXB-00s6xA; Wed, 26
 Oct 2022 13:01:11 +0200
Message-ID: <20ba163c-b8a2-7f99-d2c2-11c7c38ab32a@web.de>
Date:   Wed, 26 Oct 2022 13:01:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH 3/3] git_parse_signed(): avoid integer overflow
To:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
 <f058f391c3821b341a15fda9ae9fd20dda6a0494.1666359915.git.gitgitgadget@gmail.com>
 <xmqqpmeljae9.fsf@gitster.g> <80fe7c62-2c59-a715-3a8b-2dc2331d8e37@web.de>
 <xmqqv8obhkeb.fsf@gitster.g> <c24c3ac9-0de6-62f6-607f-2d8f69ca9fa8@web.de>
 <190de302-0898-50a1-1a9d-ab1ccc5c6bb8@dunelm.org.uk>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <190de302-0898-50a1-1a9d-ab1ccc5c6bb8@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RgHUcXGEh4go6/4m1POK0OAIdc87772JVcEJ1iWXdF95M+eCbZM
 bnKIdpxQVfovLK1VyWsvhK730HlwR/pgrhxk+ROD1d1OxnHKdE+Z0n9HYHw+AHilqjPKfC0
 cwoVFNSBydyvOQiVpGL3RkaqCJw4X0Xh2SwM28CSZdspUWT3ILA4XP73vMjwq2wsi7FjNIA
 7/nwX/pdsq+nAxouvTV4g==
UI-OutboundReport: notjunk:1;M01:P0:Gb4bI+Vz62w=;KmruZxt76fVKXKyyjowAuh9rI2g
 FxJOJU9LKd8zlcOmn7TC/En+OSklsXo+QnPuliPI16TNubW83qpJUtIE3MGQ3BArMXsiMkvKe
 5NinDcsaVK3wY3HN6AKF/KKdHhXDu9YkjnqJ9FsRL2w72TULs0MPzMA3tLseOHNOXJDnXNO6R
 mn3nHU1HQTuhvqIkctdSwEQI+BV4N36NyV2yEs7YK5Ay8RoLWhJ7MC2K+AR7Ny6XoIiG7nEkq
 wP/k4dpoYM8ZO6CEEU84nHyoLAo9lYdxQvA+3XFGyLXTJak0UFwVbovaFHGn7IsFkYfyRNmsL
 WGewMwO8IZya5MTbnzZqWx54TvuGr+YDqHxIh2IiEDihpyKXT2AokCe+Dmd31d7GjCh+30ipR
 P4AZEnNp5nda+HRf05W4gJHSy8iv8Go7m20Ia75A4/ddzlC+QExdAab3eARnflvOkkGEzJTr+
 fCh5IgTpA4NlhMC5MPCfPVIWbMVrdU4LbyY3yz63BdTtgb5/aXU9TaO9ti75KRjF4CQB96Kz0
 gwmWaBq6Mtv1eGJU8gKxqDsz0S8+yoeYkAL+WyRKptfsDQGfShtwsHkGAfMsJ2u+Al6S/zwFb
 FrUG1ycKzMWwz4rprgnE2NfClvUUqjpE26oPsDiyeYP54xJ6JF4Lewy06Xm0h8Fshd80UnnWS
 oLr5Z3otBNvXnwpkGlVC2ZcWeiJl4f/cd444ASOtX+79RIywXyUrsjL0mlC9WYgiMJ6H+oR1I
 YMnQoKuMViwkhUxtRo8ogjz5AtgkklgHJwKkHdHAx0t0f6Bj7DBqH/fCOgyuXGdn9QIRlo/x2
 jMLKQ34zbcSEQL+G9Y2bLmwFIMsjKUXvNlg/iKbAlcealUHm1FHn2C72+KFfk7IxidNRvz/n4
 tQjuN+GEL9JVJWtNyLtQZRP8LIQXkwfJzRhklSiCnPPvEHpF5W4L062rZp93XxHTK9Iewk7ql
 MJC4EyTjU2VnI1THrfNU0pX2Neo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.10.22 um 12:00 schrieb Phillip Wood:
> On 23/10/2022 06:57, Ren=C3=A9 Scharfe wrote:
>>
>> That said, I'm not sure how useful the values INT_MIN, INT64_MIN
>> and SSIZE_MIN (which unlike SSIZE_MAX is not defined by POSIX [*])
>> actually are. But doing the checks properly requires separate min
>> and max values.
>
> I'm happy to go either way, while I agree passing separate limits to
> allow INT_MIN is technically correct I'm not sure anyone has
> complained that the current code is too restrictive.
Right.  Having separate patches for the different aspects (your fix,
simplification due to adding a min parameter, range extension made
possible by that) is probably best to discuss the merits of each.

Ren=C3=A9
