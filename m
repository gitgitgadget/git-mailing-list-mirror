From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] config --global --edit: create a template file if needed
Date: Fri, 25 Jul 2014 12:05:42 -0700
Message-ID: <xmqq1tt96yyh.fsf@gitster.dls.corp.google.com>
References: <1406311207-8276-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jul 25 21:05:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAkoW-0000fo-7C
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 21:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758776AbaGYTFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 15:05:52 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56889 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754018AbaGYTFv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 15:05:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3B3F429A7D;
	Fri, 25 Jul 2014 15:05:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=txxAu6iLOYo7u1yxqt/95i3o92k=; b=SFX0Jt
	oAd7Om3XBLlLRdZodSNzGwdIILSgIfjKwuQnh0UMoH6GEJEJdJnNz4Wtcw9Jp/9B
	dKptjQHjozz2HanWellpXDxzi5E2/kEeYP4BLyJIruuCa/t5qM6f+A3vEgAsqREd
	pWqCa0DSYL3DB7DvbmI3JD//28VJyFzKkdtCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BnE2hVpnWCGIC4tnl/Bz81QlAZxlTInZ
	v0gGZDn/hFaH546nn7JgIEGxk3KIgmwgwbgU6JVg3TjJR/Wil/w/MNmroTko4Dlw
	gFNgqiaTakhsBm0re3CKZnzTq9yuMfD8LgE8zu5mDMjk3bGK9IevJrTTcp0AYj+o
	jQ6fjLgeXZ0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2F2B029A7C;
	Fri, 25 Jul 2014 15:05:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3676629A66;
	Fri, 25 Jul 2014 15:05:44 -0400 (EDT)
In-Reply-To: <1406311207-8276-1-git-send-email-Matthieu.Moy@imag.fr> (Matthieu
	Moy's message of "Fri, 25 Jul 2014 20:00:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ADA5F6A6-142E-11E4-8BAA-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254257>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> When the user has no ~/.gitconfig file, git config --global --edit used
> to launch an editor on an nonexistant file name.
>
> Instead, create a file with a default content before launching the
> editor. The template contains only commented-out entries, to save a few
> keystrokes for the user. If the values are guessed properly, the user
> will only have to uncomment the entries.
>
> Advanced users teaching newbies can create a minimalistic configuration
> faster for newbies. Beginners reading a tutorial advising to run "git
> config --global --edit" as a first step will be slightly more guided for
> their first contact with Git.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> Hopefully, all remarks applied. I went for "Git's user configuration", but
> I can change it to whatever native speakers think is better.

I am not native but I have a slight worry that a template that lists
only core.{user,email} and marked as Git's "user configuration" will
easily mislead the reader that the file is only about these two
(i.e. I am telling the stupid Git who I am), and is not meant to
hold any other configuration that are private to the user.  I still
have funny feeling about "user-wide", but "Git's user configuration"
somehow smells worse for that reason.

What the patch attempts to do is a good idea and the code looks done
right.  Let's queue it and hope people can polish the wording.

Thanks.

>  builtin/config.c | 31 ++++++++++++++++++++++++++++---
>  cache.h          |  1 +
>  ident.c          |  2 +-
>  3 files changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/config.c b/builtin/config.c
> index fcd8474..1363478 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -445,6 +445,20 @@ static int get_urlmatch(const char *var, const char *url)
>  	return 0;
>  }
>  
> +static char *default_user_config(void)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	strbuf_addf(&buf,
> +		    _("# This is Git's user configuration file.\n"
> +		      "[core]\n"
> +		      "# Please adapt and uncomment the following lines:\n"
> +		      "#	user = %s\n"
> +		      "#	email = %s\n"),
> +		    ident_default_name(),
> +		    ident_default_email());
> +	return strbuf_detach(&buf, NULL);
> +}
> +
>  int cmd_config(int argc, const char **argv, const char *prefix)
>  {
>  	int nongit = !startup_info->have_repository;
> @@ -551,6 +565,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		}
>  	}
>  	else if (actions == ACTION_EDIT) {
> +		const char *config_file = given_config_source.file ?
> +			given_config_source.file : git_path("config");
>  		check_argc(argc, 0, 0);
>  		if (!given_config_source.file && nongit)
>  			die("not in a git directory");
> @@ -559,9 +575,18 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		if (given_config_source.blob)
>  			die("editing blobs is not supported");
>  		git_config(git_default_config, NULL);
> -		launch_editor(given_config_source.file ?
> -			      given_config_source.file : git_path("config"),
> -			      NULL, NULL);
> +		if (use_global_config) {
> +			int fd = open(config_file, O_CREAT | O_EXCL | O_WRONLY, 0666);
> +			if (fd) {
> +				char *content = default_user_config();
> +				write_str_in_full(fd, content);
> +				free(content);
> +				close(fd);
> +			}
> +			else if (errno != EEXIST)
> +				die_errno(_("cannot create configuration file %s"), config_file);
> +		}
> +		launch_editor(config_file, NULL, NULL);
>  	}
>  	else if (actions == ACTION_SET) {
>  		int ret;
> diff --git a/cache.h b/cache.h
> index fcb511d..b06cbb2 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1061,6 +1061,7 @@ extern const char *git_author_info(int);
>  extern const char *git_committer_info(int);
>  extern const char *fmt_ident(const char *name, const char *email, const char *date_str, int);
>  extern const char *fmt_name(const char *name, const char *email);
> +extern const char *ident_default_name(void);
>  extern const char *ident_default_email(void);
>  extern const char *git_editor(void);
>  extern const char *git_pager(int stdout_is_tty);
> diff --git a/ident.c b/ident.c
> index 1d9b6e7..77bc882 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -102,7 +102,7 @@ static void copy_email(const struct passwd *pw, struct strbuf *email)
>  	add_domainname(email);
>  }
>  
> -static const char *ident_default_name(void)
> +const char *ident_default_name(void)
>  {
>  	if (!git_default_name.len) {
>  		copy_gecos(xgetpwuid_self(), &git_default_name);
