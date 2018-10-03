Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 398F81F453
	for <e@80x24.org>; Wed,  3 Oct 2018 09:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbeJCQ2M (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 12:28:12 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:64075 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbeJCQ2M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 12:28:12 -0400
Received: from [192.168.2.201] ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id 7ddxgZfbIoI6L7ddygQryC; Wed, 03 Oct 2018 10:40:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1538559634;
        bh=fCQG/LO8DcKzh50G/UdzM8ZaqZkm3EokJ/bc/uVGk5Q=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Azi5r3ZFdlJZcwJPJVIyUPfbFB7Di65O1blZnYcZjBvGcwgzE2OS6/wHGQVmcqdg1
         yTsfRUWSI9Vj9AyduabXkJr1VnlFVXlqKhNAMn1TjMeW5E7gIf1dKB9JRzskqWfh61
         IVo8TKLAlz1drEFwQFjKqIdRvUqRJtwe3r7FjlWU=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=5MhCPnrX47DKwZwE3rkA:9 a=73aetaXh3POpobTD:21
 a=4AaaE8-YgFgjizNH:21 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/5] diff --color-moved-ws: fix out of bounds string
 access
To:     Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <20181002175514.31495-1-phillip.wood@talktalk.net>
 <20181002175514.31495-2-phillip.wood@talktalk.net>
 <CAGZ79kYu9enUT=yL8wfM9quYYz1fs5OU4Wcvci9ZVPPdXkY6gA@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <ea197dba-bb51-0dde-bd2b-84709ce81a51@talktalk.net>
Date:   Wed, 3 Oct 2018 10:40:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYu9enUT=yL8wfM9quYYz1fs5OU4Wcvci9ZVPPdXkY6gA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfA/YqHEH8jxkokTQnGoqaMMh8/qQkCHbsh+jKn3e9jsuFlkvjifDGjQterT149nteBgJuivJYOq2weYWRsxcmPKlFUjIBVxeAm/1qhz5rAMiM17R75O4
 9EJpEXfamYQKnltQqSritMyy2iLey/faFv87VgoCaeudFJ1yWKncjvRuZ4uFtw1KOD6ZS2ci0aDrT2v2+JG4AAjC9ukwM2PwyXeX2LWSUywgkGMi/mKHskY3
 o6cXLSNPaoEhEuzeCtmbzXqN1jC57YRwYZWB/RC4eYo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/10/2018 19:58, Stefan Beller wrote:
> On Tue, Oct 2, 2018 at 10:55 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> When adjusting the start of the string to take account of the change
>> in indentation the code was not checking that the string being
>> adjusted was in fact longer than the indentation change. This was
>> detected by asan.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>  diff.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/diff.c b/diff.c
>> index 5a08d64497..0096bdc339 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -841,7 +841,7 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
>>                 al -= wslen;
>>         }
>>
>> -       if (strcmp(a, c))
>> +       if (al < 0 || al != cl || memcmp(a, c, al))
> 
> If (al < 0) then al != cl, so I would think we could drop the first
> part, and only check with al != cl || memcmp

Yes, I couldn't make up my mind weather to add the al < 0 or not but of
course only one of the lengths can ever be negative, I'll remove it

> In theory we should use xdiff_compare_lines here
> as the rest of the lines could have more white space issues,
> but we catch that earlier via a die("color-moved-ws:
> allow-indentation-change cannot be combined with other
> white space modes"), so memcmp is fine.
> 
> Side note: There are comments above this code that seem
> to be also obsolete after patch 1 ("...carried forward in
> pmb->wsd; ...)

Good point I'll go through the comments and update them

Best Wishes

Phillip

