Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521BAC433E1
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E49C122CA1
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Tnol14jn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgHEUIY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:08:24 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64996 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgHEUIP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 16:08:15 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3CCADE608D;
        Wed,  5 Aug 2020 16:08:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w0ET6bY6zJBWJnv6/zZPSV7OFRY=; b=Tnol14
        jneo17+9BqPQjt9EYodQ23irxZCmeZDqMwgcXs3pNaeWJGDP8xV6EYF4+frO490w
        r2UKp62FX8gmpBVWshHxXg7xHDZsGwgAKsBx7UEWjizHHTSZ/MH1PYbWPJNA6bI8
        kHlAyhHUvnL9Zc2lcnrlqnwlA3XMcrBvn+Jdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QXAdcTVEhmXg0/yjW9knNzPWrDlZLOay
        U3neIDSDmk1YQoGswrXUiFjNQO3Hjn8xPPd/O09UzDK5tu6I1/hWjf/9RWJ95C4K
        ilzKGbPxDNPI2OdPpicUh2DSM+HZuWVkdEfQRq579+VG6wmig2qA9jwBPaGD0tSI
        3u11S+Y31TI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 35902E608B;
        Wed,  5 Aug 2020 16:08:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 83F89E6089;
        Wed,  5 Aug 2020 16:08:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [RFC PATCH 2/7] fetch-pack: allow NULL negotiator->known_common
References: <20200724223844.2723397-1-jonathantanmy@google.com>
        <cover.1596590295.git.jonathantanmy@google.com>
        <401227c2220b6b45d80e21b52e29b6821ca139f9.1596590295.git.jonathantanmy@google.com>
Date:   Wed, 05 Aug 2020 13:08:07 -0700
In-Reply-To: <401227c2220b6b45d80e21b52e29b6821ca139f9.1596590295.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 4 Aug 2020 18:20:45 -0700")
Message-ID: <xmqqk0yconyw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 620F82FA-D757-11EA-9618-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> In a subsequent patch, a null fetch negotiator will be introduced. This
> negotiator, among other things, will not need any information about
> common objects and will have a NULL known_common. Teach fetch-pack to
> allow this.

Hmph, both the default and the skipping negotiator seem to put NULL
in known_common and add_tip when its next() method is called.  Also
they clear known_common to NULL after add_tip is called even once.

So, how have we survived so far without this patch to "allow this
(i.e.  known_common method to be NULL)"?  Is there something that
makes sure a negotiator never gets called from this function after
its .next or .add_tip method is called?

Puzzled.  Or is this merely an optimization?  If so, it's not like
the change "allows this", but it starts to take advantage of it in
some way.

	... goes and looks at mark_complete_and_common_ref()

The function seems to have an unconditional call to ->known_common(),
so anybody passing a negotiator whose known_common is NULL would
already be segfaulting, so this does not appear to be an optimization
but necessary to keep the code from crashing.  I cannot quite tell
if it is avoiding unnecessary work, or sweeping crashes under the
rug, though.  

Is the untold assumption that mark_complete_and_common_ref() will
never be called after either mark_tips() or find_common() have been
called?

Thanks.

> [NEEDSWORK]
> Optimizing out the ref iteration also affects the execution
> of everything_local(), which relies on COMPLETE being set. (Having said
> that, the typical use case - lazy fetching - would be fine with
> everything_local() always returning that not everything is local.)
>
> This optimization is needed so that in the future, fetch_pack() can be
> used to lazily fetch in a partial clone (without the no_dependents
> flag). This means that fetch_pack() needs a way to execute without
> relying on any targets of refs being present, and thus it cannot use the
> ref iterator (because it checks and lazy-fetches any missing targets).
> (Git currently does not have this problem because we use the
> no_dependents flag, but lazy-fetching will in a subsequent patch be
> changed to use the user-facing fetch command, which does not use this
> flag.)
> [/NEEDSWORK]
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  fetch-pack.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 6c786f5970..5f5474dbed 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -677,6 +677,9 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
>  	int old_save_commit_buffer = save_commit_buffer;
>  	timestamp_t cutoff = 0;
>  
> +	if (!negotiator->known_common)
> +		return;
> +
>  	save_commit_buffer = 0;
>  
>  	trace2_region_enter("fetch-pack", "parse_remote_refs_and_find_cutoff", NULL);
