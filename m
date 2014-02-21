From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] Add docstrings for lookup_replace_object() and do_lookup_replace_object()
Date: Fri, 21 Feb 2014 10:21:20 -0800
Message-ID: <xmqqios8499b.fsf@gitster.dls.corp.google.com>
References: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu>
	<1393000327-11402-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 21 19:21:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGujF-00056G-IC
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 19:21:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867AbaBUSV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 13:21:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33941 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752313AbaBUSV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 13:21:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8C2F6C7B8;
	Fri, 21 Feb 2014 13:21:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+twOOw02GfZ8YiRTWt/jynWmGLo=; b=Q/2k+x
	JwCxHHHIrh5KhWlZxaWOwBFzPbDiErS8ZZ+axvBxszcwBlpGo1O324h+mwcUMdT+
	AC4hy7qv2tfdi1f/ZGD/YE5/+o5pljIxlgzpkTHr5ohC7/YYLEnsGjt0rch0IYKZ
	94IcEy0E0AKjcXo2tKnC1PNGLFDZ8qF3yGF7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mnARHM3+DLo4NrTM4IvRBxZozWMvXkuV
	SJ1Dl01uBKRknW4qBYafWQjDd8GFtjPS0Gx/+LyJwUyiKQ4qH2MFsG12DG65zXoO
	lBzazwG5njs259eI6k3ejWcFbbdFkANlLQwdYJPQGUyxKl8aCe8tuCf0E2vhzkFn
	rQGGNlSpwRY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FAFC6C7B6;
	Fri, 21 Feb 2014 13:21:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3B3D6C7B3;
	Fri, 21 Feb 2014 13:21:23 -0500 (EST)
In-Reply-To: <1393000327-11402-2-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Fri, 21 Feb 2014 17:32:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F8383432-9B24-11E3-9C96-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242485>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  cache.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/cache.h b/cache.h
> index dc040fb..0ecd1c8 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -788,13 +788,29 @@ static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *
>  {
>  	return read_sha1_file_extended(sha1, type, size, LOOKUP_REPLACE_OBJECT);
>  }
> +
> +/*
> + * If a replacement for object sha1 has been set up, return the
> + * replacement object's name (replaced recursively, if necessary).
> + * The return value is either sha1 or a pointer to a
> + * permanently-allocated value.  This function always respects replace
> + * references, regardless of the value of check_replace_refs.
> + */
>  extern const unsigned char *do_lookup_replace_object(const unsigned char *sha1);
> +
> +/*
> + * If object sha1 should be replaced, return the replacement object's
> + * name.  This function is similar to do_lookup_replace_object(),
> + * except that it when object replacement is suppressed, it always
> + * returns its argument unchanged.
> + */
>  static inline const unsigned char *lookup_replace_object(const unsigned char *sha1)
>  {
>  	if (!read_replace_refs)
>  		return sha1;
>  	return do_lookup_replace_object(sha1);
>  }
> +
>  static inline const unsigned char *lookup_replace_object_extended(const unsigned char *sha1, unsigned flag)
>  {
>  	if (!(flag & LOOKUP_REPLACE_OBJECT))

The above description is good, but after reading e1111cef (inline
lookup_replace_object() calls, 2011-05-15) that introduced this
ugliness, I have to wonder if do_lookup_replace(), which nobody
except lookup_replace_object() ever calls, is better removed from
the public API, making lookup_replace_object() an extern definition.

We do name functions that are purely helpers that are internal
implementation detals of the API as "do_blah", but exporting that
kind of name as if that is part of the API people are expected to
call feels very wrong.
