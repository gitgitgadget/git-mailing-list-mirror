From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] git-rev-list: give better diagnostic for failed write
Date: Wed, 27 Jun 2007 10:56:30 +0200
Message-ID: <87wsxppygx.fsf@rho.meyering.net>
References: <87r6nzu666.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0706251349540.8675@woody.linux-foundation.org>
	<878xa7u2gh.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0706251505570.8675@woody.linux-foundation.org>
	<alpine.LFD.0.98.0706251536240.8675@woody.linux-foundation.org>
	<alpine.LFD.0.98.0706251557090.8675@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 27 10:56:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3TKE-0003MT-Fw
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 10:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbXF0I4c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 04:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752157AbXF0I4c
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 04:56:32 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:57220 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121AbXF0I4b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 04:56:31 -0400
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 1B4CB5A284
	for <git@vger.kernel.org>; Wed, 27 Jun 2007 10:56:31 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 098878D56; Wed, 27 Jun 2007 10:56:31 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.98.0706251557090.8675@woody.linux-foundation.org> (Linus Torvalds's message of "Mon\, 25 Jun 2007 16\:01\:58 -0700 \(PDT\)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51025>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
...
> So I didn't mean to imply that the new git.c code in 'next' is wrong, I
> just meant to imply that the "ferror()"+"fflush()" sequence that it uses
> and that I copied for my example is a very unreliable sequence, and it
> basically fails exactly because you can never know what caused the
> ferror() to trigger - if it *ever* triggers, you're basically screwed.
>
> I wonder how many applications actually ever use ferror() and friends.

At least among GNU programs, many do.
Here are a few:

    gcc, make, diff, grep, tar, find, xargs, gawk

And add to that 89 or 90 of the coreutils programs:

    $ git-grep -l close_stdout|grep 'src/.*\.c'|wc -l
    89

But none of those suppress EPIPE errors, so ferror works fine for them.
That's partly because the ferror-only situation is far less common
than the one in which we have a valid errno value.
