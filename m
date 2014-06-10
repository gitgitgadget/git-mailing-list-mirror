From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix "t0001: test git init when run via an alias"
Date: Tue, 10 Jun 2014 11:48:04 -0700
Message-ID: <xmqq4mzsa9ej.fsf@gitster.dls.corp.google.com>
References: <20140606110935.GA14446@lanh>
	<1402220230-799-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	dturner@twopensource.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 20:48:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuR5m-00056c-03
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 20:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbaFJSsO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2014 14:48:14 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57955 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751140AbaFJSsN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2014 14:48:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1060C1CDE4;
	Tue, 10 Jun 2014 14:48:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CKxCqJ1GXkon
	QylvS4x1/J44MeY=; b=uwQVhfltibqYxCbC3s7tFUMLsXYQxLXv/r1xhXXmu+0f
	2i2yVcnEwAPIywo3f8+gITOI0ilZJm9pDao+99BMa0nqYW5v4CHjlgtmH3m+rHxC
	ugonAPEubqAsHSuhvogD9n9XAUoO8Xar5uKLeViONymrm8SY/XbjXcvf3lKvhr8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=khzGBv
	yY+LKIhXV/177okJFIuKKGs9bzCpMw9d0QcbhewD61uOaLU5rZg47EVgg1XqTk3Z
	tYGMy2y0SzBppmxkTm5vwgQNCMQS4KstxgT5/Dtin90FwgW+zJMIE6O3UGOBXV9/
	hUIfKItYcv2QDN2b374HidrnLed4gphsWOAls=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0590F1CDE2;
	Tue, 10 Jun 2014 14:48:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EE4E11CDDE;
	Tue, 10 Jun 2014 14:48:05 -0400 (EDT)
In-Reply-To: <1402220230-799-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpCU5n4buNYw==?= Duy"'s message of "Sun, 8 Jun
 2014 16:37:10 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C24B80BC-F0CF-11E3-B290-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251212>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Commit 4ad8332 (t0001: test git init when run via an alias -
> 2010-11-26) noted breakages when running init via alias. The problem
> is for alias to be used, $GIT_DIR must be searched, but 'init' and
> 'clone' are not happy with that. So we start a new process like an
> external command, with clean environment in this case. Env variables
> that are set by command line (e.g. "git --git-dir=3D.. ") are kept.
>
> This should also fix autocorrecting a command typo to "init" because
> it's the same problem: aliases are read, then "init" is unhappy with
> $GIT_DIR already set up because of that.
>
> Reminded-by: David Turner <dturner@twopensource.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  git.c           | 52 +++++++++++++++++++++++++++++++++++++++++++++++=
+----

This goes far deeper than "Fix t0001", doesn't it?

>  t/t0001-init.sh |  4 ++--
>  2 files changed, 50 insertions(+), 6 deletions(-)
>
> diff --git a/git.c b/git.c
> index 7780572..d1e49da 100644
> --- a/git.c
> +++ b/git.c
> @@ -484,6 +521,10 @@ static void handle_builtin(int argc, const char =
**argv)
>  		struct cmd_struct *p =3D commands+i;
>  		if (strcmp(p->cmd, cmd))
>  			continue;
> +		if (saved_environment && (p->option & NO_SETUP)) {
> +			restore_env();
> +			break;
> +		}
>  		exit(run_builtin(p, argc, argv));
>  	}
>  }
> @@ -539,7 +580,10 @@ static int run_argv(int *argcp, const char ***ar=
gv)
>  		 * of overriding "git log" with "git show" by having
>  		 * alias.log =3D show
>  		 */
> -		if (done_alias || !handle_alias(argcp, argv))
> +		if (done_alias)
> +			break;
> +		save_env();
> +		if (!handle_alias(argcp, argv))
>  			break;
>  		done_alias =3D 1;
>  	}

So the save-env kicks in only after we tried the builtins and the
externals and didn't find any, and before expanding the alias (which
has to look at the config, which means we need to do discovery and
may contaminate the environment and the globals), and then when we
retry with the expanded alias, we restore when we know the command
will misbehave if we didn't do so?

That does not sound so bad.  Even though I wonder if that "save and
then restore" sequence logically belongs around handle_alias(), you
would not have sufficient clue to let you cheat by not restoring the
environment for commands that you happen to know that they do not
care, so that may be a reasonable optimization.

Is it too brittle a solution to force people to mark problematic
subcommands with NO_SETUP, though?  What kind of change to a
subcommand that currently does not have to be marked with NO_SETUP
would make it necessary to mark it with NO_SETUP?

Thanks.
