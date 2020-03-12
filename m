Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95141C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 18:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF9B20663
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 18:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584036017;
	bh=zewtajEBRIxcID6lS46kYzXOdQBhAR9sgM2JHYlGdbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xuDJ60qVHDgRFCrUPexT2gIGG2s6WnK8cvZ0gLCZyclHGvud26P/SRQICS3TC6+GA
	 Ac8F1oEqw/8zX4uY9peAHws35CaRt0wkkQX0YRDbhEUVy/NUSl8jbPq3jWf7xlwOc+
	 wJZr2PYboF+kJZPKOTC8BvLM9Luxsq2HiESSTsYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgCLSAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:00:16 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43434 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgCLSAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 14:00:16 -0400
Received: by mail-qk1-f195.google.com with SMTP id x1so2900758qkx.10
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 11:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=TAHWC5kjvuQl7yMOwTfP81BzeEfLv5WrNgDBBmZ2K4Q=;
        b=bRnYypm3UBfLz2vWViuMBpopmmr5D5VtTzWe2fpRiwMU55nDR8C8aEPoSgcS0SwMHs
         6flbfH2e6lm4B3JYXmizMDbTxRpp4xQPBaZEUCitvh6beYiMG/VSvpTzD34+GVFPPDYU
         l3HGtg95AmOcOpfd+ea0pBVwys1NmxsNTsz+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=TAHWC5kjvuQl7yMOwTfP81BzeEfLv5WrNgDBBmZ2K4Q=;
        b=gxModKF5WsLVWLRTzNN948WMtrsqc+LNOKH10Q09BJcEBRKGsGIuG+ohqcbBLtPOdt
         KgAzuctPyPHCSgO5qbdDIYDn6o6TZgbjZPZKBm2tnXX0+ri11rHPp5PYK0DjT69GG1nG
         3pea0MzjGdV5ORbw1R1+OqD9mVTyeGoA+dwrUl/SYjqUeu2EI74Pp0ZndRVKplIdu+QW
         ZW5KjEQnZS2ozfbatiALQ9XPzt2eatm4PssKONLLL4CGH1Okzx2nurHOPDiC1effiOFc
         EE+1pPooh9FCC4K2OCo6Isf2d3Ah0CBv+RbGvsyPhYvS0boX9+Xfu7IMXCi0fCyL9xYw
         asww==
X-Gm-Message-State: ANhLgQ2ybdMKsSMoMhENittzC3qMN4qMBVqtyCgH1+l11nx89IijBSqg
        qauDtmlDqcTCVW20gNaXHvJNOHs3h1sNFQ==
X-Google-Smtp-Source: ADFU+vu9wm9gnVOiO80Pm/KDE6z/iP+LnndK0cJv0PeNRG0KWwMpLdTti1zdDJm0CtJvF0l95qDV4w==
X-Received: by 2002:a05:620a:11b3:: with SMTP id c19mr9270872qkk.296.1584036015196;
        Thu, 12 Mar 2020 11:00:15 -0700 (PDT)
Received: from chatter.i7.local (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id m126sm6522820qkb.55.2020.03.12.11.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 11:00:14 -0700 (PDT)
Date:   Thu, 12 Mar 2020 14:00:12 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        James Ramsay <james@jramsay.com.au>, git@vger.kernel.org
Subject: Re: [TOPIC 16/17] =?utf-8?B?4oCcSSB3YW50IGEgcmV2aWV3ZXLigJ0=?=
Message-ID: <20200312180012.bgjls4esndkg3iqf@chatter.i7.local>
Mail-Followup-To: Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        James Ramsay <james@jramsay.com.au>, git@vger.kernel.org
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
 <6DAC1E49-9CA0-4074-867E-F22CD26C9FEB@jramsay.com.au>
 <20200312133127.GK212281@google.com>
 <20200312173134.bpflnl6n3w6mywlg@chatter.i7.local>
 <20200312174212.GA120942@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200312174212.GA120942@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 12, 2020 at 10:42:12AM -0700, Jonathan Nieder wrote:
> >> We've actually got a meeting with some Patchwork folks today - if
> >> anybody has a burning need they want filled via Patchwork, just say so,
> >> and we'll try to ask.
> >
> > Just to highlight this -- a long while ago someone asked me to set up a
> > patchwork instance for Git, but I believe they never used it:
> >
> > https://patchwork.kernel.org/project/git/list/
> 
> That was me.  In fact, we are using it, but mostly read-only (similar
> to lore patchwork) so far.  I'm hoping we can learn more about how to
> automatically close reviews when a patch has landed, assign delegates
> to reviews, set up bundles, etc and write some docs so it becomes
> useful to more people.

FYI, I can set it up with git-patchwork-bot, which does some of the 
above. You can read more here:

https://korg.wiki.kernel.org/userdoc/patchwork#adding_patchwork-bot_integration

If that's something you would like to see, please send a request per 
that doc.

-K
