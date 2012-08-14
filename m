From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3 03/16] Add svndump_init_fd to allow reading dumps
 from arbitrary FDs.
Date: Tue, 14 Aug 2012 13:15:34 -0700
Message-ID: <7v8vdh9qmx.fsf@alter.siamese.dyndns.org>
References: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 22:15:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1NWh-000722-4S
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 22:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757402Ab2HNUPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 16:15:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52292 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756854Ab2HNUPh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 16:15:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB7627BB8;
	Tue, 14 Aug 2012 16:15:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Emjx6AxG9Cac7jNUfePfyh4ucpg=; b=xATYJ0
	nO6sDor74r9IqSFW2JUdgJb5jGTXY5rUtKCavVoEjqGMIZZoRND8tZmGjTYfNUEQ
	5KcID8i9Evd7NBMJF93az0plX/5yKOL5kxc2cI+AFFVJEjl3ftlswwc0HatHJQ1s
	RaHn5vnFP7c4wbYMM+Ew8JcricK7r6YYpSayI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EKkeavAvdk+MLeUFxg/aNstwlSzZJ332
	PdQlvtiimezvPiRcAT9SH3Lb6DjEfZM9w1ep8QiR13cXgCeq96Jhx5EaG9m9hR1W
	YcjqgJx+8+PPPwHf0jdy65ukcX6D5J4dGxKHAIGQOsZbjwsECPzUh8HksH6W8DO2
	8xxI5FzZrw0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8B007BB7;
	Tue, 14 Aug 2012 16:15:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 233327BB5; Tue, 14 Aug 2012
 16:15:36 -0400 (EDT)
In-Reply-To: <1344971598-8213-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 (Florian Achleitner's message of "Tue, 14 Aug 2012 21:13:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CEEF3DA2-E64C-11E1-876F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203444>

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

> The existing function only allows reading from a filename or
> from stdin. Allow passing of a FD and an additional FD for
> the back report pipe. This allows us to retrieve the name of
> the pipe in the caller.
>
> Fixes the filename could be NULL bug.

What bug?  Was this line meant to go in the log message?

> Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> ---
> - dup input file descriptor, because buffer_deinit closes the fd.
>  vcs-svn/svndump.c |   22 ++++++++++++++++++----
>  vcs-svn/svndump.h |    1 +
>  2 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
> index 2b168ae..d81a078 100644
> --- a/vcs-svn/svndump.c
> +++ b/vcs-svn/svndump.c
> @@ -468,11 +468,9 @@ void svndump_read(const char *url)
>  		end_revision();
>  }
>  
> -int svndump_init(const char *filename)
> +static void init(int report_fd)
>  {
> -	if (buffer_init(&input, filename))
> -		return error("cannot open %s: %s", filename, strerror(errno));
> -	fast_export_init(REPORT_FILENO);
> +	fast_export_init(report_fd);
>  	strbuf_init(&dump_ctx.uuid, 4096);
>  	strbuf_init(&dump_ctx.url, 4096);
>  	strbuf_init(&rev_ctx.log, 4096);
> @@ -482,6 +480,22 @@ int svndump_init(const char *filename)
>  	reset_dump_ctx(NULL);
>  	reset_rev_ctx(0);
>  	reset_node_ctx(NULL);
> +	return;
> +}
> +
> +int svndump_init(const char *filename)
> +{
> +	if (buffer_init(&input, filename))
> +		return error("cannot open %s: %s", filename ? filename : "NULL", strerror(errno));
> +	init(REPORT_FILENO);
> +	return 0;
> +}
> +
> +int svndump_init_fd(int in_fd, int back_fd)
> +{
> +	if(buffer_fdinit(&input, xdup(in_fd)))
> +		return error("cannot open fd %d: %s", in_fd, strerror(errno));
> +	init(xdup(back_fd));
>  	return 0;
>  }
>  
> diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
> index df9ceb0..acb5b47 100644
> --- a/vcs-svn/svndump.h
> +++ b/vcs-svn/svndump.h
> @@ -2,6 +2,7 @@
>  #define SVNDUMP_H_
>  
>  int svndump_init(const char *filename);
> +int svndump_init_fd(int in_fd, int back_fd);
>  void svndump_read(const char *url);
>  void svndump_deinit(void);
>  void svndump_reset(void);
