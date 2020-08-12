Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D147C433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 23:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 646F320771
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 23:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PAusBzkj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgHLXK7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 19:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgHLXK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 19:10:59 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4459CC061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 16:10:59 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k13so1766105plk.13
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 16:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w3mV21YZyWT4fUbLKWFd9FJ4RpcN1l2XnRmDwMEzDDY=;
        b=PAusBzkj7ube2eAKd8chRhTmEuMOIDKXvwqSW7Xrygl0O8o/m/M4uFMYbRKQvFR9o+
         rR9s+BhRDWbKuw5v81MUhFr1v8fST4oIN3/D4k7GX8bAcPdqbbQndR/fXdT0kU3B0vtS
         QbznlgoGTA1c/bSoDa4cmpuCW7xMCCXEQPr2qPaZP+sDpX7TlwX8XiUThc3nsvlF1HM1
         OsXTZVaSTBK1WCbPCAiC+JhzGPYiF7MlMEnoZRWZqMjJi5lt7/4abr/Mv2+0x/5x20MD
         7nfejGAZD/eyYwA4v2tQqee9IChJRha5qZaxbJ5GfO3rb7EeeQM00q/MLa3bsR+83Cyp
         v6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w3mV21YZyWT4fUbLKWFd9FJ4RpcN1l2XnRmDwMEzDDY=;
        b=ol0GAqu6EvhuHymmrhcRKAy4mzgrMpYEW8I+qyumPJBchh5MDhie2h8+lACS4fZvL9
         IoqTJvkd7SDP+mywsQ9Ir7DR5MTCX00GH0SGQjibOQ1DhqhmpeWWLfP8ILGgwQM6NrWS
         ESu6y7/dmfOaoDhXmzjgwAi5ZS7cMaICckhKB0VyGVM8GjXbkmQ3xe3Q1OSZvtRKxV04
         Yd7GA1dw27jIV2P6qTr9r+L7U2YMzh0r4QvSFeQu2kfuPbCK41CdrqWopB38xhYOR3WU
         sZvu+wA+mM6y6Jzw7U/lQjHyOnH17pssnW+IF8Q1p5rldBfo3uh9RL7Re+kF5bPOplK/
         zLxg==
X-Gm-Message-State: AOAM531ZZyZIFIxh1EUqzaAzDp7IPsAe4YkAmIdR4t6gDpBtYuic2eo2
        O7BeNsTpDziRgKfkGpoC6ENt0w==
X-Google-Smtp-Source: ABdhPJyBsRD8bNWyDzjf+g4F6jZ61xftBYi25rQBMcip/Xt3rJghO282VZkmZq1rRhZoRRZu8oPWVA==
X-Received: by 2002:a17:902:8543:: with SMTP id d3mr1503343plo.244.1597273858350;
        Wed, 12 Aug 2020 16:10:58 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id z23sm3145256pgv.57.2020.08.12.16.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 16:10:57 -0700 (PDT)
Date:   Wed, 12 Aug 2020 16:10:53 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/9] maintenance: add loose-objects task
Message-ID: <20200812231053.GI2965447@google.com>
References: <pull.696.git.1596731424.gitgitgadget@gmail.com>
 <621375a3c99014c48568660bde062b7330d5a662.1596731425.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <621375a3c99014c48568660bde062b7330d5a662.1596731425.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 06, 2020 at 04:30:18PM +0000, Derrick Stolee via GitGitGadget wrote:

> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
> index bb0d5eded4..898aff4726 100644
> --- a/Documentation/git-maintenance.txt
> +++ b/Documentation/git-maintenance.txt
> @@ -80,6 +80,17 @@ gc::
>  	It can also be disruptive in some situations, as it deletes stale
>  	data.
>  
> +loose-objects::
> +	The `loose-objects` job cleans up loose objects and places them into
> +	pack-files. In order to prevent race conditions with concurrent Git
> +	commands, it follows a two-step process. First, it deletes any loose
> +	objects that already exist in a pack-file; concurrent Git processes
> +	will examine the pack-file for the object data instead of the loose
> +	object. Second, it creates a new pack-file (starting with "loose-")
> +	containing a batch of loose objects. The batch size is limited to 50
> +	thousand objects to prevent the job from taking too long on a
> +	repository with many loose objects.

[emily] What's not said is what happens to loose-* packfile. Does this
get repacked and disappear, is it treated differently, etc?
[jonathantan] This is treated the same as any other pack. Is there a
reason to call it loose-*?
[jrnieder] It seems like unreachable objects will get stuck going in and
out of this pack, right? unreachable loose obj -> loose-*.pack ->
repack, unreachable becomes loose -> repeat

> +static int prune_packed(struct maintenance_opts *opts)
> +{
> +	struct child_process child = CHILD_PROCESS_INIT;
> +
> +	child.git_cmd = 1;
> +	strvec_push(&child.args, "prune-packed");
> +
> +	if (opts->quiet)
> +		strvec_push(&child.args, "--quiet");
> +
> +	return !!run_command(&child);
[emily] Why not report the error code here to the caller? Is there a
path to notify user of errors that require user intervention?
[jrnieder] Some errors might be expected and some might not, so should
we handle them differently?
[emily] Probably makes more sense to revisit this in the far future when
we teach 'git maintenance' to send us emails and flashing lights when
our jobs fail, instead of worrying about it now :)
[jrnieder] Imagine if we got exit 127 because the usage we are using is
wrong - in that case, for example, we would want to BUG()

> +static int write_loose_object_to_stdin(const struct object_id *oid,
> +				       const char *path,
> +				       void *data)
> +{
> +	struct write_loose_object_data *d = (struct write_loose_object_data *)data;
[jrnieder] Since we are enlightened C developers, not C++ developers,
you can skip the explicit cast.

> +++ b/t/t7900-maintenance.sh
> @@ -83,4 +83,43 @@ test_expect_success 'prefetch multiple remotes' '
>  	git log prefetch/remote2/two
>  '
>  
> +test_expect_success 'loose-objects task' '
[jrnieder] Unrelated to this change, this test makes me sad that we
don't have better low-level test helpers to enable this kind of testing.
Makes me wish for something better :)
> +	# Repack everything so we know the state of the object dir
> +	git repack -adk &&
> +
> +	# Hack to stop maintenance from running during "git commit"
> +	echo in use >.git/objects/maintenance.lock &&
> +
> +	# Assuming that "git commit" creates at least one loose object
> +	test_commit create-loose-object &&
> +	rm .git/objects/maintenance.lock &&
> +
> +	ls .git/objects >obj-dir-before &&
> +	test_file_not_empty obj-dir-before &&
> +	ls .git/objects/pack/*.pack >packs-before &&
> +	test_line_count = 1 packs-before &&
> +
> +	# The first run creates a pack-file
> +	# but does not delete loose objects.
> +	git maintenance run --task=loose-objects &&
> +	ls .git/objects >obj-dir-between &&
> +	test_cmp obj-dir-before obj-dir-between &&
> +	ls .git/objects/pack/*.pack >packs-between &&
> +	test_line_count = 2 packs-between &&
> +	ls .git/objects/pack/loose-*.pack >loose-packs &&
> +	test_line_count = 1 loose-packs &&
> +
> +	# The second run deletes loose objects
> +	# but does not create a pack-file.
> +	git maintenance run --task=loose-objects &&
> +	ls .git/objects >obj-dir-after &&
> +	cat >expect <<-\EOF &&
> +	info
> +	pack
> +	EOF
> +	test_cmp expect obj-dir-after &&
> +	ls .git/objects/pack/*.pack >packs-after &&
> +	test_cmp packs-between packs-after
> +'
> +

