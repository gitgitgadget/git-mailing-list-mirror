From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 2/2] git-sh-setup: work around Cygwin path handling gotchas
Date: Thu, 24 May 2012 19:27:53 +0100
Message-ID: <4FBE7DA9.8040309@ramsay1.demon.co.uk>
References: <4FB09FF2.70309@viscovery.net> <1337191208-21110-1-git-send-email-gitster@pobox.com> <1337191208-21110-3-git-send-email-gitster@pobox.com> <CAAXzdLW5VYnHc41WZ0id=4Qe17dHSj4+J9tqVvG-PvtpXLmh+Q@mail.gmail.com> <7vd364c5kt.fsf@alter.siamese.dyndns.org> <4FB58678.1050009@ramsay1.demon.co.uk> <7vehqib4kk.fsf@alter.siamese.dyndns.org> <4FBA8CD4.3020001@ramsay1.demon.co.uk> <7vaa116ulx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Steven Penny <svnpenn@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 24 20:30:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXcnp-00015w-Gc
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 20:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934105Ab2EXSaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 14:30:19 -0400
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:37500 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934102Ab2EXSaS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 May 2012 14:30:18 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1SXcng-0005Yi-g4; Thu, 24 May 2012 18:30:16 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7vaa116ulx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198404>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> However, you could imagine adding code to accommodate external windows
>> programs. If we limit ourselves to the text editor, for example, I could
>> imagine something like the diff attached below to fix up the C based git
>> programs. (You would need to make similar changes to the shell and perl
>> scripts which launch the text editor).
> 
> If you _only_ allow editors that understands windows style paths, your
> patch may make sense, but doesn't it break editors that wants only POSIX
> style paths?

Yes.

(If it wasn't clear, I included the code to show what I *didn't* want to see!).

Cygwin built text editors will, of course, work fine with POSIX paths, but
may also work with win32 paths as well. For example, vim supports win32 paths
just fine (it's the *only* editor I tested).

I would not be surprised if vim is not alone in that; I think it mainly depends
on whether the editor attempts to "interpret" the parameter, or simply treats it
as an opaque token to be passed straight to [f]open() [1].

Equally, I suspect some cygwin built editors will fail miserably (maybe they try
to interpret the parameter as an scp-like url, say). I don't know and I'm not
about to test every cygwin text editor to find out!

So, in my opinion, adding code to explicitly support win32 paths, while possible,
is likely to open up a can-o-worms (even if this support were opt-in via config).
I would prefer that we don't go there. :-D


ATB,
Ramsay Jones

[1] Which is why git already supports win32 paths to a certain degree. For example,
the following will work as expected:

  $ git config --global core.excludesfile 'C:/cygwin/home/ramsay/.gitignore'

(ie git will read and use the given .gitignore file without problem)
