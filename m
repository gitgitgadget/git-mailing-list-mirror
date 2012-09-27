From: Simon Oosthoek <soosthoek@nieuwland.nl>
Subject: Re: bash completion with colour hints
Date: Thu, 27 Sep 2012 11:16:57 +0200
Message-ID: <50641989.6060001@nieuwland.nl>
References: <50631885.8090604@nieuwland.nl> <CALkWK0=9KKZvvNFoLUNRKWkfrqR7+RByYaWP9XXg7Pd3ym7CUQ@mail.gmail.com> <506356AA.3050005@nieuwland.nl> <7vfw64rm6s.fsf@alter.siamese.dyndns.org> <5064140E.50007@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Sep 27 11:17:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THADg-0007gn-Tu
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 11:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755Ab2I0JRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 05:17:10 -0400
Received: from mail.nieuwland.nl ([87.251.35.136]:56406 "HELO nieuwland.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754609Ab2I0JRI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 05:17:08 -0400
Received: (qmail 26166 invoked by uid 453); 27 Sep 2012 09:17:01 -0000
X-Virus-Checked: Checked by ClamAV on nieuwland.nl
Received: from Unknown (HELO [192.168.216.232]) (192.168.216.232)
  (smtp-auth username soosthoek, mechanism plain)
  by nieuwland.nl (qpsmtpd/0.83) with (AES256-SHA encrypted) ESMTPSA; Thu, 27 Sep 2012 11:17:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <5064140E.50007@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206472>

On 09/27/2012 10:53 AM, Michael J Gruber wrote:
>> We do not usually add new features to maintenance tracks, so the
>> result of applying the patch does not have to be merge-able to maint
>> or amything older.  I would base the patch on v1.7.12 (the latest
>> stable release) if I were you.
>>

I now have a patch based on 1.7.12

>>> - I read that git-prompt.sh is meant to support bash and zsh, I have
>>> only tested it on bash. Should I attempt to test it on zsh or is there a
>>> kind person with zsh as his/her shell to test it for me?
>
> Actually, the instructions in the prompt script are not complete for zsh
> (you need to activate expansion in the prompt), and I think there is
> some breakage because bash uses "\h" etc. for PS1 format specifiers
> whereas zsh uses '%h', and so the '%' in the prompt is a problem for zsh.

The only feature using it is untracked files, so that should probably be 
changed to work with zsh?

>
> Additionally, there have been several attempts already for prompt. So
> I'd suggest you check the list archives to see whether you addressed the
> issues which were raised back then. I've actually been toying with that
> myself lately. A few hints:

This would take me too much time

>
> - You need to escape the escapes '\[', i.e. tell the shell that color
> escapes produce zero length output, or else line wrapping is distorted.

A: this is something I've run into with my own contraption and I'm not 
sure I fixed it with my patch :-(

Can you give a more complete example of how that should work?

>
> - Bash interpretes '\' only when PS1 is assigned, not when an expansion
> in PS1 produces it.

is that true? how can \w produce the current working dir in the prompt?
Or do you mean it is translated to $PWD in some form internally?

>
> - Some don't like it colorful, so the coloring needs to depend on a
> config setting or env variable.

It is.

>
> - Coloring should be consistent with other coloring in Git, such as
> 'status -s -b'.

That would be nice, I suppose the coloring is configurable for git, so 
the values would need to be dynamically imported from the git config. I 
don't know how to do that.

>
> - Coloring provides the way to make the prompt characters analogous to
> 'status -s -b' because a green 'M' is different from red 'M', and is
> much clearer then having to remember '+' vs. '*' (so there is a logic in
> that).

Are you suggesting to use M instead of * or +? wouldn't that interfere 
with branchnames?

>
>  From trying myself, I'm convinced that you need a clever combination of
> PROMPT_COMMAND and PS1 to make this work. Setting PS1 in PROMPT_COMMAND
> is probably a no-go because that makes it difficult to customize PS1. I
> have something in the works which reproduces the current prompt but need
> to clean it up further. The actual coloring would require setting a lot
> of variables which communicate data from PROMPT_COMMAND to PS1, and I
> actually don't like that.

I think it should be possible in PS1 only.

>
> An alternative approach would be:
>
> - Tell users to activate git prompt by doing something like
>
> PROMPT_COMMAND='__git_prompt "[\u@\h \W (%s)]\$ '
>
> rather than the current
>
> PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
>
> - set PS1 from __git_prompt
>
> I'm not sure about the performance implications of re-setting PS1 on
> (before) each prompt invocation, though. Would that be OK?

I doubt you can set PS1 from a function (effectively a subshell?)

Thanks for your comments

I will send an updated patch later....

/Simon
