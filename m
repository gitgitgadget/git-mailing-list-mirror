From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] teach replace objects to sha1_object_info_extended()
Date: Mon, 02 Dec 2013 15:41:47 -0800
Message-ID: <xmqqtxeqq0qs.fsf@gitster.dls.corp.google.com>
References: <20131130133934.2697.75781.chriscool@tuxfamily.org>
	<20131202145225.GA12457@sigill.intra.peff.net>
	<20131202150634.GA20416@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Joey Hess <joey@kitenet.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 03 00:41:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnd7k-0001dP-Mw
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 00:41:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753627Ab3LBXlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 18:41:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62131 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753543Ab3LBXlv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 18:41:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA9B458823;
	Mon,  2 Dec 2013 18:41:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ukGvgfwk2Y4LhSI/W1tNbc80YCY=; b=Pdh+VF
	i02JRVk9JSAjjnk0VNkl+A/kzVvO052qCvw07cE0/DxfOENxWzE4i8mMEhODdRRd
	opFcfiJM8cMpIoqTzbC5wSS7YpFFJZJXvWyaPCoLocabBtdZFvjPiH456nWe/fsI
	beWkczyA+KsNPbt5XI7RotuLI9TZDFNMtv6sI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gmWIkaz+kIp6BwpaLv4wzefhL1d/JSfN
	ydfUgZms/uSt1aQ1ounx2zsSbJjNKCRfUZqwWZQyQk9Rv1HN3kypxCJmVx19dn8U
	h7KwriBvNoo/8eT3G2is2Ch3LVpbd6ZQOHgHM+qBd8Q5aBPUppgMTb+MTuah4QST
	RAj7MsURt6M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D486158822;
	Mon,  2 Dec 2013 18:41:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F8FD58821;
	Mon,  2 Dec 2013 18:41:50 -0500 (EST)
In-Reply-To: <20131202150634.GA20416@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 2 Dec 2013 10:06:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 509F01BE-5BAB-11E3-9269-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238662>

Jeff King <peff@peff.net> writes:

> On Mon, Dec 02, 2013 at 09:52:25AM -0500, Jeff King wrote:
>
>> I find it a little funny that we reuse the READ_SHA1_FILE_REPLACE flag
>> directly in lookup_replace_object. That means that it is now a
>> meaningful flag for sha1_object_info_extended, even though the name does
>> not say so. It also means that the two may have to coordinate further
>> flags (since a portion of their flag namespace is shared by
>> lookup_replace_object). I don't foresee adding a lot of new flags,
>> though, so it probably isn't a huge deal.
>> 
>> I also would have expected sha1_object_info_extended to simply receive
>> the new flag via the struct object_info. Again, probably not a big deal,
>> because there aren't many callsites that needed updating. But if we were
>> not sharing flags with read_sha1_file, I think doing it as a flag in the
>> struct would be nicer.
>
> Curious what this would look like, I wrote the patch. If you drop your
> patches 2 and 3, then your final patch (actually fixing the problem)
> would look like the one below:
>
> We may be getting into bikeshed territory, and I don't feel
> super-strongly about it, so I won't say anything more. Now we've seen
> both alternatives, and you or Junio can pick. :)

FWIW, I shared that "a little funny" feeling ;-)

>
> ---
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index b2ca775..a2e3e26 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -270,6 +270,7 @@ static int batch_objects(struct batch_options *opt)
>  	 * object.
>  	 */
>  	memset(&data, 0, sizeof(data));
> +	data.info.respect_replace = 1;
>  	data.mark_query = 1;
>  	strbuf_expand(&buf, opt->format, expand_format, &data);
>  	data.mark_query = 0;
> diff --git a/cache.h b/cache.h
> index ce377e1..0ad262f 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1074,6 +1074,7 @@ struct object_info {
>  	enum object_type *typep;
>  	unsigned long *sizep;
>  	unsigned long *disk_sizep;
> +	unsigned respect_replace:1;
>  
>  	/* Response */
>  	enum {
> diff --git a/sha1_file.c b/sha1_file.c
> index 7dadd04..b6ddad0 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2519,8 +2519,11 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
>  	struct cached_object *co;
>  	struct pack_entry e;
>  	int rtype;
> +	const unsigned char *real = oi->respect_replace ?
> +				    lookup_replace_object(sha1) :
> +				    sha1;
>  
> -	co = find_cached_object(sha1);
> +	co = find_cached_object(real);
>  	if (co) {
>  		if (oi->typep)
>  			*(oi->typep) = co->type;
> @@ -2532,16 +2535,16 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
>  		return 0;
>  	}
>  
> -	if (!find_pack_entry(sha1, &e)) {
> +	if (!find_pack_entry(real, &e)) {
>  		/* Most likely it's a loose object. */
> -		if (!sha1_loose_object_info(sha1, oi)) {
> +		if (!sha1_loose_object_info(real, oi)) {
>  			oi->whence = OI_LOOSE;
>  			return 0;
>  		}
>  
>  		/* Not a loose object; someone else may have just packed it. */
>  		reprepare_packed_git();
> -		if (!find_pack_entry(sha1, &e))
> +		if (!find_pack_entry(real, &e))
>  			return -1;
>  	}
>  
> @@ -2570,6 +2573,7 @@ int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
>  
>  	oi.typep = &type;
>  	oi.sizep = sizep;
> +	oi.respect_replace = 1;
>  	if (sha1_object_info_extended(sha1, &oi) < 0)
>  		return -1;
>  	return type;
> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
> index b90dbdc..bb785ec 100755
> --- a/t/t6050-replace.sh
> +++ b/t/t6050-replace.sh
> @@ -276,7 +276,7 @@ test_expect_success '-f option bypasses the type check' '
>  	git replace -f HEAD^ $BLOB
>  '
>  
> -test_expect_failure 'git cat-file --batch works on replace objects' '
> +test_expect_success 'git cat-file --batch works on replace objects' '
>  	git replace | grep $PARA3 &&
>  	echo $PARA3 | git cat-file --batch
>  '
