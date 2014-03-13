From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] fsck.c: Change the type of fsck_ident()'s first argument
Date: Thu, 13 Mar 2014 12:11:03 -0700
Message-ID: <xmqqbnx9j4mw.fsf@gitster.dls.corp.google.com>
References: <1394685951-9726-1-git-send-email-yshuiv7@gmail.com>
	<1394685951-9726-2-git-send-email-yshuiv7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yuxuan Shui <yshuiv7@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 20:11:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOB29-00056l-Nk
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 20:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754920AbaCMTLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 15:11:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34506 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754593AbaCMTLH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 15:11:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0B5C74275;
	Thu, 13 Mar 2014 15:11:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i0/AJsxh0omjbOpD+i2XMP/Z4jw=; b=u3EQCJ
	pp1I6s/hmvPwchAj+9xK+YYerEXVTcNkmKjgS0uATLl4y2P8LbslOayHvE+l5NKA
	5Q1rDK77+/9v1LypszGA4YKYUSvcQT7yeKOd1Jb97hb7S+rdAl4ToYHQnuvbAjZ8
	YTllvYfbYI0Iq3/MiFlV86rvbvvS/2GPUYNj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cdcyYPaMx0Yy1oO+CJl7AH//79yiVmCt
	hyjlgEwIvk7Bllmi2lKXq8HR+FtUUKuXdwgdK9zZrOjOj0QoP5gpPXQLxOfd7J32
	ea77uudM0vSBUfchxfr1tdgq6xKkcdaXC5WNNtZXQuE2H1M+CHTDq0N7Wm31eFvM
	knwuo+b4nAw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C16274274;
	Thu, 13 Mar 2014 15:11:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ACC247426E;
	Thu, 13 Mar 2014 15:11:05 -0400 (EDT)
In-Reply-To: <1394685951-9726-2-git-send-email-yshuiv7@gmail.com> (Yuxuan
	Shui's message of "Thu, 13 Mar 2014 12:45:50 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 39E9BC98-AAE3-11E3-AC59-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244046>

Yuxuan Shui <yshuiv7@gmail.com> writes:

> Since fsck_ident doesn't change the content of **ident, the type of
> ident could be const char **.
>
> This change is required to rewrite fsck_commit() to use skip_prefix().
>
> Signed-off-by: Yuxuan Shui <yshuiv7@gmail.com>
> ---

It may not be a bad idea to read and understand reviews other people
are receiving for their microprojects, e.g. $gmane/243852.

"Change the type" is not technically incorrect per-se, but when
viewed in "git shortlog" output, it wastes more bytes than it
conveys information about this change if stated differently.  Any
patch that touch existing code is a "change" by definition.

Perhaps

	fsck.c:fsck_ident(): ident argument points at a const string

or something?

I see that the body of the patch follows the review by Peff on the
previous round of this series, so I'll forge a Helped-by: or
something into the log message when I queue this patch.

Thanks.

>  fsck.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index 99c0497..7776660 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -243,7 +243,7 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
>  	return retval;
>  }
>  
> -static int fsck_ident(char **ident, struct object *obj, fsck_error error_func)
> +static int fsck_ident(const char **ident, struct object *obj, fsck_error error_func)
>  {
>  	if (**ident == '<')
>  		return error_func(obj, FSCK_ERROR, "invalid author/committer line - missing space before email");
> @@ -281,7 +281,7 @@ static int fsck_ident(char **ident, struct object *obj, fsck_error error_func)
>  
>  static int fsck_commit(struct commit *commit, fsck_error error_func)
>  {
> -	char *buffer = commit->buffer;
> +	const char *buffer = commit->buffer;
>  	unsigned char tree_sha1[20], sha1[20];
>  	struct commit_graft *graft;
>  	int parents = 0;
