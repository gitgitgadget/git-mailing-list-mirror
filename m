Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740C9C433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 02:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352488AbiCaCNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 22:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241434AbiCaCNo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 22:13:44 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7918A6583D
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 19:11:58 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id a17so26538810edm.9
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 19:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ANoVqAUrvVAzC41C188/pMjzCbKbP7GNtvtfgibntYA=;
        b=jSaCns3eydmab+OCA74QalUqSM7V93YlBv5vZtMqVxB2u56wOMcoUlq/gSWLM7exb/
         sXaephpRjxKvomWETUz09uk4aYz9y5npn9tDbGHzrwE7YeFvY8wq7sfG0S62vxHVy1m1
         SzkcalN4SPpLBRIALLV69+xVV05/JEcs67VsfeUWHlvxcUOwXakj5iDRmirlj3Zw0zeD
         FrA0YckxvwZmbFcwx7fPAXWsX6e9w2WeC/NZNV4ej47qbFg5y5ajxeMWXcv7XiB+F3JT
         hRxripBeTj7AYrvY+8BiVStt+dumikXGpIIPuriWyyw7GzEY+QEmUpvFhjRHc8uY6xlx
         BFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ANoVqAUrvVAzC41C188/pMjzCbKbP7GNtvtfgibntYA=;
        b=hBFVJMlTVC/rrHWqCQG3ACdQY8hQALIleoCKKV96atqtORqrKyGQ+8GBl3/bNMduAi
         9f598PPtqRyfi4woDgIOqUjBTrjUUuMR9CIopBk857A5YEUn6VWX5PX0rdGb9WfkLRSM
         CkvFwSUUK5xjZVLFYdQgHTqGCv9EW/fm3ovEk8exATKa7I4idCrp05fxSE1NuusfsTqK
         5LQSTKyuUAxZq4pY9X52yqHJdltm2FKrmHMED9DtDyOPj11perP6Iymf8IzCzFw4tViE
         RotS1r7LJKbTBy+sEWxEKDXP1k9u/gPCY9MiljEoWbKox44dgRvkV7JIezPMWSHiA5+Y
         G8sw==
X-Gm-Message-State: AOAM532L2stcZJuPkKMQGcr+XfD7t3ckZfGT/QoMOjeyFSDukZ0HDHxE
        qYCCiG0urIfQT77rMANMMYw=
X-Google-Smtp-Source: ABdhPJzVin0WWHhh2V+WQRjkRrItcix4FyMEy2jjbcml5y/Enq5+feriJVDoaan3TRyyMDOsjKco4w==
X-Received: by 2002:a05:6402:649:b0:41b:71d8:9594 with SMTP id u9-20020a056402064900b0041b71d89594mr4647096edx.371.1648692716912;
        Wed, 30 Mar 2022 19:11:56 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n27-20020a1709062bdb00b006da975173bfsm9011060ejg.170.2022.03.30.19.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 19:11:56 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZkHz-0008dv-VQ;
        Thu, 31 Mar 2022 04:11:55 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 3/4] builtin/stash: provide a way to export stashes
 to a ref
Date:   Thu, 31 Mar 2022 04:09:21 +0200
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220329214941.2018609-1-sandals@crustytoothpaste.net>
 <20220329214941.2018609-4-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220329214941.2018609-4-sandals@crustytoothpaste.net>
Message-ID: <220331.86lewqswes.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 29 2022, brian m. carlson wrote:

> +	if (argc) {
> +		/*
> +		 * Find each specified stash, and load data into the array.
> +		 */
> +		for (int i = 0; i < argc; i++) {
> +			ALLOC_GROW_BY(items, nitems, 1, nalloc);
> +			if (parse_revision(&revision, argv[i], 0) ||
> +			    get_oid_with_context(the_repository, revision.buf,
> +						 GET_OID_QUIETLY | GET_OID_GENTLY,
> +						 &items[i], &unused)) {
> +				error(_("unable to find stash entry %s"), argv[i]);
> +				res = -1;
> +				goto out;
> +			}
> +		}

One thing I missed on the first read-through, in the earlier commit you
factored out parse_revision(), which now contains this code (which was
here before this series):
	
	+	if (!commit) {
	+		if (!ref_exists(ref_stash)) {
	+			fprintf_ln(stderr, _("No stash entries found."));
	+			return -1;
	+		}

Aren't we going to print both "No stash entries" and "unable to find
stash entry %s" in those cases?
