Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C1CC4727E
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 18:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C267A21707
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 18:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EFUP8P5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgJGSGD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 14:06:03 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50465 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbgJGSF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 14:05:58 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D91B4F0DCB;
        Wed,  7 Oct 2020 14:05:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rslAKaM7HOb8gQKKHDTrpv+7OKA=; b=EFUP8P
        5mfkoABmWvKnTnYexwqL2MmJ25bK0pNNcki8N0CPv2cqirTgufkDEdBA7QTM/3/8
        B7WkseYyiw/YHePrmn3rgRiA6tRkdrY1lVvJtIuaUppo5z773hM9iNVDtyUaXpGU
        QHndhJtyvQ9rCBkKP6Dk2QobmMoHyfpOT4fxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=as0zZmt+c58RKjRQdk27/s7yA5k/Lo0R
        QUPAfDIYyqlM+xKSHeN6cJ+k90fUnzA/35L7vHJjp6QJv4aOUjML+cMPvQyfp1RH
        udhNY43iKPAFvj+5CO2t0ZtsncrDCvcg+COi5bgWeRV4jGYWi2TkQDr28n3bNIai
        Pi4JwnCl5sU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CF7E2F0DCA;
        Wed,  7 Oct 2020 14:05:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1F7A6F0DC2;
        Wed,  7 Oct 2020 14:05:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, Johannes.Schindelin@gmx.de,
        liu.denton@gmail.com
Subject: Re: [PATCH v2 1/3] dir: change the scope of function
 'directory_exists_in_index()'
References: <20201007074538.25891-1-shouryashukla.oo@gmail.com>
        <20201007074538.25891-2-shouryashukla.oo@gmail.com>
Date:   Wed, 07 Oct 2020 11:05:52 -0700
In-Reply-To: <20201007074538.25891-2-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Wed, 7 Oct 2020 13:15:36 +0530")
Message-ID: <xmqq8sch3o8v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDD6DB28-08C7-11EB-8137-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> diff --git a/dir.h b/dir.h
> index a3c40dec51..e46f240528 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -370,6 +370,15 @@ int read_directory(struct dir_struct *, struct index_state *istate,
>  		   const char *path, int len,
>  		   const struct pathspec *pathspec);
>  
> +enum exist_status {
> +	index_nonexistent = 0,
> +	index_directory,
> +	index_gitdir
> +};

These were adequate as private names used within the wall of dir.c,
but I doubt that they are named specific enough to stand out as
public symbols.

Unlike say "index_state" (the name of a struct type), whose nature
is quite global to any code that wants to access the in-core index,
"index_directory" is *NOT* such a name.  It is only of interest to
those who want to see "I have a directory name---does it appear as a
directory in the index?".  It is not even interesting to those who
want to ask similar and related questions like "I have this
pathname---does it appear as anything in the index, and if so what
type of entry is it?".  A worse part of this is that even if such a
helper function file_exists_in_index() were to be written, the
"exist_status" enum won't be usable to return the answer that
question, but yet the enum squats on a perfectly good name to
express "status" for the whole class that it does not represent.

So, NAK.  We need to come up with a better name for these symbols if
we were to expose them to the outside world.  The only good name
this patch makes public is "directory_exists_in_index()", which is
specific enough.

> +enum exist_status directory_exists_in_index(struct index_state *istate,
> +					    const char *dirname, int len);
> +
>  enum pattern_match_result {
>  	UNDECIDED = -1,
>  	NOT_MATCHED = 0,
