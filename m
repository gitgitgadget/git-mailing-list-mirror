From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Add __git_ps1_pc to use as PROMPT_COMMAND
Date: Tue, 02 Oct 2012 09:38:06 +0200
Message-ID: <506A99DE.7080503@drmicha.warpmail.net>
References: <5064140E.50007@drmicha.warpmail.net> <50658C9B.6030809@nieuwland.nl> <7vipaym3ks.fsf@alter.siamese.dyndns.org> <50695ECE.5010101@nieuwland.nl> <7v626udse6.fsf@alter.siamese.dyndns.org> <7v4nmec8fi.fsf@alter.siamese.dyndns.org> <5069EE8D.6050200@nieuwland.nl> <7vr4piaryi.fsf@alter.siamese.dyndns.org> <506A0366.6030009@xs4all.nl> <7va9w5c31w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Simon Oosthoek <s.oosthoek@xs4all.nl>,
	Simon Oosthoek <soosthoek@nieuwland.nl>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	schwab@linux-m68k.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 09:38:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIx3d-0004Ra-JD
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 09:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041Ab2JBHiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 03:38:11 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33287 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752951Ab2JBHiK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Oct 2012 03:38:10 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 7EBC2200BF;
	Tue,  2 Oct 2012 03:38:08 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Tue, 02 Oct 2012 03:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=iNAVn3CNNeXgP6xJmaOB5F
	VcT2I=; b=o1Jl+yEm5ZOxM4slYSj2VmFrmBPN8/ersNzuw1o4icUEzMJeGSD/0e
	UdLhLoZ85KIqagIePaL/QLau6LWpbf6aVFKEWy9T63SaA7iCnfTqNMefGA78shZK
	B2i7EzRzCZmCxxU/fThNrKPJrQM/fVkfJ7JXaXvXFmVmwndcV+L7U=
X-Sasl-enc: H2xd7uwhxUCW5sOaSmR/e6CtGxJQ/AJChtBoCOE+jcZZ 1349163488
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 51B254827BB;
	Tue,  2 Oct 2012 03:38:07 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120911 Thunderbird/15.0.1
In-Reply-To: <7va9w5c31w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206787>

Junio C Hamano venit, vidit, dixit 01.10.2012 23:09:
> Simon Oosthoek <s.oosthoek@xs4all.nl> writes:
> 
>> It's possible to set PS1 to nothing and print a string from
>> PROMPT_COMMAND, but then you miss out on all the features of the PS1
>> interpretation by bash and compared to the use of __git_ps1 at the
>> moment, it has to put out quite a different string. Because if you like
>> to see user@host+workdir (git-status)[$#]
>> the current users of __git_ps1 say PS1="\u@host+\w $(__git_ps1 "%s")\$
>> ", but all __git+ps1 has to put out is "(branch)" or "(branch *)", etc.
>>
>> If it has to print the same prompt in PC mode, it has to add all the
>> user/host/workdir/[$#] data as well, withouth being able to use the bash
>> internal interpretation (because that is only working when PS1 is set).
> 
> The longer I read your explanation, the less useful the "PC mode"
> sounds like, at least to me.  So why does an user even want to use
> such a mechanism, instead of PS1?  And even if the user wants to use
> it by doing \w, \u etc. himself, she can do that with
> 
> 	PROMPT_COMMAND='
> 		PS1=$(printf "\u \h \w %s$ " $(__git_ps1 "%s"))
>         '
> 
> just fine, no?
> 
> So I still do not see the problem, even taking your "Set PS1 in the
> command, without spitting anything out of the command" use case into
> account.
> 
> Confused....
> 

The "problem" (as far as I see) is only: What user interface do we want
to expose to the user, or rather, do we want to expose the user to ;)

So far, we say:

#    1) Copy this file to somewhere (e.g. ~/.git-prompt.sh).
#    2) Add the following line to your .bashrc/.zshrc:
#        source ~/.git-prompt.sh
#    3) Change your PS1 to also show the current branch:
#         Bash: PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
#         ZSH:  PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '

(That's incomplete for zsh, but I'm digressing...). With the above, we
would change the bash instruction to

PROMPT_COMMAND='
	PS1=$(printf "\u \h \w %s$ " $(__git_ps1 "%s"))
       '

which may look more complicated to some. I think we can aim for
something like

PROMPT_COMMAND='__git_ps1_color "\u \h \w%s$ " " (%s)"'

so that the first arg is a PS1 string, %s there gets replaced by the git
prompt (if any), and the second arg defines the formatting of the git
prompt. This makes the "ui" (what you have to set the shells vars to) as
simple as possible.

As I said, I had done some fixes and refactoring to that effect already,
but I'm not going to race Simon.

Michael
