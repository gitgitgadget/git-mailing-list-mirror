From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [ANNOUNCE] Git wiki
Date: Sat, 6 May 2006 18:53:36 +1200
Message-ID: <46a038f90605052353m2d2aca11weac7efee80c6fb35@mail.gmail.com>
References: <20060505005659.9092.qmail@science.horizon.com>
	 <20060505181540.GB27689@pasky.or.cz>
	 <Pine.LNX.4.64.0605051123420.3622@g5.osdl.org>
	 <20060505185445.GD27689@pasky.or.cz>
	 <7vr738w8t4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Petr Baudis" <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 06 08:53:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcGfc-0000fR-RF
	for gcvg-git@gmane.org; Sat, 06 May 2006 08:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWEFGxi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 02:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWEFGxi
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 02:53:38 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:53991 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932398AbWEFGxh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 May 2006 02:53:37 -0400
Received: by wr-out-0506.google.com with SMTP id 68so677908wri
        for <git@vger.kernel.org>; Fri, 05 May 2006 23:53:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ARfe7FcxkUGEOS1/PTnzmjr6VBdJQIRHJLSnxC1Bk9/8B3yscdeuTaVWTbdwm6k3p05OS7qVq0hHsohdl6j0PJs5l1VgSP10zIpPwGN7kJ6sH33/LQxBlIWq+u1ap1X3TFPAuHp+jWJ8HUzQYRAaqtjsAc4oWhJN2a6BGplghIE=
Received: by 10.54.126.20 with SMTP id y20mr17378wrc;
        Fri, 05 May 2006 23:53:36 -0700 (PDT)
Received: by 10.54.127.4 with HTTP; Fri, 5 May 2006 23:53:36 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vr738w8t4.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19649>

On 5/6/06, Junio C Hamano <junkio@cox.net> wrote:
> > If you use persistent file ids, you never miss it _AND_ you DO NOT WALK
> > THE COMMIT CHAIN! You still just match file ids in the two trees.
>
> It is unworkable.

+1 -- explicit file ids are evil. Arch/TLA demonstrated that amply...
they are a serious annoyance to the end user, they have a lot of
not-elegantly solvable cases (same file created with the same contents
in several repos -- say via an emailed patch) that git gets right
_today_.

They _are_ useful in a very small set of cases -- namely in the case
of a naive mv, which git handles correctly today. Subtler things git
sometimes does right, sometimes fails, but it can be made to be much
smarter by interpreting content changes better, for instance all this
talk about getting pickaxe to guess where the patch should be applied
for a file that got split into 3.

But those subtler cases are totally impossible with explicit id
tracking. I used Arch for a long time with very large trees, and
renames coming left, right and centre. Explicit ids didn't help much,
and the number of manual fixups we had to do was awful.

I am using GIT with the very same project, and just now, typing this,
I realised that there are still many renames happening in the project.
I had forgotten about it -- well, not really: I do use git-merge
instead of cg-merge when I suspect there may be interesting cases ;-)

Of course, YMMV, and I have to confess I was a sceptic for a while...
but now as an end-user dealing with messy projects, I say LIRAR: Linus
Is Right About Renames.

OTOH,

>> Try doing
>>
>> git diff v1.3.0..
>>
>> and think about what that actually _means_. Think about the fact that it
>> doesn't actually walk the commit chain at all: it diffs the trees between
>> v1.3.0 and the current one. What if the rename happened in a commit in
>> the middle?
>
> Then the automated renames detection will miss it given that the other
> accumulated differences are large enough, and the suggested workarounds
> _are_ precisely walking the commit chain.

I agree here with Pasky that after a while the automated
renames/copy/splitup detection will miss the operation in cases where
it would be interesting to note it to the user. IIRC git-rerere is the
tool that knows about this (still voodoo to me how) and could be used
to help here. At what (runtime) cost, I don't know, but that kind of
walking history to tell me more interesting things about the diff is
something that is usually worthwhile.

Usual disclaimers apply.


martin
