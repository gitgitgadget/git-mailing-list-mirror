From: Marc Khouzam <marc.khouzam@gmail.com>
Subject: Re: [PATCH] Add tcsh-completion support to contrib by using git-completion.bash
Date: Tue, 13 Nov 2012 22:36:24 -0500
Message-ID: <CAFj1UpEB5TqQKmEDoPY-nH5d+Ki_0R70Jd=WXtkxEj-emHEfaA@mail.gmail.com>
References: <CAFj1UpE6OtJEojaED1_DZJD0kU=nVsFE_w8xa0oJE-6auCU2rw@mail.gmail.com>
	<CAFj1UpFd9X8Jq5o7B4m35i=merBDvOo4NOtwth=UnG2S5X_rGw@mail.gmail.com>
	<CAMP44s3imos4DksroRkZ3K6una5H916gvtqttJQna8yGG8XhsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 04:36:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYTmK-00089p-UP
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 04:36:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514Ab2KNDg0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Nov 2012 22:36:26 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36617 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932486Ab2KNDgZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Nov 2012 22:36:25 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so11884190iea.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 19:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=8Skp/MtyEJs+5K2j7KC+WZjULvUUOHUCHijQqtUrPzI=;
        b=EnfDoSIX5x4+ZeM8TTLSJMTpG75Sk5JEHFguVKGqQycOGQMweQaJZ4L095OoAV0USi
         XkMNWwa2RG6Ss6Ktx6m+o42t9Jhzt7R0qYx2fYVjo4v0g0wbOUj5YAGKXChxJjPwyXLr
         grLLiQvhZR2G20iMSfSo7mluJNECybClnk5HxFJfIkFMywqi/nCcOsyfMlySdf+wdu1L
         ryEsO5cZynV7Sf0bUZyLU3OaDFVhc+hGkyKBrHuoTGrnvd1NX4Hcy4mYC3Bwot9kjoTt
         /ijvxNyR/BYRmJC5ZEU2qNthtYk/C9Q3wcmGnlWkyKJCLJzkffAxhbbw0JfLagAv+BNq
         C/RA==
Received: by 10.50.6.129 with SMTP id b1mr578485iga.23.1352864185012; Tue, 13
 Nov 2012 19:36:25 -0800 (PST)
Received: by 10.64.132.39 with HTTP; Tue, 13 Nov 2012 19:36:24 -0800 (PST)
In-Reply-To: <CAMP44s3imos4DksroRkZ3K6una5H916gvtqttJQna8yGG8XhsQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209694>

Thanks for the review.  I wasn't aware that you were doing
a similar effort for zsh.

On Tue, Nov 13, 2012 at 1:31 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Mon, Nov 12, 2012 at 9:07 PM, Marc Khouzam <marc.khouzam@gmail.com=
> wrote:
>
>> this patch allows tcsh-users to get the benefits of the awesome
>> git-completion.bash script.  It could also help other shells do the =
same.
>
> Maybe you can try to take a look at the same for zsh:
> http://article.gmane.org/gmane.comp.version-control.git/208173

Cool.  The major difference is that (as G=E1bor mentioned) zsh understa=
nds bash
syntax but tcsh does not.  tcsh doesn't even allow to define
functions.  So we have
to take a different approach to get the bash completion script to be
used by tcsh.

>> ---
>>  contrib/completion/git-completion.bash |   53 +++++++++++++++++++++=
++++++++++-
>>  contrib/completion/git-completion.tcsh |   34 ++++++++++++++++++++
>>  2 files changed, 86 insertions(+), 1 deletions(-)
>>  create mode 100755 contrib/completion/git-completion.tcsh
>>
>> diff --git a/contrib/completion/git-completion.bash
>> b/contrib/completion/git-completion.bash
>> index be800e0..6d4b57a 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -1,4 +1,6 @@
>> -#!bash
>> +#!/bin/bash
>> +# The above line is important as this script can be executed when u=
sed
>> +# with another shell such as tcsh
>>  #
>>  # bash/zsh completion support for core Git.
>>  #
>> @@ -2481,3 +2483,52 @@ __git_complete gitk __gitk_main
>>  if [ Cygwin =3D "$(uname -o 2>/dev/null)" ]; then
>>  __git_complete git.exe __git_main
>>  fi
>> +
>> +# Method that will output the result of the completion done by
>> +# the bash completion script, so that it can be re-used in another
>> +# context than the bash complete command.
>> +# It accepts 1 to 2 arguments:
>> +# 1: The command-line to complete
>> +# 2: The index of the word within argument #1 in which the cursor i=
s
>> +#    located (optional). If parameter 2 is not provided, it will be
>> +#    determined as best possible using parameter 1.
>> +_git_complete_with_output ()
>> +{
>> +       # Set COMP_WORDS to the command-line as bash would.
>> +       COMP_WORDS=3D($1)
>> +
>> +       # Set COMP_CWORD to the cursor location as bash would.
>> +       if [ -n "$2" ]; then
>> +               COMP_CWORD=3D$2
>> +       else
>> +               # Assume the cursor is at the end of parameter #1.
>> +               # We must check for a space as the last character wh=
ich will
>> +               # tell us that the previous word is complete and the=
 cursor
>> +               # is on the next word.
>> +               if [ "${1: -1}" =3D=3D " " ]; then
>> +                       # The last character is a space, so our
>> location is at the end
>> +                       # of the command-line array
>> +                       COMP_CWORD=3D${#COMP_WORDS[@]}
>> +               else
>> +                       # The last character is not a space, so our
>> location is on the
>> +                       # last word of the command-line array, so we
>> must decrement the
>> +                       # count by 1
>> +                       COMP_CWORD=3D$((${#COMP_WORDS[@]}-1))
>> +               fi
>> +       fi
>> +
>> +       # Call _git() or _gitk() of the bash script, based on the fi=
rst
>> +       # element of the command-line
>> +       _${COMP_WORDS[0]}
>
> You might want to use __${COMP_WORDS[0]}_main instead.
>
>> +
>> +       # Print the result that is stored in the bash variable ${COM=
PREPLY}
>> +       for i in ${COMPREPLY[@]}; do
>> +               echo "$i"
>> +       done
>> +}
>> +
>> +if [ -n "$1" ] ; then
>> +  # If there is an argument, we know the script is being executed
>> +  # so go ahead and run the _git_complete_with_output function
>> +  _git_complete_with_output "$1" "$2"
>> +fi
>
> Why do you need this function in this file? You can very easily add
> this function to git-completion.tcsh.

tcsh does not allow to define functions, so it is not aware of any
of the git-completion.bash functions.  So, git-completion.tcsh
cannot call anything from git-completion.bash.

>> diff --git a/contrib/completion/git-completion.tcsh
>> b/contrib/completion/git-completion.tcsh
>> new file mode 100755
>> index 0000000..7b7baea
>> --- /dev/null
>> +++ b/contrib/completion/git-completion.tcsh
>> @@ -0,0 +1,34 @@
>> +#!tcsh
>> +#
>> +# tcsh completion support for core Git.
>> +#
>> +# Copyright (C) 2012 Marc Khouzam <marc.khouzam@gmail.com>
>> +# Distributed under the GNU General Public License, version 2.0.
>> +#
>> +# This script makes use of the git-completion.bash script to
>> +# determine the proper completion for git commands under tcsh.
>> +#
>> +# To use this completion script:
>> +#
>> +#    1) Copy both this file and the bash completion script to your
>> ${HOME} directory
>> +#       using the names ${HOME}/.git-completion.tcsh and
>> ${HOME}/.git-completion.bash.
>> +#    2) Add the following line to your .tcshrc/.cshrc:
>> +#        source ${HOME}/.git-completion.tcsh
>> +
>> +# One can change the below line to use a different location
>> +set __git_tcsh_completion_script =3D ${HOME}/.git-completion.bash
>> +
>> +# Check that the user put the script in the right place
>> +if ( ! -e ${__git_tcsh_completion_script} ) then
>> +       echo "ERROR in git-completion.tcsh script.  Cannot find:
>> ${__git_tcsh_completion_script}.  Git completion will not work."
>> +       exit
>> +endif
>> +
>> +# Make the script executable if it is not
>> +if ( ! -x ${__git_tcsh_completion_script} ) then
>> +       chmod u+x ${__git_tcsh_completion_script}
>> +endif
>
> Why not just source it?
>
>> +complete git  'p/*/`${__git_tcsh_completion_script} "${COMMAND_LINE=
}"
>> | sort | uniq`/'
>> +complete gitk 'p/*/`${__git_tcsh_completion_script} "${COMMAND_LINE=
}"
>> | sort | uniq`/'
>
> This seems to be very different from bash's 'complete'. I wonder if
> the 'complete' commands in the original script cause any problems.
> Maybe only if you source it, but then again, I would expect a warning
> or something when you run it.

If you source the script under tcsh it will fail miserably because the =
bash
syntax is very different.  But when you run it, it runs under the bash =
shell
so everything will work fine.  The 'complete' command in the bash scrip=
t
will run, but will only affect the temporary bash shell that was starte=
d
to run the script.  Useless but harmless.

> But you can use the trick I did with zsh so you can source it:
>
> complete ()
> {
>         # do nothing
>         return 0
> }
>
> . "$script"

This is pretty cool.  Function overriding in shell scripts!  tcsh doesn=
't
even have functions, so that trick is out of its league :)

Thanks

Marc
