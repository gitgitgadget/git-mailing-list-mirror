Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A084C433F5
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 22:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbhLWWsV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 17:48:21 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56639 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhLWWsU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 17:48:20 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 98AE316B5CE;
        Thu, 23 Dec 2021 17:48:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YIKptEP2+Uq2WMbqoqcyHHDqo9AeEnbbjkun2y
        RrQWw=; b=K2qs7rwEM/QTiLBMygfHXs9OXg7b4OhFbiMAU3UFNC71cEgSR8m6Fo
        uqatRnb9anEUlD6qJ0z3BMulJifx8tWqNCMKBG34Q2Gxy/x5w3/fDX/1uUwU/5Lo
        WG1jwii10kC5eDw6CwkUrXD4aBlP5yHQRIFUjOp1JhHg8GyemV4M0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9183A16B5CD;
        Thu, 23 Dec 2021 17:48:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9196016B5CB;
        Thu, 23 Dec 2021 17:48:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        bagasdotme@gmail.com
Subject: Re: [PATCH] fixup! object-name: make ambiguous object output
 translatable
References: <patch-v5-3.6-b79964483e8-20211125T215529Z-avarab@gmail.com>
        <ec6a20a3d694d1d7e3db14f6bab42aff3e82c135.1640295389.git.steadmon@google.com>
Date:   Thu, 23 Dec 2021 14:48:15 -0800
In-Reply-To: <ec6a20a3d694d1d7e3db14f6bab42aff3e82c135.1640295389.git.steadmon@google.com>
        (Josh Steadmon's message of "Thu, 23 Dec 2021 13:54:53 -0800")
Message-ID: <xmqqmtkr6iq8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6AEC100E-6442-11EC-ABDA-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> A nitpick, but the "ad" and "s" strbuf names here are not very friendly
> for readers who don't know offhand what the format_commit_message fields
> expand to. This makes them more self-descriptive.

Sounds like a sensible change.  It seems that this thread didn't
have gathered much interest by others (not many review comments), or
by its author (not an ack to a suggestion like this), so perhaps I
should put on a cold storage and expect an update when the list is a
bit more quiescent.

Thanks.

> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  object-name.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/object-name.c b/object-name.c
> index 1dcbba7fa7..dcf3ab9999 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -378,15 +378,15 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
>  	       type == OBJ_BLOB || type == OBJ_TAG);
>  
>  	if (type == OBJ_COMMIT) {
> -		struct strbuf ad = STRBUF_INIT;
> -		struct strbuf s = STRBUF_INIT;
> +		struct strbuf date = STRBUF_INIT;
> +		struct strbuf msg = STRBUF_INIT;
>  		struct commit *commit = lookup_commit(ds->repo, oid);
>  
>  		if (commit) {
>  			struct pretty_print_context pp = {0};
>  			pp.date_mode.type = DATE_SHORT;
> -			format_commit_message(commit, "%ad", &ad, &pp);
> -			format_commit_message(commit, "%s", &s, &pp);
> +			format_commit_message(commit, "%ad", &date, &pp);
> +			format_commit_message(commit, "%s", &msg, &pp);
>  		}
>  
>  		/*
> @@ -395,10 +395,11 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
>  		 *
>  		 *    "deadbeef commit 2021-01-01 - Some Commit Message"
>  		 */
> -		strbuf_addf(&desc, _("%s commit %s - %s"), hash, ad.buf, s.buf);
> +		strbuf_addf(&desc, _("%s commit %s - %s"),
> +			    hash, date.buf, msg.buf);
>  
> -		strbuf_release(&ad);
> -		strbuf_release(&s);
> +		strbuf_release(&date);
> +		strbuf_release(&msg);
>  	} else if (type == OBJ_TAG) {
>  		struct tag *tag = lookup_tag(ds->repo, oid);
>  		const char *tag_tag = "";
>
> base-commit: ea5019ecd7a405d7d5f6527054d0aaca2d3b4bcd
