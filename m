From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: bash completion with colour hints
Date: Thu, 27 Sep 2012 10:53:34 +0200
Message-ID: <5064140E.50007@drmicha.warpmail.net>
References: <50631885.8090604@nieuwland.nl> <CALkWK0=9KKZvvNFoLUNRKWkfrqR7+RByYaWP9XXg7Pd3ym7CUQ@mail.gmail.com> <506356AA.3050005@nieuwland.nl> <7vfw64rm6s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Simon Oosthoek <soosthoek@nieuwland.nl>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 10:53:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TH9qt-0005dA-BG
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 10:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736Ab2I0Ixi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 04:53:38 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47482 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752482Ab2I0Ixg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Sep 2012 04:53:36 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id CDD7E2079A;
	Thu, 27 Sep 2012 04:53:35 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Thu, 27 Sep 2012 04:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=xhjR9jRDVmXb2+UYTO44d7
	NmgAM=; b=cWNo6704zONKV0mmzRBzzS5mxWuj92X8WN1mcVIWL124rxwz1yyav5
	I2Serp/lE+IjgnFc3ptJPACClvS9/GdvGI/tZCzGc4WBK3SSxqUVhQ/lVQ2TybuI
	y6XS2mCuUZqddbgwSCBuRAnnmZgCzM1TSDTAJ6f7LbCdU68vrffAw=
X-Sasl-enc: lCT8cGhdZKRK+GDgqXAFrUOqjfef3qZ/vaplcyZpPPAj 1348736015
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id F1505482708;
	Thu, 27 Sep 2012 04:53:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7vfw64rm6s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206470>

Junio C Hamano venit, vidit, dixit 27.09.2012 08:53:
> Simon Oosthoek <soosthoek@nieuwland.nl> writes:
> 
>> I read the guide and now I have some questions:
>>
>> - It suggests to use the oldest commit that contains the "bug" and can
>> support the fix. This would be the very first mention of __git_ps1
>> function I think commit d3d717a4ad0c8d7329e79f7d0313baec57c6b585
> 
> You could claim that the lack of coloring is a bug, but nobody
> complained about it so far (and I personally hate coloring in
> prompts as they are distracting noise, and would reject a patch if
> it weren't made conditional), so I would think this is more about
> "adding a feature the users can choose to use but they do not have
> to".
> 
> We do not usually add new features to maintenance tracks, so the
> result of applying the patch does not have to be merge-able to maint
> or amything older.  I would base the patch on v1.7.12 (the latest
> stable release) if I were you.
> 
>> - I read that git-prompt.sh is meant to support bash and zsh, I have
>> only tested it on bash. Should I attempt to test it on zsh or is there a
>> kind person with zsh as his/her shell to test it for me?

Actually, the instructions in the prompt script are not complete for zsh
(you need to activate expansion in the prompt), and I think there is
some breakage because bash uses "\h" etc. for PS1 format specifiers
whereas zsh uses '%h', and so the '%' in the prompt is a problem for zsh.

> That is something you should ask on list, like you did here, but the
> most effective way to do so is do so when you send a patch you
> worked on and tested with bash.  Say "I've tested it only with bash;
> can you please take a look?" and Cc the folks you find in the output
> of "git log contrib/completion/" who worked on making it workable
> with zsh.
> 

Additionally, there have been several attempts already for prompt. So
I'd suggest you check the list archives to see whether you addressed the
issues which were raised back then. I've actually been toying with that
myself lately. A few hints:

- You need to escape the escapes '\[', i.e. tell the shell that color
escapes produce zero length output, or else line wrapping is distorted.

- Bash interpretes '\' only when PS1 is assigned, not when an expansion
in PS1 produces it.

- Some don't like it colorful, so the coloring needs to depend on a
config setting or env variable.

- Coloring should be consistent with other coloring in Git, such as
'status -s -b'.

- Coloring provides the way to make the prompt characters analogous to
'status -s -b' because a green 'M' is different from red 'M', and is
much clearer then having to remember '+' vs. '*' (so there is a logic in
that).

>From trying myself, I'm convinced that you need a clever combination of
PROMPT_COMMAND and PS1 to make this work. Setting PS1 in PROMPT_COMMAND
is probably a no-go because that makes it difficult to customize PS1. I
have something in the works which reproduces the current prompt but need
to clean it up further. The actual coloring would require setting a lot
of variables which communicate data from PROMPT_COMMAND to PS1, and I
actually don't like that.

An alternative approach would be:

- Tell users to activate git prompt by doing something like

PROMPT_COMMAND='__git_prompt "[\u@\h \W (%s)]\$ '

rather than the current

PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

- set PS1 from __git_prompt

I'm not sure about the performance implications of re-setting PS1 on
(before) each prompt invocation, though. Would that be OK?

Michael
