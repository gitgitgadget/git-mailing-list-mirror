From: Phil Hord <phil.hord@gmail.com>
Subject: Re: squash commits deep down in history
Date: Tue, 4 Nov 2014 12:25:17 -0500
Message-ID: <CABURp0p_VzxXjFMEqLNg0MgY55akCmUJk7mvSG7JuuLp=r8YbA@mail.gmail.com>
References: <trinity-6a57d894-cc4f-4213-9c51-5c73de2501d0-1414067657189@3capp-gmx-bs48>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
To: Henning Moll <newsScott@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 04 18:25:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlhrW-00049J-WD
	for gcvg-git-2@plane.gmane.org; Tue, 04 Nov 2014 18:25:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbaKDRZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2014 12:25:42 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:50821 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbaKDRZi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Nov 2014 12:25:38 -0500
Received: by mail-ig0-f171.google.com with SMTP id hl2so7025344igb.16
        for <git@vger.kernel.org>; Tue, 04 Nov 2014 09:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=NZ4ejCYAwCYZ1JjrTt/YqtdHnJBvi1L7nyrQ/gnb4fs=;
        b=IaNPFvbu0gkN+xhKH3Vgbgu8LuONrV7/dYe8HA+Tp5qOMWVE2uqg2eUtlICa8hWZFq
         IEDoKCSrmRHut4F0rsIS5vCJ6JMpGkPndXPPKwW0c/Q0sw4szt2Qrti5R3ENu2fuMeCb
         MeIHEls8d4ui6CBFcktKuFlLMvhNt5Tp7jxhqA+17sbcf+CTb9iz2fnQhE0MtWpvyZlm
         jlvkdc8IG1PaRbdg7GLV95LMROUtoLoXyEp3kLzIeq62i2xF/V1bu0pjPxssgElGVCVo
         /XbaLGrgEaOTB51e/6zADYxPvjfZu0c8cXJ1EBB/i27bfUYlY35GK5ABwI63eLAu21Z5
         hJzg==
X-Received: by 10.50.29.71 with SMTP id i7mr25832632igh.4.1415121937649; Tue,
 04 Nov 2014 09:25:37 -0800 (PST)
Received: by 10.107.137.11 with HTTP; Tue, 4 Nov 2014 09:25:17 -0800 (PST)
In-Reply-To: <trinity-6a57d894-cc4f-4213-9c51-5c73de2501d0-1414067657189@3capp-gmx-bs48>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 23, 2014 at 8:34 AM, Henning Moll <newsScott@gmx.de> wrote:
> Hi,
>
> i need to squash several commits into a single one in a automated way. I know that there is interactive rebase, which can also be automated using GIT_SEQUENCE_EDITOR. Unfortunately my history is very large and i need to squash deep down in the history several times. So using interactive rebase seems not to be the right tool.
>
> I wonder if i can solve this task using filter-branch? I have a file that list the SHA1s for each squash operation per line. All SHA1s of a line are in chronological order (youngest to oldest), or in other words: the first SHA1 is the child of the second, and so on.
>
> | ab4423e 3432343 3234252
> | 2324342 5232343
> | ...
>
> Lets say there are N lines in that file. Each line means: squash all SHA1s of this line into the first (or last) SHA1 of this line.

I've often felt there should be some simple commands to do these kinds
of edits.  For example, it is easy to amend HEAD, but an
order-of-magnitude more difficult to amend HEAD^.   I imagine commands
like this:

   git rebase --reword HEAD^
   git rebase --edit some-old-commit
   git rebase --squash ab4423e 3432343 3234252

But each time I think of implementing one of these I am daunted by the
many exceptional cases.


> Performing this task with rebase would require N rewritings of the history. So e.g. HEAD (but many others too) would be rewritten N times even if it is not directly part of a line. My thinking is, that a filter-branch can do this in a single rewrite and therefore would be much more performant.
>
> How can i solve this? Any ideas?

I know you solved this already with filter-branch, but that seems like
a complicated solution to me.  I think the --interactive rebase would
have been useful for you.  You should keep in mind that you do not
need to repeat the command multiple times for your multiple squashes.
For example, if your to-do list looks like this simple example:

pick 0000000
pick ab4423e
pick 3432343
pick 3234252
pick 0000001
pick 0000002
pick 2324342
pick 5232343
pick 0000003

I think you could get the desired effect by changing it to this:

pick 0000000
pick ab4423e
squash 3432343
squash 3234252
pick 0000001
pick 0000002
pick 2324342
squash 5232343
pick 0000003

And then running that all in one interactive rebase.  Does that make sense?

Phil
