From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv2 5/6] push.c: add an --atomic-push argument
Date: Tue, 16 Dec 2014 14:33:20 -0500
Message-ID: <CAPig+cR5x=GsZ6Gg_i==o0WKgqU1PP9uQ6QAgNkF8SBOvRCJ5g@mail.gmail.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
	<1418755747-22506-1-git-send-email-sbeller@google.com>
	<1418755747-22506-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>, ronniesahlberg@gmail.com,
	Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 20:33:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0xs6-0006oj-2q
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 20:33:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbaLPTdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 14:33:22 -0500
Received: from mail-yk0-f182.google.com ([209.85.160.182]:47314 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbaLPTdV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 14:33:21 -0500
Received: by mail-yk0-f182.google.com with SMTP id 131so6230206ykp.27
        for <git@vger.kernel.org>; Tue, 16 Dec 2014 11:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=NaHxyCD05fuvIglpWgQlKCJ6xpYgeRwSUACYy5b1wf8=;
        b=ROIY3mJODmepLfZTyJ0fKpVaPb1oII1dTtPmX2dADSPdi11D0CdXV3L7ufgwB344hh
         hKss1VUpCn2cui4cHT7apbHAFqcli2FbclTbT11doMUYRTEuY2thTyBPVYAf1XAPFLwB
         K69s96Gn/AmRwGg+lg6UQHxhgqcRaVGiw04cRlCk0GKrG27aeAgfGlVh0SraLGWgAJQe
         dIAWkZGZemqGGP1DoAb+X8hZrNmKXsD6FvMtqx54+TSV90DRXiWH6yX1DxXVifZqMpe2
         IIt6YCJ+ZXkZ/tceMsfGmyLYEmD7Wkgw+lf2/eMGcDzySGvmXYncEjEpQ16IgaapJKix
         zAtw==
X-Received: by 10.236.0.197 with SMTP id 45mr28118224yhb.148.1418758400833;
 Tue, 16 Dec 2014 11:33:20 -0800 (PST)
Received: by 10.170.79.215 with HTTP; Tue, 16 Dec 2014 11:33:20 -0800 (PST)
In-Reply-To: <1418755747-22506-5-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: XpxXfHd8d0UzQnzjieXNBDmiZ3Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261457>

On Tue, Dec 16, 2014 at 1:49 PM, Stefan Beller <sbeller@google.com> wrote:
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
>         It's --atomic now! (dropping the -push)
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

s/atomic-push/atomic/

>            [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose]
>            [-u | --set-upstream] [--signed]
>            [--force-with-lease[=<refname>[:<expect>]]]
> @@ -136,6 +136,11 @@ already exists on the remote side.
>         logged.  See linkgit:git-receive-pack[1] for the details
>         on the receiving end.
>
> +--atomic::
> +       Use the an atomic transaction on the server side if available.

s/the an/an/

> +       Either all refs are updated, or on error, no refs are updated.
> +       If the server does not support atomic pushes the push will fail.
> +
>  --receive-pack=<git-receive-pack>::
>  --exec=<git-receive-pack>::
>         Path to the 'git-receive-pack' program on the remote
> diff --git a/builtin/push.c b/builtin/push.c
> index a076b19..fe0b8cc 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -518,6 +518,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>                 OPT_BIT(0, "follow-tags", &flags, N_("push missing but relevant tags"),
>                         TRANSPORT_PUSH_FOLLOW_TAGS),
>                 OPT_BIT(0, "signed", &flags, N_("GPG sign the push"), TRANSPORT_PUSH_CERT),
> +               OPT_BIT(0, "atomic", &flags, N_("use a single atomic transaction at the serverside, if available"),

"single atomic" sounds awfully redundant.

"serverside" is odd. Perhaps "server side" or merely "remote" or "remote side".

> +                       TRANSPORT_ATOMIC_PUSH),
>                 OPT_END()
>         };
>
> diff --git a/transport.c b/transport.c
> index c67feee..5b29514 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -830,6 +830,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
>         args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
>         args.porcelain = !!(flags & TRANSPORT_PUSH_PORCELAIN);
>         args.push_cert = !!(flags & TRANSPORT_PUSH_CERT);
> +       args.atomic = !!(flags & TRANSPORT_ATOMIC_PUSH);
>         args.url = transport->url;
>
>         ret = send_pack(&args, data->fd, data->conn, remote_refs,
> diff --git a/transport.h b/transport.h
> index 3e0091e..25fa1da 100644
> --- a/transport.h
> +++ b/transport.h
> @@ -125,6 +125,7 @@ struct transport {
>  #define TRANSPORT_PUSH_NO_HOOK 512
>  #define TRANSPORT_PUSH_FOLLOW_TAGS 1024
>  #define TRANSPORT_PUSH_CERT 2048
> +#define TRANSPORT_ATOMIC_PUSH 4096

For consistency with existing names, should this be TRANSPORT_PUSH_ATOMIC?

>  #define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
>  #define TRANSPORT_SUMMARY(x) (int)(TRANSPORT_SUMMARY_WIDTH + strlen(x) - gettext_width(x)), (x)
> --
> 2.2.0.31.gad78000.dirty
