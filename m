Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78A5C1F597
	for <e@80x24.org>; Sun,  5 Aug 2018 08:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbeHEKti (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 06:49:38 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44215 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeHEKti (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 06:49:38 -0400
Received: by mail-lf1-f66.google.com with SMTP id g6-v6so6919373lfb.11
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 01:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OcfGgw2tnjWLSDkfcCA1pX7xAv2YMTZ5Vf1vurZkZT0=;
        b=fSR6hPy/wJvY5xlflKD+jCG1wdpfER8ERCFjV+Um5/rp3OG5droFmwGHcDqsseZhl0
         9v72azluS330SPiMnH7IyeVea/+YSkyNFvHY/F28s8lu4y6duHtjx+9exCcjcLaCCGmG
         YROg/szcxacSt8ygHPED+f78CxSdU6HB0Atehug/2y/f8v1sBZRbWcppvBH7sPbtz+Mf
         6xAhySpGyoETioHthlXklukUR3ddI55V1L6gYpTs8tXiEHX30sUwN3b0hSHLBHaInqmb
         Tsbg5/HEnnrryM38m09k2dPYbvJACC2CjityK8hMN2OyFksZuwXlto+WT4y6dv+nWV27
         FVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OcfGgw2tnjWLSDkfcCA1pX7xAv2YMTZ5Vf1vurZkZT0=;
        b=FYVYvlYuFz+IXXlZlUTfNvVtiMoCFzfKKU1p4pcz+QolN32iLI4mWDzwSQN+SI20+H
         omYQovw41z+lzaB59lpBMH1W+J10OWSY+h49mINwIBnV2cHxnrrkujjof17gLfbqDRbJ
         OxOZD6OQ+o1v1+OxOMIZWdNaC2KR6PQrb979d+8eTuyg3KSR0LV7WtH2AdWTDlciLvho
         pRtyHsNwJwHSAcqeSSltPY1htJsWU/namcRQ9vw/xZARTxuxVswLUJmEl+sF0BQAMLDP
         z04CASoD1L20F0G3pTs0sH52kai59y6O78y//0fnHyWePIbkXDjenPczEoc9uMbtjLC4
         ergA==
X-Gm-Message-State: AOUpUlE9t0mqpSFdqjmh0miZXk6KHPTYkuJ1f11joUXfxHTrM6o8kgSL
        ysX4Fc1qjvXQ1DNQukCoj+c=
X-Google-Smtp-Source: AAOMgpe+k5Rypg/jWeeEB1EH2nCgIf1I2u+OMnPno/amGOFDhX8wnqJZEF6pDJA4ILNZCmk3qAYfWw==
X-Received: by 2002:a19:e546:: with SMTP id c67-v6mr8440526lfh.135.1533458747717;
        Sun, 05 Aug 2018 01:45:47 -0700 (PDT)
Received: from [192.168.221.164] ([185.79.217.61])
        by smtp.gmail.com with ESMTPSA id t24-v6sm1688047ljb.89.2018.08.05.01.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 01:45:46 -0700 (PDT)
Subject: Re: [PATCH 3/4] line-log: optimize ranges by joining them when
 possible
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.15.git.gitgitgadget@gmail.com>
 <d5d9db3c1124d29e26864596a8c36f0dc4de8a7e.1533421100.git.gitgitgadget@gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <9776862d-18b2-43ec-cfeb-829418d4d967@gmail.com>
Date:   Sun, 5 Aug 2018 10:45:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d5d9db3c1124d29e26864596a8c36f0dc4de8a7e.1533421100.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-08-05 00:18, Johannes Schindelin via GitGitGadget wrote:
> 
> Now, I am fairly certain that the changes are correct, but given my track
> record with off-by-one bugs (and once even an off-by-two bug), I would
> really appreciate some thorough review of this code, in particular the
> second one that is the actual bug fix. I am specifically interested in
> reviews from people who know line-log.c pretty well and can tell me whether
> the src[i].end > target[j].end is correct, or whether it should actually
> have been a >= (I tried to wrap my head around this, but I would feel more
> comfortable if a domain expert would analyze this, whistling, and looking
> Eric's way).

I don't know line-log.c at all, but here are my comments on the more
abstract range and range_set changes:

On 2018-08-05 00:18, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Technically, it is okay to have line ranges that touch (i.e. the end of
> the first range ends just before the next range begins). However, it is
> inefficient, and when the user provides such touching ranges via
> multiple `-L` options, we already join them.
>
> ...
>
>  void range_set_append(struct range_set *rs, long a, long b)
>  {
> +	if (rs->nr > 0 && rs->ranges[rs->nr-1].end + 1 == a) {
> +		rs->ranges[rs->nr-1].end = b;
> +		return;
> +	}

As I understand it, this patch attempts to make range_set_append extend
the last range in the range set to include [a,b), if [a,b) "touches" the
last range in rs.

Definition of range from line-log.h reads:

  /* A range [start,end].  Lines are numbered starting at 0, and the
   * ranges include start but exclude end. */
  struct range {
          long start, end;
  };

So the optimization described in commit message should take care of
following case, with zero lines between last range in rs and [a,b):

  rs before : [---) ... [---)
  [a,b)     :               [---)
  rs after  : [---) ... [-------)
  
It seems that the first condition in range_set_append should be:

	if (rs->nr > 0 && rs->ranges[rs->nr-1].end == a) {
		// extend the last range to include [a, b)
	}

I think that the comments around struct range could be improved by
switching from using "[]", as in the comment from line-log.h quoted
above, and "|---|" as in various comments in line-log.c to "left-closed,
right-open" interval notation like "[start,end)" and "[---)".

>  	assert(rs->nr == 0 || rs->ranges[rs->nr-1].end <= a);
>  	range_set_append_unsafe(rs, a, b);
>  }

With these consideration in mind the assert should become

	assert(rs->nr == 0 || rs->ranges[rs->nr-1].end < a);
  
to cover cases starting from one line between last range in rs and [a,b)

  rs before : [---) ... [---)
  [a,b)     :                [---)
  rs after  : [---) ... [---)[---)
                            ^
                            |
		this line still not part of the range set.
  
