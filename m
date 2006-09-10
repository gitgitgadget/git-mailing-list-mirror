From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Change set based shallow clone
Date: Sun, 10 Sep 2006 07:14:09 +0200
Message-ID: <e5bfff550609092214t4f8e195eib28e302f4d284aa@mail.gmail.com>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com>
	 <Pine.LNX.4.64.0609082054560.27779@g5.osdl.org>
	 <e5bfff550609090147q37d61f37j9c3e8ae6d3a0cf35@mail.gmail.com>
	 <Pine.LNX.4.64.0609091022360.27779@g5.osdl.org>
	 <e5bfff550609091104s3709b82fld3057a07a84ae857@mail.gmail.com>
	 <Pine.LNX.4.64.0609091256110.27779@g5.osdl.org>
	 <e5bfff550609092049t5e016cacr2502ce81bbb6489e@mail.gmail.com>
	 <7vpse4uzos.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550609092123t1d8b6c70s5750fbb787534812@mail.gmail.com>
	 <7virjwuxrz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Paul Mackerras" <paulus@samba.org>,
	"Jon Smirl" <jonsmirl@gmail.com>,
	"linux@horizon.com" <linux@horizon.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 10 07:14:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMHe7-0005it-48
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 07:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965257AbWIJFOM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 01:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWIJFOM
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 01:14:12 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:33698 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932298AbWIJFOK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 01:14:10 -0400
Received: by py-out-1112.google.com with SMTP id n25so1584174pyg
        for <git@vger.kernel.org>; Sat, 09 Sep 2006 22:14:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MxxKhckHohBZ6TY2elpLX1SvZr97uWy1qqUT3N5w8TlG8a6VdE8NqKE3PVH/Mw4+OpKiqAd9b3K3fhyUPuVL+S51pbj6R53xwBGUmTg7qAy0iCV0rY+bZ/2Ru6kxY5+/PDVhPON0nOvb3p0isZWl0h87amcKuU/xRzrfG39+JuM=
Received: by 10.35.97.17 with SMTP id z17mr6164846pyl;
        Sat, 09 Sep 2006 22:14:09 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Sat, 9 Sep 2006 22:14:09 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7virjwuxrz.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26784>

On 9/10/06, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> > >>
> > >>                     A           <--- tip of branch
> > >>                    / \
> > >>                   B   E
> > >>                   |   |
> > >>                   |   F
> > >>                   | /
> > >>                   C
> > >>                   |
> > >>                   D
> > >>                 ...
> > >>
> >
> > Ok. What about something like this?
> > A, B, C, D, E, (-3, 1)F
> >
> > where -3 is the correct position in sequence and 1 is the number of
> > revisions before F to whom apply the -3 rule.
>
> That means F knows who its descendants are, and commit objects
> do not have that information, so while traversing you need to
> keep track of all the descendants yourself, doesn't it?
>

Yes! it is, but you do it in git instead of in the visualizer ;-)
because I think in any case someone defenitly needs to keep track of
it.

> And how does that fix-up information help the user of the stream
> anyway?  If I understand your model correctly, the model does
> not synchronously draw nodes as they are received,

Visualizers draw only what is on screen so when you start them they
draw the first 20/30 lines only. And noramally git output it's faster
then user scrolling so when user scrolls down revisions are already
arrived.

> track of what it has seen so far.  When it sees F it can notice
> that its parent, C, is something it has seen, so it can tell F
> is wrong.  It also knows that it has seen E and E's parent is F
> (which turned out to be at a wrong spot), so it can suspect E is
> also in the wrong spot (now, it is fuzzy to me how that chain
> of suspicion ends at E and does not propagate up to A, but let's
> think about that later).
>
Is it possible, in that case flicker will be involved, but it is very
uncommon, so in the big amount of all other cases we have no
flickering and early graph drawing.

Becasue the worst that can happen on visualizer side is flickering we
can accept a worst rare case to have a big adavantage (no latency and
no flickering) on the (very) common case: "user scrolls to a given
page when the corresponding revisions are already arrived and, in
case, fixed up".


    Marco
