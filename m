From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Tue, 14 Feb 2006 17:07:47 +0100
Message-ID: <20060214160747.GA6350@diana.vm.bytemark.co.uk>
References: <20060210195914.GA1350@spearce.org> <20060210211740.GO31278@pasky.or.cz> <20060213210001.GA31278@pasky.or.cz> <tnxoe1aqoj2.fsf@arm.com> <20060214100844.GA1234@diana.vm.bytemark.co.uk> <43F1F5CB.10402@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 17:13:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F92ik-0007Ib-HR
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 17:08:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161096AbWBNQID convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 14 Feb 2006 11:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161104AbWBNQID
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 11:08:03 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:37134 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1161096AbWBNQIC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 11:08:02 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1F92iR-0001t3-00; Tue, 14 Feb 2006 16:07:47 +0000
To: Chuck Lever <cel@citi.umich.edu>
Content-Disposition: inline
In-Reply-To: <43F1F5CB.10402@citi.umich.edu>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16138>

On 2006-02-14 10:22:51 -0500, Chuck Lever wrote:

> Karl Hasselstr=F6m wrote:
>
> > One thing I would like to see in stgit is the opposite of "stg
> > commit"; instead of converting patches to regular commits, take
> > the topmost regular commits and convert them to patches.
> >
> > For example, "stg uncommit foo bar baz" would -- regardless of any
> > existing patches, applied or not -- convert the top three regular
> > commits, with comments and all, to stgit patches called foo, bar,
> > and baz. These would be already applied, at the bottom of the
> > stack. I imagine all one would have to do is to modify some stgit
> > metadata, so the operation could be really cheap.
> >
> > Of course, "stg uncommit" is allowed to reject any commit with
> > more than one parent, since those can't be represented as stgit
> > patches.
> >
> > This would perhaps not add much power to an all-stgit workflow,
> > but it would be a really convenient way to edit recent git
> > history. Sort of like a more convenient rebase. And a great way to
> > lure new users. :-)
>
> i think you want "stg pick --reverse" ?

No, I literally want the opposite of "stg commit", so that the
sequence "stg commit; stg uncommit" has zero net effect.

Say we have the following situation (stack growing downward, of
course):

          :
          |
          a
          |
          b
          |
          c <- bases/master
          |
          d <- applied patch "foo"
          |
          e <- applied patch "bar"; HEAD
          |
          f <- unapplied patch "baz"
          |
          :

In this situation, the hypothetical "stg uncommit" command would have
the following effect:

  $ stg uncommit goo baa

          :
          |
          a <- bases/master
          |
          b <- applied patch "baa"
          |
          c <- applied patch "goo"
          |
          d <- applied patch "foo"
          |
          e <- applied patch "bar"; HEAD
          |
          f <- unapplied patch "baz"
          |
          :

Note that HEAD is unchanged; the only thing that has happend is that
stgit has taken over the topmost two commits, and turned them into
patches. No git operations whatsoever have taken place; all stgit had
to do was change the value of bases/master and add bookkeeping
information for the two new patches.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
