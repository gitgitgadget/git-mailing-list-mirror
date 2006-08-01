From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Diff format in packs
Date: Tue, 1 Aug 2006 14:16:46 +1200
Message-ID: <46a038f90607311916k5d130f70gc0ac26eb8f15fec0@mail.gmail.com>
References: <9e4733910607311408i10e17dse776920de7c5076a@mail.gmail.com>
	 <ealruh$sq9$1@sea.gmane.org>
	 <9e4733910607311420n8537b76lbde4d60062195403@mail.gmail.com>
	 <46a038f90607311747j947c786s6af2fe637dbde89d@mail.gmail.com>
	 <9e4733910607311813l78791e40l1234cf0e458db66f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 04:16:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7joT-00059f-Sh
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 04:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbWHACQs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 22:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030392AbWHACQs
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 22:16:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:14038 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030391AbWHACQr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 22:16:47 -0400
Received: by nf-out-0910.google.com with SMTP id o25so104233nfa
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 19:16:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gnjzaXSHyZk4i7jE6k3oKOrZkb3o9tn7Fg3COIQiHZK1A1PDAViM+6riohtVTo5x5JYD5JAdM2j8O0ioUlgKic3EFeacnyjoekWUpHOiYl6j3dLH5+vg0/EWowUnYpxZrn/P6powhGh/UsqgHF/56nwjeI4/lzjCa7w8AnMP1M8=
Received: by 10.78.166.7 with SMTP id o7mr103138hue;
        Mon, 31 Jul 2006 19:16:46 -0700 (PDT)
Received: by 10.78.120.17 with HTTP; Mon, 31 Jul 2006 19:16:45 -0700 (PDT)
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <9e4733910607311813l78791e40l1234cf0e458db66f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24564>

On 8/1/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 7/31/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> > Jon,
> >
> > just get all the file versions out of the ,v file and into the GIT
> > repo, then do find .git/objects/ -type f | git-pack-objects. You don't
> > have to even think of generating the packfile yourself.
>
> Moz CVS expands into over 1M files and 12GB in size. I keep getting
> concerned about algorithms that take days to complete and need 4GB to
> run.

If you run that every 1000 rcs files converted, it will be really
cheap in processing and memory footprint. That's not a concern.


> > On 8/1/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> > > I am working on combining cvs2svn, parsecvs and cvsps into something
> > > that can handle Mozilla CVS.
> >
> > If you publish your WIP somewhere, I might be able to jump in and help
> > a bit. I've seen your "challenge" email earlier, but haven't been able
> > to get started yet -- lots of work on other foss fronts.
>
> I haven't got anything useful yet, I keep switching in and out of
> working on this. I am still trying to work out a viable transition
> strategy that I can attempt to sell the Mozilla developers on. So far
> I don't have one.

I understand that, and it's a shame.

> The requirements I have so far:

Yep to 1..4. I suspect that you can get "there" with a converted
cvs2svn transformed to deal with git as your are pursuing, and in
dealing with the follow-on imports using git-cvsimport. The only real
limitation there is that new branches opened in that transition period
may be imported with the root in the wrong place.

But for "ongoing" branches, the setup works great. I've done in many
times with parsecvs for the initial import and git-cvsimport for the
subsequent incrementals.

> 5) a bonus feature would be a partial repository to avoid the initial
> 700MB git download.

Agreed. However, I thought I had gotten it to be much slimmer than
that, but I may be wrong. Also, a current Moz checkout via cvs is
massively chatty, so between bandwidth and latency, I think the git
protocol beats cvs for the initial checkout even for Moz.

> I've spent more time looking at parsecvs than cvsps, is it reasonable
> to convert cvsps to the algorithm described above? Another strategy

I don't think cvsps is easily fixable.

> would be to use cvs2svn to build the changeset database and then use
> cvsps to simply read the changesets out of it and build the git
> repository.

Once cvs2svn has the db built, it should be easy to write a
perl/python script that mimics the output of cvsps.

> Parsecvs never finishes the conversion it always hits an error or GPF
> after 4-5 hours, probably a wild pointer somewhere.

Hmmmm. Nag Keith?



martin
