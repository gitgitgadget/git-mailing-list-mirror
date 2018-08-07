Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53323208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 13:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389281AbeHGQIz (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 12:08:55 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:18436 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbeHGQIz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 12:08:55 -0400
Received: from [192.168.2.201] ([92.22.26.195])
        by smtp.talktalk.net with SMTP
        id n2ROf3WHJpXFjn2ROfZ73k; Tue, 07 Aug 2018 14:54:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533650067;
        bh=CSKgTIzlHxHpQMsUtKambukB9hYKlPNm/ebYnYR+UxE=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JphLTFJ4PwqJ/71RCkXwhe9UIw3r1+EwT8ZAa2BSkc/bWDD5eKyAsy87PkUFy6f/t
         HKAWaZRjNoigwVL+Hn1fY7rvfxxf90D1CrFre0Ny9PZwDAX0//1ORHNjXKXhsbNxwc
         LAGnE/siJ/BiaM8DAVxpqTMlbsIBGiRf64XiCtzc=
X-Originating-IP: [92.22.26.195]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=8bf3kEuDtVJeVZALKX4IsA==:117
 a=8bf3kEuDtVJeVZALKX4IsA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=1rMj1fQsO2HMPQElDmkA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/2] sequencer: fix quoting in write_author_script
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180807093452.22524-1-phillip.wood@talktalk.net>
 <20180807093452.22524-3-phillip.wood@talktalk.net>
 <CAPig+cQkY1_qDu=fdbA0gVPH88B47bM5BpgbYY8ivsj1Y0QHTw@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <753b860e-c922-fd70-9d2d-0581976a6f37@talktalk.net>
Date:   Tue, 7 Aug 2018 14:54:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPig+cQkY1_qDu=fdbA0gVPH88B47bM5BpgbYY8ivsj1Y0QHTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAa9JBr2bi/EGWc36N4L1C9wjB0HS4LxhYEiQiijxxFEdercJzo0q36yZiPjSCc3GTVACVsfSQBXuLfpKVeKj/fzIZhJZY75wGGk/2z8Bwq24zRC0ySy
 DGB6QlCIco9S7uB+38+P79vRO+s3ITjonOEbyY6yHa2ESC1Bu525HwA+DTN8+XKSX+0fRlJ0Ee/W6L1bZZ9jhl6wJGBXjMGM8BetSrOrzswYCknMtFYbsd5s
 eysoHRsWB+Y048a4+7DPrUkMIUTozp7rXLuTQFNjnHae0K6TrEgDVDB4/Dj0xdCC3hD1F3ND8fZ7KahnwAM/jA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric

On 07/08/18 11:23, Eric Sunshine wrote:
> On Tue, Aug 7, 2018 at 5:35 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>>      - Reverted the implementation to v2 with more robust detection of the
>>        missing "'" on the last line of the author script based on a
>>        suggestion by Eric. This means that this series needs to progress
>>        closely with Eric's series of fixes or the fallback code will never
>>        be called.
> 
> Thanks for working on this. I haven't read the patch closely yet, but
> one thing caught my attention as I ran my eye over it...
> 
>> +static int quoting_is_broken(const char *s, size_t n)
>> +{
>> +       /* Skip any empty lines in case the file was hand edited */
>> +       while (n > 0 && s[--n] == '\n')
>> +               ; /* empty */
>> +       if (n > 0 && s[n] != '\'')
>> +               return 1;
> 
> To be "technically correct", I think the condition in the 'if'
> statement should be ">=". It should never happen in practice that the
> entire content of the file is a single character followed by zero or
> more newlines, but using the proper condition ">=" would save future
> readers of this code a "huh?" moment.
> 

I'm not sure it is that simple. If the script consists solely of a
single quote then we should return 1, if it is a single character that
is not "'" then it should return 0. Currently it returns 0 in both those
cases so is technically broken when the script is "'". If it used ">="
instead then I think it would return 0 when it should return 1 and vice
versa. As you say this shouldn't happen in practice.

Best Wishes

Phillip
