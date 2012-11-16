From: Marc Khouzam <marc.khouzam@gmail.com>
Subject: Re: [PATCH] tcsh-completion re-using git-completion.bash
Date: Fri, 16 Nov 2012 09:39:45 -0500
Message-ID: <CAFj1UpEdft+L5KW+tMy6Lqm1eUkHQgwWuXaC0UTUdqwW=ohk-Q@mail.gmail.com>
References: <CAFj1UpHgPvdDeKZ-Ap7-aVx6p_pxT4a2F01ajmNa00txPyS=Qw@mail.gmail.com>
	<1352980269-15569-1-git-send-email-marc.khouzam@gmail.com>
	<CAMP44s0Guq0nYJEfbvNDyt8Oqaux-cXbTsyro6pxUnEpA4+XOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: szeder@ira.uka.de, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 15:40:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZN5L-00048P-QB
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 15:40:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633Ab2KPOjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 09:39:46 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57211 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503Ab2KPOjp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 09:39:45 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so3657431iea.19
        for <git@vger.kernel.org>; Fri, 16 Nov 2012 06:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Mr3s2JdLXEwpmX6t3ALf2J6HplJ5gukRh6uVMz7Tr/I=;
        b=x+p5s1lZPcxL4ycSWNJU7mRTQUZxaC080eXxA0Fz15iXKuQc/ry7rRNeCOFNVYLGeB
         6rhCfA/K/8rtMzN3Hs5SGuCNR0J6Y7BFwP2960Isn4qPQBaAv8RRmnBZgePafB1zOda0
         9jE8SQAWohz8NuTdj8jLh/tPQdI6QrE8rs9NGkMRdGI5vUV1l/XNpHUWTAB0kcY/va7p
         Hz2btAS9d4zK6Ybtpsj3CtsMD894jfs/wzsLb60r+5I3jrCoYjGdRb+mEbfZwWsIdgA4
         I5MLmJJDE8StvsjkSOsiIrB3zbUi/BwsMQRV+89BnK6v8rMzS04Wgq7lmjQxiHRN/oMu
         zRhw==
Received: by 10.50.195.130 with SMTP id ie2mr3463542igc.40.1353076785218; Fri,
 16 Nov 2012 06:39:45 -0800 (PST)
Received: by 10.64.132.39 with HTTP; Fri, 16 Nov 2012 06:39:45 -0800 (PST)
In-Reply-To: <CAMP44s0Guq0nYJEfbvNDyt8Oqaux-cXbTsyro6pxUnEpA4+XOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209878>

On Thu, Nov 15, 2012 at 8:41 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Thu, Nov 15, 2012 at 12:51 PM, Marc Khouzam <marc.khouzam@gmail.com> wrote:
>> The current tcsh-completion support for Git, as can be found on the
>> Internet, takes the approach of defining the possible completions
>> explicitly.  This has the obvious draw-back to require constant
>> updating as the Git code base evolves.
>>
>> The approach taken by this commit is to to re-use the advanced bash
>> completion script and use its result for tcsh completion.  This is
>> achieved by executing (versus sourcing) the bash script and
>> outputting the completion result for tcsh consumption.
>>
>> Three solutions were looked at to implement this approach with (A)
>> being retained:
>>
>>   A) Modifications:
>>           git-completion.bash and new git-completion.tcsh
>
> As I said, I don't think this is needed. It can be done in a single
> stand-alone script without modifications to git-completion.bash.
>
> This works:

Thank you for taking the time to try things out.

What you suggest below is an improvement on solution (C).
I had chosen (A) instead because (C) creates a third script
which gets generated each time a new shell is started.
It should be safe, but it felt a little wrong.
But I have to admit I was on the fence between the two
solutions.

If you guys don't think it is bad to generate a third script
(that the user may notice in his ${HOME}),
I'll post a new patch (and try once more to get gmail not to
replace the tabs with spaces), using your improved
solution (C).

> set called = ($_)

I fought with this a lot before posting to the list.
It seems that $_ is not set when a double sourcing
happens.  Testing the solution as an actual user
showed me that when I start a new shell it
sources ~/.tcshrc, which then sources ~/.git-completion.tcsh
and then $_ is empty for some reason.

I couldn't find another way to figure out where the script
is located, which is why I had to force the user to use
${HOME} for everything.

> set script = "${called[2]}.tmp"
>
> cat <<\EOF > $script
> source "$HOME/.git-completion.sh"

This is nice.  Shame on me not to have thought about it.
In my version I actually 'cat' the entire bash script into $script
instead of simply sourcing it.

> # Set COMP_WORDS in a way that can be handled by the bash script.
> COMP_WORDS=($1)
>
> # Set COMP_CWORD to the cursor location as bash would.
> if [ -n "${2-}" ]; then
>         COMP_CWORD=$2
> else

Since this code will be part of a tcsh-only script, I don't think
we need to prepare for a possible $2.  tcsh won't provide it.
So, I'll remove that logic, which will simplify things slightly.

>         # Assume the cursor is at the end of parameter #1.
>         # We must check for a space as the last character which will
>         # tell us that the previous word is complete and the cursor
>         # is on the next word.
>         if [ "${1: -1}" == " " ]; then
>                 # The last character is a space, so our location is at the end
>                 # of the command-line array
>                 COMP_CWORD=${#COMP_WORDS[@]}
>         else
>                 # The last character is not a space, so our location is on the
>                 # last word of the command-line array, so we must decrement the
>                 # count by 1
>                 COMP_CWORD=$((${#COMP_WORDS[@]}-1))
>         fi
> fi
>
> # Call _git() or _gitk() of the bash script, based on the first
> # element of the command-line
> _${COMP_WORDS[0]}
>
> IFS=$'\n'
> echo "${COMPREPLY[*]}"
> \EOF
>
> complete git  'p/*/`bash ${script} "${COMMAND_LINE}" | sort | uniq`/'
> complete gitk 'p/*/`bash ${script} "${COMMAND_LINE}" | sort | uniq`/'

I am worried about 'sort' and 'uniq' being aliased by the user, so I was
thinking of using '\sort | \uniq'

I'll work on the new version of the solution.

Thanks again

Marc
