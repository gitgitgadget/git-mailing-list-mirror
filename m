Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C02BC433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 420D76103C
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbhIOQWn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 12:22:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59739 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhIOQWn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 12:22:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CA31613CA32;
        Wed, 15 Sep 2021 12:21:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=blHceBt+w3LzFp/g3y1oFE+x6xeONRpak9jRti
        QToMA=; b=khROneM2uP5+QOXFMWGHOCbjr7J+uEJ3AjeH4NVxf6kTRZwM70kQJg
        OyEN/dRa1dDo0vBAhKu6ldWfmCUvNBiKHQ/i9UVgOoBmB5EvBA9ivvATYEydDADU
        2dGhnKNS8+XFaP4Qq+eIMR9LPaJV8MEZuCyEk4tDNXHma20B92Y6Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C1DD113CA31;
        Wed, 15 Sep 2021 12:21:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 121FA13CA30;
        Wed, 15 Sep 2021 12:21:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v3 6/6] core.fsyncobjectfiles: enable batch mode for
 testing
References: <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
        <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
        <55a40fc8fd59df6180c8a87d93fcc9a232ff8d0a.1631590725.git.gitgitgadget@gmail.com>
Date:   Wed, 15 Sep 2021 09:21:19 -0700
In-Reply-To: <55a40fc8fd59df6180c8a87d93fcc9a232ff8d0a.1631590725.git.gitgitgadget@gmail.com>
        (Neeraj Singh via GitGitGadget's message of "Tue, 14 Sep 2021 03:38:45
        +0000")
Message-ID: <xmqqtuilyfls.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F67F870E-1640-11EC-B270-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Neeraj Singh <neerajsi@microsoft.com>
>
> Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> ---
>  environment.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/environment.c b/environment.c
> index 3e23eafff80..27d5e11267e 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -43,7 +43,7 @@ const char *git_hooks_path;
>  int zlib_compression_level = Z_BEST_SPEED;
>  int core_compression_level;
>  int pack_compression_level = Z_DEFAULT_COMPRESSION;
> -enum FSYNC_OBJECT_FILES_MODE fsync_object_files;
> +enum FSYNC_OBJECT_FILES_MODE fsync_object_files = FSYNC_OBJECT_FILES_BATCH;
>  size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
>  size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
>  size_t delta_base_cache_limit = 96 * 1024 * 1024;

Despite what the title of the change claims, this is not "enable for
testing", but "enable for everybody even in production", isn't it?

I'd prefer we do not do this, certainly not for "testing".

If setting the variable to "batch" were meant to eventually improve
performance for all different flavours of workload, I do not think
we would mind if we set it to "batch" for those who opt into the
"experimental" set of features by setting the feature.experimental
configuration variable to true.  And after a few development cycles
when the feature proves to be useful for everybody, we may want to
apply this patch under a justification that is different from "for
testing".

On the other hand, if this is meant to help 85% of people while
degrading the remainder of workflow, I do not think we would want to
see this change without a warning that says something along the
lines of "under rare circumstances (e.g. if you employ such and such
workflow), the new default value used for the core.fsyncObjectFiles
configuration variable will hurt performance."

Since this is about answering the question "between performance and
crash resilience, where do you as an end user strike the balance for
your needs?", I do not think it falls into either of the above two
categories.  

The only plausible justification I can think of to apply a "we
default to 'batch' for everybody" patch with is something like:

    Now with the 'batch' setting for core.fsyncObjectFiles, unlike
    'true' that paid very high overhead, the overhead to ensure our
    writes hit the disk platters has so greatly been reduced that it
    hurts the performance only negligibly.  Let's switch the default
    from the unsafe value of 'false' to safer and performant value
    of 'batch'.

I however doubt with the current round of patches, we are there yet.
