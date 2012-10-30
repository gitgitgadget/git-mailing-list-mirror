From: Stefan Zager <szager@google.com>
Subject: Re: [PATCH] Enable parallelism in git submodule update.
Date: Tue, 30 Oct 2012 11:11:22 -0700
Message-ID: <CAHOQ7J-e=KBOsjoeTWsf1f+LNgaAxN974-FXNMeOy7B-FR0wyg@mail.gmail.com>
References: <5090168f.5e+7ZUFKdYL2Qnw7%szager@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jens Lehmann <jens.lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 19:11:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTGHp-0007QQ-Gz
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 19:11:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965204Ab2J3SLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 14:11:24 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:52395 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965163Ab2J3SLY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 14:11:24 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so2369298qad.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 11:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-system-of-record;
        bh=j5nykwS2FE2b6v7IfMfSOZp8J8jNZ/8zP/7ub92AcVo=;
        b=d2T1j6nZ1fKUV3ql+e2ucSJ+9MPtXh+dbMux0OURs0y+6PA6v4H7sEvWYN7S132+7B
         XkJxvxscCZvoa2VFMHpsxxM5jHGbQqAxCAspUcI2dZUfpgJAAWix018et+dv+2DlE39k
         jojU6zde6hCX6/fRCNs3QjHoj7J3owLDKfrSBVbMx7DMPOGH3zjFXCqVbIjDswPkGr/H
         r9p7lsC+jq91YnI/xoEEnryOALcu6Qe5PEcuXYCswBLbzoFd0aTzyNyvG9qQi3rWhp50
         e0+13I3hnSkNkjIgtEFnZkn9G3hi6CJZ1RzSBz6ujuZb/U2HV9GIjj2DbQ1i9twtBCG7
         WGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-system-of-record:x-gm-message-state;
        bh=j5nykwS2FE2b6v7IfMfSOZp8J8jNZ/8zP/7ub92AcVo=;
        b=VG1qRJUn13OaPmpbuZi7ovGD568BlIBbORfjwrD0vidSYZAO8j3D6HnaY357n4fqwI
         p0sWfqObP1uDuGvIVhmAqWtzeNbHQy+ixHdqWEJHTD88V/pNDwHljmYzgum1zYhHe9fq
         39/O47bPEAEfLRYKi3oPz5Po9ahWh7ghflz9LPkR+0/EvzAmy7qvmZrur562qMXFuDwQ
         DylWJzPZeXuMhcXiBD63juMIwOuU7I+t6RteBa3f/qs36V1BpOa5r5m3L70oWZa6ew+m
         FizCnF87gPyXHgi6VZfnTNTLnPgZj66d9m9fx4zKZIb3R2N55OOTgkbORxwPCWVutxFe
         hxVw==
Received: by 10.49.133.97 with SMTP id pb1mr26781631qeb.31.1351620682850; Tue,
 30 Oct 2012 11:11:22 -0700 (PDT)
Received: by 10.49.71.197 with HTTP; Tue, 30 Oct 2012 11:11:22 -0700 (PDT)
In-Reply-To: <5090168f.5e+7ZUFKdYL2Qnw7%szager@google.com>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQnb+8DelxvLMBI+ZmtdNrMHSAuFAZyA6mr1Haq3uzNFvY7fhzucVdEZ4Gp3NuhAcsJ/xs45EGOY4rBYKFPg8L8k8VYN6wPyJPxiFEAdxtAYNFunWRLL85RiGDlkrAEWero1Oo7/BA1FnApsqTXYXLFoLhQfrqudn56zT8HCQ87RjlvvpLaY5QjebGnxvDQagQ9kgBEe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208716>

This is a refresh of a conversation from a couple of months ago.

I didn't try to implement all the desired features (e.g., smart logic
for passing a -j parameter to recursive submodule invocations), but I
did address the one issue that Junio insisted on: the code makes a
best effort to detect whether xargs supports parallel execution on the
host platform, and if it doesn't, then it prints a warning and falls
back to serial execution.

Stefan

On Tue, Oct 30, 2012 at 11:03 AM,  <szager@google.com> wrote:
> The --jobs parameter may be used to set the degree of per-submodule
> parallel execution.
>
> Signed-off-by: Stefan Zager <szager@google.com>
> ---
>  Documentation/git-submodule.txt |    8 ++++++-
>  git-submodule.sh                |   40 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 46 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index b4683bb..cb23ba7 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -14,7 +14,8 @@ SYNOPSIS
>  'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
>  'git submodule' [--quiet] init [--] [<path>...]
>  'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
> -             [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
> +             [--reference <repository>] [--merge] [--recursive]
> +             [-j|--jobs [jobs]] [--] [<path>...]
>  'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
>               [commit] [--] [<path>...]
>  'git submodule' [--quiet] foreach [--recursive] <command>
> @@ -146,6 +147,11 @@ If the submodule is not yet initialized, and you just want to use the
>  setting as stored in .gitmodules, you can automatically initialize the
>  submodule with the `--init` option.
>  +
> +By default, each submodule is treated serially.  You may specify a degree of
> +parallel execution with the --jobs flag.  If a parameter is provided, it is
> +the maximum number of jobs to run in parallel; without a parameter, all jobs are
> +run in parallel.
> ++
>  If `--recursive` is specified, this command will recurse into the
>  registered submodules, and update any nested submodules within.
>  +
> diff --git a/git-submodule.sh b/git-submodule.sh
> index ab6b110..60a5f96 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -8,7 +8,7 @@ dashless=$(basename "$0" | sed -e 's/-/ /')
>  USAGE="[--quiet] add [-b branch] [-f|--force] [--reference <repository>] [--] <repository> [<path>]
>     or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
>     or: $dashless [--quiet] init [--] [<path>...]
> -   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
> +   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [-j|--jobs [jobs]] [--] [<path>...]
>     or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
>     or: $dashless [--quiet] foreach [--recursive] <command>
>     or: $dashless [--quiet] sync [--] [<path>...]"
> @@ -500,6 +500,7 @@ cmd_update()
>  {
>         # parse $args after "submodule ... update".
>         orig_flags=
> +       jobs="1"
>         while test $# -ne 0
>         do
>                 case "$1" in
> @@ -518,6 +519,20 @@ cmd_update()
>                 -r|--rebase)
>                         update="rebase"
>                         ;;
> +               -j|--jobs)
> +                       case "$2" in
> +                       ''|-*)
> +                               jobs="0"
> +                               ;;
> +                       *)
> +                               jobs="$2"
> +                               shift
> +                               ;;
> +                       esac
> +                       # Don't preserve this arg.
> +                       shift
> +                       continue
> +                       ;;
>                 --reference)
>                         case "$2" in '') usage ;; esac
>                         reference="--reference=$2"
> @@ -551,11 +566,34 @@ cmd_update()
>                 shift
>         done
>
> +       # Correctly handle the case where '-q' came before 'update' on the command line.
> +       if test -n "$GIT_QUIET"
> +       then
> +               orig_flags="$orig_flags -q"
> +       fi
> +
>         if test -n "$init"
>         then
>                 cmd_init "--" "$@" || return
>         fi
>
> +       if test "$jobs" != 1
> +       then
> +               if ( echo test | xargs -P "$jobs" true 2>/dev/null )
> +               then
> +                       if ( echo test | xargs --max-lines=1 true 2>/dev/null ); then
> +                               max_lines="--max-lines=1"
> +                       else
> +                               max_lines="-L 1"
> +                       fi
> +                       module_list "$@" | awk '{print $4}' |
> +                       xargs $max_lines -P "$jobs" git submodule update $orig_flags
> +                       return
> +               else
> +                       echo "Warn: parallel execution is not supported on this platform."
> +               fi
> +       fi
> +
>         cloned_modules=
>         module_list "$@" | {
>         err=
> --
> 1.7.7.3
>
