From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: blame now knows -S
Date: Sat, 8 Apr 2006 15:53:56 +0200
Message-ID: <e5bfff550604080653l2c73f844n8e03e55f9c467039@mail.gmail.com>
References: <7v1ww9loon.fsf@assigned-by-dhcp.cox.net>
	 <20060408114240.GA10137@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Martin Langhoff" <martin@catalyst.net.nz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 08 15:54:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSDtS-0002Px-1F
	for gcvg-git@gmane.org; Sat, 08 Apr 2006 15:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbWDHNx5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Apr 2006 09:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWDHNx5
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Apr 2006 09:53:57 -0400
Received: from wproxy.gmail.com ([64.233.184.230]:60583 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964918AbWDHNx4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 8 Apr 2006 09:53:56 -0400
Received: by wproxy.gmail.com with SMTP id i11so487344wra
        for <git@vger.kernel.org>; Sat, 08 Apr 2006 06:53:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WZc2Ax8EycyB1WcHiihCvU6MpviB/yUPNWBEGMk3UU6ykjOl2UNhZ8Ea3qhAt7FK9X2hJ61D7fcYC6jxS0PUluNaU4UKHo8qnGJsAnL9/wvn94PYcZbvn1gWVl/3VnJuLQ2ixFges9SuTj2wJjqWJgLM5s0kZ1S+jbVEIU2Noac=
Received: by 10.65.206.19 with SMTP id i19mr630813qbq;
        Sat, 08 Apr 2006 06:53:56 -0700 (PDT)
Received: by 10.64.131.14 with HTTP; Sat, 8 Apr 2006 06:53:56 -0700 (PDT)
To: "Fredrik Kuivinen" <freku045@student.liu.se>
In-Reply-To: <20060408114240.GA10137@c165.ib.student.liu.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18517>

On 4/8/06, Fredrik Kuivinen <freku045@student.liu.se> wrote:
> On Fri, Apr 07, 2006 at 02:28:40AM -0700, Junio C Hamano wrote:
> > I've made a few changes to "git blame" myself:
> >
> >  - fix breakage caused by recent revision walker reorganization;
> >  - use built-in xdiff instead of spawning GNU diff;
> >  - implement -S <ancestry-file> like annotate does.
> >
> > Depending on the density of changes, it now appears that blame
> > is 10%-30% faster than annotate.  I thought CVS emulator might
> > be interested to give it a whirl..
> >
>
> Nice work!
>
> There is another possible optimisation with respect to xdiff. Instead
> of producing the diff on the xdiff side and parsing the diff in
> blame.c, we could add another call back which just gets the relevant
> information from the hunk header. I don't know how much we would gain
> from this, but it might be worth a try.
>

If I can comment on this thread, I would like to note IMHO that given
the differences in
languages (C vs Perl) and the use of almost the same algorithm, just a
10%-30% in speed difference between blame and annotate it means that
any further optimization can gain little because the bottleneck is
elsewhere.

And I think is in getting the revision's history. Call it
git-rev-list, although both
blame and annotate use directly the library revision.h

After the new xdiff merge, git-rev-list accounts for almost whole the time.
Normally more then 80% in qgit.

Although the qgit annotation algorithm is different from both blame
and annotate I think
that a faster git-rev-list <path> or revison history walker as you may
want to call it it's a key
in really speed-up annotation stuff.

    Marco
