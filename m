Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AB2C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 21:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31BC26054E
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 21:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241352AbhIQVQ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 17:16:29 -0400
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:55932 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230515AbhIQVQ3 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Sep 2021 17:16:29 -0400
Received: from MTA-11-3.privateemail.com (mta-11-1.privateemail.com [198.54.118.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 4BF3480D3E
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 17:15:06 -0400 (EDT)
Received: from mta-11.privateemail.com (localhost [127.0.0.1])
        by mta-11.privateemail.com (Postfix) with ESMTP id BED6318000A5;
        Fri, 17 Sep 2021 17:15:03 -0400 (EDT)
Received: from [192.168.0.46] (unknown [10.20.151.218])
        by mta-11.privateemail.com (Postfix) with ESMTPA id 13D7C18000B3;
        Fri, 17 Sep 2021 17:15:02 -0400 (EDT)
Date:   Fri, 17 Sep 2021 17:14:56 -0400
From:   Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH v5 2/2] pretty: colorize pattern matches in commit
 messages
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Message-Id: <WCKLZQ.YCP2HWKW7YBB2@effective-light.com>
In-Reply-To: <CAPig+cRfFZ=GAevJ0b9oBGTR8P3MnSg+R43ujSP0dZJL08riqA@mail.gmail.com>
References: <20210916140943.2442184-1-someguy@effective-light.com>
        <20210916140943.2442184-2-someguy@effective-light.com>
        <CAPig+cRfFZ=GAevJ0b9oBGTR8P3MnSg+R43ujSP0dZJL08riqA@mail.gmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 17 2021 at 03:10:12 AM -0400, Eric Sunshine 
<sunshine@sunshineco.com> wrote:
> `buf` and `eol` seem like an accident waiting to happen...
> 
>>  +       line_color = opt->colors[GREP_COLOR_SELECTED];
>>  +       match_color = opt->colors[GREP_COLOR_MATCH_SELECTED];
>>  +
>>  +       while (grep_next_match(opt, buf, eol, ctx, &match, field, 
>> eflags)) {
>>  +               if (match.rm_so == match.rm_eo)
>>  +                       break;
>>  +
>>  +               strbuf_grow(sb, strlen(line_color) + 
>> strlen(match_color) +
>>  +                           (2 * strlen(GIT_COLOR_RESET)));
> 
> ... because strbuf_grow() may reallocate the underlying buffer, which
> means that `buf` and `eol` will end up pointing at freed memory, which
> will be accessed by the next call to grep_next_match().

I don't see how it's problematic, since `tmp_sb` isn't modified after 
`buf`
is initialized (until strbuf_release() is called, of course).


