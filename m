From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Something is broken in repack
Date: Tue, 11 Dec 2007 10:36:20 -0500
Message-ID: <9e4733910712110736w34495ba2l86b2de82055620fd@mail.gmail.com>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
	 <9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com>
	 <alpine.LFD.0.99999.0712102231570.555@xanadu.home>
	 <9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com>
	 <9e4733910712102129v140c2affqf2e73e75855b61ea@mail.gmail.com>
	 <9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com>
	 <alpine.LFD.0.99999.0712110832251.555@xanadu.home>
	 <alpine.LFD.0.99999.0712110951070.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, gcc@gcc.gnu.org,
	"Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 16:36:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J27A3-0005KD-Uv
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 16:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366AbXLKPgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 10:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752396AbXLKPgW
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 10:36:22 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:61048 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbXLKPgV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 10:36:21 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2074759rvb
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 07:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=zrR1qauTPbFT3JaH1AISUkad8HHGJSN660KT4oAyQRw=;
        b=FcOTkl1K7Fu6lz3EpfnzK5+6ZxYOJrxZ+2Zl5fnMnUkkhtWi1RoKAGCkJ0bBQuUdowiHw3LE89fh6JlKBVFCC7Ej4pIzfjWMBBtJQJ3h99gXd6cehcl+QDOFlTYljgS20U7/OQCXPg3sotfR0G3zii9UUDfNbd4GCCt3F26sl8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jvWmCy77p99YuPlKURNdgKc5Y2kI/Lz2M8A2JnFy4yU8psDe8CPGHN/foVF9J04LpVZK5qLfNmBu2QDrtPgavvbDzg/JLpzw93y74fDR0V8FgSARU63Q3woMDlUdRcNCuoFTwSwD4hP1Kptymk5cAJo97b09vzwEP6ZsbdkZxQg=
Received: by 10.141.164.10 with SMTP id r10mr5084043rvo.1197387380697;
        Tue, 11 Dec 2007 07:36:20 -0800 (PST)
Received: by 10.140.166.14 with HTTP; Tue, 11 Dec 2007 07:36:20 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0712110951070.555@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67874>

On 12/11/07, Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 11 Dec 2007, Nicolas Pitre wrote:
>
> > And yet, this is still missing the actual issue.  The issue being that
> > the 2.1GB pack as a _source_ doesn't cause as much memory to be
> > allocated even if the _result_ pack ends up being the same.
> >
> > I was able to repack the 2.1GB pack on my machine which has 1GB of ram.
> > Now that it has been repacked, I can't repack it anymore, even when
> > single threaded, as it start crowling into swap fairly quickly.  It is
> > really non intuitive and actually senseless that Git would require twice
> > as much RAM to deal with a pack that is 7 times smaller.
>
> OK, here's something else for you to try:
>
>         core.deltabasecachelimit=0
>         pack.threads=2
>         pack.deltacachesize=1
>
> With that I'm able to repack the small gcc pack on my machine with 1GB
> of ram using:
>
>         git repack -a -f -d --window=250 --depth=250
>
> and top reports a ~700m virt and ~500m res without hitting swap at all.
> It is only at 25% so far, but I was unable to get that far before.
>
> Would be curious to know what you get with 4 threads on your machine.

Changing those parameters really slowed down counting the objects. I
used to be able to count in 45 seconds now it took 130 seconds. I am
still have the Google allocator linked in.

4 threads, cumulative clock time
25%     200 seconds, 820/627M
55%     510 seconds, 1240/1000M - little late recording
75%     15 minutes, 1658/1500M
90%      22 minutes, 1974/1800M
it's still running but there is no significant change.

Are two types of allocations being mixed?
1) long term, global objects kept until the end of everything
2) volatile, private objects allocated only while the object is being
compressed and then freed

Separating these would make a big difference to the fragmentation
problem. Single threading probably wouldn't see a fragmentation
problem from mixing the allocation types.

When a thread is created it could allocated a private 20MB (or
whatever) pool. The volatile, private objects would come from that
pool. Long term objects would stay in the global pool. Since they are
long term they will just get laid down sequentially in memory.
Separating these allocation types make things way easier for malloc.

CPU time would be helped by removing some of the locking if possible.

-- 
Jon Smirl
jonsmirl@gmail.com
