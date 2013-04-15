From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/33] refs: document do_for_each_ref() and do_one_ref()
Date: Mon, 15 Apr 2013 10:38:05 -0700
Message-ID: <7vobdfwv7m.fsf@alter.siamese.dyndns.org>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
 <1365944088-10588-4-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 15 19:38:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URnM5-0002vy-Nf
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 19:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756275Ab3DORiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 13:38:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51728 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755644Ab3DORiI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 13:38:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E51E15B96;
	Mon, 15 Apr 2013 17:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=rOz84mwIpiVkK0LydjlzRlVQbkA=; b=EC5SN7RTnw1+dwDYy7rY
	G5jK4TZnznY3bI1IQyOEIEsLwMni7f0kAlBheQ+lu5woafImCULJjMhNOInycu5o
	EFyT54lNPQlTZB2bGlpVMWCugQxl4fBe2DiOnUx5SAy9Nur8aowr0ndwyn56/V+j
	4CVbXfT0wB/VuMdADic8VAE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=rYlhvUoE7uzHxeGstVayYvJnBr0ABUr7+wI8Wce0ovLXok
	wzo73dziF/p+11gJaOgKy6R4apxdZFp1BgqDdWm+gUDQvROuQeDBnXhEvNeGnnOi
	Urp1WhYj6VEXILHZn9C6yjWqhUJ3ovoKX+wYPl5jh9zT+84rdrgRYGvqKSaUE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 121F215B93;
	Mon, 15 Apr 2013 17:38:07 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F10A15B92; Mon, 15 Apr
 2013 17:38:06 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3B5A3AF8-A5F3-11E2-B63A-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221259>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index 1df1ccd..f503ec4 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -525,10 +525,14 @@ static void sort_ref_dir(struct ref_dir *dir)
>  	dir->sorted = dir->nr = i;
>  }
>  
> -#define DO_FOR_EACH_INCLUDE_BROKEN 01
> +/* Include broken references in a do_for_each_ref*() iteration: */
> +#define DO_FOR_EACH_INCLUDE_BROKEN 0x01
>  
>  static struct ref_entry *current_ref;
>  
> +/*
> + * Handle one reference in a do_for_each_ref*()-style iteration.
> + */
>  static int do_one_ref(const char *base, each_ref_fn fn, int trim,
>  		      int flags, void *cb_data, struct ref_entry *entry)
>  {
> @@ -1338,6 +1342,13 @@ void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
>  	for_each_rawref(warn_if_dangling_symref, &data);
>  }
>  
> +/*
> + * Call fn for each reference in the specified submodule for which the
> + * refname begins with base.  If trim is non-zero, then trim that many
> + * characters off the beginning of each refname before passing the
> + * refname to fn.  flags can be DO_FOR_EACH_INCLUDE_BROKEN to include
> + * broken references in the iteration.
> + */

Early termination due to "fn()" returning non-zero needs to be
documented here, no?

>  static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn fn,
>  			   int trim, int flags, void *cb_data)
>  {
