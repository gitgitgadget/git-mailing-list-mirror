Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4DED2055E
	for <e@80x24.org>; Thu, 26 Oct 2017 02:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbdJZCBu (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 22:01:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57479 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751911AbdJZCBt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 22:01:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53B0499340;
        Wed, 25 Oct 2017 22:01:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3NavJArvssWlf2JV9SPNcAUNp4o=; b=c89J6T
        9vByNVkm9SJvHGHVVixiuNLxT16eU+SKmvjsAbBWPGTq1FHvhuafkn5Nasvr+Qks
        JSlxH4loWyTNy7v3xmTMcJU5Yq6BOynZATsrSpC0Wohmy1BySvhG8M9PEjOG9VyY
        ffmaOS1IvN/eEZWf1St0CLXF8z6tuvKxwP7/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pJ+eHh3drg7f4mEY7wnIC+TlPK0uLxh5
        GggNYmytJplFiyqfyN0Y9CVIR1GYJI++iqX7+rokYfhlgLCuu1tbTslS6Ea2f06a
        slRDwYerBwuyhYeoblmxKynPfUWIHo5IJ/t1RtzvwZvCvW7bh1SAZD9EwCJpE7D/
        30nYpiaaDvQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B8739933E;
        Wed, 25 Oct 2017 22:01:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B270F9933D;
        Wed, 25 Oct 2017 22:01:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 00/13] WIP Partial clone part 1: object filtering
References: <20171024185332.57261-1-git@jeffhostetler.com>
        <xmqqmv4fizyn.fsf@gitster.mtv.corp.google.com>
        <CAGf8dg+cK3WpEqosgkbdcrDzrMXJxVYHiBZda6UM7k8Ggq=eBw@mail.gmail.com>
Date:   Thu, 26 Oct 2017 11:01:46 +0900
In-Reply-To: <CAGf8dg+cK3WpEqosgkbdcrDzrMXJxVYHiBZda6UM7k8Ggq=eBw@mail.gmail.com>
        (Jonathan Tan's message of "Tue, 24 Oct 2017 23:46:18 -0700")
Message-ID: <xmqq7evihdkl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9FCECD3E-B9F1-11E7-A52C-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> On Tue, Oct 24, 2017 at 10:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> OK, thanks for working well together.  So does this (1) build on
>> Jonathan's fsck-squelching series, or (2) ignores that and builds
>> filtering first, potentially leaving the codebase to a broken state
>> where it can create fsck-unclean repository until Jonathan's series
>> is rebased on top of this, or (3) something else?  [*1*]
>
> Excluding the partialclone patch (patch 9), I think that the answer is
> (2), but I don't think that it leaves the codebase in a broken state.
> In particular, none of the code modifies the repo, so it can't create
> a fsck-unclean one.

OK.  It is not dangerous enough to matter until we start using the
updated features in repack->rev-list|pack-objects ;-)  As I said, I
was mostly interested in learning what the big-picture direction was
and also seeing you two were more-or-less in agreement.

> The above is relevant only if we can exclude the partialclone patch,
> but I think that we can and we should, as I wrote in my reply to Jeff
> Hostetler [1].

OK.

> As for how this patch set (excluding the partialclone patch) interacts
> with my fsck series, they are relatively independent, as far as I can
> tell. I'll rebase my fsck, gc, and lazy object fetch patches (but not
> the fetch and clone parts, which we plan to instead adapt from Jeff
> Hostetler's patches, as far as I know) on top of these and resend
> those out once discussion on this has settled.

OK.  Thanks, I think tht is a reasonable way forward.

> [1] https://public-inbox.org/git/CAGf8dg+8AR=XfSV92ODAtKTNjBnD1+oVZp9rs4Y4Otz_eZyTfg@mail.gmail.com/
>
>> I also saw a patch marked as "this is from Jonathan's earlier work",
>> taking the authorship (which to me implies that the changes were
>> extensive enough), so I am a bit at loss envisioning how this piece
>> fits in the bigger picture together with the other piece.
>
> The patch you mentioned is the partialclone patch, which I think can
> be considered separately from the rest (as I said above).

Good, that lets us sidestep Jeff's question about "how should the
credits for this change attributed?", too.
