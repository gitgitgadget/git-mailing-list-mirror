From: Alexander Potashev <aspotashev@gmail.com>
Subject: Re: [PATCH v2 resend] git.c: make autocorrected aliases work
Date: Sun, 4 Jan 2009 20:28:33 +0300
Message-ID: <20090104172833.GA7139@myhost>
References: <1231089128-12066-1-git-send-email-dato@net.com.org.es> <1231089361-12619-1-git-send-email-dato@net.com.org.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Adeodato =?iso-8859-1?Q?Sim=F3?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Sun Jan 04 18:30:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJWnl-0006th-7s
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 18:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755837AbZADR2i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Jan 2009 12:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755715AbZADR2i
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 12:28:38 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:29059 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755470AbZADR2h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 12:28:37 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2506797fgg.17
        for <git@vger.kernel.org>; Sun, 04 Jan 2009 09:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=moCQ1IjuD5kQPmNLaadSLbo4z2wTWRI8dr21lSQ2L/8=;
        b=QpwGz3gffSbyLdMXThNFpHcIdzBGDsZflYGe9D4jGxbCwOy5FVZLrmWRFJNHtqJc9+
         0eTWLjqn3KdKXF5Pyp/qfS+ROvGfsUJNXPqXxSbJc5r3kDhbAHCHOvjMHFURcsAx2nBB
         xhveaBL0svmk67SV8/eb+D9yFQJd9AKfeWEF8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=GpQP6+2K8cxFXasf2Q+CFFFabWSuZYLjtpmZEpnaNCLz/bb9yI8AnfnVwYKQQbphGL
         FZctzkv58YfhcQ6mPptbwt5TmyeDKDtak5NXnlWlssxHuDG39Z0QNPFhasrUs0sktUZt
         qYrq4ek3VOQ29bYrP7Z2qryaGePLN7Ebl/5do=
Received: by 10.86.59.18 with SMTP id h18mr10239382fga.45.1231090114644;
        Sun, 04 Jan 2009 09:28:34 -0800 (PST)
Received: from smtp.gmail.com (ppp91-78-207-99.pppoe.mtu-net.ru [91.78.207.99])
        by mx.google.com with ESMTPS id 12sm2948060fgg.36.2009.01.04.09.28.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Jan 2009 09:28:33 -0800 (PST)
Received: by smtp.gmail.com (sSMTP sendmail emulation); Sun, 04 Jan 2009 20:28:33 +0300
Content-Disposition: inline
In-Reply-To: <1231089361-12619-1-git-send-email-dato@net.com.org.es>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104527>

On 18:16 Sun 04 Jan     , Adeodato Sim=F3 wrote:
> help_unknown_cmd() is able to autocorrect a command to an alias, and =
not
> only to internal or external commands. However, main() was not passin=
g the
> autocorrected command through handle_alias(), hence it failed if it w=
as an
> alias.
>=20
> This commit makes the autocorrected command go through handle_alias()=
, once
> handle_internal_command() and execv_dashed_external() have been tried=
=2E Since
> this is done twice in main() now, moved that logic to a new run_argv(=
)
> function.
>=20
> Also, print the same "Expansion of alias 'x' failed" message when the=
 alias
> was autocorrected, rather than a generic "Failed to run command 'x'".
>=20
> Signed-off-by: Adeodato Sim=F3 <dato@net.com.org.es>
> ---
>=20
> Meh, I didn't realize that by attaching an incremental diff, I'd brea=
k
> `git am`. Sorry about that.
>=20
>  git.c |   53 +++++++++++++++++++++++++++++++++--------------------
>  1 files changed, 33 insertions(+), 20 deletions(-)
>=20
> diff --git a/git.c b/git.c
> index e0d9071..ee331aa 100644
> --- a/git.c
> +++ b/git.c
> @@ -416,12 +416,34 @@ static void execv_dashed_external(const char **=
argv)
>  	strbuf_release(&cmd);
>  }
> =20
> +static int run_argv(int *argcp, const char ***argv)
> +{
> +	int done_alias =3D 0;
> +
> +	while (1) {
> +		/* See if it's an internal command */
> +		handle_internal_command(*argcp, *argv);
> +
> +		/* .. then try the external ones */
> +		execv_dashed_external(*argv);
> +
> +		/* It could be an alias -- this works around the insanity
> +		 * of overriding "git log" with "git show" by having
> +		 * alias.log =3D show
> +		 */
> +		if (done_alias || !handle_alias(argcp, argv))
> +			break;
> +		done_alias =3D 1;
> +	}
> +
> +	return done_alias;
> +}
> +
> =20
>  int main(int argc, const char **argv)
>  {
>  	const char *cmd =3D argv[0] && *argv[0] ? argv[0] : "git-help";
>  	char *slash =3D (char *)cmd + strlen(cmd);
> -	int done_alias =3D 0;
> =20
>  	/*
>  	 * Take the basename of argv[0] as the command
> @@ -479,31 +501,22 @@ int main(int argc, const char **argv)
>  	setup_path();
> =20
>  	while (1) {
> -		/* See if it's an internal command */
> -		handle_internal_command(argc, argv);
> -
> -		/* .. then try the external ones */
> -		execv_dashed_external(argv);
> -
> -		/* It could be an alias -- this works around the insanity
> -		 * of overriding "git log" with "git show" by having
> -		 * alias.log =3D show
> -		 */
> -		if (done_alias || !handle_alias(&argc, &argv))
> +		static int done_help =3D 0;
> +		static int was_alias =3D 0;
> +		was_alias =3D run_argv(&argc, &argv);
> +		if (errno !=3D ENOENT)
>  			break;
> -		done_alias =3D 1;
> -	}
> -
> -	if (errno =3D=3D ENOENT) {
> -		if (done_alias) {
> +		if (was_alias) {
>  			fprintf(stderr, "Expansion of alias '%s' failed; "
>  				"'%s' is not a git-command\n",
>  				cmd, argv[0]);
>  			exit(1);

Why not using 'die' here?

		die("Expansion of alias '%s' failed;
			'%s' is not a git-command",
  			cmd, argv[0]);

DISCLAIMER: I have never used git's 'die'

>  		}
> -		argv[0] =3D help_unknown_cmd(cmd);
> -		handle_internal_command(argc, argv);
> -		execv_dashed_external(argv);
> +		if (!done_help) {
> +			cmd =3D argv[0] =3D help_unknown_cmd(cmd);
> +			done_help =3D 1;
> +		} else
> +			break;
>  	}
> =20
>  	fprintf(stderr, "Failed to run command '%s': %s\n",
> --=20
> 1.6.1.62.g677ca
