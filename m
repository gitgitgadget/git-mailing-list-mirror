From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] "sleep 1" sleeps too little on cygwin
Date: Fri, 20 Jan 2006 16:23:10 +0100
Message-ID: <81b0412b0601200723k1a271046u9c310d9c9b7d83f0@mail.gmail.com>
References: <7vmzhtzzlf.fsf@assigned-by-dhcp.cox.net>
	 <7v4q41zd1t.fsf@assigned-by-dhcp.cox.net>
	 <20060118185229.GA3001@steel.home>
	 <7vmzhtqakl.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0601190701g2696b1a9l14f3d288875e11ab@mail.gmail.com>
	 <20060119182822.GA32022@trixie.casa.cgf.cx>
	 <20060119221227.GB3601@steel.home>
	 <20060119222553.GB7567@trixie.casa.cgf.cx>
	 <7vbqy78zwy.fsf@assigned-by-dhcp.cox.net>
	 <20060120033548.GE5090@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 20 16:28:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzyAh-0006wZ-9h
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 16:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWATPXh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 10:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWATPXY
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 10:23:24 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:32318 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750785AbWATPXM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2006 10:23:12 -0500
Received: by uproxy.gmail.com with SMTP id s2so37977uge
        for <git@vger.kernel.org>; Fri, 20 Jan 2006 07:23:11 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZSvzby1fX8ycI9hmSaDvO4t9EFVg2hvH3ICl+heL73aLG1V8zRGrCJ9JqdmlyO1VoZMoDOdLwyMi+I507THJPO9fBwfwKcOyikV+SxAu/uAwO7d1ahnFPtsDx49gSwVqEUYElgoQJkBOWcUnYRR7lFdQcVOK197jieulnRUl518=
Received: by 10.49.9.19 with SMTP id m19mr150089nfi;
        Fri, 20 Jan 2006 07:23:10 -0800 (PST)
Received: by 10.49.14.20 with HTTP; Fri, 20 Jan 2006 07:23:10 -0800 (PST)
To: Christopher Faylor <me@cgf.cx>
In-Reply-To: <20060120033548.GE5090@trixie.casa.cgf.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14966>

On 1/20/06, Christopher Faylor <me@cgf.cx> wrote:
> On Thu, Jan 19, 2006 at 05:13:17PM -0800, Junio C Hamano wrote:
> >Christopher Faylor <me@cgf.cx> writes:
> >>Inodes are only calculated by hashing the path name when the OS lacks
> >>the support to provide a "real" inode and in that case there is no hard
> >>link support available so it's a non-issue.
> >
> >Does that mean on such filesystems "mv foo bar" would change the i-num
> >of the moved entity?

It is just a rename. It will not change inode by definition (the file is the
same, it is the name which was changed). To get inode change you
have to create it, like "cp foo bar; rm foo". And now, if a filesystem
has (or exports) inodes, would the inode change. If it does not, you
really can't say anything about the inode (it can even change, and
does in this case, being calculated from pathname).

> I just tried this on Windows XP.  On a FAT32 or a NTFS filesystem the

I have FAT32. It does not support inodes"
    $ : > foo
    $ stat foo |grep node
    Device: 111712fch/286724860d    Inode: 3595119992080318288  Links: 1
    $ mv foo bar
    $ stat bar |grep node
    Device: 111712fch/286724860d    Inode: 3595119974866484701  Links: 1

> inode is unchanged.  On a FAT filesystem, it changes.  I assume that
> means that FAT doesn't support a real file ID.  The only thing I think
> anyone would be using FAT for these days is possibly a boot partition.

It's still faster than NTFS, I use it as a temporary compilation partition,
and as NT is painfully slow about filesystems and throughput in general,
I keep my sources on the partition as well.

> That's the only reason I have one.  I use to to multi-boot various
> flavors of Windows.  It's the lowest common denominator.

Lowliest.
