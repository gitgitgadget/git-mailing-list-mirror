From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: Fwd: [PATCH] Add tcsh-completion support to contrib by using
 git-completion.bash
Date: Tue, 13 Nov 2012 12:14:48 +0100
Message-ID: <20121113111448.GA3817@goldbirke>
References: <CAFj1UpE6OtJEojaED1_DZJD0kU=nVsFE_w8xa0oJE-6auCU2rw@mail.gmail.com>
 <CAFj1UpFd9X8Jq5o7B4m35i=merBDvOo4NOtwth=UnG2S5X_rGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Marc Khouzam <marc.khouzam@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 12:15:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYET2-0005l3-Ui
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 12:15:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125Ab2KMLOz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Nov 2012 06:14:55 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:52589 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755118Ab2KMLOv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 06:14:51 -0500
Received: from localhost6.localdomain6 (p5B13079E.dip0.t-ipconnect.de [91.19.7.158])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0LnYoV-1T6bbi2jfD-00hzC0; Tue, 13 Nov 2012 12:14:49 +0100
Content-Disposition: inline
In-Reply-To: <CAFj1UpFd9X8Jq5o7B4m35i=merBDvOo4NOtwth=UnG2S5X_rGw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:0fwQwSrwa0OHPErSM3YuDfg89ggdy8I7YJdGB4yZCL7
 zVUEHj9KxJYLvUYZzhcXmkw8eJYn9mXpuk8mrQfbN7nN0V2Jpl
 vMX6BOrccwLedL3UrusuEDvUzMzmrJK3WnOo55ORyzptyELh37
 ctBFAO9nZ6gyDjltDRrmjtKDlvdiqa4uokIbwxOp8h+8ytb22P
 KHEP6eqEif8+mk9WJS0ohuwjnjPXz1/S76btgFw4n9PU/37H/t
 Rc3D0lCmuisgNlBrQl6LbnCRnL8FqJspQr2bcKIiEnF1ZjSDAQ
 xOVmeAkaP3WiBc2qk1oFnF6JqYwgANNfRKTVdoBmTjxGqXnLLQ
 /HYhm9SL9mLO1slLImDg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209597>

Hi,

On Mon, Nov 12, 2012 at 03:07:46PM -0500, Marc Khouzam wrote:
> Hi,

[...]

> Signed-off-by: Marc Khouzam <marc.khouzam@gmail.com>

[...]

> Thanks
>=20
> Marc
>=20
> ---
>  contrib/completion/git-completion.bash |   53 ++++++++++++++++++++++=
+++++++++-
>  contrib/completion/git-completion.tcsh |   34 ++++++++++++++++++++
>  2 files changed, 86 insertions(+), 1 deletions(-)
>  create mode 100755 contrib/completion/git-completion.tcsh

Please have a look at Documentation/SubmittingPatches to see how to
properly format the commit message, i.e. no greeting and sign-off in
the commit message part, and the S-o-b line should be the last before
the '---'.

Your patch seems to be severely line-wrapped.  That document also
contains a few MUA-specific tips to help avoid that.

Other than that, it's a good description of the changes and
considerations.  I agree that this approach seems to be the best from
the three.

> diff --git a/contrib/completion/git-completion.bash
> b/contrib/completion/git-completion.bash
> index be800e0..6d4b57a 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1,4 +1,6 @@
> -#!bash
> +#!/bin/bash
> +# The above line is important as this script can be executed when us=
ed
> +# with another shell such as tcsh

See comment near the end.

>  #
>  # bash/zsh completion support for core Git.
>  #
> @@ -2481,3 +2483,52 @@ __git_complete gitk __gitk_main
>  if [ Cygwin =3D "$(uname -o 2>/dev/null)" ]; then
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
> +       COMP_WORDS=3D($1)

That comment is only true for older Bash versions.  Since v4 Bash
splits the command line at characters that the readline library treats
as word separators when performing word completion.  But the
completion script has functions to deal with both, so this shouldn't
be a problem.

> +
> +       # Set COMP_CWORD to the cursor location as bash would.
> +       if [ -n "$2" ]; then
> +               COMP_CWORD=3D$2
> +       else
> +               # Assume the cursor is at the end of parameter #1.
> +               # We must check for a space as the last character whi=
ch will
> +               # tell us that the previous word is complete and the =
cursor
> +               # is on the next word.
> +               if [ "${1: -1}" =3D=3D " " ]; then
> +                       # The last character is a space, so our
> location is at the end
> +                       # of the command-line array
> +                       COMP_CWORD=3D${#COMP_WORDS[@]}
> +               else
> +                       # The last character is not a space, so our
> location is on the
> +                       # last word of the command-line array, so we
> must decrement the
> +                       # count by 1
> +                       COMP_CWORD=3D$((${#COMP_WORDS[@]}-1))
> +               fi
> +       fi
> +
> +       # Call _git() or _gitk() of the bash script, based on the fir=
st
> +       # element of the command-line
> +       _${COMP_WORDS[0]}
> +
> +       # Print the result that is stored in the bash variable ${COMP=
REPLY}

Really? ;)

I like the above comments about setting COMP_CWORD, because they
explain why you do what you do, which would be otherwise difficult to
figure out.  But telling that an echo in a for loop over an array
prints that array is, well, probably not necessary.

> +       for i in ${COMPREPLY[@]}; do
> +               echo "$i"
> +       done

There is no need for the loop here to print the array one element per
line:

        local IFS=3D$'\n'
        echo "${COMPREPLY[*]}"

> +}
> +
> +if [ -n "$1" ] ; then
> +  # If there is an argument, we know the script is being executed
> +  # so go ahead and run the _git_complete_with_output function
> +  _git_complete_with_output "$1" "$2"

Where does the second argument come from?  Below you run this script
as '${__git_tcsh_completion_script} "${COMMAND_LINE}"', i.e. $2 is
never set.  Am I missing something?

> +fi
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
> +set __git_tcsh_completion_script =3D ${HOME}/.git-completion.bash
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

Not sure about this.  If I source a script to provide completion for a
command, then I definitely don't expect it to change file permissions.

However, even if the git completion script is not executable, you can
still run it with 'bash ${__git_tcsh_completion_script}'.  This way
neither the user would need to set permissions, not the script would
need to set it behind the users back.  Furthermore, this would also
make changing the shebang line unnecessary.

> +
> +complete git  'p/*/`${__git_tcsh_completion_script} "${COMMAND_LINE}=
"
> | sort | uniq`/'
> +complete gitk 'p/*/`${__git_tcsh_completion_script} "${COMMAND_LINE}=
"
> | sort | uniq`/'

Is the 'sort | uniq' really necessary?  After the completion function
returns Bash automatically sorts the elements in COMPREPLY and removes
any duplicates.  Doesn't tcsh do the same?  I have no idea about tcsh
completion.

Does the git completion script returns any duplicates at all?
Ambigious refs come to mind, but I just checked that refs completion,
or rather 'git for-each-ref' (the command driving refs completion), is
kind enough to make any ambigious ref names unique (i.e. a branch and
a tag with the same name is listed as 'heads/name' and 'tags/name').


Thanks,
G=E1bor
