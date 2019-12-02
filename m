Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAC1C432C0
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 23:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5472070B
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 23:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEm1/w9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfLBX2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:28:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42615 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfLBX2T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 18:28:19 -0500
Received: by mail-pf1-f194.google.com with SMTP id l22so638142pff.9
        for <git@vger.kernel.org>; Mon, 02 Dec 2019 15:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nrupA1CvVfsQPgZQ5fOwtRe4o9wVshVpgq7+df7Skxo=;
        b=nEm1/w9HLm3LLTObHFp6Hf2yUQFKs87RfOYUI6/5fSmoQ5gfr8k43o5tCgtKoGtE/n
         nxCg/7uin4WgNPr5ULrT8VL0n42raF9jhsxIcyHqZYgEJh1fXNEVQY7lDenPa3OGQK26
         VtzBoY7/h7vNBjeLB1eXo8EGY5D+yHIaqVo4XlBnX1XSJDDjIAJn6eoQjF0adR/G8S5e
         I9N/OplenCEG4EBNHBubnkTOF3WtvLUtCYycqRtOCanxXeg9da53JC1j1MD6L/O35iT+
         KtdJ5HEy8p4k/q1VEZT05wgh1kf0lAgvqUz20u6tDGConYuFKFOkL1BBLDFS3IaFHijN
         GY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nrupA1CvVfsQPgZQ5fOwtRe4o9wVshVpgq7+df7Skxo=;
        b=aOvAW1KxoBwT2sRY/+ElT3B07oNx22LFqhNQ2op8CkSWDnvCJsnZDfKQCEbrXUEJX4
         sns55ss1DUXR6xBKqqQ108GdwFEyyvMfF5iYaRrmD8giqyrZBgFl5ebsXcxF06rqwDuh
         R1Uf+S366iHAOPd8JXaBvAHppe/qS2wyyynPmOLw/OrHjyxJ+6jRriToKtS/7KPFZpcy
         quty7d+dfK7F0xp+vnFJslGcMjhCJiDLTsN2CvaGP01QfJfWJY2WinBN6I0KmkXfb0ut
         JFyX0z8BMXe9kOa2SWcsyUPG6A9ZCu5KDK3nkvW1vCSffs9GGotSs4WGD2ufU55XqTxS
         6Z4g==
X-Gm-Message-State: APjAAAX3oOnI7HdpzCVkQfTMrSYCaVHtLc7su0HgH451OJWt7S82Gweh
        jIkdKpa9YMEb4F1UXi/6Ot8=
X-Google-Smtp-Source: APXvYqz4Ujt4S9pvJJ9Z+/Yf2wRbUhOrHzDBW+yCxMZmXN9fRIkBRoDiCZzGJcDRF9PWNvY6stWUUQ==
X-Received: by 2002:a63:6cc8:: with SMTP id h191mr1857332pgc.345.1575329299006;
        Mon, 02 Dec 2019 15:28:19 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id u9sm584427pfm.102.2019.12.02.15.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 15:28:18 -0800 (PST)
Date:   Mon, 2 Dec 2019 15:28:16 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 22/26] t7700: consolidate code into
 test_no_missing_in_packs()
Message-ID: <20191202232816.GA26892@generichostname>
References: <cover.1574731022.git.liu.denton@gmail.com>
 <cover.1574884302.git.liu.denton@gmail.com>
 <a99a45cb6f2cc7328ef0e52fc2ea8fec537bfba9.1574884302.git.liu.denton@gmail.com>
 <xmqq7e3i4b1p.fsf@gitster-ct.c.googlers.com>
 <20191202205037.GA43606@generichostname>
 <xmqqo8wqwd9m.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo8wqwd9m.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, Dec 02, 2019 at 02:53:09PM -0800, Junio C Hamano wrote:
> > (By the way, if I were to reroll this series, should I keep sending out
> > the entire patchset? It feels very noisy to send out 20-something emails
> > every reroll when I'm just making a small one or two line change.)
> 
> Especially if it is near the end of the series, just a single step
> is OK.  But is there anything that is glaringly wrong that needs a
> reroll?  Or would it be "this is good enough, so let's have them
> cook in 'next' and graduate to 'master'---further clean-up can be
> done after all the dust settles"?  I have an impression that we
> reached the latter by now.

Perhaps the log message could use some improvement to document the
discussion we had? I don't know if that's worth a reroll, though. Aside
from that, I agree that it's ready for 'next'.

> 
> Thanks.
