From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2] mergetools/diffmerge: support DiffMerge as a git mergetool
Date: Sat, 12 Oct 2013 12:55:41 -0700
Message-ID: <CAJDDKr7LgCXjZLzZqKkkUnqt4EGdcA0wvf=uT8KZXba-+q00Sw@mail.gmail.com>
References: <1381554070-12241-1-git-send-email-ssaasen@atlassian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Saasen <ssaasen@atlassian.com>
X-From: git-owner@vger.kernel.org Sat Oct 12 21:55:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VV5Hu-0002pK-RJ
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 21:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438Ab3JLTzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 15:55:43 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:41767 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406Ab3JLTzm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 15:55:42 -0400
Received: by mail-pb0-f44.google.com with SMTP id xa7so5674400pbc.31
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 12:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nBTE8vWBsPHePmWw2iPdop4iHrDga5dS/mjuLWqLVW4=;
        b=phmNcS58FaQH9IzriFpp2B+RMdmDZtjUJUT6+Xf/Z9R82QK1dI1bf7B246XGDM5ZiU
         YYiXKWTqSO925e/gy6wSHt5lyopjm8MEozGqVMntL5+grtDhQtquhao/61No+5c2MYnG
         9ZhrybWYFgj9F5pbhn+OsjKsZgvDwFZfGSx+xSggmgHPb8AbfJFQ1qvzNacx4Z8RIzH8
         gWqN+w0KiOPNQYJbVivDQZNqA0mZ0IIZBuUSs2qqdo8HG2ZxVincoERgaTJkyk7AsHLf
         2zQlccuy2ln2/gFlWuaSQYhoErLQEbEf00Z7r8Wm7Wn6le06RKJT/MZY8cQSQUhiCh8A
         TG7g==
X-Received: by 10.68.216.67 with SMTP id oo3mr20081106pbc.117.1381607741818;
 Sat, 12 Oct 2013 12:55:41 -0700 (PDT)
Received: by 10.70.102.45 with HTTP; Sat, 12 Oct 2013 12:55:41 -0700 (PDT)
In-Reply-To: <1381554070-12241-1-git-send-email-ssaasen@atlassian.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236054>

Thanks for the re-roll.  We're very close; see below.

On Fri, Oct 11, 2013 at 10:01 PM, Stefan Saasen <ssaasen@atlassian.com> wrote:
> DiffMerge is a non-free (but gratis) tool that supports OS X, Windows and Linux.
>
>     See http://www.sourcegear.com/diffmerge/
>
> DiffMerge includes a script `/usr/bin/diffmerge` that can be used to launch the
> graphical compare tool.
>
> This change adds mergetool support for DiffMerge and adds 'diffmerge' as an
> option to the mergetool help.
>
> Signed-off-by: Stefan Saasen <ssaasen@atlassian.com>
> Acked-by: David Aguilar <davvid@gmail.com>
> ---
>  contrib/completion/git-completion.bash |  2 +-
>  git-mergetool--lib.sh                  |  3 ++-
>  mergetools/diffmerge                   | 15 +++++++++++++++
>  3 files changed, 18 insertions(+), 2 deletions(-)
>  create mode 100644 mergetools/diffmerge
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index e1b7313..07b0ba5 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1188,7 +1188,7 @@ _git_diff ()
>         __git_complete_revlist_file
>  }
>
> -__git_mergetools_common="diffuse ecmerge emerge kdiff3 meld opendiff
> +__git_mergetools_common="diffuse diffmerge ecmerge emerge kdiff3 meld opendiff
>                         tkdiff vimdiff gvimdiff xxdiff araxis p4merge bc3 codecompare
>  "
>
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index feee6a4..0fcb253 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -250,7 +250,8 @@ list_merge_tool_candidates () {
>                 else
>                         tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
>                 fi
> -               tools="$tools gvimdiff diffuse ecmerge p4merge araxis bc3 codecompare"
> +               tools="$tools gvimdiff diffuse diffmerge ecmerge "
> +               tools+="p4merge araxis bc3 codecompare"

I don't believe "+=" is portable across all POSIX shells.

I tried this on "dash" (which is the default /bin/sh on Debian) and it
was not understood there.

$ f="1 2 3"
$ f+=" 4"
/bin/dash: 2: f+= 4: not found

I think we should stick to the tools="$tools ....." style of concatenation.

Everything else looks good to me.

Thanks,
-- 
David
