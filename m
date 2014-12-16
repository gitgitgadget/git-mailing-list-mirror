From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 5/6] push.c: add an --atomic-push argument
Date: Tue, 16 Dec 2014 11:36:16 -0800
Message-ID: <xmqqsigf9ykv.fsf@gitster.dls.corp.google.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
	<1418755747-22506-1-git-send-email-sbeller@google.com>
	<1418755747-22506-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, jrnieder@gmail.com,
	ronniesahlberg@gmail.com, Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 20:36:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0xuw-0000D6-HG
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 20:36:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbaLPTgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 14:36:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58752 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750899AbaLPTgS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 14:36:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ED5F928AEE;
	Tue, 16 Dec 2014 14:36:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CmyrL+v3uFOlDAIZS4HXpGuaqD8=; b=PjqtC4
	qNa4pfTyGaEeUFbKwYavCpKzxGWCXkT4FmK98uIkHNXdxt5otbCUA5RYpUh8a0/N
	GqVpuR1TeZZ/7i5OjcHXa8a+VmKr84AhDiQxXsru6ogqsNi9yqqhT6t/V0/ZpbQT
	T+Wrvf3IF//QLgNQ6kfgGjDaJYzmDnQn3rtZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EufJja43AnPXTtiJ8BeT0gtk7Fnzlp2l
	WDJ26ATrExhaVErTewbtyfEqrRSxiHoRpOt8tiOijL5Ira6seIhRAxw/Rcxi5Afb
	o1g9Plp5X9o6Hw+a1LnBoOCcYzKnZnmvV8fagEhWZ4SuuLSHqDH3I/1ZEcnocEmz
	fCkui4WTTp0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E3BAF28AED;
	Tue, 16 Dec 2014 14:36:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5A78828AEC;
	Tue, 16 Dec 2014 14:36:19 -0500 (EST)
In-Reply-To: <1418755747-22506-5-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 16 Dec 2014 10:49:06 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CEF786B0-855A-11E4-9CFD-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261460>

Stefan Beller <sbeller@google.com> writes:

> From: Ronnie Sahlberg <sahlberg@google.com>
>
> Add a command line argument to the git push command to request atomic
> pushes.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Notes:
>     Changes v1 -> v2
>     	It's --atomic now! (dropping the -push)

Also from the subject line ;-)

>
>  Documentation/git-push.txt | 7 ++++++-
>  builtin/push.c             | 2 ++
>  transport.c                | 1 +
>  transport.h                | 1 +
>  4 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 21b3f29..3feacc5 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -9,7 +9,7 @@ git-push - Update remote refs along with associated objects
>  SYNOPSIS
>  --------
>  [verse]
> -'git push' [--all | --mirror | --tags] [--follow-tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
> +'git push' [--all | --mirror | --tags] [--follow-tags] [--atomic-push] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
>  	   [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose]
>  	   [-u | --set-upstream] [--signed]
>  	   [--force-with-lease[=<refname>[:<expect>]]]
> @@ -136,6 +136,11 @@ already exists on the remote side.
>  	logged.  See linkgit:git-receive-pack[1] for the details
>  	on the receiving end.
>  
> +--atomic::
> +	Use the an atomic transaction on the server side if available.
> +	Either all refs are updated, or on error, no refs are updated.
> +	If the server does not support atomic pushes the push will fail.
> +
>  --receive-pack=<git-receive-pack>::
>  --exec=<git-receive-pack>::
>  	Path to the 'git-receive-pack' program on the remote
> diff --git a/builtin/push.c b/builtin/push.c
> index a076b19..fe0b8cc 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -518,6 +518,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>  		OPT_BIT(0, "follow-tags", &flags, N_("push missing but relevant tags"),
>  			TRANSPORT_PUSH_FOLLOW_TAGS),
>  		OPT_BIT(0, "signed", &flags, N_("GPG sign the push"), TRANSPORT_PUSH_CERT),
> +		OPT_BIT(0, "atomic", &flags, N_("use a single atomic transaction at the serverside, if available"),
> +			TRANSPORT_ATOMIC_PUSH),
>  		OPT_END()
>  	};
>  
> diff --git a/transport.c b/transport.c
> index c67feee..5b29514 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -830,6 +830,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
>  	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
>  	args.porcelain = !!(flags & TRANSPORT_PUSH_PORCELAIN);
>  	args.push_cert = !!(flags & TRANSPORT_PUSH_CERT);
> +	args.atomic = !!(flags & TRANSPORT_ATOMIC_PUSH);
>  	args.url = transport->url;
>  
>  	ret = send_pack(&args, data->fd, data->conn, remote_refs,
> diff --git a/transport.h b/transport.h
> index 3e0091e..25fa1da 100644
> --- a/transport.h
> +++ b/transport.h
> @@ -125,6 +125,7 @@ struct transport {
>  #define TRANSPORT_PUSH_NO_HOOK 512
>  #define TRANSPORT_PUSH_FOLLOW_TAGS 1024
>  #define TRANSPORT_PUSH_CERT 2048
> +#define TRANSPORT_ATOMIC_PUSH 4096
>  
>  #define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
>  #define TRANSPORT_SUMMARY(x) (int)(TRANSPORT_SUMMARY_WIDTH + strlen(x) - gettext_width(x)), (x)
