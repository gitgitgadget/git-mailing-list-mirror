Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDF4C433E5
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 22:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2310A2065E
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 22:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="c+cCY+EN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgGWWAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 18:00:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65153 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgGWWAS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 18:00:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A4EE37FBF4;
        Thu, 23 Jul 2020 18:00:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RyUyoDoASM0kobrGO61FYLvZCSc=; b=c+cCY+
        ENKjyS8qehRc4LjMcoNpLUbiAUIuvP4q9oxMdZVtv0u5UEP0jpph6Sy+fTd2WJLM
        oOlnX1imNgsAZ+FwFMjYFSq6/B/61j3ezt4jyndkR0jqKspwGQfWcWoVuB1e90yd
        c74sMZGs6lLK00fil1AmxlC+OtzQNWP7y//u4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OGVGrGPzFcNy4AOXmHzz9iCEc6O8EIq2
        /4s6hqICHDzn3hBi3SOT8xQJJhIAOxE0rhIEjEDIqIddI1Lt5c6kpydbiQoH9j4z
        uCLU9sLdzS1VPj5IMkU/H+rzCVi7uh85lfy7lKkL1R+oDCDk02Nmu3zwLijHOfGg
        JD2nhHk3+cg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 99CAE7FBF3;
        Thu, 23 Jul 2020 18:00:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 147867FBEE;
        Thu, 23 Jul 2020 18:00:12 -0400 (EDT)
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
Subject: Re: [PATCH v2 10/18] maintenance: add incremental-repack task
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <b6328c210625e1ba98e2065208a2a478c2c64f94.1595527000.git.gitgitgadget@gmail.com>
Date:   Thu, 23 Jul 2020 15:00:11 -0700
In-Reply-To: <b6328c210625e1ba98e2065208a2a478c2c64f94.1595527000.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 23 Jul 2020
        17:56:32 +0000")
Message-ID: <xmqqeep1q4d0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E1A57A56-CD2F-11EA-8500-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> 1. 'git multi-pack-index write' creates a multi-pack-index file if
>    one did not exist, and otherwise will update the multi-pack-index
>    with any new pack-files that appeared since the last write. This
>    is particularly relevant with the background fetch job.
>
>    When the multi-pack-index sees two copies of the same object, it
>    stores the offset data into the newer pack-file. This means that
>    some old pack-files could become "unreferenced" which I will use
>    to mean "a pack-file that is in the pack-file list of the
>    multi-pack-index but none of the objects in the multi-pack-index
>    reference a location inside that pack-file."

An obvious alternative is to favor the copy in the older pack,
right?  Is the expectation that over time, most of the objects that
are relevant would reappear in newer packs, so that eventually by
favoring the copies in the newer packs, we can retire and remove the
old pack, keeping only the newer ones?

But would that assumption hold?  The old packs hold objects that are
necessary for the older parts of the history, so unless you are
cauterizing away the old history, these objects in the older packs
are likely to stay with us longer than those used by the newer parts
of the history, some of which may not even have been pushed out yet
and can be rebased away?

> 2. 'git multi-pack-index expire' deletes any unreferenced pack-files
>    and updaes the multi-pack-index to drop those pack-files from the
>    list. This is safe to do as concurrent Git processes will see the
>    multi-pack-index and not open those packs when looking for object
>    contents. (Similar to the 'loose-objects' job, there are some Git
>    commands that open pack-files regardless of the multi-pack-index,
>    but they are rarely used. Further, a user that self-selects to
>    use background operations would likely refrain from using those
>    commands.)

OK.

> 3. 'git multi-pack-index repack --bacth-size=<size>' collects a set
>    of pack-files that are listed in the multi-pack-index and creates
>    a new pack-file containing the objects whose offsets are listed
>    by the multi-pack-index to be in those objects. The set of pack-
>    files is selected greedily by sorting the pack-files by modified
>    time and adding a pack-file to the set if its "expected size" is
>    smaller than the batch size until the total expected size of the
>    selected pack-files is at least the batch size. The "expected
>    size" is calculated by taking the size of the pack-file divided
>    by the number of objects in the pack-file and multiplied by the
>    number of objects from the multi-pack-index with offset in that
>    pack-file. The expected size approximats how much data from that

approximates.

>    pack-file will contribute to the resulting pack-file size. The
>    intention is that the resulting pack-file will be close in size
>    to the provided batch size.

> +static int maintenance_task_incremental_repack(void)
> +{
> +	if (multi_pack_index_write()) {
> +		error(_("failed to write multi-pack-index"));
> +		return 1;
> +	}
> +
> +	if (multi_pack_index_verify()) {
> +		warning(_("multi-pack-index verify failed after initial write"));
> +		return rewrite_multi_pack_index();
> +	}
> +
> +	if (multi_pack_index_expire()) {
> +		error(_("multi-pack-index expire failed"));
> +		return 1;
> +	}
> +
> +	if (multi_pack_index_verify()) {
> +		warning(_("multi-pack-index verify failed after expire"));
> +		return rewrite_multi_pack_index();
> +	}
> +	if (multi_pack_index_repack()) {
> +		error(_("multi-pack-index repack failed"));
> +		return 1;
> +	}

Hmph, I wonder if these warning should come from each helper
functions that are static to this function anyway.

It also makes it easier to reason about this function by eliminating
the need for having a different pattern only for the verify helper.
Instead, verify could call rewrite internally when it notices a
breakage.  I.e.

	if (multi_pack_index_write())
		return 1;
	if (multi_pack_index_verify("after initial write"))
		return 1;
	if (multi_pack_index_exire())
		return 1;
	...

Also, it feels odd, compared to our internal API convention, that
positive non-zero is used as an error here.

> +	return 0;
> +}
> +
>  typedef int maintenance_task_fn(void);
>  
>  struct maintenance_task {
> @@ -1037,6 +1152,10 @@ static void initialize_tasks(void)
>  	tasks[num_tasks]->fn = maintenance_task_loose_objects;
>  	num_tasks++;
>  
> +	tasks[num_tasks]->name = "incremental-repack";
> +	tasks[num_tasks]->fn = maintenance_task_incremental_repack;
> +	num_tasks++;
> +
>  	tasks[num_tasks]->name = "gc";
>  	tasks[num_tasks]->fn = maintenance_task_gc;
>  	tasks[num_tasks]->enabled = 1;

Exactly the same comment as 08/18 about natural/inherent ordering
applies here as well.

Thanks.
