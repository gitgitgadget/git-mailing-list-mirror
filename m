Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BA63174D
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 22:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705616780; cv=none; b=PqHUypjsX9IBUwNWVPDXQrqkHRjZALou4bl2DlhtReWmiziZeyefP4Bpt2Fe5o4HhGYRbIwi51y1bXsiMQp/IFdzHmNI19xNWuVVXPg663AAiUGc71ED0HZguHWn784XS2WP24XWUOXqooc5/JPPtcmzQ235fLR+kL6h1VRePNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705616780; c=relaxed/simple;
	bh=3vzOdF7ROzQO0192ePgnjqhgDAWr8H/yWOLQG/aE1LY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P+C9oy0H8O5HDgUeemcCNBRH/xW72oGN22kIplxiVQc24Sbcyzmu0kYuQs0jPvohHX0WTRWu8NW7NGqKdo1Lz2JNCGD284vMVOnSKgjPChNzHwjDzOow1xHq5UwZhniVWRbSC2S2dAF43SiJAnuhMUazfbiC5m1DooDiGdefoyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NVmF5F+U; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NVmF5F+U"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3184A1CD1F2;
	Thu, 18 Jan 2024 17:26:12 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3vzOdF7ROzQO0192ePgnjqhgDAWr8H/yWOLQG/
	aE1LY=; b=NVmF5F+UgnNypx1yjI+3VWWk96CDfYokeKqTJBG5cRSDdPFipwK29E
	eXo1dHovCogsRUcQoQjO1+iut2wcLKt9OgaEPBu8w97zNpNiJa2EJRZieyXj8Vjl
	qN3+SEJuTFl+1uS6BbEy+UKrofB6BLFENJ9UzIlqo/sb40BfpvcKk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 299251CD1F1;
	Thu, 18 Jan 2024 17:26:12 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 890A51CD1F0;
	Thu, 18 Jan 2024 17:26:11 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Emily Shaffer <nasamuffin@google.com>,  Christian
 Couder <chriscool@tuxfamily.org>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH 01/10] trailer: move process_trailers() to
 interpret-trailers.c
In-Reply-To: <2dc3279b37f3aa81ba20e3dd08b029ca655ac3d8.1704869487.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Wed, 10 Jan 2024 06:51:17
	+0000")
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
	<2dc3279b37f3aa81ba20e3dd08b029ca655ac3d8.1704869487.git.gitgitgadget@gmail.com>
Date: Thu, 18 Jan 2024 14:26:10 -0800
Message-ID: <xmqqle8mp9bx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 956F0950-B650-11EE-A88A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/trailer.h b/trailer.h
> index 1644cd05f60..b3e4a5e127d 100644
> --- a/trailer.h
> +++ b/trailer.h
> @@ -81,15 +81,29 @@ struct process_trailer_options {
>  
>  #define PROCESS_TRAILER_OPTIONS_INIT {0}
>  
> -void process_trailers(const char *file,
> -		      const struct process_trailer_options *opts,
> -		      struct list_head *new_trailer_head);
> +void parse_trailers_from_config(struct list_head *config_head);
> +
> +void parse_trailers_from_command_line_args(struct list_head *arg_head,
> +					   struct list_head *new_trailer_head);
> +
> +void process_trailers_lists(struct list_head *head,
> +			    struct list_head *arg_head);
> +
> +void parse_trailers(struct trailer_info *info,
> +		    const char *str,
> +		    struct list_head *head,
> +		    const struct process_trailer_options *opts);

OK.

> +void ensure_configured(void);
> +void print_all(FILE *outfile, struct list_head *head,
> +	       const struct process_trailer_options *opts);
> +void free_all(struct list_head *head);

All of these names are way overly generic to live in the global
namespace, no?  Granted, they may only be visible to folks who
include <trailer.h>, but sooner or later other subsystems would find
need to provide library-ish functions that allows their callers to
do these things to their subsystem: make sure the subsystem has been
initialized, print info on all "things" on a list that the subsystem
works on, and free all "things" on such a list.

It is sad to have a function that takes "struct list_head *" as its
parameter without having any comment on what the elements on that
list are about.  free_trailer_items() might be a more appropriate
name (or free_all_trailer_items(), if we foresee a need to just free
the first item on the list and give such a helper
free_trailer_item(), in which case, the distinction between "item"
vs "items" might become too subtle.

I am assuming (and did not verify more than seeing the "git show"
output with "--color-moved") that other changes in this step are all
pure moves?  If so, other than need to be careful about naming when
making things from static to extern pointed out above, this step
looks OK to me.

Thanks.
