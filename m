Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC302C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5218321D6C
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gX6xeCDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441842AbgJUW4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 18:56:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53333 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392411AbgJUW4U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 18:56:20 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C6110914CF;
        Wed, 21 Oct 2020 18:56:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=92H2mzAjvTHQ4uKNF/3pq2VgJVQ=; b=gX6xeC
        DsK4cjvVDeqqz9iOhCwbASlDIUWCw/O1qcIMo7+hesc8I54kbhM4PEOjAbQL9NGW
        SDAXKg6R3jh9QmXQu4xBz+GOedSUnX1Bs/aT9GTJi1cjPquz16lVxv8AQRpybj+z
        PX8pd1O3HW6Is0KQlQrsMV/+mDVCBfSew1Cwc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CEnGKI6xMgLIDZK80CZeCBS7ML/Y38FD
        +7GLZYeJrrWR/oG0e93fnuKFjQRzDcZ3OMw8wuRRGvSHjdtAsxJc08TFFowhs0m+
        KK9RtxYJQGUFyQ061UDtfjHe2qD+MbW/Yy3bGFEXzIDjohV6SnCE/3+9FWm0x+7D
        adP8KUcjD/Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD37F914CE;
        Wed, 21 Oct 2020 18:56:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 48153914CD;
        Wed, 21 Oct 2020 18:56:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] sequencer: tolerate abbreviated stopped-sha file
References: <20201021220353.928067-1-jonathantanmy@google.com>
Date:   Wed, 21 Oct 2020 15:56:17 -0700
In-Reply-To: <20201021220353.928067-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 21 Oct 2020 15:03:53 -0700")
Message-ID: <xmqqd01b429a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A13CA928-13F0-11EB-81A1-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> In 0512eabd91 ("sequencer: stop abbreviating stopped-sha file",
> 2020-09-25), Git was taught both to write full object names to the
> stopped-sha file and to require full object names when reading. However,
> a user would experience a problem if they started an interactive rebase
> using an old version of Git and then continued with a current version of
> Git (for example, if the system version of Git was updated in the
> meantime).
>
> Teach Git to allow object names of any length when reading.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> Not sure how big of a problem this will potentially be, but I noticed it
> and wanted to mention it.

If I didn't mention that I deliberately chose to declare it a
non-issue during the discussion, that was my mistake.

If this is not causing real-world problem, I'd in principle prefer
to keep the "expect full hex when reading what's supposed to be
written as full hex" sanity checking, but this is a file that is
purely internal between the two invocation of the program and not
even known by mere end users, so I could be persuaded to change my
mind on this particular case.

Assuming that the "use case" is real, the patch is obviously
correct.  We won't write anything but a commit object name so
using oid_committish() would not change the behaviour in good
cases.

Thanks.

> ---
>  sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 00acb12496..37847d4534 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2653,7 +2653,7 @@ static int read_populate_opts(struct replay_opts *opts)
>  		}
>  
>  		if (read_oneliner(&buf, rebase_path_squash_onto(), 0)) {
> -			if (get_oid_hex(buf.buf, &opts->squash_onto) < 0) {
> +			if (get_oid_committish(buf.buf, &opts->squash_onto) < 0) {
>  				ret = error(_("unusable squash-onto"));
>  				goto done_rebase_i;
>  			}
