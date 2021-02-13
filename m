Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6099EC433E9
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 01:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 244F464DF2
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 01:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhBMBIA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 20:08:00 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51985 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbhBMBHh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 20:07:37 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7F7B011A993;
        Fri, 12 Feb 2021 20:06:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S94AseCHsS53qRfR7jvxiC/vOWE=; b=l2vK2R
        OqKDgMnrMhcCsQmU6iOOTEr18y4kMp9j+WtRW/bjHfdfPp5W4LuhYJOCCRKnYK6U
        fVzJKXRWgbGDj5sbPmopUZKqmrGw2aM1RN7yE/vSeb9ek/w9TpwwVvO5KES9lqPb
        oNPxk0/3QrK2qf08KbijUExH3PMNFFduDqqoM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AbFGJ9iQ1s3qh9/6JKPn01nd0ItSBByx
        b9lCONoxnTNybV5FzMxIDIuMBzMEkN/JM2sgZqGP7c75LXI9qGQeRGwNFOuLx0yI
        A23r2x/uh/Pb/JDz8KeFT/MQGSIe6P7fh4y24Def0CyLQahTBlqG/Re4L2PqsN1D
        wt3+M0Y2/j4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 774C011A992;
        Fri, 12 Feb 2021 20:06:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BC1C611A991;
        Fri, 12 Feb 2021 20:06:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Karsten Blees <blees@dcon.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/2] diffcore-rename: filter rename_src list when
 possible
References: <pull.842.git.1612331345.gitgitgadget@gmail.com>
        <pull.842.v2.git.1612382628.gitgitgadget@gmail.com>
        <7ae9460d3dba84122c2674b46e4339b9d42bdedd.1612382628.git.gitgitgadget@gmail.com>
Date:   Fri, 12 Feb 2021 17:06:50 -0800
In-Reply-To: <7ae9460d3dba84122c2674b46e4339b9d42bdedd.1612382628.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Wed, 03 Feb 2021
        20:03:47 +0000")
Message-ID: <xmqq8s7svkr9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C171CB28-6D97-11EB-A2BE-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -578,8 +624,7 @@ void diffcore_rename(struct diff_options *options)
>  			struct diff_filespec *one = rename_src[j].p->one;
>  			struct diff_score this_src;
>  
> -			if (one->rename_used && !want_copies)
> -				continue;
> +			assert(!one->rename_used || want_copies || break_idx);

Doesn't assert becomes a no-op in production builds?  Shouldn't this
be a BUG() instead?
