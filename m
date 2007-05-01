From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 4/8] git-repack --max-pack-size: add fixup_header_footer()
Date: Tue, 1 May 2007 10:58:52 -0700
Message-ID: <56b7f5510705011058y89e4aa4p8f8b7eccde30af78@mail.gmail.com>
References: <463679EB.2010301@gmail.com> <20070501050633.GZ5942@spearce.org>
	 <56b7f5510704302241n79601619kda8251a9f7776884@mail.gmail.com>
	 <20070501060340.GD5942@spearce.org>
	 <alpine.LFD.0.98.0705011318000.6574@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue May 01 19:58:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hiwcr-0004Oc-Dj
	for gcvg-git@gmane.org; Tue, 01 May 2007 19:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755174AbXEAR6y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 13:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755185AbXEAR6y
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 13:58:54 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:54466 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755174AbXEAR6x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 13:58:53 -0400
Received: by nz-out-0506.google.com with SMTP id o1so2292039nzf
        for <git@vger.kernel.org>; Tue, 01 May 2007 10:58:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ak61unxdAorK3l6i6qxdu02f3nI6hrBZs/YUDRVl2q1CIasuHkvKGreXvZBEGUvF7m+ephB90ouedUnMWCPC4ynkA3JKhghU7G960PMox8S8eJNArdLgJXHodCER+8HZoKCsKHRqzbAsQ0b5YZvL6hM24hkBL91zuKbBXTv4pf8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lau/7LnHerTu5UpEyDUvaU8KD4I6eghsO0Ak1jSndwW+OP5CBuNz45C4u1LHuvbFqrRqRUJupqBmfN/QnL7W+rKZDXGEoGdeJZkGyH9qAQ+QYrHBuoymsnj1Eb2/WBlPhpR6qdJbmqfERYyXZWlnFWhvdOPgJhZWqXVlfZVjPPY=
Received: by 10.115.17.1 with SMTP id u1mr2455072wai.1178042332384;
        Tue, 01 May 2007 10:58:52 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Tue, 1 May 2007 10:58:52 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0705011318000.6574@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45965>

On 5/1/07, Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 1 May 2007, Shawn O. Pearce wrote:
> > Dana How <danahow@gmail.com> wrote:
> > > On 4/30/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > > > Why not
> > > > refactor both to use the same implementation and stuff it away in
> > > > say pack-check.c (for lack of a better place), or start a new file
> > > > (pack-write.c)?
> > > Actually I didn't just copy it, I tried to rewrite it for my use
> > > as well as the fast-import.c use (note there is a 3rd copy
> > > in some *index*.c file which I didn't try to merge in yet).
> > > However I didn't yet put it in a new file or change fast-import.c
> > > to call it since I wanted to change as little as possible.
> > ...
> > > I agree with all your arguments.  I had several reasons
> > > to avoid extra rearrangements/refactorings:
> > > (a) First patch to git, not previously known to me;
> > > (b) I prefer to separate new functionality from "clean-up" work;
> >
> > A really good reason.  ;-)
> >
> > But I'd still rather see it done right the first time, then done
> > partially (copied) and wait for someone to clean it up later.
> > Sometimes that cleanup doesn't happen.
>
> Well I intended to do more cleanups in the pack code eventually.  That
> included the index writing and pack header fixing.  But I was expecting
> for the pack splitting changes to go in first as it is likely to impose
> some requirements of its own. It is then easier to have a proper
> interface common to all users after everything is in place.
I was in the middle of creating pack-write.c at Shawn's suggestion.
It will only contain fixup_header_footer(), to be called by fast-import.c
and builtin-pack-object.c.  index-pack.c also has
readjust_pack_header_and_sha1(),
which is compatible except it doesn't close the file.  I was going to leave it
alone for now.  This new file should be the logical place to put other common
pack-writing-related things.  Please barf now if you don't think I
should do this
tiny refactoring at this point.

> > > I'd have no problem submitting a follow-on patch later containing
> > > some clean-up work if you & NP clear it, so I know I won't have
> > > problems from (d).  Note I had to completely rewrite this patch
> > > when NP submitted some of his pending stuff.
> >
> > Yea, hazard of working in this part of the code when Nico is
> > also active.  My own sliding mmap stuff was written twice too,
> > for the same reason - Nico doing much needed improvements right in
> > the same spot as I was working, at the same time.
>
> Well well.  OK I'm used to be considered as the bad guy anyway.  ;-)
You *did* tell me about your upcoming patches as I recall ;-)

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
