Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7FA3202A5
	for <e@80x24.org>; Tue, 26 Sep 2017 04:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754296AbdIZEMD (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 00:12:03 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:54367 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbdIZEMC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 00:12:02 -0400
Received: by mail-pf0-f177.google.com with SMTP id d187so4932426pfg.11
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 21:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5st+iY4cpsPR6DgopGJ/o0a0gQxeoB+lLYi4OsqzJTA=;
        b=U4ddHBOXgcFQM47+mnnkS1A1+AbrhP4MqGRFLBY6KoTJMpWHL5qNOhEhKwPYQik4GR
         RbPv4n/XOvR9otPXvaVr32oEGKBRQO8UeNv88amb/V8xRyladvB7RAA4mAIvW+IvPYgG
         edKA5rxKEJsTGLNWW2jP8zDXBvy72cRArUGGkkg0Zu/EYhRTCwrAkqmch4jgbgivcoQ7
         Z3QW5E0dyU2lR93krwaiQKfNsyJdg2o5NkIank9X10mOqdROBKSSdxlL1DjOO4s7hnug
         /eictZVd4whzy+VEH2o7FovK1xVzeEYpkPB3J1GSUtVsWojnZDO4Uvkitpn5V3gC0+b5
         uD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5st+iY4cpsPR6DgopGJ/o0a0gQxeoB+lLYi4OsqzJTA=;
        b=uS5MlJik9d3d5niYGB2Ikb4RxpsYYAUuWnsYnKHrlpBhHAuws+hSQ5yZVUy7cpCeaF
         3GCEypHkCeIddEYVkESxCII9UdHIcn9h0Xs2QX0xUD2Bt9KJLF9BubJO3dGvLt5CvKpZ
         Z5n2LYhw9L2aOeak1AtB2eu8G0jFhFHPYiIjy1Dktrhpg5UmSs1g08mgYpWj8Ps0B3bs
         VIMSGfwHAuHGEH56HaU2QUcY07pwkAQQCirlEKRhJ1rDo5v9wvTnh3XttbynWOkKCJxZ
         VTgR4gNktnlx/z0j18YfDRwGKqDiIHkASHMj1xPuzNbs4zYR/4ij/l0M3k0x8CFrG+Fj
         eEpQ==
X-Gm-Message-State: AHPjjUjONh88VQFfIPkgOV2tCn/LDcTrP6rNlrNwD1HMsviXHHRGEFZ2
        duit5nKiIPHHAUDo65YfnFLyLGZw
X-Google-Smtp-Source: AOwi7QAjpLU36megn/biqJYlZ2rnBUxthSLLnJ1SIvCYrwyeE/UXbhPUPZFyVmNfPQ7qJSyDqeuWzA==
X-Received: by 10.84.171.129 with SMTP id l1mr9558100plb.39.1506399121629;
        Mon, 25 Sep 2017 21:12:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8cad:f525:a0b8:9738])
        by smtp.gmail.com with ESMTPSA id i12sm13536499pgr.21.2017.09.25.21.12.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 21:12:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 3/7] read_in_full: reset errno before reading
References: <20170925232313.hhtqpxuzpzbnbdop@sigill.intra.peff.net>
        <20170925233316.GI27425@aiede.mtv.corp.google.com>
        <20170925233732.4lqavl56qwpfjuxy@sigill.intra.peff.net>
        <20170925234541.l6qcislhfwtnxf5m@sigill.intra.peff.net>
        <20170925235510.GL27425@aiede.mtv.corp.google.com>
        <20170926000117.y3solltovyueq3zc@sigill.intra.peff.net>
        <CAGZ79kZwc8bNWJfH_36soy75EpyHAMbJGhQd4rV5f-0RMjiwHQ@mail.gmail.com>
        <20170926000913.6x7qhj2vw73tldxe@sigill.intra.peff.net>
        <20170926001602.GO27425@aiede.mtv.corp.google.com>
        <20170926001732.GP27425@aiede.mtv.corp.google.com>
        <20170926001956.hgtdeklogvkirdxa@sigill.intra.peff.net>
Date:   Tue, 26 Sep 2017 13:11:59 +0900
In-Reply-To: <20170926001956.hgtdeklogvkirdxa@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 25 Sep 2017 20:19:57 -0400")
Message-ID: <xmqqvak6ayk0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> #ifndef EUNDERFLOW
>> # ifdef ENODATA
>> #  define EUNDERFLOW ENODATA
>> # else
>> #  define EUNDERFLOW ESPIPE
>> # endif
>> #endif
>
> Right, I think our mails just crossed but I'm leaning in this direction.

Hmph, I may be slow (or may be skimming the exchanges too fast), but
what exactly is wrong with "0"?  As long as we do not have to tell
two or more "not exactly an error from syscall in errno" cases, I
would think "0" is the best value to use.

If the syserror message _is_ the issue, then we'd need to either
pick an existing errno that is available everywhere (with possibly
suboptimal message), or pick something and prepare a fallback for
platforms that lack the errno, so picking "0" as the value and use
whatever logic we would have used for the "fallback" would not sound
too bad.  I.e.

	if (read_in_full(..., size) != size)
		if (errno)
			die_errno("oops");
		else
			die("short read");

If the callsite were too numerous,

#define die_errno_or(msg1, msg2) if (errno) die_errno(msg1); else die(msg2)

perhaps?

