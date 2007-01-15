From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] Reencode committer info to utf-8 before formatting mail header
Date: Mon, 15 Jan 2007 17:54:22 +0100
Message-ID: <87fyac44e9.fsf@morpheus.local>
References: <871wm08kcu.fsf@morpheus.local> <7vd55jrj38.fsf@assigned-by-dhcp.cox.net> <7vr6tzogp4.fsf@assigned-by-dhcp.cox.net> <7vmz4nog5b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Jan 15 23:15:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6a6h-0003UB-Ei
	for gcvg-git@gmane.org; Mon, 15 Jan 2007 23:15:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbXAOWPH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 15 Jan 2007 17:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbXAOWPH
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 17:15:07 -0500
Received: from main.gmane.org ([80.91.229.2]:48000 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439AbXAOWPF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 17:15:05 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1H6a6Y-0001v9-4K
	for git@vger.kernel.org; Mon, 15 Jan 2007 23:15:02 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Jan 2007 23:15:02 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Jan 2007 23:15:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:ZLtKc6gtzy8+T5wVKlMEj59w7Ww=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36892>

Junio C Hamano <junkio@cox.net> writes:

> Side note.  The previous patch does not help if your commit were
> made in non UTF-8 with not too recent git; the code assumes that
> commit messages without the new "encoding" headers are in UTF-8.

This was exactly the problem I was trying to solve.

> We might want to help transitioning people by doing something
> like this on top of the previous patch.  Then when dealing with
> an ancient commit (sorry, I am not saying commits older than 3
> weeks are ancient -- but it will be 6 months from now ;-), you
> can override that default by setting an environment variable.
>
> ---
> diff --git a/commit.c b/commit.c
> index 9b2b842..a1b5705 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -692,8 +692,12 @@ static char *logmsg_reencode(const struct commit=
 *commit,
>  	if (!*output_encoding)
>  		return NULL;
>  	encoding =3D get_header(commit, "encoding");
> -	if (!encoding)
> -		encoding =3D utf8;
> +	if (!encoding) {
> +		if (getenv("GIT_OLD_COMMIT_ENCODING"))
> +			encoding =3D strdup(getenv("GIT_OLD_COMMIT_ENCODING"));
> +		else
> +			encoding =3D utf8;
> +	}
>  	if (!strcmp(encoding, output_encoding))
>  		out =3D strdup(commit->buffer);
>  	else
>
>
>

--=20
David K=C3=A5gedal
