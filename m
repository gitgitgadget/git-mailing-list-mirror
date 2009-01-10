From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: Re: [PATCH] Get format-patch to show first commit after root commit
Date: Fri, 9 Jan 2009 19:37:41 -0600
Message-ID: <d77df1110901091737k6c4fb826tb2287072db2e36a@mail.gmail.com>
References: <1231536787-20685-1-git-send-email-nathan.panike@gmail.com>
	 <7vmye0yohu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 02:39:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLSoc-0007JJ-Mc
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 02:39:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756692AbZAJBhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 20:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756078AbZAJBhn
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 20:37:43 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:57444 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754532AbZAJBhm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 20:37:42 -0500
Received: by yx-out-2324.google.com with SMTP id 8so3117844yxm.1
        for <git@vger.kernel.org>; Fri, 09 Jan 2009 17:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=/Agug4ScnZjaAtreuG4wbQP+VrFRmQBhqhx0Cx0ovME=;
        b=qO3J7BXLiaDGuDR49QRlYv40NXs+kvWFJT4eU9B7a5B5XiBp1v80msAk1UA+N0NT7z
         I1RFKVfXImTmV//ySr7M3QmRSgv8twYzU2ABmjCSWfAyW8IEBcwBmN3THBKeQpJ4KtUc
         6/ptFqv5PRUoydOex4ly+DHipr7vuqEVgK9n0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=q2MjdS5cSMUKCkfA9sLZaPniYfEIPekM5GbF0Vkdhlw0RjCwO13WJC1a03E5PoedoD
         W9hj7tRP/6mc4qenq3azAfI05VcmOyOudZWqURW7+VLBKPwCRzaIFG7aBheO0IMLOEGW
         xXANPjearAO8EsCG+yEeTjrdKOk0IuNQScgDY=
Received: by 10.90.74.7 with SMTP id w7mr5146892aga.73.1231551461194;
        Fri, 09 Jan 2009 17:37:41 -0800 (PST)
Received: by 10.90.114.9 with HTTP; Fri, 9 Jan 2009 17:37:41 -0800 (PST)
In-Reply-To: <7vmye0yohu.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105061>

Hi:

On Fri, Jan 9, 2009 at 6:49 PM, Junio C Hamano <gitster@pobox.com> wrote:

> I do not see anything special you do for "one commit" case in your patch,
> yet the proposed commit message keeps stressing "-1", which puzzles me.

I was trying to address Alexander's concerns he brought up previously
in the thread.

> Wouldn't it suffice to simply say something like:
>
>    You need to explicitly ask for --root to obtain a patch for the root
>    commit.  This may have been a good way to make sure that the user
>    realizes that a patch from the root commit won't be applicable to a
>    history with existing data, but we should assume the user knows what
>    he is doing when the user explicitly specifies a range of commits that
>    includes the root commit.
>

Indeed it would.  I was giving a specific case that shows what problem
this patch addresses.

> Three issues.
>
>  - The "if(){" violates style by not having one SP before "(" and after ")",
>   and surrounds a single statement with needless { } pair.  You need one SP
>   on each side of the = (assignment) as well.
>
>  - Because rev.show_root_diff is a no-op for non-root commit anyway, I do not
>   think you even want a conditional there.
>
>  - It is a bad style to muck with rev.* while it is actively used for
>   iteration (note that the above part is in a while loop that iterates over
>   &rev).

Thanks for the advice.  I shall adhere to it next time I submit a patch.

> I think the attached would be a better patch.  We already have a
> configuration to control if we show the patch for a root commit by
> default, and we can use reuse it here.  The configuration defaults to true
> these days.

I did not realize this configuration was available.  The patch below
is much more elegant.

> Because the code before the hunk must check if the user said "--root
> commit" or just "commit" from the command line and behave quite
> differently by looking at rev.show_root_diff, we cannot do this assignment
> before the command line parsing like other commands in the log family.
>
>  builtin-log.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git c/builtin-log.c w/builtin-log.c
> index 4a02ee9..2d2c111 100644
> --- c/builtin-log.c
> +++ w/builtin-log.c
> @@ -935,6 +935,14 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>                 * get_revision() to do the usual traversal.
>                 */
>        }
> +
> +       /*
> +        * We cannot move this anywhere earlier because we do want to
> +        * know if --root was given explicitly from the comand line.
> +        */
> +       if (default_show_root)
> +               rev.show_root_diff = 1;
> +
>        if (cover_letter) {
>                /* remember the range */
>                int i;
>

Thanks,

Nathan Panike
