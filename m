Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CF6D203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 19:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526AbcGZTfC (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 15:35:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51819 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751328AbcGZTfA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 15:35:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E32622DFE7;
	Tue, 26 Jul 2016 15:34:58 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rimjlAFQkESMR1W2OkyjKPWvm8A=; b=YUe6Nf
	EmN8nU9BLPI0woU2JmMWjfeHrtdFaLYUNP+6a29HANFrccqnkAOLH1VY/nDf7toA
	Xx/hlFJmgV1u2ANTRXmPxABBvsIU1H7QVl5obK4116C2L9qT/bQKwVp2D/X6OcdN
	WS1HuxEfu4A/vQqq9fn7IZBCAu4sng7PozjtA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cus1KKPwp/VfXxkoCUudM4EXVKTHNfLU
	MD1kaQrri0hqCgDPfFOvH+9dKWrIYwt5eF6BgWHu+18LGpJLna1zrVrWSr0M68at
	H/q86NqxQdT+zzWV+RlWZmuvPcPtDoxk+PWgfeRpGEd4hHxlItgTIK4waQudwfqt
	v4Shrjr9ly0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D9A632DFE5;
	Tue, 26 Jul 2016 15:34:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 378E92DFE4;
	Tue, 26 Jul 2016 15:34:58 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v8 34/41] apply: add 'be_silent' variable to 'struct apply_state'
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
	<20160627182429.31550-35-chriscool@tuxfamily.org>
Date:	Tue, 26 Jul 2016 12:34:56 -0700
In-Reply-To: <20160627182429.31550-35-chriscool@tuxfamily.org> (Christian
	Couder's message of "Mon, 27 Jun 2016 20:24:22 +0200")
Message-ID: <xmqqeg6g19cv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0988DA18-5368-11E6-B89D-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> This variable should prevent anything to be printed on both stderr
> and stdout.

It is far more important to describe "why" this is needed than what
it does, the latter of which can be read from the patch text.

And I do not see any "why" here.  Is this "when the current caller
wanted to silence us, it spawned us in a separate process and
redirected our output to /dev/null, but we no longer can do that
because we will change the calling convention to allow direct calls
into us"?

Do we have a precedent to name a switch that we usually call "quiet"
or "silent" as "be_{silent,quiet}"?  Is there already a "silent"
nearby that records what the end-user gave us (e.g. via "--silent"
option), a new name may be needed, but if that is the motivation,
I'd probably call it something more specific, "apply_silently" or
somesuch.

> Let's not take care of stdout and apply_verbosely for now though,
> as that will be taken care of in following patches.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  apply.c | 43 +++++++++++++++++++++++++++++--------------
>  apply.h |  1 +
>  2 files changed, 30 insertions(+), 14 deletions(-)
>
> diff --git a/apply.c b/apply.c
> index 7bf12a7..802fa79 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -1617,8 +1617,9 @@ static void record_ws_error(struct apply_state *state,
>  		return;
>  
>  	err = whitespace_error_string(result);
> -	fprintf(stderr, "%s:%d: %s.\n%.*s\n",
> -		state->patch_input_file, linenr, err, len, line);
> +	if (!state->be_silent)
> +		fprintf(stderr, "%s:%d: %s.\n%.*s\n",
> +			state->patch_input_file, linenr, err, len, line);
>  	free(err);
>  }
>  
> @@ -1813,7 +1814,7 @@ static int parse_single_patch(struct apply_state *state,
>  		return error(_("new file %s depends on old contents"), patch->new_name);
>  	if (0 < patch->is_delete && newlines)
>  		return error(_("deleted file %s still has contents"), patch->old_name);
> -	if (!patch->is_delete && !newlines && context)
> +	if (!patch->is_delete && !newlines && context && !state->be_silent)
>  		fprintf_ln(stderr,
>  			   _("** warning: "
>  			     "file %s becomes empty but is not deleted"),
> @@ -3038,8 +3039,8 @@ static int apply_one_fragment(struct apply_state *state,
>  		 * Warn if it was necessary to reduce the number
>  		 * of context lines.
>  		 */
> -		if ((leading != frag->leading) ||
> -		    (trailing != frag->trailing))
> +		if ((leading != frag->leading ||
> +		     trailing != frag->trailing) && !state->be_silent)
>  			fprintf_ln(stderr, _("Context reduced to (%ld/%ld)"
>  					     " to apply fragment at %d"),
>  				   leading, trailing, applied_pos+1);
> @@ -3536,7 +3537,8 @@ static int try_threeway(struct apply_state *state,
>  		 read_blob_object(&buf, pre_sha1, patch->old_mode))
>  		return error("repository lacks the necessary blob to fall back on 3-way merge.");
>  
> -	fprintf(stderr, "Falling back to three-way merge...\n");
> +	if (!state->be_silent)
> +		fprintf(stderr, "Falling back to three-way merge...\n");
>  
>  	img = strbuf_detach(&buf, &len);
>  	prepare_image(&tmp_image, img, len, 1);
> @@ -3566,7 +3568,9 @@ static int try_threeway(struct apply_state *state,
>  	status = three_way_merge(image, patch->new_name,
>  				 pre_sha1, our_sha1, post_sha1);
>  	if (status < 0) {
> -		fprintf(stderr, "Failed to fall back on three-way merge...\n");
> +		if (!state->be_silent)
> +			fprintf(stderr,
> +				"Failed to fall back on three-way merge...\n");
>  		return status;
>  	}
>  
> @@ -3578,9 +3582,15 @@ static int try_threeway(struct apply_state *state,
>  			hashcpy(patch->threeway_stage[0].hash, pre_sha1);
>  		hashcpy(patch->threeway_stage[1].hash, our_sha1);
>  		hashcpy(patch->threeway_stage[2].hash, post_sha1);
> -		fprintf(stderr, "Applied patch to '%s' with conflicts.\n", patch->new_name);
> +		if (!state->be_silent)
> +			fprintf(stderr,
> +				"Applied patch to '%s' with conflicts.\n",
> +				patch->new_name);
>  	} else {
> -		fprintf(stderr, "Applied patch to '%s' cleanly.\n", patch->new_name);
> +		if (!state->be_silent)
> +			fprintf(stderr,
> +				"Applied patch to '%s' cleanly.\n",
> +				patch->new_name);
>  	}
>  	return 0;
>  }
> @@ -4483,7 +4493,8 @@ static int write_out_one_reject(struct apply_state *state, struct patch *patch)
>  			    "Applying patch %%s with %d rejects...",
>  			    cnt),
>  		    cnt);
> -	say_patch_name(stderr, sb.buf, patch);
> +	if (!state->be_silent)
> +		say_patch_name(stderr, sb.buf, patch);
>  	strbuf_release(&sb);
>  
>  	cnt = strlen(patch->new_name);
> @@ -4510,10 +4521,12 @@ static int write_out_one_reject(struct apply_state *state, struct patch *patch)
>  	     frag;
>  	     cnt++, frag = frag->next) {
>  		if (!frag->rejected) {
> -			fprintf_ln(stderr, _("Hunk #%d applied cleanly."), cnt);
> +			if (!state->be_silent)
> +				fprintf_ln(stderr, _("Hunk #%d applied cleanly."), cnt);
>  			continue;
>  		}
> -		fprintf_ln(stderr, _("Rejected hunk #%d."), cnt);
> +		if (!state->be_silent)
> +			fprintf_ln(stderr, _("Rejected hunk #%d."), cnt);
>  		fprintf(rej, "%.*s", frag->size, frag->patch);
>  		if (frag->patch[frag->size-1] != '\n')
>  			fputc('\n', rej);
> @@ -4562,8 +4575,10 @@ static int write_out_results(struct apply_state *state, struct patch *list)
>  		struct string_list_item *item;
>  
>  		string_list_sort(&cpath);
> -		for_each_string_list_item(item, &cpath)
> -			fprintf(stderr, "U %s\n", item->string);
> +		if (!state->be_silent) {
> +			for_each_string_list_item(item, &cpath)
> +				fprintf(stderr, "U %s\n", item->string);
> +		}
>  		string_list_clear(&cpath, 0);
>  
>  		rerere(0);
> diff --git a/apply.h b/apply.h
> index df44b51..44bed19 100644
> --- a/apply.h
> +++ b/apply.h
> @@ -52,6 +52,7 @@ struct apply_state {
>  	int apply_in_reverse;
>  	int apply_with_reject;
>  	int apply_verbosely;
> +	int be_silent;
>  	int no_add;
>  	int threeway;
>  	int unidiff_zero;
