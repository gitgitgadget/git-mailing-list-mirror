Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05B7C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 05:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C064161074
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 05:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241791AbhIAFFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 01:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhIAFFG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 01:05:06 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4682AC061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 22:04:10 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z4so2472240wrr.6
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 22:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kbpgUm9CwtUstfHruenGyUYR+lRLvv8UtBTB5sstMIY=;
        b=Cs1STByVXGKfB89A9HEZGq5AnnxKiq1AivGxARqx1q8y6l9Gho2hRpvQX3M+VX/8S5
         P/VYzghCLUCkPRMefYDKjhpTVJ9GxcJLvuj4dRgmTXc1Ugd6uEZ/iUbTsQZsGlTkB99s
         IXJ7Q+9vrPeiPNJKWn/SzUSHt5MPg2rKwbU7CO20iaTrcJHjFM+t7GrHf7uwd1I/hepT
         aWLU3XiPDTH9aR1RWRaZ418a8s4keTfOF7o6RePJYnVGADH0CPpZ1l3ytmb7WfR36E0I
         /PiLzoUrrWuXW8I5BevCMCEUmz0j5EkGDugSgSTkQUjQ034I35kAYbs67o5ntXU0GOZJ
         RreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kbpgUm9CwtUstfHruenGyUYR+lRLvv8UtBTB5sstMIY=;
        b=eI3hfKO4qzuA9ywqE4LSD7MfofivvuIVIAsgRycT0laMnFbVqAMSXK+BlBIFyzuMJi
         mZfqw7kBI8OOkavy8poTbF4Ge+bIq4RblrKuRGIkjeqenk9y8frqVIWv+p5aJTmqUFM9
         /vc+4MGqL3tvNJKnASDGCJGILATxfewF7QHOH1P7QbwhtKFvpp4l1oyE52oJO81tQL3X
         3whXA0svkakXlp/yMpVfRxIzxE5T2yPnrtVxS2wHq0/LJDL0B+PkT27DLppi3Ha/Gp4j
         qgc6Q6RLeEt/NUoiPtZ/FiZdevttx6lRqw4bDG8hmy/MCHX9ATSe9h9nl7DnQqIMu0i6
         MmNQ==
X-Gm-Message-State: AOAM532fGceATgA56mMdk9oGlHxgel2rtCpmbVMY7y7exv/err6kXdU8
        2CuAlmgO2haWwNwS/HDVZSh4kSlVAzk=
X-Google-Smtp-Source: ABdhPJyJ68GRv6eE5yfVmi8m2mv8iMcqUDq5ZJ6qE2gYBRu8zZ8RhVoK8Aot/21XFyn4EsRirMC1Yg==
X-Received: by 2002:a05:6000:1808:: with SMTP id m8mr34287974wrh.272.1630472648866;
        Tue, 31 Aug 2021 22:04:08 -0700 (PDT)
Received: from szeder.dev (84-236-78-211.pool.digikabel.hu. [84.236.78.211])
        by smtp.gmail.com with ESMTPSA id t14sm20122057wrw.59.2021.08.31.22.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 22:04:08 -0700 (PDT)
Date:   Wed, 1 Sep 2021 07:04:06 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Clemens Fruhwirth <clemens@endorphin.org>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: What's cooking in git.git (Aug 2021, #09; Sun, 29)
Message-ID: <20210901050406.GB76263@szeder.dev>
References: <xmqq35qr7mq5.fsf@gitster.g>
 <87tuj7xhqo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tuj7xhqo.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 01:00:46PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sun, Aug 29 2021, Junio C Hamano wrote:

> > * ab/only-single-progress-at-once (2021-07-23) 8 commits
> >  - progress.c: add & assert a "global_progress" variable
> >  - pack-bitmap-write.c: add a missing stop_progress()
> >  - progress.c: add temporary variable from progress struct
> >  - progress.c: stop eagerly fflush(stderr) when not a terminal
> >  - progress.c: call progress_interval() from progress_test_force_update()
> >  - progress.c: move signal handler functions lower
> >  - progress.c tests: test some invalid usage
> >  - progress.c tests: make start/stop verbs on stdin
> >
> >  Further tweaks on progress API.
> 
> (Summary copied from <87v93wflm0.fsf@evledraar.gmail.com>)
> 
> The changes are rather straightforward, see
> <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>; so if anyone's
> interested in reviewing them.
> 
> There's been no reports of anyone running into the new BUG() assertion
> in 8/8 of it: <patch-8.8-1a14176bee-20210722T125012Z-avarab@gmail.com>

Please don't advance this to next yet.  I've found some issues with
it, but not the time to raise them.

