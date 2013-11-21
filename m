From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 04/10] git_connect: factor out discovery of the protocol and its parts
Date: Thu, 21 Nov 2013 15:22:53 -0800
Message-ID: <xmqqk3g12vci.fsf@gitster.dls.corp.google.com>
References: <201311212139.51214.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Nov 22 00:23:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjdaT-0004PP-D4
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 00:23:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755516Ab3KUXXA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Nov 2013 18:23:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61975 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753970Ab3KUXW6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Nov 2013 18:22:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D60E543D6;
	Thu, 21 Nov 2013 18:22:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=r9ztd/S9gbKJ
	tvxWi/OASwmM/YI=; b=GtlKH9vs9ZaeBTYfONSToKfzMS4D/PXJXTkDKJ/FA6M0
	dHeYg8ttluoV8s82P/+ab/6eG3kfnapTFlIizu6QXzgJQk/+WWqAXkAylRx3HuHD
	uzibjSxAMOOcofsWCc1UzyN0fYef3bGtQESHeAzZAmIpV1daH073f44z/PVLSR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FL0rnf
	/T3wdm1sc0tdS6WpFzYp4ntD51cezLigUQeZbc3jz4TLxrxpiGM42yBJ3tioCTTn
	YHpn8TI0hJPcrnLgiTuXs1Gj/6kzHU/WG3UfNetq0JnxRME5pqcbFHYS78LRPn18
	MmqsgDUM29MEVJzt807a/SR9PidXUSgoyqlOw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CCD8543D5;
	Thu, 21 Nov 2013 18:22:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 85A2C543D1;
	Thu, 21 Nov 2013 18:22:56 -0500 (EST)
In-Reply-To: <201311212139.51214.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Thu, 21 Nov 2013 21:39:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DA68BF58-5303-11E3-AB69-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238162>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> git_connect has grown large due to the many different protocols synta=
xes
> that are supported. Move the part of the function that parses the URL=
 to
> connect to into a separate function for readability.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---

I lost track, but was this authored by j6t?  If so please:

 (1) begin the body of the message like so:

	From: Johannes Sixt <j6t@kdbg.org>

        git_connect has grown ...

     so that the resulting commit will have him as the author; and

 (2) have your own sign-off after his at the end, i.e.

	....
        connect to into a separate function for readability.

	Signed-off-by: Johannes Sixt <j6t@kdbg.org>
        Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>

     to record the flow of the patch.

The resulting code looks fine from a cursory view.

Thanks.


>  connect.c | 80 ++++++++++++++++++++++++++++++++++++++++++-----------=
----------
>  1 file changed, 53 insertions(+), 27 deletions(-)
>
> diff --git a/connect.c b/connect.c
> index 6cc1f8d..a6cf345 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -543,37 +543,20 @@ static char *get_port(char *host)
>  	return NULL;
>  }
> =20
> -static struct child_process no_fork;
> -
>  /*
> - * This returns a dummy child_process if the transport protocol does=
 not
> - * need fork(2), or a struct child_process object if it does.  Once =
done,
> - * finish the connection with finish_connect() with the value return=
ed from
> - * this function (it is safe to call finish_connect() with NULL to s=
upport
> - * the former case).
> - *
> - * If it returns, the connect is successful; it just dies on errors =
(this
> - * will hopefully be changed in a libification effort, to return NUL=
L when
> - * the connection failed).
> + * Extract protocol and relevant parts from the specified connection=
 URL.
> + * The caller must free() the returned strings.
>   */
> -struct child_process *git_connect(int fd[2], const char *url_orig,
> -				  const char *prog, int flags)
> +static enum protocol parse_connect_url(const char *url_orig, char **=
ret_host,
> +				       char **ret_port, char **ret_path)
>  {
>  	char *url;
>  	char *host, *path;
>  	char *end;
>  	int c;
> -	struct child_process *conn =3D &no_fork;
>  	enum protocol protocol =3D PROTO_LOCAL;
>  	int free_path =3D 0;
>  	char *port =3D NULL;
> -	const char **arg;
> -	struct strbuf cmd =3D STRBUF_INIT;
> -
> -	/* Without this we cannot rely on waitpid() to tell
> -	 * what happened to our children.
> -	 */
> -	signal(SIGCHLD, SIG_DFL);
> =20
>  	if (is_url(url_orig))
>  		url =3D url_decode(url_orig);
> @@ -645,6 +628,49 @@ struct child_process *git_connect(int fd[2], con=
st char *url_orig,
>  	if (protocol =3D=3D PROTO_SSH && host !=3D url)
>  		port =3D get_port(end);
> =20
> +	*ret_host =3D xstrdup(host);
> +	if (port)
> +		*ret_port =3D xstrdup(port);
> +	else
> +		*ret_port =3D NULL;
> +	if (free_path)
> +		*ret_path =3D path;
> +	else
> +		*ret_path =3D xstrdup(path);
> +	free(url);
> +	return protocol;
> +}
> +
> +static struct child_process no_fork;
> +
> +/*
> + * This returns a dummy child_process if the transport protocol does=
 not
> + * need fork(2), or a struct child_process object if it does.  Once =
done,
> + * finish the connection with finish_connect() with the value return=
ed from
> + * this function (it is safe to call finish_connect() with NULL to s=
upport
> + * the former case).
> + *
> + * If it returns, the connect is successful; it just dies on errors =
(this
> + * will hopefully be changed in a libification effort, to return NUL=
L when
> + * the connection failed).
> + */
> +struct child_process *git_connect(int fd[2], const char *url,
> +				  const char *prog, int flags)
> +{
> +	char *host, *path;
> +	struct child_process *conn =3D &no_fork;
> +	enum protocol protocol;
> +	char *port;
> +	const char **arg;
> +	struct strbuf cmd =3D STRBUF_INIT;
> +
> +	/* Without this we cannot rely on waitpid() to tell
> +	 * what happened to our children.
> +	 */
> +	signal(SIGCHLD, SIG_DFL);
> +
> +	protocol =3D parse_connect_url(url, &host, &port, &path);
> +
>  	if (protocol =3D=3D PROTO_GIT) {
>  		/* These underlying connection commands die() if they
>  		 * cannot connect.
> @@ -666,9 +692,9 @@ struct child_process *git_connect(int fd[2], cons=
t char *url_orig,
>  			     prog, path, 0,
>  			     target_host, 0);
>  		free(target_host);
> -		free(url);
> -		if (free_path)
> -			free(path);
> +		free(host);
> +		free(port);
> +		free(path);
>  		return conn;
>  	}
> =20
> @@ -709,9 +735,9 @@ struct child_process *git_connect(int fd[2], cons=
t char *url_orig,
>  	fd[0] =3D conn->out; /* read from child's stdout */
>  	fd[1] =3D conn->in;  /* write to child's stdin */
>  	strbuf_release(&cmd);
> -	free(url);
> -	if (free_path)
> -		free(path);
> +	free(host);
> +	free(port);
> +	free(path);
>  	return conn;
>  }
