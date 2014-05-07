From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/tag.c: Add tag name to user message
Date: Wed, 07 May 2014 14:24:51 -0700
Message-ID: <xmqqy4yd704c.fsf@gitster.dls.corp.google.com>
References: <201405070749.s477nvCL000897@herc.mirbsd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Richard Hartmann <richih@debian.org>
To: Thorsten Glaser <tg@debian.org>
X-From: git-owner@vger.kernel.org Wed May 07 23:25:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi9Km-0004lc-Sy
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 23:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbaEGVY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 17:24:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59987 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751814AbaEGVY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 17:24:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 14F4F16081;
	Wed,  7 May 2014 17:24:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5FY2w75XOtODCzgl6YB6dDXMUVA=; b=a2qnxv
	JZdZq9YIYn6pmdnlrl36xuNkBsZ2p73vAhrkhQVSB/S3GcTxUlG23mX/D1qydaZJ
	M58TNU9k295uzaEfzaHeTSdYrzO+9Hs6QtWrU1xorsnXgWhXT9cBKkD4FmUohLpM
	dCyXpc5EOHzDF+jH9XUy9OlH5yWSIqX2ktYec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m+67RanpcKEKUBpTCqPySIoV7VAM8jGd
	W1pcTD9UizhzFvWBOWPdLTXAOvaOi0iRdNjidghQWFV+u1ks6XqHG3QzykqDVY/a
	vklnMOpxkBMsWhPzsokevJVPiAlPWvkAwg7w9ePcti3C0IetkcIaPpjqjmezjZy4
	2EDapNU8Z+w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0796A16080;
	Wed,  7 May 2014 17:24:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 803BE1607B;
	Wed,  7 May 2014 17:24:52 -0400 (EDT)
In-Reply-To: <201405070749.s477nvCL000897@herc.mirbsd.org> (Thorsten Glaser's
	message of "Fri, 30 Aug 2013 00:03:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 06FDE766-D62E-11E3-9356-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248380>

Thorsten Glaser <tg@debian.org> writes:

> Display the tag name about to be added to the user during interactive
> editing.
>
> Signed-off-by: Thorsten Glaser <tg@debian.org>
> Signed-off-by: Richard Hartmann <richih@debian.org>
> ---

Sounds sensible from a first glance.  Will queue; thanks.

>  builtin/tag.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 6c7c6bd..8a7265b 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -278,11 +278,11 @@ static int do_sign(struct strbuf *buffer)
>  }
>  
>  static const char tag_template[] =
> -	N_("\nWrite a tag message\n"
> +	N_("\nWrite a message for tag:\n  %s\n"
>  	"Lines starting with '%c' will be ignored.\n");
>  
>  static const char tag_template_nocleanup[] =
> -	N_("\nWrite a tag message\n"
> +	N_("\nWrite a message for tag:\n  %s\n"
>  	"Lines starting with '%c' will be kept; you may remove them"
>  	" yourself if you want to.\n");
>  
> @@ -378,9 +378,9 @@ static void create_tag(const unsigned char *object, const char *tag,
>  			struct strbuf buf = STRBUF_INIT;
>  			strbuf_addch(&buf, '\n');
>  			if (opt->cleanup_mode == CLEANUP_ALL)
> -				strbuf_commented_addf(&buf, _(tag_template), comment_line_char);
> +				strbuf_commented_addf(&buf, _(tag_template), tag, comment_line_char);
>  			else
> -				strbuf_commented_addf(&buf, _(tag_template_nocleanup), comment_line_char);
> +				strbuf_commented_addf(&buf, _(tag_template_nocleanup), tag, comment_line_char);
>  			write_or_die(fd, buf.buf, buf.len);
>  			strbuf_release(&buf);
>  		}
