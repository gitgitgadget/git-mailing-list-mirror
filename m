Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2BEC433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 21:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0DD8610A6
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 21:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344431AbhDPVe1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 17:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbhDPVe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 17:34:26 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB33DC061574
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 14:33:59 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id o20so7638005edc.7
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 14:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=i5PNlpDP3NXSWmiMzIv968HLzjDf33fNppu8n+BFSt8=;
        b=PAeZIrilA+apU3d3Ls53fVu2EpgAotq40yjWbj7KKWjs4Dq4Kvvl696g101B6wdWE5
         4q7j8KOdR5kFvABlSpPVPyPLj1pDpdPoyP0d3DG0pT/5k35FNPg/AqSu2apIYKRQ+pVs
         ZTxciQY/tXbLfUGiRQPr7mjGrQEBxykxg4/Okvyix0+MIkbkw28uMXopb1liRIWcApIy
         A8lTVX0Os9nAxSCUU+BPCSjJi3LBTrG/eMrD/GfYgxEmg6mkS9kiywiweLszgWXshQA1
         EKWIQje0mWklAfpKVWitAs+EkQO+jpPBudifqkzReS+lTjuHA5+Mlji3jXepmMy1GaQy
         byZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=i5PNlpDP3NXSWmiMzIv968HLzjDf33fNppu8n+BFSt8=;
        b=lGz7sY1Dgzz5b6jXWNJiHVG865wFPkeCMBSBjz7RoepoegH1G6iQBUBplhbBNu8WaT
         TnBA0BIh9ITlqllDCrhpvXwDNcAWHvKizQsGVJg2tWEIia0ztin2KVulidYjjzVuJZkI
         Whxks4V3215EFaLmowZMW3/aF2pFaZJtIpMU+5k6dea8WBZPnPdKQTQ4q05EXl+8Be1R
         bUzpQ/yonASVM7KpQSzSoTZYwXF8l8tWejyoVLqGMAShKUxjZJUKAFigkYg6+v/5PTnx
         6lAPVS1RzEHH6h6lj2jVfFB2qrRM1AtKyWtuB/qZ50+k7Yy7G3ftwB/9Pt3nPsRo1zS3
         5xBg==
X-Gm-Message-State: AOAM531N6dx80JKnDF8QchIs7z3Jg6d6DHUzV0ntnlxx9Qtus32FzGbB
        f/Vl9PZGhWgGDOz6hbjaL7k=
X-Google-Smtp-Source: ABdhPJw5V0BZRktFzkXLZQOPtCkyMOzCmWN2CtpHK9sRx1VDiG1bPJl4dFSyGBMKwmmtbY+Zx/V6GQ==
X-Received: by 2002:a05:6402:54f:: with SMTP id i15mr12429393edx.365.1618608838772;
        Fri, 16 Apr 2021 14:33:58 -0700 (PDT)
Received: from szeder.dev (78-131-14-48.pool.digikabel.hu. [78.131.14.48])
        by smtp.gmail.com with ESMTPSA id q10sm3026607eds.26.2021.04.16.14.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 14:33:58 -0700 (PDT)
Date:   Fri, 16 Apr 2021 23:33:56 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH] Makefile: add missing dependencies of 'config-list.h'
Message-ID: <20210416213356.GR2947267@szeder.dev>
References: <20200416211807.60811-2-emilyshaffer@google.com>
 <20210408212915.3060286-1-szeder.dev@gmail.com>
 <87pmz4ig4o.fsf@evledraar.gmail.com>
 <YG+UeQRwdBsVeRNV@coredump.intra.peff.net>
 <20210409212044.GD2947267@szeder.dev>
 <xmqqblaem4px.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqblaem4px.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 16, 2021 at 12:03:54PM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > On Thu, Apr 08, 2021 at 07:40:41PM -0400, Jeff King wrote:
> >> On Fri, Apr 09, 2021 at 12:08:23AM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> 
> >> > > -config-list.h:
> >> > > +config-list.h: Documentation/*config.txt Documentation/config/*.txt
> >> > >  	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh \
> >> > >  		>$@+ && mv $@+ $@
> >> > >  
> >> > >  command-list.h: generate-cmdlist.sh command-list.txt
> >> > >  
> >> > > -command-list.h: $(wildcard Documentation/git*.txt) Documentation/*config.txt Documentation/config/*.txt
> >> > > +command-list.h: $(wildcard Documentation/git*.txt)
> >> > >  	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh \
> >> > >  		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
> >> > >  		command-list.txt >$@+ && mv $@+ $@
> >> > 
> >> > This change makes sense.
> >> 
> >> I agree it looks like it's moving in the right direction, but I am
> >> slightly puzzled by the existing code. Why do we need to use $(wildcard)
> >> for git*.txt, but not for the others?
> >
> > We don't need $(wildcard) for git*.txt either, because 'make' expands
> > wildcards in prerequisites, see e.g.:
> >
> >   https://www.gnu.org/software/make/manual/html_node/Wildcard-Examples.html
> >
> >
> > On a related note: all config variables are now listed in
> > Documentation/config/*.txt; Documentation/*config.txt doesn't contain
> > any, so that could be removed.
> 
> Is it OK for me to keep expecting an update to the patch happen soon?

No, I think this is a good bugfix patch that stands on its own, and
further cleanups could be done independently on top and should not
block this patch from being merged to master.

I'm inclined to think that this should be merged and then
'so/log-diff-merge' should be queued on top because of the subtle
interaction between this bug, the new config variable and the
completion tests.

