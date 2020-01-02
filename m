Return-Path: <SRS0=b7P8=2X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB73C2D0C2
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 19:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A28321655
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 19:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pxEr0u+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgABTyQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jan 2020 14:54:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64120 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbgABTyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jan 2020 14:54:16 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B64F22AF3F;
        Thu,  2 Jan 2020 14:54:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Yqs7xlppP5J87LtvPSQnbaTTnzk=; b=pxEr0u
        +WTM1X1b/x6Y2ETPA9sqTqboZmhbxNaTXhofa6uI2xfZ/dHvfAORi5hvcPOTqQcj
        Lbt46w1iBfvyia9DiatBUvIDhycopylkcqKPkUrFGo5wIRedm02RHdI1cq4mtPr7
        hK63qHMeqriAVQfWZysGn1Wha++V7ODgfXeFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b+Vze16ZTig26GH2Y9WvYxV924XQh7lc
        /Nu42F9REX4xPprDSuVn4WGxZW1rDjG20dLkznSl3AIFKCi1poxpZW7ZN6MePrm8
        LJJMHL8JorHEO3TwTojm43Hsjea6VOtZn0phG5hYQ5Z7tiDqo2su8oGEIpOs0iqc
        0RMm015ygso=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ACCF12AF3E;
        Thu,  2 Jan 2020 14:54:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 25AEC2AF3D;
        Thu,  2 Jan 2020 14:54:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH 1/1] add: use advise function to display hints
References: <pull.508.git.1577934241.gitgitgadget@gmail.com>
        <90608636bf184de76f91e4e04d9e796a021775a0.1577934241.git.gitgitgadget@gmail.com>
Date:   Thu, 02 Jan 2020 11:54:11 -0800
In-Reply-To: <90608636bf184de76f91e4e04d9e796a021775a0.1577934241.git.gitgitgadget@gmail.com>
        (Heba Waly via GitGitGadget's message of "Thu, 02 Jan 2020 03:04:01
        +0000")
Message-ID: <xmqqpng1eisc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A64F8F36-2D99-11EA-8EA6-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Heba Waly <heba.waly@gmail.com>
>
> Use the advise function in advice.c to display hints to the users, as
> it provides a neat and a standard format for hint messages, i.e: the
> text is colored in yellow and the line starts by the word "hint:".

Use of advise() function is good for giving hints not just due to
its yellow coloring (which by the way I find not very readable,
perhaps because I use black ink on white paper).  One good thing in
using the advise() API is that the messages can also be squelched
with advice.* configuration variables.

And these two hints in "git add" are good chandidates to make
customizable (perhaps with "advice.addNothing"), so I tend to agree
with you that it makes sense to move these two messages to advise().
Unfortunately this patch goes only halfway and stops (see below).

If there are many other places that calls to advise() are made
without getting guarded by the toggles defined in advice.c, we
should fix them, I think.

>
> Signed-off-by: Heba Waly <heba.waly@gmail.com>
> ---
>  builtin/add.c  | 4 ++--
>  t/t3700-add.sh | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index 4c38aff419..eebf8d772b 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -390,7 +390,7 @@ static int add_files(struct dir_struct *dir, int flags)
>  		fprintf(stderr, _(ignore_error));
>  		for (i = 0; i < dir->ignored_nr; i++)
>  			fprintf(stderr, "%s\n", dir->ignored[i]->name);
> -		fprintf(stderr, _("Use -f if you really want to add them.\n"));
> +		advise(_("Use -f if you really want to add them.\n"));
>  		exit_status = 1;
>  	}
>  
> @@ -480,7 +480,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  
>  	if (require_pathspec && pathspec.nr == 0) {
>  		fprintf(stderr, _("Nothing specified, nothing added.\n"));
> -		fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
> +		advise( _("Maybe you wanted to say 'git add .'?\n"));
>  		return 0;
>  	}

The final code for the above part would look like:

		if (advice_add_nothing)
			advise(_("Use -f if you really want to add them."));
		...
		if (advice_add_nothing)
			advise( _("Maybe you wanted to say 'git add .'?"));

and then you would

 * add defn of advice_add_nothing to advice.h
 * add decl of the same, initialized to 1(true), to advice.c
 * map "addNothing" to &advice_add_nothing in advice.c::advice_config[]

to complete the other half of this patch, if the config we choose to
use is named "advice.addNothing".

By the way, notice that the single-liner advise() messages do not
end with LF?  This is another difference between printf() family and
advise().  advise() cuts its message at LF and prefixes each piece
with "hint:" but after the final LF there is nothing but NUL, which
means the final LF is optional.

The warning()/error()/die() family is different from advise() in
that they do not chop the incoming message at LF.  This behaviour is
less i18n friendly, and it would be nice to eventually change them
to behave similarly to advise().

Thanks.

 
