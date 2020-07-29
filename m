Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FA8C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 22:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D488208A9
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 22:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OjF2mL2E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgG2WVd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2WVd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 18:21:33 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717F6C061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 15:21:33 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id z5so15279320pgb.6
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 15:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XuMTTQ4XS0LiVlTMH5JqvLE0VIrj7V/qFv85jm+twGo=;
        b=OjF2mL2EpHiHwHR2hlW10dZjywRnI7UVPtWx9UhIABptAz0MaqbR41NXxCjqqkzdlH
         bs2W1JZaBRlnhrrIa1/qBviYxrSSSO5F1C3AXTuT4dpXiR0WVLi00NhbFkvCNEvXv8o6
         jugMc8lt+gz4BSNaixjBIVzQAW85i6bYc5XJ6IgIzw3tGqp8PVBtk5J6ts3gw0FxnTw7
         IJD6839dENRCIiV7kvwyOXzLKT9zyysrmtLWBhKIS+HXImexvRcd1E251h0FQAnk6qh/
         6kQ6xLPNexClrjF3GDnGadWaSkUmVvkC/fZDxrwxN+pVAEz5q6IbFd/p0wRVTIh4dMat
         SsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XuMTTQ4XS0LiVlTMH5JqvLE0VIrj7V/qFv85jm+twGo=;
        b=cyYPuaWxrXa6HWuEtLBYK16FYQCdoU3QDO+ckquQxIcxNiNppqP5r4vS/WLuKsevfo
         axHXsI/flRPukbAJ3KelXN7fkS5LdaP3vqmZOH0nTDDGUKLs17kFCf2qYlhDNo9yBaol
         alM1inTvgRO7gmOzvVIDF7gQbKL8Xgi3Bfgc4+SczKtcAriuMU/BKdZb8P/+qMYUrRY8
         /xhZ8TiF4E6gLq1QwYU+lthQOOUqdwy0Gtq5f/7qrzLvMAvt6LgSGays3KqqkxZiY3DL
         KhU+26MeWHH9WSXdPu9LdhllwP0abABOpvaFm19n3VXERDql4AtlclCpAAxyeVwbDX0U
         xbww==
X-Gm-Message-State: AOAM533q5QOSYDaQlsufYwELX5Xyh3WuvHaJEvR8iRSo0NN3dk1z21cN
        LRtB3atE2BvGxMfhkw5Qnw+oOA==
X-Google-Smtp-Source: ABdhPJymEA++zkGYXgebSkSOcdhye4HuhnuoGEgtWY/8+TPB0pH1iv59HaTqykhw0347Cjx0KNjKpA==
X-Received: by 2002:a65:66c4:: with SMTP id c4mr27322482pgw.442.1596061292844;
        Wed, 29 Jul 2020 15:21:32 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id y196sm3587265pfc.202.2020.07.29.15.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 15:21:32 -0700 (PDT)
Date:   Wed, 29 Jul 2020 15:21:26 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 09/18] maintenance: add loose-objects task
Message-ID: <20200729222126.GC2965447@google.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <83648f48655ba68126110018d81c1d2e2bcc7a6f.1595527000.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83648f48655ba68126110018d81c1d2e2bcc7a6f.1595527000.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 23, 2020 at 05:56:31PM +0000, Derrick Stolee via GitGitGadget wrote:
> +loose-objects::
> +	The `loose-objects` job cleans up loose objects and places them into
> +	pack-files. In order to prevent race conditions with concurrent Git
> +	commands, it follows a two-step process. First, it deletes any loose
> +	objects that already exist in a pack-file; concurrent Git processes
> +	will examine the pack-file for the object data instead of the loose
> +	object. Second, it creates a new pack-file (starting with "loose-")

[jonathan tan + jonathan nieder] If you are going to document this,
probably it should also be tested, so the documentation does not become
stale. Or, just don't document it.

> +static int pack_loose(void)
> +{
> +	struct repository *r = the_repository;
> +	int result = 0;
> +	struct write_loose_object_data data;
> +	struct strbuf prefix = STRBUF_INIT;
> +	struct child_process *pack_proc;
> +
> +	/*
> +	 * Do not start pack-objects process
> +	 * if there are no loose objects.
> +	 */
> +	if (!for_each_loose_file_in_objdir(r->objects->odb->path,
> +					   loose_object_exists,
> +					   NULL, NULL, NULL))

[emily] To me, this is unintuitive - but upon inspection, it's exiting
the foreach early if any loose object is found, so this is cheaper than
actually counting. Maybe a comment would help to understand? Or we could
name the function differently, like "bail_if_loose()" or something?

> +test_expect_success 'loose-objects task' '
> +	# Repack everything so we know the state of the object dir
> +	git repack -adk &&
> +
> +	# Hack to stop maintenance from running during "git commit"
> +	echo in use >.git/objects/maintenance.lock &&
> +	test_commit create-loose-object &&

[jonathan nieder] Does it make sense to use a different git command
which is guaranteed to make a loose object? Is 'git commit' futureproof,
if we decide commits should directly create packs in the future? 'git
unpack-objects' is guaranteed to make a loose object, although it is
clumsy because it needs a packfile to begin with...

[jonathan tan] But, using 'git commit' is easier to understand in this
context. Maybe commenting to say that we assume 'git commit' makes 1 or
more loose objects will be enough to futureproof - then we have a signal
to whoever made a change to make this fail, and that person knows how to
fix this test.
