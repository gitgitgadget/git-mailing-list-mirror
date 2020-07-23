Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F38C433DF
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 19:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A6F20792
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 19:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OV0p4SDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgGWT5b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 15:57:31 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50500 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgGWT5a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 15:57:30 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A9D16D4139;
        Thu, 23 Jul 2020 15:57:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mYYpbgTVACjVGdJXSLAdt92HcPQ=; b=OV0p4S
        DQXGDVcYeBb/4rU/07TGm386KKHCJujkgXcGQDyrUtA/6WC3S5jwGfR9JePOQoBO
        10/4CKpSjjdOaFzaI2hKrdfuzx957E9ClrQBM0ymRUVGeFGSMxjypR1gcfEq5VWl
        3Xa6eYOKpJKbj/ij5zc4rB4w3gps8EPCcZlJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dHDePAc4X6v+LzW3+9tWLp4+t/BBStU9
        GEEAKNV0iKYFb8ZcFuq6c9hNgLCe2QpAcuT2cqVntu7pMytDmkWYsd8jmsaUmIEN
        T32eAhA0PIjY+pie2d1KnlS1EGnMvqF8CINqH0cNDLIyF1kkW5aHippWq5yekrwx
        TwKl6dkXIas=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A14E8D4138;
        Thu, 23 Jul 2020 15:57:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D3CDAD4136;
        Thu, 23 Jul 2020 15:57:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 04/18] maintenance: initialize task array
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <8e260bccf1a0b6cd799a6bc78798b31ebed8ad7e.1595527000.git.gitgitgadget@gmail.com>
Date:   Thu, 23 Jul 2020 12:57:24 -0700
In-Reply-To: <8e260bccf1a0b6cd799a6bc78798b31ebed8ad7e.1595527000.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 23 Jul 2020
        17:56:26 +0000")
Message-ID: <xmqqr1t2qa1n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB08EDEE-CD1E-11EA-82CE-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static void initialize_tasks(void)
> +{
> +	int i;
> +	num_tasks = 0;
> +
> +	for (i = 0; i < MAX_NUM_TASKS; i++)
> +		tasks[i] = xcalloc(1, sizeof(struct maintenance_task));
> +
> +	tasks[num_tasks]->name = "gc";
> +	tasks[num_tasks]->fn = maintenance_task_gc;
> +	tasks[num_tasks]->enabled = 1;
> +	num_tasks++;

Are we going to have 47 different tasks initialized by code like
this in the future?  I would have expected that you'd have a table
of tasks that serves as the blueprint copy and copy it to the table
to be used if there is some need to mutate the table-to-be-used.

>  }
>  
>  int cmd_maintenance(int argc, const char **argv, const char *prefix)
> @@ -751,6 +787,7 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
>  				   builtin_maintenance_options);
>  
>  	opts.quiet = !isatty(2);
> +	initialize_tasks();
>  
>  	argc = parse_options(argc, argv, prefix,
>  			     builtin_maintenance_options,
