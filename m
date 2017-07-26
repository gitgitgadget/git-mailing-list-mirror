Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76B3E20899
	for <e@80x24.org>; Wed, 26 Jul 2017 08:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbdGZIky (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 04:40:54 -0400
Received: from smtp61.i.mail.ru ([217.69.128.41]:39402 "EHLO smtp61.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751023AbdGZIkx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 04:40:53 -0400
X-Greylist: delayed 157850 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Jul 2017 04:40:53 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=list.ru; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=poJ1wVWWX9PlFQA781tGCcKRbH/ZuvbhHrD2zRVOqb8=;
        b=XkBFL5/B2niHzdkYAvgALzxHoUKZDiVjyB+1UFbnNSqYJqI3cscHKrqsgZY8ZlwDyx81N3Xj/uaRq/MKou8q/LRMfOUJJogD/GopZSgZjRhk8rTtIX+Z0bw33XfiaFcQz4gXYN9oN+zGV+sMwsgLFzBj6YW0jknv5D/igpt/dJM=;
Received: by smtp61.i.mail.ru with esmtpa (envelope-from <stsp@list.ru>)
        id 1daHsB-0005gN-7s; Wed, 26 Jul 2017 11:40:51 +0300
Subject: Re: git gc seems to break --symbolic-full-name
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
References: <234492d7-7fd6-f847-8b85-010732ff43b6@list.ru>
 <xmqqbmodhb5h.fsf@gitster.mtv.corp.google.com>
 <223fa7c7-196d-e4fe-85b5-7d7cc576aa52@list.ru>
 <CA+P7+xrhLf9eS_KkxTmWZgQ+Ho8VN83GS-OvxmboZ=_iY4dY0g@mail.gmail.com>
 <ed1ddfec-5782-d14b-6717-a1532efc0138@list.ru>
 <CA+P7+xock9gpYVtxj2n6L5Y9dO1VV01OEOT5i0MR7ay68yS+WQ@mail.gmail.com>
From:   Stas Sergeev <stsp@list.ru>
Message-ID: <a6738cae-ad8d-cf51-0fbb-428cf0f88703@list.ru>
Date:   Wed, 26 Jul 2017 11:40:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CA+P7+xock9gpYVtxj2n6L5Y9dO1VV01OEOT5i0MR7ay68yS+WQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-MW
Authentication-Results: smtp61.i.mail.ru; auth=pass smtp.auth=stsp@list.ru smtp.mailfrom=stsp@list.ru
X-7FA49CB5: 0D63561A33F958A5EB317B801D63D57D1089BFEA85E178F970494687B87A4A5F725E5C173C3A84C3CE9959E2676FD8771CAF3259CDF72A7180CB4917E5AABA03C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F41B67924A99884D73B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: F1845AB6CCC9920DF7838D61D4D05C421C1D71F90DA31DF33A78C54437ED425BC1762CDF3CC0E93F1653177920737CA72999BEE114A20FF4278B2D54D4112F244F0A872F021F905956A8FB0C6EBA5FCCEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

26.07.2017 03:36, Jacob Keller пишет:
> If your goal is to make it so users filling out bug reports have a
> version, then using git descrsibe and making that be part of your
> version (based off your tags, and commits) is how pretty much every
> other project I've worked on does this.
>
> I really don't think that's your goal here, given you're doing things
> in make with timestamps and builds, so I guess I misunderstood your
> answer?
There are 2 different things:
1. put git describe output into some header file
2. make things to rebuild with every new commit

So I actually stuck at solving 2, because 1 is trivial.
My original solution for 2 was to "depend" on
refs/heads/*. This worked besides git gc, but had
a lot of troubles with worktrees. And this time I
switched to the "touch tmpfile" trick with the date
taken from git log. This requires .LOW_RESOLUTION_TIME
in makefile, so probably not the best solution again,
but should hopefully be more future-proof than the
previous one.
