Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7492C433E1
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 20:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88DFE20720
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 20:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="d3VT39BE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbgGUU1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 16:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728691AbgGUU1n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 16:27:43 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFC0C061794
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 13:27:43 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id u64so7506260qka.12
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 13:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zRTMUhkKLYOnKY/rFTocl2oArOBUChH7RuHkN0aT02Y=;
        b=d3VT39BEUS73Ws3ANuahuft2InJbRZaV9l3vpwzv94Wcti1SCqzOvNmqvf6Qq6q/6x
         xt3pgCxGGRlvTicGOvMvgb3lBxOxcPpQuAw42DRNoZ0xtzCP8m3wcIEb3V9c201/+G8Z
         VJPecjqsDclH8mqWUnaDr4TikklC5Zxks9VDcJRCkEYsX7xwy+rl2xqyZtKQ5C67brvl
         oCr9daa6H8QUTtABZ+hF7mo3vGQArKXfRbmS/VLxzsU+DAjupHJ9P2Xc0grhBFEHdqH1
         4rQewUP7YInhEeWO+misN5SN/1Q7FRUYID09TI9FvvbrBIR/h9Am7uuNq8YdsM8nU1t+
         kpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zRTMUhkKLYOnKY/rFTocl2oArOBUChH7RuHkN0aT02Y=;
        b=StU842aRyuzW8X5HV6JvuH0bYXhFVF6/HkxuK2OTUg6ld42u/+Hraw5uC/ZNs3XTK4
         oxzuXdtohZ4AlTtMj6B88KeFhbJk+Wd6Th820C2hGM9/iSGyNNCtFRVZpQizmgYjRviU
         pc4W0eT83cxPkOdVML8MxQUVTpEgv60Fuvy63ExYqmPkhV6sE7Ci1mDMbtklkMFnkzxL
         wUs51lYHMBVvqSM41twgBdXgAR3ft6wzy+/gHuWj0wiA5l6ysUBdfMAeLd/WQM2udSxf
         GB6HNjOWxuj0HxdNsSyMZS3gzqoS4irb/ZxKpEwaejK+CBBgCajv4WsYuIve6ridAIew
         kk0g==
X-Gm-Message-State: AOAM53115ohhGlq+hX9pWl/qmfAf3Mgv+kZnPIfIswExaYGBquyuSDcp
        XEgOb57OBl6nnGWCoYR+0oNoig==
X-Google-Smtp-Source: ABdhPJyggs2dIAHrZNWsiNu+k1VYrPnv1zixMQAdgCRVNC8VbLnv3E8bohbOQrztZ0uI+TPE6Fq1tw==
X-Received: by 2002:ae9:e882:: with SMTP id a124mr12728500qkg.24.1595363262296;
        Tue, 21 Jul 2020 13:27:42 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1456:25db:8327:2471])
        by smtp.gmail.com with ESMTPSA id u58sm25204496qth.77.2020.07.21.13.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 13:27:41 -0700 (PDT)
Date:   Tue, 21 Jul 2020 16:27:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        chriscool@tuxfamily.org
Subject: Re: [PATCH 0/4] upload-pack: custom allowed object filters
Message-ID: <20200721202740.GA34538@syl.lan>
References: <cover.1593720075.git.me@ttaylorr.com>
 <xmqqwo2w7hv4.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwo2w7hv4.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 21, 2020 at 01:06:39PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Taylor Blau (4):
> >   list_objects_filter_options: introduce 'list_object_filter_config_name'
> >   upload-pack.c: allow banning certain object filter(s)
> >   upload-pack.c: pass 'struct list_objects_filter_options *'
> >   upload-pack.c: introduce 'uploadpack.filter.tree.maxDepth'
> >
> >  Documentation/config/uploadpack.txt |  22 ++++++
> >  list-objects-filter-options.c       |  23 ++++++
> >  list-objects-filter-options.h       |   6 ++
> >  t/t5616-partial-clone.sh            |  34 +++++++++
> >  upload-pack.c                       | 104 ++++++++++++++++++++++++++++
> >  5 files changed, 189 insertions(+)
> >
> > --
> > 2.27.0.225.g9fa765a71d
>
> With this series (I do not know which one of them is the culprit) in
> the 'seen' branch, we seem to consistently get a segfault while
> running t5616 on macOS clang build [*1*]

Aye. Am I reading that correctly that it's git clone dying with a
SIGPIPE instead of a segfault? If so, this is what Szeder pointed out a
little lower in the thread (tl;dr is that 'git clone' is not resilient
to this whereas 'git fetch' is, and so we still need an `ok=sigpipe`
somewhere in t5616).

The new version that I'm preparing has these appropriately, so feel
free to discard this until I send a new version your way...

> [Footnote]
>
> *1* https://travis-ci.org/github/git/git/jobs/710504820 has the
>     topic at the tip of 'seen' that fails.  Without that merge,
>     https://travis-ci.org/github/git/git/jobs/710342598 seems to
>     pass on all archs.

Thanks,
Taylor
