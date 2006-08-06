From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: GPF in index-pack
Date: Sun, 6 Aug 2006 00:00:11 -0400
Message-ID: <9e4733910608052100t463e6fb8gba54e4afde1ab19a@mail.gmail.com>
References: <9e4733910608051805j1192d910hf55393f1dbe1e472@mail.gmail.com>
	 <9e4733910608051944v5af7e552wd6909b9773dd516e@mail.gmail.com>
	 <20060806024858.GC20565@spearce.org>
	 <9e4733910608051958h6144add7td46de70dd8b45a5e@mail.gmail.com>
	 <20060806033222.GD20565@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 06 06:00:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9ZoJ-0001VO-FP
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 06:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbWHFEAP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 00:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWHFEAP
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 00:00:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:51621 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751516AbWHFEAN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Aug 2006 00:00:13 -0400
Received: by nf-out-0910.google.com with SMTP id p46so70553nfa
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 21:00:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f8Be61w0FzGQmijukZgkj1F0tQP/HcFnkiJD6OuC7iNfzHHYwWd27eY3FP/UEbQ9g0LGWeyW5plxz9hWVxcGHR00lieM2GzQvWHvO70hNP+PwI3CoR3wIFUitOoDFfJETKSo+QkhIc73XuAEw4mENFII5ilIT0IuJ5eO8APNxvQ=
Received: by 10.78.107.8 with SMTP id f8mr2029234huc;
        Sat, 05 Aug 2006 21:00:11 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Sat, 5 Aug 2006 21:00:11 -0700 (PDT)
To: "Shawn Pearce" <spearce@spearce.org>
In-Reply-To: <20060806033222.GD20565@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24959>

On 8/5/06, Shawn Pearce <spearce@spearce.org> wrote:
> Jon Smirl <jonsmirl@gmail.com> wrote:
> > On 8/5/06, Shawn Pearce <spearce@spearce.org> wrote:
> > >Jon Smirl <jonsmirl@gmail.com> wrote:
> > >> Process size is 2.6GB when the seg fault happen. That's a lot of
> > >> memory to build a pack index over 1M objects.
> > >>
> > >> I'm running a 3:1 process address space split. I wonder why it didn't
> > >> grow all the way to 3GB. I still have RAM and swap available.
> > >
> > >Was the pack you are trying to index built with that fast-import.c
> > >I sent last night?  Its possible its doing something weird that
> > >pack-index can't handle, such as insert a duplicate object into
> > >the same pack...
> >
> > built with fast-import.
> >
> > >How big is the pack file?  I'd expect pack-index to be using
> > >something around 24 MB of memory (24 bytes/entry) but maybe its
> > >hanging onto a lot of data (memory leak?) as it decompresses the
> > >entries to compute the checksums.
> >
> > It is 934MB in size with 985,000 entries.
> >
> > Why does resolve_delta in index-pack.c need to be recursive? Is there
> > a better way to code that routine? If it mmaps the file that uses 1GB
> > address space, why does it need another 1.5GB to build an index?
>
> Probably the easiest way to code the routine.  Delta depth is
> bounded; in the fast-import.c that I sent out last night I hardcoded
> it to 10, which is (I believe) the default for GIT.  So long as that
> routine is recursive only along a single delta chain the recursion
> depth won't be very high and shouldn't be the problem.

When I put index-pack in gdb at the seg fault, resolve_delta had
recursed more than 20,000 times. I stopped looking after that.

> > I had a prior 400MB pack file built with fast-import that I was able
> > to index ok.
>
> Dumb luck?  Maybe that had no duplicates while this one does?

Is there a git command to list the sha1's in a pack that doesn't have
an index? I could sort it, sort it unqiue, and then diff the outputs.

-- 
Jon Smirl
jonsmirl@gmail.com
