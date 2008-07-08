From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 0/2] push optimizations
Date: Tue, 8 Jul 2008 06:36:22 +0200
Message-ID: <20080708043622.GC2247@diana.vm.bytemark.co.uk>
References: <20080702060113.11361.39006.stgit@yoghurt> <b0943d9e0807071412j71780300p87d00cccea6cd8f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 06:38:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG4yb-0005Np-8j
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 06:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbYGHEg3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jul 2008 00:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbYGHEg3
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 00:36:29 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3053 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbYGHEg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 00:36:29 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KG4wA-0000gk-00; Tue, 08 Jul 2008 05:36:22 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0807071412j71780300p87d00cccea6cd8f4@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87707>

On 2008-07-07 22:12:26 +0100, Catalin Marinas wrote:

> 2008/7/2 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > Here's the git-apply call you asked for. You were right: it was a
> > huge speed-up.
>
> I know, I've been through this couple of years ago :-)

:-P

> > I set up a benchmark to test it:
> >
> >  * 32 directories, each containing 32 subdirectories, each
> >    containing 32 small (and different) files.
>
> Can you try with a Linux kernel like the -mm tree? You get normally
> sized patches which might show a difference with the patch log. You
> can clone the for-akpm branch on git://linux-arm.org/linux-2.6 and
> just uncommit ~300 patches.

Sure, I'll do that. (But one of the reasons I chose a fully synthetic
benchmark is that I wanted to start a performance suite similar to our
test suite, and we want such a thing to be repeatable but not too
large. (That said, operating on points of the kernel history that are
fixed should do the trick as well. I'll try to find such points -- a
long string of -mm patches somewhere in the history maybe?))

> >  * I set all this up with a python script feeding fast-import. A
> >    huge time-saver!
>
> What is fast-import?

man git-fast-import

I'll try to clean up and publish the script I used.

> >  * Pop patches, git-reset to upstream, then goto top patch. This
> >    makes sure that we use the new infrastructure to push, and that
> >    we get one file-level conflict in each patch.
> >
> > Before the first patch, the "goto" command took 4:27 minutes,
> > wall-clock time. After the first patch, it took 1:31. After the
> > second, 0:48; one second or so slower than the stable branch
> > (which does not have a patch stack log).
>
> One second is just noise and depends on how warm the caches are. You
> could run a few times consecutively and discard the first result but
> we don't need to be that accurate.

I did run a few times, and it did indeed fluctuate some -- but I'm
pretty sure there was a measurable slowdown. Though I agree that it's
close enough that it doesn't really make a difference.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
