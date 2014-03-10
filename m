From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] [GSOC] branch.c: install_branch_config: simplify if chain
Date: Mon, 10 Mar 2014 17:18:18 -0400
Message-ID: <CAPig+cSybcLaPbMfHfRVW47o9v7qrM9XZVyoiEPf1GocUAsAWg@mail.gmail.com>
References: <1394429521-10974-1-git-send-email-Adam@sigterm.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Adam <adam@sigterm.info>
X-From: git-owner@vger.kernel.org Mon Mar 10 22:18:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN7aa-0004n5-Tr
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 22:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230AbaCJVSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 17:18:20 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:58625 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbaCJVST (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 17:18:19 -0400
Received: by mail-yk0-f173.google.com with SMTP id 10so20674082ykt.4
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 14:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XPpF8RA4M6XckKrCz3y8Co4HyBhxFKx4gh8EDgnEjn8=;
        b=Jvb+y6fvO/kqzd+M1BhPAleDON3CgOA7VcxPewogY4VRX8GXGYrLRn9k1syrJkApsS
         JnYlqIEv16PhQMTkDcNq746jmjonMOdpp4vUN4mwQ4H6A4a5u0ULUlCjrFjXmedu3AOX
         ORjI5JSc7YwKkBlnmwIBLmxCMRxMQidYD/oqoU8GwZbL4u5FkRmgzmNo2k+e5L1IRvv1
         kR4Y7mOJHAT/cYJo3K2c2rxoqzVVgn/3vm8Ok95N1iMiAVtEsoiIISrJPnAIDSCG7bBP
         WXQYpSlvOFEv0nmwOIA2tQIV/tvaD6EvVYVd1ijrVzRkkkw/R2+wK95P/gz/9TQ3tdQy
         Eu7Q==
X-Received: by 10.236.142.48 with SMTP id h36mr46792354yhj.49.1394486298799;
 Mon, 10 Mar 2014 14:18:18 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Mon, 10 Mar 2014 14:18:18 -0700 (PDT)
In-Reply-To: <1394429521-10974-1-git-send-email-Adam@sigterm.info>
X-Google-Sender-Auth: O2UxUes3EfKXdGEtwbButpWxmiA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243817>

On Mon, Mar 10, 2014 at 1:32 AM, Adam <adam@sigterm.info> wrote:
> Simplify if chain in install_branch_config().

Nicely done. Whether the rewritten code is indeed simpler is probably
a matter of taste, however, the submission itself is well executed.

> Signed-off-by: Adam <Adam@sigterm.info>

On this project, use your full name if possible.

> ---

The GSoC microproject which begat this submission asks if it would
make sense to change the code to be table-driven. If you considered
this suggestion, this area just below the "---" line following your
sign-off would be the perfect place to explain your reasons for
rejecting it.

>  branch.c |   46 +++++++++++++++++++++++-----------------------
>  1 files changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 723a36b..b2d59f1 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -77,29 +77,29 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
>         strbuf_release(&key);
>
>         if (flag & BRANCH_CONFIG_VERBOSE) {
> -               if (remote_is_branch && origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track remote branch %s from %s by rebasing.") :
> -                                 _("Branch %s set up to track remote branch %s from %s."),
> -                                 local, shortname, origin);
> -               else if (remote_is_branch && !origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track local branch %s by rebasing.") :
> -                                 _("Branch %s set up to track local branch %s."),
> -                                 local, shortname);
> -               else if (!remote_is_branch && origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track remote ref %s by rebasing.") :
> -                                 _("Branch %s set up to track remote ref %s."),
> -                                 local, remote);
> -               else if (!remote_is_branch && !origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track local ref %s by rebasing.") :
> -                                 _("Branch %s set up to track local ref %s."),
> -                                 local, remote);
> -               else
> -                       die("BUG: impossible combination of %d and %p",
> -                           remote_is_branch, origin);
> +               if (remote_is_branch) {
> +                       if (origin)
> +                               printf_ln(rebasing ?
> +                                         _("Branch %s set up to track remote branch %s from %s by rebasing.") :
> +                                         _("Branch %s set up to track remote branch %s from %s."),
> +                                         local, shortname, origin);
> +                       else
> +                               printf_ln(rebasing ?
> +                                         _("Branch %s set up to track local branch %s by rebasing.") :
> +                                         _("Branch %s set up to track local branch %s."),
> +                                         local, shortname);
> +               } else {
> +                       if (origin)
> +                               printf_ln(rebasing ?
> +                                         _("Branch %s set up to track remote ref %s by rebasing.") :
> +                                         _("Branch %s set up to track remote ref %s."),
> +                                         local, remote);
> +                       else
> +                               printf_ln(rebasing ?
> +                                         _("Branch %s set up to track local ref %s by rebasing.") :
> +                                         _("Branch %s set up to track local ref %s."),
> +                                         local, remote);
> +               }
>         }
>  }
>
> --
> 1.7.1
