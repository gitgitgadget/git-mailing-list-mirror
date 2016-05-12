From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/94] builtin/apply: move 'unidiff_zero' global into 'struct apply_state'
Date: Thu, 12 May 2016 12:28:08 -0700
Message-ID: <xmqq1t57f54n.fsf@gitster.mtv.corp.google.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-11-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 21:28:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0wHS-0007o2-9g
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 21:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098AbcELT2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 15:28:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54486 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752495AbcELT2N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 15:28:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ECE951BC2E;
	Thu, 12 May 2016 15:28:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NyoyG6Bpi8xxkDDyIrUmIRq2OR0=; b=vAxGd5
	zLQcOnWWriFxEC8cDyul4C4jXMA6bCGST4NvU8QOBtI3AAnY9SmE6puA48eZzYDr
	fCSNMVht0NX0P2o5qXMKRf1OZLDyiry/8YLFgv2bHYYM0ofIRxbj4Xzf9EXEzaub
	u2Hhp5INSZetA+2wOO+lrNSRTe3ZqJpDsDMTs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qe07ep6EEYxyCZOYuO8xLuN+PuLZw7dX
	C1FXsWkXDXwlezOnh6YsOgKB9uhyshGqGVjh7nfKcLfYoZBUF5Jsit56RWxl43mr
	AhnSCstDhW3CK5jQWB0zdekx5NYh2xSFuP/wWsP7s1B2oQBAomOEDFMMWZy/rKPH
	x//VnZcGFpo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E2DF11BC2D;
	Thu, 12 May 2016 15:28:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 43F7B1BC2C;
	Thu, 12 May 2016 15:28:11 -0400 (EDT)
In-Reply-To: <20160511131745.2914-11-chriscool@tuxfamily.org> (Christian
	Couder's message of "Wed, 11 May 2016 15:16:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A9FF4012-1877-11E6-8717-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294433>

Christian Couder <christian.couder@gmail.com> writes:

> To libify the apply functionality the 'unidiff_zero' variable should
> not be static and global to the file. Let's move it into
> 'struct apply_state'.
>
> Reviewed-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---

Looks correct; I would have expected from the flow of thought in the
series that p_value and linenr that were already mentioned would be
the first two to be put in this, but that would have to wait until
more functions are taught to pass the state around, so this ordering
would probably be fine.

>  builtin/apply.c | 42 ++++++++++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 18 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index e133033..44ae95d 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -24,6 +24,8 @@
>  struct apply_state {
>  	const char *prefix;
>  	int prefix_length;
> +
> +	int unidiff_zero;
>  };
>  
>  /*
> @@ -37,7 +39,6 @@ struct apply_state {
>   */
>  static int newfd = -1;
>  
> -static int unidiff_zero;
>  static int state_p_value = 1;
>  static int p_value_known;
>  static int check_index;
> @@ -2694,7 +2695,8 @@ static void update_image(struct image *img,
>   * postimage) for the hunk.  Find lines that match "preimage" in "img" and
>   * replace the part of "img" with "postimage" text.
>   */
> -static int apply_one_fragment(struct image *img, struct fragment *frag,
> +static int apply_one_fragment(struct apply_state *state,
> +			      struct image *img, struct fragment *frag,
>  			      int inaccurate_eof, unsigned ws_rule,
>  			      int nth_fragment)
>  {
> @@ -2836,7 +2838,7 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
>  	 * without leading context must match at the beginning.
>  	 */
>  	match_beginning = (!frag->oldpos ||
> -			   (frag->oldpos == 1 && !unidiff_zero));
> +			   (frag->oldpos == 1 && !state->unidiff_zero));
>  
>  	/*
>  	 * A hunk without trailing lines must match at the end.
> @@ -2844,7 +2846,7 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
>  	 * from the lack of trailing lines if the patch was generated
>  	 * with unidiff without any context.
>  	 */
> -	match_end = !unidiff_zero && !trailing;
> +	match_end = !state->unidiff_zero && !trailing;
>  
>  	pos = frag->newpos ? (frag->newpos - 1) : 0;
>  	preimage.buf = oldlines;
> @@ -3067,7 +3069,7 @@ static int apply_binary(struct image *img, struct patch *patch)
>  	return 0;
>  }
>  
> -static int apply_fragments(struct image *img, struct patch *patch)
> +static int apply_fragments(struct apply_state *state, struct image *img, struct patch *patch)
>  {
>  	struct fragment *frag = patch->fragments;
>  	const char *name = patch->old_name ? patch->old_name : patch->new_name;
> @@ -3080,7 +3082,7 @@ static int apply_fragments(struct image *img, struct patch *patch)
>  
>  	while (frag) {
>  		nth++;
> -		if (apply_one_fragment(img, frag, inaccurate_eof, ws_rule, nth)) {
> +		if (apply_one_fragment(state, img, frag, inaccurate_eof, ws_rule, nth)) {
>  			error(_("patch failed: %s:%ld"), name, frag->oldpos);
>  			if (!apply_with_reject)
>  				return -1;
> @@ -3388,8 +3390,11 @@ static int load_current(struct image *image, struct patch *patch)
>  	return 0;
>  }
>  
> -static int try_threeway(struct image *image, struct patch *patch,
> -			struct stat *st, const struct cache_entry *ce)
> +static int try_threeway(struct apply_state *state,
> +			struct image *image,
> +			struct patch *patch,
> +			struct stat *st,
> +			const struct cache_entry *ce)
>  {
>  	unsigned char pre_sha1[20], post_sha1[20], our_sha1[20];
>  	struct strbuf buf = STRBUF_INIT;
> @@ -3415,7 +3420,7 @@ static int try_threeway(struct image *image, struct patch *patch,
>  	img = strbuf_detach(&buf, &len);
>  	prepare_image(&tmp_image, img, len, 1);
>  	/* Apply the patch to get the post image */
> -	if (apply_fragments(&tmp_image, patch) < 0) {
> +	if (apply_fragments(state, &tmp_image, patch) < 0) {
>  		clear_image(&tmp_image);
>  		return -1;
>  	}
> @@ -3459,7 +3464,8 @@ static int try_threeway(struct image *image, struct patch *patch,
>  	return 0;
>  }
>  
> -static int apply_data(struct patch *patch, struct stat *st, const struct cache_entry *ce)
> +static int apply_data(struct apply_state *state, struct patch *patch,
> +		      struct stat *st, const struct cache_entry *ce)
>  {
>  	struct image image;
>  
> @@ -3467,9 +3473,9 @@ static int apply_data(struct patch *patch, struct stat *st, const struct cache_e
>  		return -1;
>  
>  	if (patch->direct_to_threeway ||
> -	    apply_fragments(&image, patch) < 0) {
> +	    apply_fragments(state, &image, patch) < 0) {
>  		/* Note: with --reject, apply_fragments() returns 0 */
> -		if (!threeway || try_threeway(&image, patch, st, ce) < 0)
> +		if (!threeway || try_threeway(state, &image, patch, st, ce) < 0)
>  			return -1;
>  	}
>  	patch->result = image.buf;
> @@ -3717,7 +3723,7 @@ static void die_on_unsafe_path(struct patch *patch)
>   * Check and apply the patch in-core; leave the result in patch->result
>   * for the caller to write it out to the final destination.
>   */
> -static int check_patch(struct patch *patch)
> +static int check_patch(struct apply_state *state, struct patch *patch)
>  {
>  	struct stat st;
>  	const char *old_name = patch->old_name;
> @@ -3816,13 +3822,13 @@ static int check_patch(struct patch *patch)
>  		return error(_("affected file '%s' is beyond a symbolic link"),
>  			     patch->new_name);
>  
> -	if (apply_data(patch, &st, ce) < 0)
> +	if (apply_data(state, patch, &st, ce) < 0)
>  		return error(_("%s: patch does not apply"), name);
>  	patch->rejected = 0;
>  	return 0;
>  }
>  
> -static int check_patch_list(struct patch *patch)
> +static int check_patch_list(struct apply_state *state, struct patch *patch)
>  {
>  	int err = 0;
>  
> @@ -3832,7 +3838,7 @@ static int check_patch_list(struct patch *patch)
>  		if (apply_verbosely)
>  			say_patch_name(stderr,
>  				       _("Checking patch %s..."), patch);
> -		err |= check_patch(patch);
> +		err |= check_patch(state, patch);
>  		patch = patch->next;
>  	}
>  	return err;
> @@ -4434,7 +4440,7 @@ static int apply_patch(struct apply_state *state,
>  	}
>  
>  	if ((check || apply) &&
> -	    check_patch_list(list) < 0 &&
> +	    check_patch_list(state, list) < 0 &&
>  	    !apply_with_reject)
>  		exit(1);
>  
> @@ -4597,7 +4603,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
>  			PARSE_OPT_NOARG, option_parse_space_change },
>  		OPT_BOOL('R', "reverse", &apply_in_reverse,
>  			N_("apply the patch in reverse")),
> -		OPT_BOOL(0, "unidiff-zero", &unidiff_zero,
> +		OPT_BOOL(0, "unidiff-zero", &state.unidiff_zero,
>  			N_("don't expect at least one line of context")),
>  		OPT_BOOL(0, "reject", &apply_with_reject,
>  			N_("leave the rejected hunks in corresponding *.rej files")),
