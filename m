From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add tcsh-completion support to contrib by using git-completion.bash
Date: Tue, 13 Nov 2012 19:31:45 +0100
Message-ID: <CAMP44s3imos4DksroRkZ3K6una5H916gvtqttJQna8yGG8XhsQ@mail.gmail.com>
References: <CAFj1UpE6OtJEojaED1_DZJD0kU=nVsFE_w8xa0oJE-6auCU2rw@mail.gmail.com>
	<CAFj1UpFd9X8Jq5o7B4m35i=merBDvOo4NOtwth=UnG2S5X_rGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Marc Khouzam <marc.khouzam@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 19:32:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYLHE-0000iK-5m
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 19:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755264Ab2KMSbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 13:31:46 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:65468 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005Ab2KMSbq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 13:31:46 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so7729724oag.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 10:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nuc9v2AKSXh/5QXI69JHR0i48Tg2jTnEbDqJpgbeVVE=;
        b=urjYK+2QYfL35EX5O76It0RPqpSyGHGuGZXR9fJ2k4mJq15uf69LqVjH2eWAixxRj1
         BGszFDWLQ+YVjmkp03Ub6sqRpbnK0eIbAA5Ek5QoG6OKeIw1qY/NthZW/O1wXk0JoZbm
         szQwEVIuTzCoC1JfU7m10YVnASMGy8vULCLNZN6GUOcuGGlBkNbJAl/qzfEzV249JqsY
         JffJMY1AJ/RVU6nJpkdhkBvUbVL7d9bLKmPRrKFubWCwa0K4pC7kbc18z3lUQRFnrn0m
         kRtkRToHKEDRQ8em6IwBSjpyhgNiN8mbI2DXr2AmaZ/Of0BDe8LjumvzlNI1D5IsyEOq
         gtWA==
Received: by 10.182.116.6 with SMTP id js6mr18545840obb.82.1352831505379; Tue,
 13 Nov 2012 10:31:45 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Tue, 13 Nov 2012 10:31:45 -0800 (PST)
In-Reply-To: <CAFj1UpFd9X8Jq5o7B4m35i=merBDvOo4NOtwth=UnG2S5X_rGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209653>

On Mon, Nov 12, 2012 at 9:07 PM, Marc Khouzam <marc.khouzam@gmail.com> wrote:

> this patch allows tcsh-users to get the benefits of the awesome
> git-completion.bash script.  It could also help other shells do the same.

Maybe you can try to take a look at the same for zsh:
http://article.gmane.org/gmane.comp.version-control.git/208173

> ---
>  contrib/completion/git-completion.bash |   53 +++++++++++++++++++++++++++++++-
>  contrib/completion/git-completion.tcsh |   34 ++++++++++++++++++++
>  2 files changed, 86 insertions(+), 1 deletions(-)
>  create mode 100755 contrib/completion/git-completion.tcsh
>
> diff --git a/contrib/completion/git-completion.bash
> b/contrib/completion/git-completion.bash
> index be800e0..6d4b57a 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1,4 +1,6 @@
> -#!bash
> +#!/bin/bash
> +# The above line is important as this script can be executed when used
> +# with another shell such as tcsh
>  #
>  # bash/zsh completion support for core Git.
>  #
> @@ -2481,3 +2483,52 @@ __git_complete gitk __gitk_main
>  if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
>  __git_complete git.exe __git_main
>  fi
> +
> +# Method that will output the result of the completion done by
> +# the bash completion script, so that it can be re-used in another
> +# context than the bash complete command.
> +# It accepts 1 to 2 arguments:
> +# 1: The command-line to complete
> +# 2: The index of the word within argument #1 in which the cursor is
> +#    located (optional). If parameter 2 is not provided, it will be
> +#    determined as best possible using parameter 1.
> +_git_complete_with_output ()
> +{
> +       # Set COMP_WORDS to the command-line as bash would.
> +       COMP_WORDS=($1)
> +
> +       # Set COMP_CWORD to the cursor location as bash would.
> +       if [ -n "$2" ]; then
> +               COMP_CWORD=$2
> +       else
> +               # Assume the cursor is at the end of parameter #1.
> +               # We must check for a space as the last character which will
> +               # tell us that the previous word is complete and the cursor
> +               # is on the next word.
> +               if [ "${1: -1}" == " " ]; then
> +                       # The last character is a space, so our
> location is at the end
> +                       # of the command-line array
> +                       COMP_CWORD=${#COMP_WORDS[@]}
> +               else
> +                       # The last character is not a space, so our
> location is on the
> +                       # last word of the command-line array, so we
> must decrement the
> +                       # count by 1
> +                       COMP_CWORD=$((${#COMP_WORDS[@]}-1))
> +               fi
> +       fi
> +
> +       # Call _git() or _gitk() of the bash script, based on the first
> +       # element of the command-line
> +       _${COMP_WORDS[0]}

You might want to use __${COMP_WORDS[0]}_main instead.

> +
> +       # Print the result that is stored in the bash variable ${COMPREPLY}
> +       for i in ${COMPREPLY[@]}; do
> +               echo "$i"
> +       done
> +}
> +
> +if [ -n "$1" ] ; then
> +  # If there is an argument, we know the script is being executed
> +  # so go ahead and run the _git_complete_with_output function
> +  _git_complete_with_output "$1" "$2"
> +fi

Why do you need this function in this file? You can very easily add
this function to git-completion.tcsh.

> diff --git a/contrib/completion/git-completion.tcsh
> b/contrib/completion/git-completion.tcsh
> new file mode 100755
> index 0000000..7b7baea
> --- /dev/null
> +++ b/contrib/completion/git-completion.tcsh
> @@ -0,0 +1,34 @@
> +#!tcsh
> +#
> +# tcsh completion support for core Git.
> +#
> +# Copyright (C) 2012 Marc Khouzam <marc.khouzam@gmail.com>
> +# Distributed under the GNU General Public License, version 2.0.
> +#
> +# This script makes use of the git-completion.bash script to
> +# determine the proper completion for git commands under tcsh.
> +#
> +# To use this completion script:
> +#
> +#    1) Copy both this file and the bash completion script to your
> ${HOME} directory
> +#       using the names ${HOME}/.git-completion.tcsh and
> ${HOME}/.git-completion.bash.
> +#    2) Add the following line to your .tcshrc/.cshrc:
> +#        source ${HOME}/.git-completion.tcsh
> +
> +# One can change the below line to use a different location
> +set __git_tcsh_completion_script = ${HOME}/.git-completion.bash
> +
> +# Check that the user put the script in the right place
> +if ( ! -e ${__git_tcsh_completion_script} ) then
> +       echo "ERROR in git-completion.tcsh script.  Cannot find:
> ${__git_tcsh_completion_script}.  Git completion will not work."
> +       exit
> +endif
> +
> +# Make the script executable if it is not
> +if ( ! -x ${__git_tcsh_completion_script} ) then
> +       chmod u+x ${__git_tcsh_completion_script}
> +endif

Why not just source it?

> +complete git  'p/*/`${__git_tcsh_completion_script} "${COMMAND_LINE}"
> | sort | uniq`/'
> +complete gitk 'p/*/`${__git_tcsh_completion_script} "${COMMAND_LINE}"
> | sort | uniq`/'

This seems to be very different from bash's 'complete'. I wonder if
the 'complete' commands in the original script cause any problems.
Maybe only if you source it, but then again, I would expect a warning
or something when you run it.

But you can use the trick I did with zsh so you can source it:

complete ()
{
	# do nothing
	return 0
}

. "$script"

It looks like in your case you would need to save the old complete()
function though, or somehow restore it. If you go for this method, you
use the __*_main functions though.

Cheers.

-- 
Felipe Contreras
