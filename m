From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: irc usage..
Date: Mon, 22 May 2006 19:42:10 +1200
Message-ID: <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>
	 <20060520203911.GI6535@nowhere.earth> <446F95A2.6040909@gentoo.org>
	 <Pine.LNX.4.64.0605201543260.3649@g5.osdl.org>
	 <446FA262.7080900@gentoo.org>
	 <Pine.LNX.4.64.0605211209080.3649@g5.osdl.org>
	 <Pine.LNX.4.64.0605212053590.3697@g5.osdl.org>
	 <44713BE4.9040505@gentoo.org>
	 <Pine.LNX.4.64.0605212132570.3697@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Donnie Berkholz" <spyderous@gentoo.org>,
	"Yann Dirson" <ydirson@altern.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Matthias Urlichs" <smurf@smurf.noris.de>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 22 09:42:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fi53Q-0006D6-36
	for gcvg-git@gmane.org; Mon, 22 May 2006 09:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595AbWEVHmN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 03:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbWEVHmN
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 03:42:13 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:14207 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932595AbWEVHmL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 03:42:11 -0400
Received: by wr-out-0506.google.com with SMTP id 68so197217wri
        for <git@vger.kernel.org>; Mon, 22 May 2006 00:42:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UMqv8rQOkvF7xXb//yczz3zyDt8FGV9eSp6ie3WouXu9Um7HlEWvWOWH9rRPzWVPhJ2DbE1/kjpp1nC6Y9yn971rBUm6aiaO+73shtVSsCYcoNONkl1IhF0QoiISgiww+E+GFqlWP10svxsh5KGWhGbmW5/9KEVt5qCQVxUkOUs=
Received: by 10.54.70.17 with SMTP id s17mr1639485wra;
        Mon, 22 May 2006 00:42:10 -0700 (PDT)
Received: by 10.54.127.17 with HTTP; Mon, 22 May 2006 00:42:10 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605212132570.3697@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20486>

On 5/22/06, Linus Torvalds <torvalds@osdl.org> wrote:
> Did you do a "top" at any time just before this all happened? It _sounds_
> like it might actually be a memory leak on the CVS server side, and the
> problem may (or may not) be due to the optimization that keeps a single
> long-running CVS server instance for the whole process.

Running a few tests right now. Looks like cvs (Debian/etch 1.12.9-13)
itself is not leaking any memory. The Perl (Debian/etch
5.8.7-something and now 5.8.8-4) process OTOH is visibly allocating
memory. Starts off at 4MB and gets up to ~17MB by the time it has done
6K commits.

I am trying to figure out whether the leak is in the script or in the
Perl implementation, using PadWalk, Devel::Leak and friends. If the
leak is here, I can't see it (yet).

> I wouldn't be in the least surprised if that ends up triggering a slow
> leak in CVS itself, and then CVS runs out of memory.

Or a slow leak in Perl? The 5.8.8 release notes do talk about some
leaks being fixed, but this 5.8.8 isn't making a difference.

Working on it.



martin
