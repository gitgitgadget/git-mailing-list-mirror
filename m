From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: Fwd: [PATCH] Add tcsh-completion support to contrib by using
 git-completion.bash
Date: Wed, 14 Nov 2012 01:09:09 +0100
Message-ID: <20121114000909.GA14953@goldbirke>
References: <CAFj1UpE6OtJEojaED1_DZJD0kU=nVsFE_w8xa0oJE-6auCU2rw@mail.gmail.com>
 <CAFj1UpFd9X8Jq5o7B4m35i=merBDvOo4NOtwth=UnG2S5X_rGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Marc Khouzam <marc.khouzam@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 01:09:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYQXv-0007TL-DP
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 01:09:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756083Ab2KNAJO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Nov 2012 19:09:14 -0500
Received: from moutng.kundenserver.de ([212.227.17.8]:65017 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756039Ab2KNAJM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 19:09:12 -0500
Received: from localhost6.localdomain6 (p5B13079E.dip0.t-ipconnect.de [91.19.7.158])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0Ll0b7-1T0TER1bCH-00bCRB; Wed, 14 Nov 2012 01:09:10 +0100
Content-Disposition: inline
In-Reply-To: <CAFj1UpFd9X8Jq5o7B4m35i=merBDvOo4NOtwth=UnG2S5X_rGw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:q/l4472d4nM6HEzcbdBkk4/rQBjQnSH3nHi47bEPDRm
 TXPIlAPT52f+BlobB80URdCM/0EggkXG+1V+7bvtGWTur76hSW
 5GdbIWxlZ8iFn0PYhh66uBkFV5VTHWN+/68VRXZldMkgbh5eNi
 tCN6SlzUZX6vhXZMTJRoL4BM2rslmHkviLBc4QOG9ZGbeupA2j
 RbWBxWpBL/sCe054vaH7YHnu/RaPcKaIsmnD/dUc0KLptQl/1O
 51mSOXiB0k2XMw6MeiFWMCHYnCXbpU0knrWWfn2ADwf9DvMtUr
 OpK6hTOu8O6TocmmAqtksBjauknJXwcO/LETbEty0vC0AUDgcF
 tuWxqKFZFLXGfNR0Hu5aKnK19Yqv0hNmsi1u7w/Sh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209689>

Hi,


I've got two more comments.

On Mon, Nov 12, 2012 at 03:07:46PM -0500, Marc Khouzam wrote:
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

We differentiate between _git_whatever() and __git_whatever()
functions.  The former performs completion for the 'whatever' git
command/alias, the latter is a completion helper function.  This
is a helper function, so it should begin with double underscores.

> +{
> +       # Set COMP_WORDS to the command-line as bash would.
> +       COMP_WORDS=3D($1)
> +
> +       # Set COMP_CWORD to the cursor location as bash would.
> +       if [ -n "$2" ]; then

A while ago the completion script was made 'set -u'-clean.  (If 'set
-u' is enabled, then it's an error to access undefined variables).
I'm not sure how many people are out there who'd use this script for
tcsh while having 'set -u' in their profile...  probably not that
many.  Still, I think it would be great to keep it up.

Here $2 would be undefined, so accessingit it would cause an error
under those semantincs.  Please use ${2-} instead (use empty string
when undefined).

> +if [ -n "$1" ] ; then

Same here.

> +  # If there is an argument, we know the script is being executed
> +  # so go ahead and run the _git_complete_with_output function
> +  _git_complete_with_output "$1" "$2"

And here.

Thanks
G=E1bor
