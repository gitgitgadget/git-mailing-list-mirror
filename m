From: "Govind Salinas" <govindsalinas@gmail.com>
Subject: Fwd: [PATCH] Invoke "git gc --auto" from "git add" and "git fetch"
Date: Wed, 5 Sep 2007 15:59:17 -0500
Message-ID: <69b0c0350709051359o343ce517md19bda824d84852b@mail.gmail.com>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
	 <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
	 <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
	 <alpine.LFD.0.9999.0709051438460.21186@xanadu.home>
	 <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
	 <7vhcm8j1bp.fsf_-_@gitster.siamese.dyndns.org>
	 <69b0c0350709051357ifa547aarfe3e0b36cf9be98f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 22:59:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT1y9-0006lU-Ac
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 22:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055AbXIEU7U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 16:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752966AbXIEU7U
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 16:59:20 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:25919 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220AbXIEU7T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 16:59:19 -0400
Received: by py-out-1112.google.com with SMTP id u77so6288327pyb
        for <git@vger.kernel.org>; Wed, 05 Sep 2007 13:59:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SyiQsMxiDoycltZUOGDrvwFcfGaBLbrFjYvykO4syxSd8OOXz7ebF2TySGCHj+8JKCsoCpWzotnk3smzHj/hp5STyWUQvazVheXUQgkPNYIVaZGwks7UQ9CN71PMuldl1/Ag+9cPDhzSoqgHTBB98jxA6jUgIBSnjesutbDerqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lcUynV+ZXr5u70DtppivDyguQF/YP/hlYWt6efupuHxgdlUv0poUHkvd9PYYVeJmVucXtY2sPDINagsF933mw62/x44En0OUqBxX8cP8eEEqHJFP/d5NLbhx1KiYq25DjqBEzqgOqIOEvAY9b8kaP+UV/PK9rfaZf7Jaiq1t0p8=
Received: by 10.65.59.11 with SMTP id m11mr7931178qbk.1189025957769;
        Wed, 05 Sep 2007 13:59:17 -0700 (PDT)
Received: by 10.65.189.16 with HTTP; Wed, 5 Sep 2007 13:59:17 -0700 (PDT)
In-Reply-To: <69b0c0350709051357ifa547aarfe3e0b36cf9be98f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57762>

Forgot to cc the list.

---------- Forwarded message ----------
From: Govind Salinas <govindsalinas@gmail.com>
Date: Sep 5, 2007 3:57 PM
Subject: Re: [PATCH] Invoke "git gc --auto" from "git add" and "git fetch"
To: Junio C Hamano <gitster@pobox.com>


I have a completely uninformed question...

Can git-add/rm/etc create dangling object or objects that would
be cleaned up by git-gc --auto?  I would think (and I could be
completely off base here) that you would only want to call gc
after an operation that could create stuff that needs to be gc'ed,
since only then could the threshold be reached.

Anyways, just curious.  One day I should actually go in and read
some git code.

-Govind

On 9/5/07, Junio C Hamano <gitster@pobox.com> wrote:
> This makes the two commands to call "git gc --auto" when they
> are done.
>
> I earlier said that obvious candidates also include merge and
> rebase, but these are lot less frequent operations compared to
> add, and more importantly, in a normal workflow they would
> almost always happen after "git fetch" is done.
>
> In other words, if you are downstream developer, the automatic
> invocation in "git fetch" will take care of things for you, and
> otherwise if you do not have an upstream, you would be doing
> your own development, so "git add" to add your changes will take
> care of the auto invocation for you.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * This is obviously a follow-up to the previous one that allows
>    you to say "git gc --auto".  I somewhat feel dirty about
>    calling cmd_gc() bypassing fork & exec from "git add",
>    though...
>
>  builtin-add.c |    2 ++
>  git-fetch.sh  |    1 +
>  2 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-add.c b/builtin-add.c
> index 105a9f0..8431c16 100644
> --- a/builtin-add.c
> +++ b/builtin-add.c
> @@ -263,9 +263,11 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>
>   finish:
>         if (active_cache_changed) {
> +               const char *args[] = { "gc", "--auto", NULL };
>                 if (write_cache(newfd, active_cache, active_nr) ||
>                     close(newfd) || commit_locked_index(&lock_file))
>                         die("Unable to write new index file");
> +               cmd_gc(2, args, NULL);
>         }
>
>         return 0;
> diff --git a/git-fetch.sh b/git-fetch.sh
> index c3a2001..86050eb 100755
> --- a/git-fetch.sh
> +++ b/git-fetch.sh
> @@ -375,3 +375,4 @@ case "$orig_head" in
>         fi
>         ;;
>  esac
> +git gc --auto
> --
> 1.5.3.1.840.g0fedbc
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
