From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status: disable translation when --porcelain is used
Date: Thu, 20 Mar 2014 10:47:43 -0700
Message-ID: <xmqq38iczrr4.fsf@gitster.dls.corp.google.com>
References: <CAPP0M7Rw50hPHm49FetNXPGESXOoAND4NXU9F=rajv+NA=G32Q@mail.gmail.com>
	<1395317561-9380-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, ghostanarky@gmail.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Mar 20 18:47:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQh4J-0005B1-NL
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 18:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757287AbaCTRrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 13:47:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42113 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271AbaCTRrq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 13:47:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD73A74502;
	Thu, 20 Mar 2014 13:47:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rdf0hbCmxhGwx/2HXIeV6z/fSJE=; b=DfbxzF
	cPuJyGaufDT5TiZ3PusLSu70PITiBxklTmMxMBaWtprcHdB4bEjC9vKgQFtiq1rM
	2KDsidiCwWtETEkaz0gJYjlndX3Yc3BVLIZaZKJ/3oX8x6YTGxzCw0zeYM55xCLn
	BEEsNxsMjhrRGjRNfHcwwUyM7SOoepiR82qAA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V4BXgC4OPJxUMquJkXKoIDwJ+gl9zxrc
	zG+Wzhg547c2wnYkjTn8YtOH+fts3xtduhkgoMx+LzGZ9IzTecib33WIEOW/iPGD
	cCjgYq3mLxA1bq3E06DnWHvDJ7Nym5lP/ydqEw7w15lQroLRnA/4pQAUABzKsHxQ
	5+n7vPPuLJo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF8E9744FF;
	Thu, 20 Mar 2014 13:47:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 28108744FD;
	Thu, 20 Mar 2014 13:47:45 -0400 (EDT)
In-Reply-To: <1395317561-9380-1-git-send-email-Matthieu.Moy@imag.fr> (Matthieu
	Moy's message of "Thu, 20 Mar 2014 13:12:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BE3F8CB0-B057-11E3-990C-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244565>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> "git status --branch --porcelain" displays the status of the branch
> (ahead, behind, gone), and used gettext to translate the string.
>
> Use hardcoded strings when --porcelain is used, but keep the gettext
> translation for "git status --short" which is essentially the same, but
> meant to be read by a human.
>
> Reported-by: Anarky <ghostanarky@gmail.com>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>> The porcelain format of git status is described as not based on user
>> configuration.
>> But with --branch, behind/ahead are translated following the user's locale.
>> Is it normal that scripts need to take care of that?
>
> Indeed, I'd call that a bug. Here's a fix.

Good thing to fix.  Thanks.

>  wt-status.c | 15 ++++++++++-----
>  wt-status.h |  1 +
>  2 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index a452407..e55e5b9 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1509,19 +1509,23 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
>  		return;
>  	}
>  
> +	const char *gone   = s->no_gettext ? "gone"   : _("gone");
> +	const char *behind = s->no_gettext ? "behind " : _("behind ");
> +	const char *ahead  = s->no_gettext ? "ahead "  : _("ahead ");

Having to repeat the same string constant twice (and a half for the
variable name) each is an eyesore.  I wonder if we can do better,
perhaps with:

#define LABEL(string) (s->no_gettext ? (string) : _(string))

and then

	color_fprintf(s->fp, header_color, LABEL(N_("gone")));

or something along those lines?

>  	color_fprintf(s->fp, header_color, " [");
>  	if (upstream_is_gone) {
> -		color_fprintf(s->fp, header_color, _("gone"));
> +		color_fprintf(s->fp, header_color, gone);
>  	} else if (!num_ours) {
> -		color_fprintf(s->fp, header_color, _("behind "));
> +		color_fprintf(s->fp, header_color, behind);
>  		color_fprintf(s->fp, branch_color_remote, "%d", num_theirs);
>  	} else if (!num_theirs) {
> -		color_fprintf(s->fp, header_color, _("ahead "));
> +		color_fprintf(s->fp, header_color, ahead);
>  		color_fprintf(s->fp, branch_color_local, "%d", num_ours);
>  	} else {
> -		color_fprintf(s->fp, header_color, _("ahead "));
> +		color_fprintf(s->fp, header_color, ahead);
>  		color_fprintf(s->fp, branch_color_local, "%d", num_ours);
> -		color_fprintf(s->fp, header_color, _(", behind "));
> +		color_fprintf(s->fp, header_color, ", %s", behind);
>  		color_fprintf(s->fp, branch_color_remote, "%d", num_theirs);
>  	}
>  
> @@ -1566,5 +1570,6 @@ void wt_porcelain_print(struct wt_status *s)
>  	s->use_color = 0;
>  	s->relative_paths = 0;
>  	s->prefix = NULL;
> +	s->no_gettext = 1;
>  	wt_shortstatus_print(s);
>  }
> diff --git a/wt-status.h b/wt-status.h
> index 30a4812..82f6ce6 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -50,6 +50,7 @@ struct wt_status {
>  	enum commit_whence whence;
>  	int nowarn;
>  	int use_color;
> +	int no_gettext;
>  	int display_comment_prefix;
>  	int relative_paths;
>  	int submodule_summary;
