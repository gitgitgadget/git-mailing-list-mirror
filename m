Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8533BC43616
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62CB061434
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbhELRnT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 13:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347186AbhELRW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 13:22:59 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115F5C061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 10:21:51 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id u16so22938323oiu.7
        for <git@vger.kernel.org>; Wed, 12 May 2021 10:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Hl5tBYuVBzOZp28AJNuQ/n/nLEgbcJpCp0Cbcb4MrHE=;
        b=helITNMkeo6AhDsA+/Ig839WMdtm0mlgkxumttMWma0eQfiuplphg4E5MwZ2qKtoYF
         4ol3xlVxshUQQOzNfQXYRZ4/rG+MFgiCLm6D7DN307lG/0Lu4ATjXHZNJxjVO+AnZSkz
         6UVxwOCRtPacLiNvd8Ba/ZCB548ROKysdRsWcLAoOpaPU9Cay5E7ZE/zrUqEgn8CTuls
         X28IBowZPiNoF+pxfSPXDJSGtsDNGhMGWTZ+cIYF0UH/K6tA3RzAV888/M0ohqPAQDmj
         GpX3UGElUgLXHNChjS8deKK30Ub1pJ7NBp0nJY73H97jTo7HDbjgNauihxO/4tkFqGAW
         xBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Hl5tBYuVBzOZp28AJNuQ/n/nLEgbcJpCp0Cbcb4MrHE=;
        b=H2gC5lO/CAbXXcfGo3aoEf7u8mbY2X/rgHvSTUvpELNWgn9W1RwA+U2X/mTM8tPHXa
         N5sjMt313H/t3EDPNGmg8zuX+Gjaf3jBUqn6xK7iYFvw6wyf/16UPMhNmZLMrn6un/dN
         MYiT6V4+j/LTDUiCeLRVo73mF2Mf2owQ/fRtnWvhvbxTt26B8z7TvDGvQxQRxziPLHf3
         Uz6AfHvKfg9FTOm148MBVmMMyxysMsVGzS7GcqIoT1F6eZd8XFOxigOUKp1Oc8S8FFGW
         YewHT0ZCZM5XUz9XZ4XA0MUL5lwK8vJorSwVLWe85I5GzJSSZUfff+6MByRA6Z7OeIRJ
         7X+Q==
X-Gm-Message-State: AOAM5337g1dXofnpLVgJCDMl81+syflFiGlDAxdewUcQws6Wepw7bsyV
        /45QNTa8EJjslMjLcn8hTf00zJ3AeJ4kVQ==
X-Google-Smtp-Source: ABdhPJxg4nxGxW04eK/dAcukH8s3nlNhPdvEpKk7OCyP/YOEJP+IeJMAHJGjs8IIaQZGJE7ku8nZ6Q==
X-Received: by 2002:aca:42c6:: with SMTP id p189mr8283307oia.36.1620840110366;
        Wed, 12 May 2021 10:21:50 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id w66sm129968ooa.37.2021.05.12.10.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 10:21:49 -0700 (PDT)
Date:   Wed, 12 May 2021 12:21:48 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Gregory Anders <greg@gpanders.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <609c0eaca8d28_71bd120878@natae.notmuch>
In-Reply-To: <YJvUMTAVKJqPZF2t@gpanders.com>
References: <20210512033039.4022-1-greg@gpanders.com>
 <609b8a5a65826_6e0fc2084c@natae.notmuch>
 <YJvUMTAVKJqPZF2t@gpanders.com>
Subject: Re: [PATCH] git-send-email: add sendmailCommand option
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gregory Anders wrote:
> >> +--sendmail-cmd=<command>::
> >
> >Oh no no no. Don't do shortcuts.
> >
> >If you think --sendmail-command is too long, then address that problem
> >head on, don't try to hide it.
> >
> >I do think it's too long, which is why I suggested --command (especially
> >since it's obvious which command we are talking about), but I wouldn't
> >suggest --sdm-command, or something of that sort. We have to own our
> >decisions.
> >
> >  1. --command
> >  2. --sendmail
> >  3. --sendmail-command
> >
> >We have to pick one. I suggest #1.
> >
> >To try to make #3 shorter is just shoving the problem under the rug.
> 
> The intention behind `--sendmail-cmd` was consistency with `--to-cmd` 
> and `--cc-cmd`. Though both of those options also use the condensed 
> 'cmd' form in their configuration options as well, so I suppose I should 
> also change this one to 'sendemail.sendmailcmd'.

I see. In that case that might make sense. I still prefer #1.

> >> --- a/t/t9001-send-email.sh
> >> +++ b/t/t9001-send-email.sh
> >> @@ -57,7 +57,7 @@ test_no_confirm () {
> >>  		git send-email \
> >>  		--from="Example <from@example.com>" \
> >>  		--to=nobody@example.com \
> >> -		--smtp-server="$(pwd)/fake.sendmail" \
> >> +		--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
> >
> >People are already using --smpt-server=$cmd, we need to keep testing
> >that.
> >
> >Yes, eventually we would want them to move to --sendmail-cmd (or
> >--command, or whatever), but that won't happen tomorrow. Therefore our
> >primary tests need to be focused on --smtp-server.
> >
> >We need new *additional* tests for --sendmail-cmd, but those should not
> >override the current tests. At least not right now.
> 
> I will add a test case for the absolute path form of --smtp-server; 
> however, if we are introducing an option for specifying a sendmail-like 
> command, surely that is the one to use when using "fake.sendmail", no?
> 
> If we leave the test cases as-is for now, we introduce a split that 
> someone will eventually need to come back and update anyway. Instead of 
> kicking that can down the road, I thought it best to go ahead and do it 
> now.

The sole purpose of software is that it's useful to users. Software that
works today but not tomorrow is bad software.

The primary purpose of the testing framework is to ensure that doesn't
happen; that git keeps working in the same way today than it did
yesterday.

That's why it's more important that tests excercise the options people
were using yesterday.

In addition we also want to be testing new functionality, but that's *in
addition*.

Maybe at some point in the future more people will be using
--sendmail-cmd, but right now that's not the case. Right now we need to
be testing the option people are using *today*.

Cheers.

-- 
Felipe Contreras
