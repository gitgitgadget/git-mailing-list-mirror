Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAC6C433EF
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 20:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 170DA60D43
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 20:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhJXUMa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 16:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhJXUMa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 16:12:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2E8C061745
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 13:10:09 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d13so6317292wrf.11
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 13:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7EfHWMDXbdr21f1MBf62MchJPagFUWNbw3uQVCDARbE=;
        b=jry0Z/SD0UXNGjp7uxw2I6KLnenECEXJAhBlax3sIk9enze78dWWuevPGcZd/eAFiN
         xkROiEKsQwH2P4vfENrdjHQAKcSCWQHX0esCKHrysOV+mJNjQOzbYj2750fXtBXWykPg
         uMKXp972cuMJH8ASQU/hQjADOErbXSXcFvTZpY+oKnOgdShoWkx+tGsMqV2eeGG+XpmX
         oSjISIfxe77fiL3FKoJqJYGTgbl7ZfM3/qrBQoCW3RdsSuAOuGOPaTjivwohFbjvt1Py
         6038Dn77xejYiDaBBtia2nkEQY8qlblZyc9bfzqlLQVfLPoCZd7UmSw69LFm0ZZvtml1
         X1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7EfHWMDXbdr21f1MBf62MchJPagFUWNbw3uQVCDARbE=;
        b=mHH/sAI0L1R07DR30FFFlO1p/i8jn3T5M+CGd2uVlwJtO9yCk7u9qohshM3aHxQ66b
         pzS+YBoYBifjQP/NODLJin1mEzqqH7dAoEPTnlbyFRnNStN7RgcXaJHTIrtpPj7DKFHe
         u4wkehvBE37/PbS14QNn406EvtuU/kgQkb7zkj/+4qrpSQERw/hSlHDOGgTEgHcLQJQE
         jVFYuf6CN9MSZLf3EGxstntDsVsJxHitvNibJ1XMqOcWOVm60EaX0uvbQ6v+Pvi5xrry
         oz4h7V9cFXDcLgf7xQN7ZQ8Bb9gDztRNUQnEv2o11PRf5pabXbzdBLV3gjzFOWhKTrbS
         dgOA==
X-Gm-Message-State: AOAM530GpCWmoOIiqYlHXGJohHF+mTWwgRUgfxvXEsD7gIXZ2+/I53op
        +YOeyKqqO3nFVqWJxpNX9dk=
X-Google-Smtp-Source: ABdhPJwPGf30DAjdf5LzFhQM9tJCxY/hvnFvavYAVisLPySkTAtrhR67+vvZssHWbzpPxc+CryhCNQ==
X-Received: by 2002:adf:a10f:: with SMTP id o15mr18711082wro.286.1635106207744;
        Sun, 24 Oct 2021 13:10:07 -0700 (PDT)
Received: from szeder.dev (94-21-23-225.pool.digikabel.hu. [94.21.23.225])
        by smtp.gmail.com with ESMTPSA id i6sm2833509wry.71.2021.10.24.13.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 13:10:07 -0700 (PDT)
Date:   Sun, 24 Oct 2021 22:10:00 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v3 03/10] progress.c tests: make start/stop verbs on stdin
Message-ID: <20211024201000.GB2101@szeder.dev>
References: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
 <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
 <patch-v3-03.10-045d58d8201-20211013T222329Z-avarab@gmail.com>
 <20211021223044.GA3615@szeder.dev>
 <211022.864k99kune.gmgdl@evledraar.gmail.com>
 <YXM3ynt1UafUHfMQ@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YXM3ynt1UafUHfMQ@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 22, 2021 at 06:14:34PM -0400, Taylor Blau wrote:
> On Fri, Oct 22, 2021 at 04:18:16PM +0200, Ævar Arnfjörð Bjarmason wrote:
> > >>  	progress_testing = 1;
> > >> -	progress = start_progress(title, total);
> > >>  	while (strbuf_getline(&line, stdin) != EOF) {
> > >>  		char *end;
> > >>
> > >> -		if (skip_prefix(line.buf, "progress ", (const char **) &end)) {
> > >> +		if (skip_prefix(line.buf, "start ", (const char **) &end)) {
> > >> +			uint64_t total = strtoull(end, &end, 10);
> > >> +			if (*end == '\0') {
> > >> +				progress = start_progress(default_title, total);
> > >> +			} else if (*end == ' ') {
> > >> +				item = string_list_insert(&list, end + 1);
> > >> +				progress = start_progress(item->string, total);
> > >
> > > Why is it necessary to use a string_list here?  This is the only place
> > > where it is used, so I don't understand why we should store anything
> > > in it.
> >
> > The progress.c API doesn't xstrdup() the title you give it, so you can't
> > free() it after while it's alive.
> >
> > Here we're re-setting the same strbuf in a loop, so if we hand a "title"
> > to progress.c we need to keep it around, when we later add a BUG
> > assertion in 10/10:
> >
> > +	if (global_progress)
> > +		BUG("'%s' progress still active when trying to start '%s'",
> > +		    global_progress->title, progress->title);
> > +	global_progress = progress;
> >
> > The "old" title would point to already-free'd or to a nonsensical value
> > if we didn't do that.
> 
> *nod*. I figured as much, but a comment indicating that may be helpful
> for reviewers and future readers of this code.

Yeah, a comment would be nice; though perhaps giving that list
variable a descriptive name, e.g. 'titles' (plural!) would have been
enough to set me on the right track.

