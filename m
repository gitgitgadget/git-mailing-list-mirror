Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AE76208CD
	for <e@80x24.org>; Wed, 16 Aug 2017 02:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752619AbdHPCIN (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 22:08:13 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34062 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751635AbdHPCIM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 22:08:12 -0400
Received: by mail-pf0-f196.google.com with SMTP id t86so40175pfe.1
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 19:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H/d6JEkHIoUlWd/3aYd63sTC/pLH1VKr1J0AvqTWgfg=;
        b=CHYhMhxKRc9xZEfvsM0RoSRG1vFGzz0r/g9WUrM+u3L37Z3+5Sg6EDSlzTrGPV1XpP
         iBxm8GORzBt6WhL4/cYT5mK1MGEp2PjANaPBiWWTVbENcwX9Kb44VuSrYzrUkCShIO3F
         bosEFpm7dizb2JmNek8Y5JOKLo9EXuPoe/o7iMvrYCAEuicxpZ+pmPNSvSlEsIYb7B3J
         cE//mzh1Dz1BD4r5VhbuTEIRDpqu4eXWGMxqHgrbFWsbk1xQzh07h4ZI05pZgjgZe+Pt
         9NWtqUBkpPSkSY17Sgosw0GxQrW9WFPqtjkpK8cnJmeJeo+5kFI+IM6Y2ZBT5tZO8V70
         +B3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H/d6JEkHIoUlWd/3aYd63sTC/pLH1VKr1J0AvqTWgfg=;
        b=aOhPjvAef3iguxwQyIgLQ0v9LJKAMwLdVNDi7nssras+N+WcybbQn9Y21W9uXMMJqm
         1kNXtWtmUijHt9G8M/tSYE88+N19tZNo9f7bdR8gu+mACvEh9+NfdNER1pgalAX1zH7o
         Hc8wTdQZ64paBjYvyaWehQCBLmgJKCvPlB+eI30Snkr/8zvhXc4HiSNv0Lpaee05CfPH
         Xt4Dhfee6NOH8z11nYKX4BlDHlkHqRzIUOEvM285jufi/ASijMHn4sEBtebyqVqpWece
         k2pK1BHQxqyx4uvrwqlYz9u5RnhqcXkocxRkKPx8ONTgojqB7cRuvj+vQTGpaYe3NRRT
         m8sg==
X-Gm-Message-State: AHYfb5ik78hCVBT/6A8tF/KjOur5yTOd9xNrQ6NoGoag1P3RRvp4915f
        Jt8ELB0xlvp48Q==
X-Received: by 10.99.53.75 with SMTP id c72mr126965pga.397.1502849291658;
        Tue, 15 Aug 2017 19:08:11 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:3932:90a0:1342:ce37])
        by smtp.gmail.com with ESMTPSA id u26sm18608781pfi.140.2017.08.15.19.08.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 19:08:11 -0700 (PDT)
Date:   Tue, 15 Aug 2017 19:08:09 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] push: do not add submodule odb as an alternate when
 recursing on demand
Message-ID: <20170816020809.GI13924@aiede.mtv.corp.google.com>
References: <CAGZ79kZouNBxOKr7X8j6wqebp3Wh3cDqhYR-t_PxaF7AwQ0Wzg@mail.gmail.com>
 <20170815224332.22730-1-sbeller@google.com>
 <xmqqh8x8pg8p.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kag+U94tzJ14mB4VZjSZ2MtUJ4vu4MXKLKkpkLw=2K_NA@mail.gmail.com>
 <xmqqd17wpe14.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZAkdiKHUweQK6U4dqAakfzReDMfiHKDmzsKGuAH3BgyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZAkdiKHUweQK6U4dqAakfzReDMfiHKDmzsKGuAH3BgyA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:
> On Tue, Aug 15, 2017 at 5:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>> Junio C Hamano wrote:

>>>> Is "is it populated" a good thing to check here, though?  IIRC,
>>>> add-submodule-odb allows you to add the object database of an
>>>> inactivated submodule, so this seems to change the behaviour.  I do
>>>> not know if the behaviour change is a good thing (i.e. bugfix) or
>>>> not (i.e. regression) offhand, though.
>>>
>>> Good point, we should be able to push non-populated, even inactive(?)
>>> submodules. For that we strictly need add_submodule_odb here
>>> (or the repo object of the submodule, eventually).
>>>
>>> So let's retract this patch for now.
>>
>> Not so fast.
>
> Ok, I took another look at the code.
>
> While we may desire that un-populated submodules can be pushed
> (due to checking out another revision where the submodule
> doesn't exist, before pushing), this is not supported currently, because
> the call to run the push in the submodule assumes there is a
> "<path>/.git" on which the child process can operate.
> So for now we HAVE to have the submodule populated.

It was not immediately obvious to me that this is just "for now".

I would be really confused if I had deactivated a submodule and
"git push --recurse-submodules" pushed from it anyway.  If the
submodule is active but not populated, then the question becomes "Why
wasn't it populated?"

If this is a bare repository, then nothing is populated, and pushing
from an active-but-unpopulated submodule sounds like a plausible wish.
But in a non-bare repository, I'm having trouble imagining the use
case that brings this situation about.

And where people have been needing this so far has been non-bare
repositories.  In that context, the check "is active and populated"
does not seem unusual or provisional.  Are you hinting that replacing
the check with "is active" would make it work well in bare
repositories?  I think I agree, though you'd have to be careful about
the case where the submodule is active but hasn't been fetched to
$GIT_DIR/modules yet.

Thanks,
Jonathan
