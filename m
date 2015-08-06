From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH] contrib: teach completion about git-worktree options
 and arguments
Date: Thu, 6 Aug 2015 12:29:53 -0400
Message-ID: <CAPig+cQhh7YCiirp4a1+R0bWh46JoFgVOVUCNidTWXK8uNL2Mg@mail.gmail.com>
References: <1437684550-21884-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 06 18:30:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNO3L-0007S1-OH
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 18:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755445AbbHFQ3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 12:29:55 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:36501 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755161AbbHFQ3x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 12:29:53 -0400
Received: by ykeo23 with SMTP id o23so66781232yke.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 09:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+X9cte7/PkV+TiOTUAmYSvKoVkuOP9QFX2JMtTY2R7c=;
        b=qcAx1XBiHxp2/2w9rUQqupHPIbV+Tl0KWnLWjTDiOL7D2Ejki4aprZpTzvB1OlfJ+L
         hsCe+rmEP17fUnCXFRSOb7Da+p6f6Y/Jm9+3Fsteug36mtv4OwRXcm1E0brr3fsrKgUr
         zKNSOqL5xWyVlzkjr2v4rlNWVXSLNUAELCaTYYDwii5p+9S9NQIc+kL0ytkiL2FIUD6o
         Wl8lwoYimf+d1wVaklXgrLbAMM22xXn8R8nG2VLcpbzryENZzo43ddZf/S1MV01JT5lJ
         LoC66ZlZl3PDGIx/wHHBGz4MjSV/u3ytiBxlf9RdTKZkdqzAkxjTpHN/KNFIkNnG0RO0
         OxoA==
X-Received: by 10.13.207.1 with SMTP id r1mr2938194ywd.166.1438878593083; Thu,
 06 Aug 2015 09:29:53 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Thu, 6 Aug 2015 09:29:53 -0700 (PDT)
In-Reply-To: <1437684550-21884-1-git-send-email-sunshine@sunshineco.com>
X-Google-Sender-Auth: uE6KMJxAVq8nxnQosMIM7eHEnIs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275425>

On Thu, Jul 23, 2015 at 4:49 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> Complete subcommands 'add' and 'prune', as well as their respective
> options --force, --detach, --dry-run, --verbose, and --expire. Also
> complete 'refname' in "git worktree add [-b <newbranch>] <path>
> <refname>".

Ping[1]?

[1]: http://article.gmane.org/gmane.comp.version-control.git/274526

> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>
> This is RFC since this is my first foray into the Git completion script,
> and there are likely better and more idiomatic ways to accomplish this.
>
>  contrib/completion/git-completion.bash | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index c97c648..07c34ef 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2564,6 +2564,38 @@ _git_whatchanged ()
>         _git_log
>  }
>
> +_git_worktree ()
> +{
> +       local subcommands='add prune'
> +       local subcommand="$(__git_find_on_cmdline "$subcommands")"
> +       local c=2 n=0 refpos=2
> +       if [ -z "$subcommand" ]; then
> +               __gitcomp "$subcommands"
> +       else
> +               case "$subcommand,$cur" in
> +               add,--*)
> +                       __gitcomp "--force --detach"
> +                       ;;
> +               add,*)
> +                       while [ $c -lt $cword ]; do
> +                               case "${words[c]}" in
> +                               --*) ;;
> +                               -[bB]) ((refpos++)) ;;
> +                               *) ((n++)) ;;
> +                               esac
> +                               ((c++))
> +                       done
> +                       if [ $n -eq $refpos ]; then
> +                               __gitcomp_nl "$(__git_refs)"
> +                       fi
> +                       ;;
> +               prune,--*)
> +                       __gitcomp "--dry-run --verbose --expire"
> +                       ;;
> +               esac
> +       fi
> +}
> +
>  __git_main ()
>  {
>         local i c=1 command __git_dir
> --
> 2.5.0.rc3.407.g68aafd0
