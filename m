Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E07C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 18:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA81C61211
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 18:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhIUS03 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 14:26:29 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:59931 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhIUS02 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 14:26:28 -0400
Received: from [192.168.1.37] ([84.13.154.214])
        by smtp.talktalk.net with SMTP
        id SkRumN29np21aSkRumHWXf; Tue, 21 Sep 2021 19:24:58 +0100
X-Originating-IP: [84.13.154.214]
X-Spam: 0
X-OAuthority: v=2.3 cv=S72nP7kP c=1 sm=1 tr=0 a=nZAgPUNe/8GoCGAv1ndepQ==:117
 a=nZAgPUNe/8GoCGAv1ndepQ==:17 a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10
 a=1oJP67jkp3AA:10 a=ldyaYNNxDcoA:10 a=ZZnuYtJkoWoA:10 a=aulWLQ49AAAA:20
 a=F08kHXuo_yTQvSsD-hMA:9 a=QEXdDO2ut3YA:10 a=8up93pgRy1Xemhfk5qaC:22
Subject: Re: Trimming 'deadheads' (TREESAME 2nd parent) from revision walks?
From:   Philip Oakley <philipoakley@iee.email>
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <01fe28d8-2887-bc42-c91b-c3237b5186a7@iee.email>
 <YUeImAqA0SZAdA2R@coredump.intra.peff.net>
 <87k0jcb01k.fsf@evledraar.gmail.com>
 <88dfc31a-187c-6609-0df6-d6b970b1a136@iee.email>
 <YUj0J+jY0jURkipM@coredump.intra.peff.net>
 <9b85811f-de5d-24b3-36f6-7e2f9be6cae0@iee.email>
Message-ID: <be7ec330-2b2c-a01f-c7ca-e5e752493ee0@iee.email>
Date:   Tue, 21 Sep 2021 19:24:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9b85811f-de5d-24b3-36f6-7e2f9be6cae0@iee.email>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfLc3qcNREuqz1KhhiZ8V1+i8zYeepXU7er5IJDTm5e3WIWHHWava+jwFk5lawvvTCDmVb92mvfdTJYvkq238BF8gj4Reaj18HcRq/FA/4euS8wCDyYth
 wL3lMtaTCJ9H63ugL4LQ3zYne0YZ0qynXbhKPunScimjpVY+qZqiVxYKe1TBMhHlWCtHsIIA79reZ82Fbitv9BHT+I4tBypT+BxVhYdh5OytodhoHLU5IMtK
 A7o3c0GitHCBR1slgi17/0IOLIkqdUmfGWjNs1SSLHU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/09/2021 14:36, Philip Oakley wrote:
> The `theirs` strategy is really only suitable for maintainers, rather
> than solo coders, as it need to be 'old releases` that are kept, rather
> 'old cruft` (I've generated too much of that in my time).
>
> Dscho's scripts (for anyone interested) for GfW are in
> https://github.com/git-for-windows/build-extra/blob/main/shears.sh#L16-L18
> and 
> https://github.com/git-for-windows/build-extra/blob/main/ever-green.sh,
> though from the script perspective it's an 'ours' strategy.
>
> Dscho has to locate the start commit via it's subject line, rather than
> it's topology.

It's taken me a while to realise why/how Dscho is using 'ours', for a
'theirs' merge.

He is inserting that merge into the start of the --merging-rebase's
instruction sheet, which means that the rebase itself will reverse the
meaning of 'ours' and 'theirs' as it checks out the 'theirs' branch
first before performing the actions in the instruction sheet.

Thus the 'ours' strategy now works in our favour, to effectively
deadhead the old hear as a 'theirs' merge and then begin the rebasing of
the Git-for-Windows patch thicket on top of the latest Git.

Sneaky.

--
Philip
(added dscho as cc, just in case I've got it wrong again;-)
