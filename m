Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68464C43460
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44798613AA
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242119AbhETPGw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 11:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbhETPGv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 11:06:51 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B36FC061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:05:30 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v14so9331718pgi.6
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RORLHCs5YAMV2RyFgoS6IktyYB25UwOQRoCl4FZZrlY=;
        b=LRtI2ATx535kRSy8QuAfumpN4RYaIpT16BL0QJ2QYZCbTNt4n8PoXxcLwFYk/1GvMb
         jFPObONjjo7OktYVe7lJrqMawtqMQXE6hMbFSjTCI1LC6ZppMkyijUMNhBm8yDl30Uxi
         S/PJsWuLmUgKaBt3pm7zLp/JWmyDHF2nUe2shwa0tvMgbeXUAkoSsHW6vFSuRoZy0sOT
         /nKDc5Izhvx3UGHYXjlX6PKrGp/MvGxHlnjHMoNcIG2pMsnCbrNOv6C3nyOzoAyHgZTJ
         fn/HupD4jwmG6Sra9FlgjfmN3/1G69kwMmk7AefVkfeDRVxK36/4vLViSOyXSQxIOWu4
         crDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RORLHCs5YAMV2RyFgoS6IktyYB25UwOQRoCl4FZZrlY=;
        b=IEN3AfOlshY0Xj6Qmlet+N3OWeUGlZDKqPuogo5USacEwQdSX5+W2LZmNwvm3tgfMA
         m7/036GH/HDjrz8LCFXRMNVfioshPmIHII7794zUUsJDjcQXyAewzuwXCm1XH0QMo+7q
         85QDD9hnLI0th/r8Q6418ekuBSy+/sVu5c052MDhaMIBu7fF4iW1YfjlTYf2VkCB/ys8
         BlYcnOATi4A4ZFPsQI1vMVGaANq0T9TgTvXvqH68hFwFLhygtVrPOzZWcU+sVS7Siwvd
         /QK79eEEyJXiYXbtgdXs0D6SFLqSlVoCD3RPb8QQ7Fy1B6bOB+JL+y0raT+RKI62jhmV
         51wQ==
X-Gm-Message-State: AOAM530Hd0mp8ESjPZlQ5wUisHBQ/QkMmHwjGFyxfa7PvNLdMrq+xVfY
        cQM5gTVttinTaOA2oOn4SC8=
X-Google-Smtp-Source: ABdhPJwf//nJUyXC6TqFRWgvvSdjKpLgYCUQ/OhjnmCehSuzBgVEQ5hCuK7X18LaQQyBcJg1FuTSZw==
X-Received: by 2002:aa7:88c3:0:b029:2e3:d6dc:7c6f with SMTP id k3-20020aa788c30000b02902e3d6dc7c6fmr1270402pff.35.1621523129957;
        Thu, 20 May 2021 08:05:29 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4edd:d685:2ff9:b567])
        by smtp.gmail.com with ESMTPSA id y76sm415338pfb.74.2021.05.20.08.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 08:05:29 -0700 (PDT)
Date:   Thu, 20 May 2021 08:05:26 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] doc: explain the use of color.pager
Message-ID: <YKZ6tqP+e/iTxz2g@google.com>
References: <YKTXlTjwOUi4W+R8@coredump.intra.peff.net>
 <YKVsw3uqb66ifzvd@google.com>
 <xmqq5yzdvrlg.fsf@gitster.g>
 <YKYe9PZbTO1CyBOp@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKYe9PZbTO1CyBOp@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Thu, May 20, 2021 at 03:36:59PM +0900, Junio C Hamano wrote:

>> The original commit and its log message we ended up with did not
>> explain the motivation behind well enough.
>>
>> The motivation from the original thread:
>>
>>       When I use a pager that escapes the escape character or highlights the
>>       content itself the output of git diff without the pager should have
>>       colors but not with the pager.  For example using git diff with a
>>       pathspec is quite short most of the time.  For git diff I have to
>>       enable paging manually and run git diff | $PAGER usually but git log
>>       uses the pager automatically and should not use colors with it.
>>
>> can be quoted as a whole, but "the point is to deal with ..." is a
>> succinct summary that is good enough for the purpose of this commit,
>> I would think.
>
> Thanks, I was just preparing a near-identical response.
>
> I do think it's an important principle in general to summarize the
> content of things we link to. It's just that the summary in this case
> was so short that it was easy to look past. :)

I was making a different point: that the summary is so good that the
link is not even needed (or that if you are just trying to cite your
sources, it should be a footnote).  The current proposed commit
message makes the link prominent, which tells the reader that reading
the thread is a good use of their time, when in this example it isn't.

[...]
>   When color mode options (e.g., `color.ui`) are set to `auto`, Git by
>   default will enable color when the output is going to a terminal or to
>   a pager (since the pager itself is outputting to a terminal). This is
>   a problem if your pager doesn't faithfully relay the color codes to
>   the terminal. You can set this boolean to `false` to disable color
>   when output is going to a terminal.

Oh!  FWIW, I like that and don't think it's overkill.

> On Thu, May 20, 2021 at 03:36:59PM +0900, Junio C Hamano wrote:

>> So, in short, I think it would be sufficient to amend the proposed
>> log message with s/deal with/to deal with/ and nothing else.
>
> I'm happy with that.

Yes, the proposed patch is an improvement on the status quo, so I'd
rather that it land as-is than not land at all.  That said, the
resulting text is still confusing.  It can be easy to forget how much
context we're assuming when we read it ourselves; the proposed text
still makes an uninitiated reader go "huh?" in a way that the "When
color mode options" example above does not.

Thanks,
Jonathan
