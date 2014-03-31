From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/27] update_refs(): Fix constness
Date: Mon, 31 Mar 2014 14:40:11 -0700
Message-ID: <xmqqha6e3v44.fsf@gitster.dls.corp.google.com>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
	<1395683820-17304-7-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 31 23:40:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUjwN-0001Pq-JN
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 23:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbaCaVkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 17:40:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48453 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750946AbaCaVkO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 17:40:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B50DF79617;
	Mon, 31 Mar 2014 17:40:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IJsN1RbuEf7lwzp7h0xQCllHHMw=; b=ANZWML
	2ptNNuhYXEbEuqzTJj+m3UWnjpAwGhrp/w0j5tq+olyZTY+VJYw66IJcLgnPW65U
	XAClpQ6G2T+AORMYhl+KP/TTQCuO7ktv5LcY8SvCbiLxv0d0OQ6EAy6vJjqNv8aO
	8AvRSXkAL6ravNfODjWlyDS/q0a+sDKIhPIGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fe0oCLlj86m1Eq9iy18gmt5n8WrauOSP
	3sm4TgnjtMYx0FM0Erm0B2bZYHxVxf5JBAbhjmUZF0Jcw0Eft374jjixKgUNWaVD
	bYnn1AfVb26E4pTQs5ZppuoxtPxps2Qn5wvb5lRVctNUbcmiXijmGDcLaqCNsN1X
	kacNJrySpwE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A31AE79615;
	Mon, 31 Mar 2014 17:40:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B676179610;
	Mon, 31 Mar 2014 17:40:12 -0400 (EDT)
In-Reply-To: <1395683820-17304-7-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Mon, 24 Mar 2014 18:56:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0A3E1C08-B91D-11E3-831B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245538>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Since full const correctness is beyond the ability of C's type system,
> just put the const where it doesn't do any harm.  A (struct ref_update
> **) can be passed to a (struct ref_update * const *) argument, but not
> to a (const struct ref_update **) argument.

Sounds good, but next time please try not to break lines inside a
single typename, which is somewhat unreadable ;-)

I'd suggest rewording "s/Fix/tighten/".  Because a patch that
changes constness can loosen constness to make things more correct,
"git shortlog" output that says if it is tightening or loosening
would be more informative than the one that says that it is "fixing".

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  builtin/update-ref.c | 2 +-
>  refs.c               | 2 +-
>  refs.h               | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index f6345e5..a8a68e8 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -14,7 +14,7 @@ static const char * const git_update_ref_usage[] = {
>  
>  static int updates_alloc;
>  static int updates_count;
> -static const struct ref_update **updates;
> +static struct ref_update **updates;
>  
>  static char line_termination = '\n';
>  static int update_flags;
> diff --git a/refs.c b/refs.c
> index 196984e..1305eb1 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3306,7 +3306,7 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
>  	return 0;
>  }
>  
> -int update_refs(const char *action, const struct ref_update **updates_orig,
> +int update_refs(const char *action, struct ref_update * const *updates_orig,
>  		int n, enum action_on_err onerr)
>  {
>  	int ret = 0, delnum = 0, i;
> diff --git a/refs.h b/refs.h
> index a713b34..08e60ac 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -228,7 +228,7 @@ int update_ref(const char *action, const char *refname,
>  /**
>   * Lock all refs and then perform all modifications.
>   */
> -int update_refs(const char *action, const struct ref_update **updates,
> +int update_refs(const char *action, struct ref_update * const *updates,
>  		int n, enum action_on_err onerr);
>  
>  extern int parse_hide_refs_config(const char *var, const char *value, const char *);
