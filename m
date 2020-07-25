Return-Path: <SRS0=cPh9=BE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE9CC433FC
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 01:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD0942070E
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 01:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="EsKsZQ+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgGYBqu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 21:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgGYBqu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 21:46:50 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF18C0619D3
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 18:46:50 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id e12so8272696qtr.9
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 18:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aRx3j/tK3K9T9WW+FPxH7Pb/GL/zv+PDCYdRuurl0gs=;
        b=EsKsZQ+R3TDuDSKEew/L6IDIixgpnlBQeOMj7BwD4TZTXhsBBueySdSBHuoU9JwWxQ
         feJjKmRnrDYtEFH8y25EnOabQ4PpbWQ3ZAu2wFG9NYT2Qi45HT8T1BEZ3oVdXJwZSP88
         EUpJ0dFw42qIqo1rryjkv0vqGeCSMqvFu8uNjZBYS49HB2HObY3wabOpRBFkIXJWtGNp
         ZCiWz/WYNO4+PFPhR45xR4vtJn375hDjaGBIq0YC6C/L/T7K6Xm/QdurZe9kQvQ1OX0i
         WKrBAqYOWBkjjHdaBkkd2mhIfzC6MtPcpvOrLN24ob1PJEo+QU3TSwM6uYaeAXD1ICgt
         aG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aRx3j/tK3K9T9WW+FPxH7Pb/GL/zv+PDCYdRuurl0gs=;
        b=el8g9Y1Pgjvr6Vq3wXXJA68x7fl0XHhgRlu1pxmq/D1QjRsqfDdii7BEWbs593S5jv
         pPMtlfukp42SEC9ov0oJH2neS50feLIEO3zX6c0IZoeUpv/juJvNcTod2m2m2SeE9Iet
         DUVJ/vv4H0C2ycDN7SabH/ttPPj1EPLQ734BI7fO+gp/vFDbauN6V449+dhk9o4wyerV
         phaCTrpv6zugACCanVVMWp0M7eRfP3tCWWOB5657LgB/T3Hz+rbaqpD90vm6X/R3VfBu
         Y0QRXySEfCbS2dGHLu3FcL26/eZI3GGFsOUatoX9Qzu0SnhPhTvGuMCjAJZTCLbRanBK
         yX9A==
X-Gm-Message-State: AOAM533fXFO8i/hQ95mNujquQxGflovo1ArbJS1SELUWPmWgwn0WOZDu
        FP28ETV9wITJjs7eNpI1QPeGPQ==
X-Google-Smtp-Source: ABdhPJwZQpCqjLIRtzm5MI1zYcdTJtp4Og16VjMWaOqRliXPSukFLfKak1Ud3wCLS0E0khuC0ulOQg==
X-Received: by 2002:ac8:1e0e:: with SMTP id n14mr9510205qtl.109.1595641609454;
        Fri, 24 Jul 2020 18:46:49 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:348b:af05:525a:6ad])
        by smtp.gmail.com with ESMTPSA id f41sm3895943qtk.55.2020.07.24.18.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 18:46:48 -0700 (PDT)
Date:   Fri, 24 Jul 2020 21:46:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 04/18] maintenance: initialize task array
Message-ID: <20200725014647.GC35171@syl.lan>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <8e260bccf1a0b6cd799a6bc78798b31ebed8ad7e.1595527000.git.gitgitgadget@gmail.com>
 <xmqqr1t2qa1n.fsf@gitster.c.googlers.com>
 <1501583a-0fb0-ad88-bd2f-4f64c3c66980@gmail.com>
 <67e49b30-9a7f-8c18-3a06-96c516027c7a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67e49b30-9a7f-8c18-3a06-96c516027c7a@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 24, 2020 at 08:51:32AM -0400, Derrick Stolee wrote:
> On 7/24/2020 8:23 AM, Derrick Stolee wrote:
> > On 7/23/2020 3:57 PM, Junio C Hamano wrote:
> >> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >>
> >>> +static void initialize_tasks(void)
> >>> +{
> >>> +	int i;
> >>> +	num_tasks = 0;
> >>> +
> >>> +	for (i = 0; i < MAX_NUM_TASKS; i++)
> >>> +		tasks[i] = xcalloc(1, sizeof(struct maintenance_task));
> >>> +
> >>> +	tasks[num_tasks]->name = "gc";
> >>> +	tasks[num_tasks]->fn = maintenance_task_gc;
> >>> +	tasks[num_tasks]->enabled = 1;
> >>> +	num_tasks++;
> >>
> >> Are we going to have 47 different tasks initialized by code like
> >> this in the future?  I would have expected that you'd have a table
> >> of tasks that serves as the blueprint copy and copy it to the table
> >> to be used if there is some need to mutate the table-to-be-used.
> >
> > Making it a table will likely make it easier to read. I hadn't
> > thought of it.
> >
> > At the start, I thought that the diff would look awful as we add
> > members to the struct. However, the members that are not specified
> > are set to zero, so I should be able to craft this into something
> > not too terrible.
>
> OK, my attempt has led to this final table:
>
> 	const struct maintenance_task default_tasks[] = {
> 		{
> 			"prefetch",
> 			maintenance_task_prefetch,
> 		},
> 		{
> 			"loose-objects",
> 			maintenance_task_loose_objects,
> 			loose_object_auto_condition,
> 		},
> 		{
> 			"incremental-repack",
> 			maintenance_task_incremental_repack,
> 			incremental_repack_auto_condition,
> 		},
> 		{
> 			"gc",
> 			maintenance_task_gc,
> 			need_to_gc,
> 			1,
> 		},
> 		{
> 			"commit-graph",
> 			maintenance_task_commit_graph,
> 			should_write_commit_graph,
> 		}
> 	};
> 	num_tasks = sizeof(default_tasks) / sizeof(struct maintenance_task);
>
> This is followed by allocating and copying the data to the
> 'tasks' array, allowing it to be sorted and modified according
> to command-line arguments and config.
>
> Is this what you intended?

I'm not sure if Junio intended what I'm going to suggest, but I think
that you could make looking up these "blueprint" tasks a little easier
by using the designated index initializer. For what it's worth, I wasn't
sure if we allow this in the codebase, but some quick perusing through
Documentation/CodingGuidelines turns up 512f41cfac (clean.c: use
designated initializer, 2017-07-14), which does use this style.

Maybe something like:

  enum maintenance_task_kind {
    TASK_PREFETCH = 0,
    TASK_LOOSE_OBJECTS,
    /* ... */
    TASK__COUNT
  };

  const struct maintenance_task default_tasks[TASK__COUNT] = {
    [TASK_PREFETCH] = {
      "prefetch",
      maintenance_task_prefetch,
    },
    [...] = ...
  };

and then you should be able to pick those out with
'default_tasks[TASK_PREFETCH]'. I'm not sure if you are able to rely on
those tasks appearing in a certain order in which case you can feel free
to discard this suggestion.

If nothing else, I'm glad that we can use the '[...] = '-style
initializers :-).

> Thanks,
> -Stolee

Thanks,
Taylor
