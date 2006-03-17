From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Possible --remove-empty bug
Date: Fri, 17 Mar 2006 11:57:38 +0100
Message-ID: <e5bfff550603170257u21ee6583jabe5a6409cc40766@mail.gmail.com>
References: <e5bfff550603120612k555fc7f3v9d8d17b1bd0b9e41@mail.gmail.com>
	 <7vk6azz6xx.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0603121450210.3618@g5.osdl.org>
	 <7vlkvfw3px.fsf@assigned-by-dhcp.cox.net>
	 <7v4q22ucio.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0603131058270.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 17 11:57:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKCeM-0001hX-Di
	for gcvg-git@gmane.org; Fri, 17 Mar 2006 11:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbWCQK5j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Mar 2006 05:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752593AbWCQK5j
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Mar 2006 05:57:39 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:37981 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752590AbWCQK5j convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Mar 2006 05:57:39 -0500
Received: by zproxy.gmail.com with SMTP id m7so832462nzf
        for <git@vger.kernel.org>; Fri, 17 Mar 2006 02:57:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VSQ47rxe16Pxm6BSTnYWoikOvxRmtAOTbNOw+s8rK9lhEiwWDU2zIsG5utSaDMml3e2Ag+ubfxdlViSD/lGvNJ5n6CVwElTGEL//HW2t2E7YJLcHjYndrnvFDUMId6MGbX8xGsP/kKQ5hxqvTbyhDixvwgqzEv0t4HHuMdKBKQQ=
Received: by 10.65.193.6 with SMTP id v6mr122370qbp;
        Fri, 17 Mar 2006 02:57:38 -0800 (PST)
Received: by 10.64.131.10 with HTTP; Fri, 17 Mar 2006 02:57:38 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603131058270.3618@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17666>

On 3/13/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
> However, to be honest, the only reason to ever use --remove-empty is for
> rename detection, and Frederik's approach of doing that through the
> library interface directly is actually a much superior option. So we might
> as well drop the compilcation of --remove-empty entirely, unless somebody
> has already started using it.
>

In case of a rather recent file --remove-empty option gives a good
speed up in history loading with git-rev-list. So qgit uses that
option.

Annotation in qgit it is little different from blame algorithm because
it works from oldest revision to latest instead of the contrary. This
is due because it calculates in one pass _all_ the annotations of  all
the different revisions of a given file, starting from file history,
i.e. 'git-rev-list file_path' output.

The GUI interface of qgit let's the user quickly jump between two file
revisions. So the corresponding annotations should be already prepared
to make it snappy.


> The _real_ optimization would be to make the pathname based pruning be
> done incrementally instead of having to build up the whole tree.

Anything that speeds-up file git-rev-list history loading surely gives
a big boost to all annotation/blame stuff. I have made some profiling
on qgit (the public git repo version that is much faster, not the
qgit1.1 released one) and I found that 50% to 70% of the time is spent
on git-rev-list, of the remaining the 80% is spent on git-diff-tree -p
patch loading and only a small amount is spent on actually calculate
the annotation.

Of course these numbers can vary a little according to file/repo, but
the big picture stays the same.


Marco
