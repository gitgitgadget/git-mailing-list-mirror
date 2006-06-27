From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: CFT: merge-recursive in C
Date: Tue, 27 Jun 2006 10:58:41 +0200
Message-ID: <81b0412b0606270158i16ebee20me81ca2b9fa71db5c@mail.gmail.com>
References: <20060626233838.GA3121@steel.home>
	 <Pine.LNX.4.63.0606270936520.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>,
	"Fredrik Kuivinen" <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Jun 27 10:59:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fv9PJ-00074t-Dr
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 10:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932853AbWF0I6o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 04:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932925AbWF0I6n
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 04:58:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:13384 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932853AbWF0I6m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 04:58:42 -0400
Received: by ug-out-1314.google.com with SMTP id a2so2475162ugf
        for <git@vger.kernel.org>; Tue, 27 Jun 2006 01:58:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K7Lz15Q8lUhpnsp4bVFjRi7hMjMkI16ThHYfBeg+6MhLGWF2uXEbsV37i9oItSAVU67f3SwNu60M+dPQXRbI0N1gAYQzDJb/5+Zb2ygm77uKnbXGgfsXxtisxHqelQc+WU2QI6sw4rQH49wWv7lKF8qKPdPdH9n+2bKl3MfwLXk=
Received: by 10.78.117.10 with SMTP id p10mr2414669huc;
        Tue, 27 Jun 2006 01:58:41 -0700 (PDT)
Received: by 10.78.37.7 with HTTP; Tue, 27 Jun 2006 01:58:41 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606270936520.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22717>

On 6/27/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > I finally got pis^Witched enough by my platform at work and decided
> > to start the effort of converting Fredriks git-merge-recursive to C.
>
> Darn. I was working on the same thing since a few days.

I didn't know :)

> - have you considered using run-command() instead of system()?

No. What run-program?

> - in setup_index(), you set GIT_INDEX_FILE, but I do not think that the
>   rest of git picks up on it. environment.cc:get_index_file() checks if
>   the variable was set already, but not if it changed.

Not even sure it's needed. Leftover from conversion

> - You work with linked lists all the time. This is slow, especially for
>   the checks, if a file/directory is already there. Sorted lists would be
>   way faster there. Since you encapsulated that, it is no problem to
>   change that later (before inclusion).

Right, that's why it is mostly encapsulated.

> - is not "struct commit_list" more appropriate than "struct graph"?

Not even properly considered it yet. It probably is.

> - I always wondered why merge-recursive did not call merge-base, but did
>   its own thing. Hmm?

No idea yet.

> > To my deep disappointment, it didn't work out as good as I hoped: one
> > program I see most often and for longest time in the process list
> > (git-diff-tree) is a too complex thing to be put directly into
> > merge-recursive.c, so any help in this direction will be greatly
> > appreciated.
>
> Maybe something like this (ripped from my fragment of merge-recursive.c):
>
> static struct container *get_renames(struct tree *tree,
>                 struct tree *o, struct tree *a, struct tree *b,
>                 struct container *cache_entries)
...
> It is not tested, evidently, since I did not get the merge-base code
> integrated yet. But it should give you an idea.
>

Thanks! It was something I was getting at after Junio explained it.
Will have to wait until after work.
