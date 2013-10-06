From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetools/diffmerge: support DiffMerge as a git mergetool
Date: Sun, 6 Oct 2013 14:21:53 -0700
Message-ID: <CAJDDKr6vyt-UgO-p2HxxAdpQnGy+=zwpc9TUpK5LL54LrjNEGg@mail.gmail.com>
References: <1380961741-85909-1-git-send-email-ssaasen@atlassian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Stefan Saasen <ssaasen@atlassian.com>
X-From: git-owner@vger.kernel.org Sun Oct 06 23:22:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VSvm3-0000sC-2G
	for gcvg-git-2@plane.gmane.org; Sun, 06 Oct 2013 23:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754302Ab3JFVVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Oct 2013 17:21:55 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:60339 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753533Ab3JFVVy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Oct 2013 17:21:54 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro12so6227438pbb.41
        for <git@vger.kernel.org>; Sun, 06 Oct 2013 14:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yG2y5uiAfgP5oZWn2wcFL+dw1rMymsuh0BZqQgWAL1k=;
        b=FoRMlG0T+QjkQULuTeRjy5JVxAJv4rsLxcfB8Ko6kESUiu5KSfcsr37R89HA8nDiPB
         lfZogpo++3pRfFWItjIJuNXAg9JuNeqB7gErkBUqQ+V3yHQi+JbRKVngz2ySJ0MaQYUB
         icb+lZc+c9AIVIJm3byvC+sRkrfnEoo7/oXc1UV7fXuf7lpMROMWcs7cHbdY012Jx/17
         NMZ4ZD9HsIWessllxHhrmDm9ufFGYdmy0ewQJjjJKcvW/S78bn4e55F/GK84DwG6UPKT
         bzv/MmlxG0woNxs8sW1avnOScXImtz2YgV6O1yFLxDFm0axpejOvx97++lNV8w+Nxsd3
         bVFg==
X-Received: by 10.68.240.2 with SMTP id vw2mr27233134pbc.80.1381094513091;
 Sun, 06 Oct 2013 14:21:53 -0700 (PDT)
Received: by 10.70.102.45 with HTTP; Sun, 6 Oct 2013 14:21:53 -0700 (PDT)
In-Reply-To: <1380961741-85909-1-git-send-email-ssaasen@atlassian.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235752>

On Sat, Oct 5, 2013 at 1:29 AM, Stefan Saasen <ssaasen@atlassian.com> wrote:
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
> ---
>  contrib/completion/git-completion.bash |  2 +-
>  git-mergetool--lib.sh                  |  2 +-
>  mergetools/diffmerge                   | 15 +++++++++++++++
>  3 files changed, 17 insertions(+), 2 deletions(-)
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

It's a little unfortunate that we have to keep repeating ourselves
here.  mergetool--lib has a list_merge_tool_candidate() that populates
$tools and help us avoid having to maintain these lists in separate
files.

It might be worth leaving the git-completion.bash bits alone in this
first patch and follow it up with a change that generalizes the "list
of tools" thing so that it can be reused here, possibly.  The
show_tool_help() function, as used by "git difftool --tool-help" and
"git mergetool --tool-help", might be a good place to look for
inspiration.

We were able to eliminate duplication in the docs (see the handling
for $(mergetools_txt) in Documentation/Makefile) so it'd be nice if we
could do the same for git-completion.bash, somehow.

> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index feee6a4..6d0fa3b 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -250,7 +250,7 @@ list_merge_tool_candidates () {
>                 else
>                         tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
>                 fi
> -               tools="$tools gvimdiff diffuse ecmerge p4merge araxis bc3 codecompare"
> +               tools="$tools gvimdiff diffuse diffmerge ecmerge p4merge araxis bc3 codecompare"

I think this line was already too long in its current form.  Would you
mind splitting up this long line?

>         fi
>         case "${VISUAL:-$EDITOR}" in
>         *vim*)
> diff --git a/mergetools/diffmerge b/mergetools/diffmerge
> new file mode 100644
> index 0000000..85ac720
> --- /dev/null
> +++ b/mergetools/diffmerge
> @@ -0,0 +1,15 @@
> +diff_cmd () {
> +       "$merge_tool_path" "$LOCAL" "$REMOTE" >/dev/null 2>&1
> +}
> +
> +merge_cmd () {
> +       if $base_present
> +       then
> +               "$merge_tool_path" --merge --result="$MERGED" \
> +                       "$LOCAL" "$BASE" "$REMOTE"
> +       else
> +               "$merge_tool_path" --merge \
> +                       --result="$MERGED" "$LOCAL" "$REMOTE"
> +       fi
> +       status=$?
> +}

Other than those two minor notes, this looks good to me.

Thanks,
-- 
David
