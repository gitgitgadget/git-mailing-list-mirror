Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BE791F463
	for <e@80x24.org>; Fri, 20 Sep 2019 20:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfITUKu (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 16:10:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64967 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfITUKu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 16:10:50 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 34A188E78B;
        Fri, 20 Sep 2019 16:10:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rRRkrYSPuriR5iyjgobMNTIhj5Y=; b=ncB/Bs
        fE9y+/V7CwLVy/sgusjiz6wSHiuaNk8Mlu9Nc2N5iVx1mX0mvW10dEYNKf1nNKd5
        3L0z7bmGuviTUu+xzcKZFVg4z1CJjVDHUU1fnoRivR0lVA65iLNHMiil7eR/YtX4
        sK0ECns7t0n+q0rFZOyR1YTzte+GiQUATAq5c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F1i6/8/2ySZ2R/XjFDI8izg5X0yK0Z5I
        b39Yc0Gv+G0rC+iVOYqi7IsSc5CKaERrj+E2Ibb+//4TajsdoV/wj5e0BL6EDd0o
        J16I5GYLoonGu5oxtbC3JRUAMFsQDLTpegB6KQHawufiKF6wKBjJpnflpgrpugUh
        QddQjHUa37U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2C1778E78A;
        Fri, 20 Sep 2019 16:10:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4DB6B8E77E;
        Fri, 20 Sep 2019 16:10:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, williamtbakeremail@gmail.com,
        stolee@gmail.com, jeffhost@microsoft.com,
        William Baker <William.Baker@microsoft.com>
Subject: Re: [PATCH v2 2/6] midx: add progress to write_midx_file Add progress to write_midx_file.  Progress is displayed when the MIDX_PROGRESS flag is set.
References: <pull.337.git.gitgitgadget@gmail.com>
        <pull.337.v2.git.gitgitgadget@gmail.com>
        <3bc8677ea7655a3706914f9753c0a3b79dbf7e1f.1568998427.git.gitgitgadget@gmail.com>
Date:   Fri, 20 Sep 2019 13:10:40 -0700
In-Reply-To: <3bc8677ea7655a3706914f9753c0a3b79dbf7e1f.1568998427.git.gitgitgadget@gmail.com>
        (William Baker via GitGitGadget's message of "Fri, 20 Sep 2019
        09:53:49 -0700 (PDT)")
Message-ID: <xmqqlfuiu3sv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8F051B0-DBE2-11E9-8D72-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"William Baker via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/midx.c b/midx.c
> index b2673f52e8..54e4e93b2b 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -449,6 +449,8 @@ struct pack_list {
>  	uint32_t nr;
>  	uint32_t alloc;
>  	struct multi_pack_index *m;
> +	struct progress *progress;
> +	uint32_t pack_paths_checked;
>  };

What is the reason behind u32 here?  Do we want to be consistently
limited to 4G on all platforms?

I have a feeling that we do not care too deeply all that much for
the purpose of progress output, in which case, just an ordinary
"unsigned" may be much less misleading.

FWIW, the function that uses this field is display_progress(), which
takes uint64_t there.

> @@ -457,6 +459,7 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
>  	struct pack_list *packs = (struct pack_list *)data;
>  
>  	if (ends_with(file_name, ".idx")) {
> +		display_progress(packs->progress, ++packs->pack_paths_checked);

OK, "git grep display_progress" tells me that we are expected to
pass the value of the counter that is already incremented, so this
is also in line with that practice.

> +	if (flags & MIDX_PROGRESS)
> +		packs.progress = start_progress(_("Adding packfiles to multi-pack-index"), 0);
> +	else
> +		packs.progress = NULL;
>
>  	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &packs);
> +	stop_progress(&packs.progress);

OK.

> +	if (flags & MIDX_PROGRESS)
> +		progress = start_progress(_("Writing chunks to multi-pack-index"),
> +					  num_chunks);
> ...
> +
> +		display_progress(progress, i + 1);
>  	}
> +	stop_progress(&progress);
>  

OK.
