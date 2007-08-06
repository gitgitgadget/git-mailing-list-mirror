From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: GIT push to sftp (feature request)
Date: Mon, 6 Aug 2007 12:00:03 +1200
Message-ID: <46a038f90708051700t7a758f8fwdf7c63c8aeef9ee8@mail.gmail.com>
References: <200708051105.44376.pavlix@pavlix.net>
	 <46a038f90708051412p722aa906v73e986a805f1558b@mail.gmail.com>
	 <vpqir7t8vy0.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Martin Langhoff" <martin.langhoff@gmail.com>,
	pavlix <pavlix@pavlix.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 06 02:00:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHq13-0006XJ-Hz
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 02:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758041AbXHFAAG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 20:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757960AbXHFAAG
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 20:00:06 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:49262 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757941AbXHFAAE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 20:00:04 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1317696wxd
        for <git@vger.kernel.org>; Sun, 05 Aug 2007 17:00:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DdaoKHMyq1tYCua9/yWbqFnmXPlKl4ndDFwLWRHSjC9HtugjY5RSacTsveSO+aqy794vuuOOOjSmonTejP/1PsLJr/ro6RQGWJivpHlB37SwMDpIVA/mNuf2qmgw46Pskb3dneHOutCFcMeR7QSgaVwHtMslTu4Y5Q59HLSkU2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PcwzU8EXDA8aDaoflT/La7mH0Kv03NzkGV8P8+UwjaVQGUd2s6bgfZ9qWf3bo0uPwvA2vi+3lxiK0l53ydHYMIq4r+gP+EBQqEgonZpzhz4O2wJTJnwdBu17EaIoPQQWF9rm4E0pAAMzCmTYQaiWkgk7UZ/0Se5HvZdBGjahKpc=
Received: by 10.90.66.9 with SMTP id o9mr4249576aga.1186358403520;
        Sun, 05 Aug 2007 17:00:03 -0700 (PDT)
Received: by 10.90.52.9 with HTTP; Sun, 5 Aug 2007 17:00:03 -0700 (PDT)
In-Reply-To: <vpqir7t8vy0.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55087>

On 8/6/07, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> "Martin Langhoff" <martin.langhoff@gmail.com> writes:
>
> > Git tries to be smart in at least 2 ways that don't work with dump
> > protocols: it works locklessly (yet it performs atomic updates) and it
> > sends only the objects needed over the wire (saving a lot of
> > bandwidth).
> >
> > Using dumb protocols it's impossible to do either.
>
> That's not exactly true. You can't be as efficient with dumb protocols

You are right -- I should have said: it's pretty hard, and we haven't
put the effort ;-)

there's been discussion recently of having info in the pack index that
would support http range requests.

> (its ancestor,
> GNU Arch, also had a way to be network-efficient on dumb protocols).

Do I remember your name from gnuarch-users? -- that Arch/tla was never
particularly efficient, and fetches of large updates were slow and
painful. Surely it was efficient on paper though :-p

> Regarding atomic and lock-less updates, I believe this is
> implementable too as soon as you have an atomit "rename" in the
> protocol. But here, bzr isn't a proof of existance, it does locking.

And I should have said - minimal locking rather than no locking

To update it safely, you need to open with a lock, read to ensure the
sha1 is what you think it is, write the new sha1, close. A rename is
still subject to race conditions.

IMVHO it would be good to have a way to push over sftp even it it is
slow, unsafe and full of big blinking warnings. git itself is sane
enough that the client side won't get corrupted or lose data if there
is a race condition on the server side.

Given a brief delay, the client can probably check - post push - that
the operation wasn't clobbered by a race condition. Of course, this
*is* sticks-and-bubblegum approach on the server side. But a solid
client repo makes almost any server-side disaster recoverable.

cheers,



martin
