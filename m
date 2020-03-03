Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5A4C3F2D1
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 21:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1F5208C3
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 21:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZHKTXr8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732555AbgCCVXI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 16:23:08 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42522 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732413AbgCCVXI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 16:23:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id z11so6276826wro.9
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 13:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WThCEXtIn1Sq34CQkfX7cfqRoA4SSOUjTp2hB/cayGs=;
        b=UZHKTXr8estNv2MShYXUI0Zttcc8EsOgWSp/ETIuMsLqK4jxf5j1K8231KO/TMZBxo
         dJzbIELAdHax+v7duKLmscXS8Z4lb0a8tCdWORFoDHTBDH3awaHwOuCyqy3zmw3WLZ5T
         u+PtTCmSCbGUjIEX3Mte/Xhq3lor4EYZmEWrITtg6ydtqRIab9vMYx4BZ7YddMiJRFnu
         7MYqkko1+YjRF9qHNBCfZFZdoM+pBDdBzrkSjtNtRpuV4y4BM6Y8lfgntifajASJkhiF
         Hg9ZUsg2nQiPPb2aOjQdlPHfs5qdR6qwGWh3fnvM7fb84OeDTDwP6+SgRDBSlUMF8oLN
         TyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WThCEXtIn1Sq34CQkfX7cfqRoA4SSOUjTp2hB/cayGs=;
        b=mVGqMwn7uqitDGxm1nLe+civSRbI6klqQakSN8tq4eNb42ifgLIYH6eslKi/dN7SYA
         aMJldo4gqaNdixgz0pmNx7k5FSc7h2I0jYJv3Dl0Hf+u012l/KgGsGY5LrS6TB/L9ip7
         P5o/nfZ/FflyWAqQRWU+7q8jTdyesvN7JKW79Z/+UT9NjTOySpBKSykNJxMGzjG5pXVG
         fOhYAR4JCNB7LdrBP97oKs1BWnTxB4l5LqobU9H4YBLdYeuDq3sa/vh9MSP7FlX01kNF
         /8NStCnemgkemX/AFR5+4ps1ZnLbgVH3Ey0mxH1NHpavF3AASm61FTVBuC5v9BQJcS6b
         eoFw==
X-Gm-Message-State: ANhLgQ0l8367YUX5wqUTLlAND3fYnMPZ0fw34sKRYQl3TP4MlmDNX2i9
        xOVLs5D6fvHmg+fSjLQjVKw=
X-Google-Smtp-Source: ADFU+vvo6vGZd13po/Eru19DuSeHDlHsz7tLDzbeRSP6kOvm38AzS/x00L7n72/+bgufTGb8+i+Teg==
X-Received: by 2002:adf:e68b:: with SMTP id r11mr20897wrm.138.1583270584771;
        Tue, 03 Mar 2020 13:23:04 -0800 (PST)
Received: from doriath (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id n11sm25322816wrq.40.2020.03.03.13.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 13:23:04 -0800 (PST)
Date:   Tue, 3 Mar 2020 22:23:02 +0100
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] doc: update the documentation of pack-objects and
 repack
Message-ID: <20200303212302.znhumbjo7lywyhvh@doriath>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Tue, 03 Mar 2020 21:59:15 +0100
References: <20200228154357.1710521-1-damien.olivier.robert+git@gmail.com>
 <20200228154357.1710521-2-damien.olivier.robert+git@gmail.com>
 <xmqqk142bn5f.fsf@gitster-ct.c.googlers.com>
 <20200303174136.ess5lfxrsrt6qvdu@feanor>
 <xmqqa74x8e9k.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqa74x8e9k.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Junio C Hamano, Tue 03 Mar 2020 at 10:49:43 (-0800) :
> Damien Robert <damien.olivier.robert@gmail.com> writes:
> 
> > The problem here is that
> > `--keep-true-parents`, `--no-empty`, `--all`, `--reflog`, `--indexed-objects`,
> > `--exclude-promisor-objects`
> > are always passed and not driven by any options of `git repack`, so I
> > did not know where else to put them.
> 
> Ah, I think I may have misread the patch, then.  Why do readers who
> wanted to learn 'git repack' even need to see what the command does
> under the hood, driving what other low-level commands by passing
> what options, in the first place?  Such implementation details can
> change without affecting end-users, no?

So do you suggest instead to remove all references to 'git-pack-objects'
in 'git-repack'? As I explained in my previous email, if some options
reference pack-objects, I think they should all do for consistency.

I also think that the situation of git-repack is a bit special:
first it is a very thin wrapper around git-pack-objects, so the
implementation details are not really abstracted from git-pack-objects.
Furthermore it is at an intermediate 'level' between a high level command
like 'git gc' and a plumbing command like 'git pack-objects'. So the user
interested in 'git repack' is probably interested in some low level
details.

Now to give an exemple, the doc of git-repack states:
    This command is used to combine all objects that do not currently
    reside in a "pack", into a pack.
This is a high level overview, but the user who knows a bit about Git
internals may wonder what exactly 'all' entails: non local objects, kept
objects, promisor objects, unreachable objects?
Knowing that the default options passed are:
`--keep-true-parents`, `--all`, `--reflog`, `--indexed-objects`, `--exclude-promisor-objects`
answers this questions: it is essentially all objects except unreachable ones.
Here I think that these technical details are more precise that whatever
sentence I could come up with, but I am happy to hear suggestions :)

I agree however that `--non-empty` is an implementation detail.
