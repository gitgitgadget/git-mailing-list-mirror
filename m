From: "Tilo Schwarz" <tilo@tilo-schwarz.de>
Subject: Re: How to manage parameter files and code separately using git?
Date: Sun, 02 May 2010 11:18:30 +0200
Message-ID: <op.vb2ms4r8a8ed4e@dellschleppa>
References: <op.vb0195s1a8ed4e@dellschleppa>
 <7vmxwj5ym8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 02 11:18:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8VJw-0001Iq-2r
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 11:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756196Ab0EBJSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 05:18:35 -0400
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:24341 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756182Ab0EBJSe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 05:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1272791912; l=3091;
	s=domk; d=tilo-schwarz.de;
	h=In-Reply-To:From:Content-Transfer-Encoding:MIME-Version:Date:
	References:Subject:To:Content-Type:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=O2ykRSwKJNflaSsBg3G1cCnorv4=;
	b=As3dOQ6XuqDwsFteCBG2asNHqUpPWFQlQ3Poj5n4IfdG5HJx+xx92S5jl04tlJ9lUmK
	5qRIp5PFnz5xOF/1jAuYXXjqhbluRlNW4/WrHLePda2znjdBrDp4wOCiGyH96b4Nwkes1
	Ma3G3Q5IXGEGQNWNMdvbDthIb05EuILx6Kw=
X-RZG-AUTH: :IW0NeWC8cvPlgn0IPTehqi9r6o/0DSXjJ1Me0yWdPTUrUVR0TMXac2ZAlsdx1c9Kh8s=
X-RZG-CLASS-ID: mo00
Received: from dellschleppa (p549CD3E5.dip.t-dialin.net [84.156.211.229])
	by post.strato.de (klopstock mo51) (RZmta 23.0)
	with ESMTP id a0126fm4288ukJ for <git@vger.kernel.org>;
	Sun, 2 May 2010 11:18:32 +0200 (MEST)
In-Reply-To: <7vmxwj5ym8.fsf@alter.siamese.dyndns.org>
User-Agent: Opera Mail/10.10 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146153>

On Sat, 01 May 2010 19:18:55 +0200, Junio C Hamano <gitster@pobox.com>  
wrote:

Thank you for the detailed explanation!

> This design constraint makes the issue not a version control problem but
> more of a software engineering problem.  The changes to your parameter
> file have its own history (e.g. you upgraded your machine last week with
> different hardware---the software didn't change but the parameter has to)
> and the history is largely independent of the software that reads the
> file.  In that sense, you should _never_ tie its history with the history
> of your software.

Ok.

> At the same time, the history of the parameter file is not completely
> independent of that of the software.  You may have added a new feature  
> and code to read a new setting in the parameter file today and older  
> parameter file would not have a setting for that variable.

Exactly.

> The method I used in my day-job project is something like this:
>
>  - Include a "config.sample" file and track it in the history of the
>    source code; the values it gives to the variables are the same as the
>    default ones.  This file mostly serves as a documentation.

I actually did exactly that already (but forgot to mention it in my first  
mail, sorry!). The problem with this "one" config.sample is, that I need  
about three really different config files because of really different  
sensor setups on about five different computers. So when I push on a USB  
stick, walk to another computer, then pull and try to run the software -  
bummer, forgot to copy the current config file - walk back, copy ...
But maybe the solution below solves this too. Or I write a little script  
doing the push and parameter file copy.

>  - Design your parameter mechanism in a way that:
>
>    - a parameter file can include another;

Can't do that yet.

>    - an unrecognized parameter setting is ignored;

Can do.

>    - a variable definition that happens later overrides an earlier
>      definition.

Can do.

>  - Have a real parameter file that is _not_ tracked in the history of the
>    source code.  Have it include parameter.sample and then define machine
>    specific settings after that to override.

Good idea.

> It is only required for the "real" parameter file not to be tracked in  
> the history of the source code---it is perfectly fine to track it in a
> separate history.  The easiest way to do this would be to keep a  
> parameter working tree next door, and "ln -s ../params/config config" in  
> the working tree for the source code.  You could keep this symlink  
> tracked in the
> source history, but you do not have to.

I see. So if I want parameter file history the only proper solution is to  
have a separate parameter file git repo, right?

> You will try to read from ./config, which will include ./config.sample in
> order to read the default, and then read the customized setting that
> appear later in ./config.  Because of the symlink, you will actually be
> reading from ../params/config next door.

Ok, will give it a try.

-- 
Regards,

	Tilo
