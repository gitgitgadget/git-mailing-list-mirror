Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6F4C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 21:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6CE261179
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 21:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345733AbhIIVKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 17:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbhIIVKK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 17:10:10 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE270C061574
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 14:09:00 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id s16so3390749ilo.9
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 14:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UTxcWtQ+vZlwhh3FS6A4gaLefJ29wt6qNeDCTb/6/9w=;
        b=tzJc4UM49gApPfwxPNG1dXaPkv61S9QVY6drR/al2JXIn+n36/6/OxD6CZi4cUSscV
         Nz1sKKweAnwskO3dhgRocx6A/8zPGELEdTDokzTkKEjL5JG9f5b7uOlE5XqZ+G5lNq3r
         fa9GzX491D1h6msqpHBn5V6epUhGJsquJQ/5EHFRi52XBSPtpIMMAvoyZUwvrmyxpLBw
         iAQPj50BG8Xh3aPFERxG6xQFjk+5NU1bSysyUM8FeisamfA+Qe5zeeccoC1so6+gNqCB
         a3YfeXQDLhsYp1dn5JV2iRHgUWDHHRFM/xOBgoh26uuLRlux9WkQyQlmBzNW4mbc+0WI
         uTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UTxcWtQ+vZlwhh3FS6A4gaLefJ29wt6qNeDCTb/6/9w=;
        b=nBNAVez6pny11teQVrzRsmDDOJnNDfb6DlvGI3ApTjeCKAnIG0VWLcnweNEKAFtQg+
         lmEEhZKX3i2np0N3o/47sEZfl23mU0CaOzKvGOBD9UGzPypAZ1CXblAUrKC4csyv9cgp
         WfIIWbAc/SRKaV+S6BZ6E6yzuNNrhI83tyJTphz475MnxJ6V5V4jHNV83WhFySQ58x4x
         6qJK6IfaCDfH8agSr89B3ry2lhQ5t4IzGYjYaVH/0aMl1P7pT1p5LgDxAP5SzKnHbtyt
         Wt+AhuAPwlUoC/F9LcQxO3coZ6IRDLC5Nrqh5yzVlVREjbih4yJeVy9Rktye8T0Ekmvn
         Kr6Q==
X-Gm-Message-State: AOAM531gpQz3DnoJQXTzGZORQIMLf+T1DsbSogXr2UsSZVjW3p+fkWkO
        2QDWFzgMqa2yvEO1L0AvYnXJTA==
X-Google-Smtp-Source: ABdhPJxNtH2DZwfdwxR5++vJb6Ovnt1ZYM9PbwNZyqDHRNmkWvqnRmSUm1hK9gZFhDgLxuegMDEh0g==
X-Received: by 2002:a92:d107:: with SMTP id a7mr2383099ilb.199.1631221740413;
        Thu, 09 Sep 2021 14:09:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n11sm1420369ilq.21.2021.09.09.14.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 14:09:00 -0700 (PDT)
Date:   Thu, 9 Sep 2021 17:08:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH 5/9] builtin/repack.c: move `.idx` files into place last
Message-ID: <YTp365kOEpRenuml@nand.local>
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover.1631157880.git.me@ttaylorr.com>
 <3b10a97ec0e7c9e672904e6415909a1b8cea872e.1631157880.git.me@ttaylorr.com>
 <xmqqa6klzghf.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqa6klzghf.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 09, 2021 at 12:38:52PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> > diff --git a/builtin/repack.c b/builtin/repack.c
> > index 5f9bc74adc..c3e4771609 100644
> > --- a/builtin/repack.c
> > +++ b/builtin/repack.c
> > @@ -208,10 +208,10 @@ static struct {
> >  	unsigned optional:1;
> >  } exts[] = {
> >  	{".pack"},
> > -	{".idx"},
> >  	{".rev", 1},
> >  	{".bitmap", 1},
> >  	{".promisor", 1},
> > +	{".idx"},
> >  };
>
> And the .idx entry MUST stay the last.  I wonder if dropping the
> trailing comma and replace it with a "/* must be at the end */"
> comment would be an effective way to ensure that.

Heh, Ævar even wrote that up, and I responded that I did not think it
helped much. Again, I'm happy to add it back if anybody feels strongly.

Thanks,
Taylor
