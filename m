Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C30C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 22:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F085561205
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 22:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbhJVWQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 18:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhJVWQy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 18:16:54 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D25DC061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 15:14:36 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z69so7219925iof.9
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 15:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TjpXPbwBGV0efxSWo8cLOK8T3GmAucHCX9tAgWA2NFI=;
        b=mp2SxWw0QfgHqLv3UV3TN1LBBuvU49gZP8oy3UGj1uXQ0itlPriZezZ+9EWgF9/noz
         OiW4gH6ogK7KHPh21UN29cbulWQiCXoWct3H0cHVFoIVVUVV6PIb8HWETitbEBkcJTDC
         ZUbVNSDW2BMnWbyCE1SWZluSLq1Fll8Gj/KQtoBWRkPyFnDqin3hpVCFwqjnvySYSBsc
         UayYotUBprjCOg+HDzfS0wTsMLc88QC3upzxmEyi6Q4xgyfjoFPYDL+8txprZnxCL4AI
         6fX5C/n9MT3jdpQ2LvQZkeIQBYKIbV8n3dKprbPzN4dIAokt5UC3ytpCRTMvhn7xrl2l
         RZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TjpXPbwBGV0efxSWo8cLOK8T3GmAucHCX9tAgWA2NFI=;
        b=sLyI/Ls5dV8Fl61FjMbuaUE4rodHgMz1ZPBHTNS41JWo0cU/XKw4jmX9ilOsLXZaT7
         Ke0C7LT1PCS+Xa+0g1bfxXpVnZ4a1AUp3vGZKo5E9v2vg5ahtZGemRH1CXUZ8luxBUqM
         wQlzIxs4mrIaCzja7ShSlL4lynleqC0//6m8CvLj4BaxH9wmxl7vUF9DK7LRs4jnQ6HH
         BCFEbS193qFlcYWYWL24tqRJLan6fE3hvX71yXZYLcuaAyaalvYVBhA3mARka9bE7vul
         ewsAL9OKNTKFUVD20Am0t6x3HLm/uB5isQJ1DQhnqDeojhUGUcOJ09vLbdHg/9RZjZOy
         8qKQ==
X-Gm-Message-State: AOAM532txhan8xHBla32nyLjaF3mYcC/h+mT/p4Lh/OL7UEYvW/ieNMu
        N1HbD465c9uw/nB6wI4CA/rERA==
X-Google-Smtp-Source: ABdhPJx/XWqdJKDDFgyJhtWiNA50flvvzAozlmVyP5RL2BpDpLbH1cz+oZDmMScot8euhEqsJmLSiQ==
X-Received: by 2002:a05:6638:140f:: with SMTP id k15mr1557339jad.33.1634940875741;
        Fri, 22 Oct 2021 15:14:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l14sm798579ilk.60.2021.10.22.15.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 15:14:35 -0700 (PDT)
Date:   Fri, 22 Oct 2021 18:14:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v3 03/10] progress.c tests: make start/stop verbs on stdin
Message-ID: <YXM3ynt1UafUHfMQ@nand.local>
References: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
 <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
 <patch-v3-03.10-045d58d8201-20211013T222329Z-avarab@gmail.com>
 <20211021223044.GA3615@szeder.dev>
 <211022.864k99kune.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211022.864k99kune.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 22, 2021 at 04:18:16PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >>  	progress_testing = 1;
> >> -	progress = start_progress(title, total);
> >>  	while (strbuf_getline(&line, stdin) != EOF) {
> >>  		char *end;
> >>
> >> -		if (skip_prefix(line.buf, "progress ", (const char **) &end)) {
> >> +		if (skip_prefix(line.buf, "start ", (const char **) &end)) {
> >> +			uint64_t total = strtoull(end, &end, 10);
> >> +			if (*end == '\0') {
> >> +				progress = start_progress(default_title, total);
> >> +			} else if (*end == ' ') {
> >> +				item = string_list_insert(&list, end + 1);
> >> +				progress = start_progress(item->string, total);
> >
> > Why is it necessary to use a string_list here?  This is the only place
> > where it is used, so I don't understand why we should store anything
> > in it.
>
> The progress.c API doesn't xstrdup() the title you give it, so you can't
> free() it after while it's alive.
>
> Here we're re-setting the same strbuf in a loop, so if we hand a "title"
> to progress.c we need to keep it around, when we later add a BUG
> assertion in 10/10:
>
> +	if (global_progress)
> +		BUG("'%s' progress still active when trying to start '%s'",
> +		    global_progress->title, progress->title);
> +	global_progress = progress;
>
> The "old" title would point to already-free'd or to a nonsensical value
> if we didn't do that.

*nod*. I figured as much, but a comment indicating that may be helpful
for reviewers and future readers of this code.

Thanks,
Taylor
