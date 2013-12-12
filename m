From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] cat-file: pass expand_data to print_object_or_die
Date: Wed, 11 Dec 2013 19:03:14 -0800
Message-ID: <7vmwk6u5xp.fsf@alter.siamese.dyndns.org>
References: <20131211115458.GA10561@sigill.intra.peff.net>
	<20131211115642.GA10594@sigill.intra.peff.net>
	<20131211201112.GM2311@google.com>
	<20131211230142.GA16606@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Samuel Bronson <naesten@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 12 04:03:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqwYt-0006FN-Jg
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 04:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253Ab3LLDDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 22:03:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45700 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882Ab3LLDDV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 22:03:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A2145AF83;
	Wed, 11 Dec 2013 22:03:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qcai9E+s7CRvAD8GJRXJMdKEk4Q=; b=axKrdm
	E0mLwo/ILBYPb4xJ8IzkIYHB2NrLKyBShHFPQBCzNP3gMmTwCee2BQzmHpcLWgED
	45j9+AqQt4tCZl/GDB3+KcYRwidsvj1aZx6gTuoT8dL5YItFg17GBHHAq6Wabfnc
	mgb5DIVa4o5zXddL+Oxa5h8x6BORaIc2chVNM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a197Jup0BWAj5KVI6xE29MEzT8yUnAOd
	Qfv2D5geBQjvKk0bKxx3fhCH5ut5dZaKp/oP1VGYZmsxJNz3Q9G0pgZYCXYkT50N
	YRC8VUX8llt43dKD0A5w+s+HY9GSPiik7RLnF+P2yDCR1DmP4h5hJGYNqmHvD+dI
	NsTCgSRPZJE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A5CD5AF81;
	Wed, 11 Dec 2013 22:03:20 -0500 (EST)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D8465AF7A;
	Wed, 11 Dec 2013 22:03:16 -0500 (EST)
In-Reply-To: <20131211230142.GA16606@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 12 Dec 2013 07:01:42 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F2C981E6-62D9-11E3-BB36-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239222>

Jeff King <peff@peff.net> writes:

> It technically does typo-fix the error message, which I guess is a
> functional change. But I didn't count that. :)
>
> Here it is with the commit message fixes and your reviewed-by.

Thanks, both.

Will queue, to eventually merge to 'maint'.

>
> -- >8 --
> Subject: cat-file: pass expand_data to print_object_or_die
>
> We currently individually pass the sha1, type, and size
> fields calculated by sha1_object_info. However, if we pass
> the whole struct, the called function can make more
> intelligent decisions about which fields were actually
> filled by sha1_object_info.
>
> This patch takes that first refactoring step, passing the
> whole struct, so further patches can make those decisions
> with less noise in their diffs. There should be no
> functional change to this patch (aside from a minor typo fix
> in the error message).
>
> As a side effect, we can rename the local variables in the
> function to "type" and "size", since the names are no longer
> taken.
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/cat-file.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index b2ca775..1434afb 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -193,25 +193,26 @@ static size_t expand_format(struct strbuf *sb, const char *start, void *data)
>  	return end - start + 1;
>  }
>  
> -static void print_object_or_die(int fd, const unsigned char *sha1,
> -				enum object_type type, unsigned long size)
> +static void print_object_or_die(int fd, struct expand_data *data)
>  {
> -	if (type == OBJ_BLOB) {
> +	const unsigned char *sha1 = data->sha1;
> +
> +	if (data->type == OBJ_BLOB) {
>  		if (stream_blob_to_fd(fd, sha1, NULL, 0) < 0)
>  			die("unable to stream %s to stdout", sha1_to_hex(sha1));
>  	}
>  	else {
> -		enum object_type rtype;
> -		unsigned long rsize;
> +		enum object_type type;
> +		unsigned long size;
>  		void *contents;
>  
> -		contents = read_sha1_file(sha1, &rtype, &rsize);
> +		contents = read_sha1_file(sha1, &type, &size);
>  		if (!contents)
>  			die("object %s disappeared", sha1_to_hex(sha1));
> -		if (rtype != type)
> +		if (type != data->type)
>  			die("object %s changed type!?", sha1_to_hex(sha1));
> -		if (rsize != size)
> -			die("object %s change size!?", sha1_to_hex(sha1));
> +		if (size != data->size)
> +			die("object %s changed size!?", sha1_to_hex(sha1));
>  
>  		write_or_die(fd, contents, size);
>  		free(contents);
> @@ -250,7 +251,7 @@ static int batch_one_object(const char *obj_name, struct batch_options *opt,
>  	strbuf_release(&buf);
>  
>  	if (opt->print_contents) {
> -		print_object_or_die(1, data->sha1, data->type, data->size);
> +		print_object_or_die(1, data);
>  		write_or_die(1, "\n", 1);
>  	}
>  	return 0;
