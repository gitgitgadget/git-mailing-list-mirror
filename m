From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add __git_ps1_pc to use as PROMPT_COMMAND
Date: Mon, 01 Oct 2012 12:54:29 -0700
Message-ID: <7vr4piaryi.fsf@alter.siamese.dyndns.org>
References: <5064140E.50007@drmicha.warpmail.net>
 <50658C9B.6030809@nieuwland.nl> <7vipaym3ks.fsf@alter.siamese.dyndns.org>
 <50695ECE.5010101@nieuwland.nl> <7v626udse6.fsf@alter.siamese.dyndns.org>
 <7v4nmec8fi.fsf@alter.siamese.dyndns.org> <5069EE8D.6050200@nieuwland.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, s.oosthoek@xs4all.nl,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	schwab@linux-m68k.org
To: Simon Oosthoek <soosthoek@nieuwland.nl>
X-From: git-owner@vger.kernel.org Mon Oct 01 21:54:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIm4h-0004VO-1z
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 21:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753675Ab2JATyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 15:54:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37937 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753324Ab2JATyc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 15:54:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AF91941B;
	Mon,  1 Oct 2012 15:54:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N0OIbkTqdC9uFWc2g0TQ2Cq/hZ8=; b=gvLj7D
	jMrOesmsz0NzWTBnxAAgJty+UwoOZxCeRKFxzAAan3MWJk+g/wBs+0lIA3zVyHLM
	MLck0zp89atJ+8BuWS9zknEkOuxMWsmwBzOZiKqQyjm0V/DXzGB2bLSj9MCxtjEO
	sq+eFvo9jXzOgWbmMK00qtdlJ5S+F4eB37v1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uoSEARtWEkFDz/HR+YH0jdaKn/lMvXRa
	15rK3tNxngfgLckrDqOVldk/aKeKzlFk7ZMj5wLAGXW5X9qUVwvMocaUMezugXHN
	cJUp7CnW13j4DX2iuY/rfK3Sxh+4z7gU4mpP8ym9aEZiiLghL7FKn7UrTCBdHwST
	iU8gYMIK/wE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6698F941A;
	Mon,  1 Oct 2012 15:54:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D28119419; Mon,  1 Oct 2012
 15:54:30 -0400 (EDT)
In-Reply-To: <5069EE8D.6050200@nieuwland.nl> (Simon Oosthoek's message of
 "Mon, 01 Oct 2012 21:27:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D09B5EA8-0C01-11E2-AF41-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206762>

Simon Oosthoek <soosthoek@nieuwland.nl> writes:

> On 01/10/12 21:13, Junio C Hamano wrote:
>
>> Hrm, let me ask a stupid question.  Why do we even need __git_ps1_pc
>> in the first place?  Wouldn't it be just the matter of
>> 
>> 	PROMPT_COMMAND='__git_ps1 "%s"'
>> 
>> once you have __git_ps1 that works?
>
> Apart from one small detail, PS1 must be set directly when __git_ps1 is
> called as a PROMPT_COMMAND, while in command substitution mode,
> __git_ps1 needs to put out a string value to substitute...

Now you lost me.  The documentation of PROMPT_COMMAND in "man bash"
says this:

       PROMPT_COMMAND
              If set, the value is executed as a command prior to
              issuing each primary prompt.

So yes, if you say "PROMPT_COMMAND='whatever'", you will get output
from 'whatever' followed by what $PS1 would normally give you.  
If you do not want to see PS1 after 'whatever' gives you, you have
to set it to an empty string.

On the other hand, they way people have been using __git_ps1 is (as
described in the prompt script) to do something like this:

	PS1='...cruft... $(__git_ps1 "%s") ...cruft...'

To keep supporting them, __git_ps1 has to be a function that writes
the prompt string to its standard output.  The external interface of
PROMPT_COMMAND also is that it wants a command that emits the string
desired for the prompt to its standard output.  I do not see any
"when it is used like this, X, but when it is used like that, Y"
kind of issue around it, either.

So what is the problem????
