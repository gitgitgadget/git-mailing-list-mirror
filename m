From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] ll-merge: replace flag argument with options struct
Date: Thu, 26 Aug 2010 09:39:26 -0700
Message-ID: <7vpqx5mipt.fsf@alter.siamese.dyndns.org>
References: <20100823205915.GA4484@ns1.cockos.com>
 <20100826054158.GB9708@burratino> <20100826054953.GE9708@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Justin Frankel <justin@cockos.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	eyvind.bernhardsen@gmail.com, Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 18:39:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OofUY-0006T6-IG
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 18:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754423Ab0HZQjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 12:39:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36498 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754235Ab0HZQjn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 12:39:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 84639D02CD;
	Thu, 26 Aug 2010 12:39:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=sPz3OsbX1xW9dKLO9xIHj2hcAtM=; b=b9DBvU
	UvYd1MPFJCJ49hgfX9wFy4lYW+ThOpoTB3tR473/4GVp88/MnsJ0+BVDefJVMZqH
	qFd1ZsxVILizMhft7+x+Be7MJDCpVk9R1w0j45cPWqCLCdu9RY6osI4bAEG/FgL2
	mbUmb/kBpSk3b6UMFYmd/1c+nux8y8grZcDrY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mGC44iBV9YlRYCAFAPP32Jbx3qLE9qT9
	MFb5+abUn6QtViBs+cKxu9YdLsDClEPxKMBJoePuUd80rqwfTGqdriGEXri506gd
	I3DuIfOujZf5VgQPkzSIL/21h1UK+piu8ZJOWNZbglQ3nF/fjYEwb7wrvfQrnOy5
	WN6N+SOws6o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B503D02CA;
	Thu, 26 Aug 2010 12:39:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B5246D02C2; Thu, 26 Aug
 2010 12:39:27 -0400 (EDT)
In-Reply-To: <20100826054953.GE9708@burratino> (Jonathan Nieder's message of
 "Thu\, 26 Aug 2010 00\:49\:53 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 831FA928-B130-11DF-BEE8-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154543>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Keeping track of the flag bits is proving more trouble than it's
> worth.  Instead, use a pointer to an options struct like most similar
> APIs do.
>
> Callers with no special requests can pass NULL to request the default
> options.
>
> Cc: Bert Wesarg <bert.wesarg@googlemail.com>
> Cc: Avery Pennarun <apenwarr@gmail.com>
> Helped-by: Justin Frankel <justin@cockos.com>
> Helped-by: Bert Wesarg <bert.wesarg@googlemail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> This time, with updated documentation.

Thanks.

> diff --git a/ll-merge.c b/ll-merge.c
> index 6bb3095..9bd3732 100644
> --- a/ll-merge.c
> +++ b/ll-merge.c
> ...
> @@ -96,14 +102,17 @@ static int ll_union_merge(const struct ll_merge_driver *drv_unused,
>  			  mmfile_t *orig, const char *orig_name,
>  			  mmfile_t *src1, const char *name1,
>  			  mmfile_t *src2, const char *name2,
> -			  int flag, int marker_size)
> +			  const struct ll_merge_options *opts,
> +			  int marker_size)
>  {
>  	/* Use union favor */
> -	flag &= ~LL_OPT_FAVOR_MASK;
> -	flag |= create_ll_flag(XDL_MERGE_FAVOR_UNION);
> +	struct ll_merge_options o;
> +	assert(opts);
> +	o = *opts;
> +	o.variant = XDL_MERGE_FAVOR_UNION;
>  	return ll_xdl_merge(drv_unused, result, path_unused,
>  			    orig, NULL, src1, NULL, src2, NULL,
> -			    flag, marker_size);
> +			    &o, marker_size);
>  	return 0;

Hmph, two returns...

> @@ -337,15 +348,21 @@ int ll_merge(mmbuffer_t *result_buf,
>  	     mmfile_t *ancestor, const char *ancestor_label,
>  	     mmfile_t *ours, const char *our_label,
>  	     mmfile_t *theirs, const char *their_label,
> -	     int flag)
> +	     const struct ll_merge_options *opts)
>  {
>  	static struct git_attr_check check[2];
>  	const char *ll_driver_name = NULL;
>  	int marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
>  	const struct ll_merge_driver *driver;
> -	int virtual_ancestor = flag & LL_OPT_VIRTUAL_ANCESTOR;
>  
> +	if (!opts) {
> +		struct ll_merge_options default_opts = {0};
> +		return ll_merge(result_buf, path, ancestor, ancestor_label,
> +				ours, our_label, theirs, their_label,
> +				&default_opts);

Fun---expecting tail recursion elimination ;-)?

> +	}
> +
> -	if (flag & LL_OPT_RENORMALIZE) {
> +	if (opts->renormalize) {
>  		normalize_file(ancestor, path);
>  		normalize_file(ours, path);
>  		normalize_file(theirs, path);
> ...
>  		}
>  	}
>  	driver = find_ll_merge_driver(ll_driver_name);

A tangent, as this comment is not about the "richer ll-merge" series.

The above strikes me that the low level merge driver *ought* to have a say
in the use of renormalize.  For example, ll_merge_binary() may probably
not want to have its input renormalized, no?
