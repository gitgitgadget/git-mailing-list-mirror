From: Petr Baudis <pasky@suse.cz>
Subject: Re: TopGit: problem with patch series generation
Date: Wed, 13 Aug 2008 02:18:09 +0200
Message-ID: <20080813001809.GO10151@machine.or.cz>
References: <20080812161854.GB30067@lapse.rw.madduck.net>
	<8aa486160808121428t259f5340x6d1a14cadedac30c@mail.gmail.com>
	<20080812224155.GB15521@lapse.rw.madduck.net>
	<20080812225916.GN10151@machine.or.cz>
	<20080812231037.GC16481@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: vcs distro packaging discussion list
	<vcs-pkg-discuss@lists.alioth.debian.org>,
	Santi =?iso-8859-2?Q?B=E9jar?= <sbejar@gmail.com>,
	git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org Wed Aug 13 02:19:17 2008
Return-path: <vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org>
Envelope-to: gcpv-vcs-pkg-discuss@m.gmane.org
Received: from alioth.debian.org ([217.196.43.134])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT457-0001Jp-7F
	for gcpv-vcs-pkg-discuss@m.gmane.org; Wed, 13 Aug 2008 02:19:17 +0200
Received: from localhost ([127.0.0.1] helo=alioth.debian.org)
	by alioth.debian.org with esmtp (Exim 4.63)
	(envelope-from <vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org>)
	id 1KT44B-0007d0-8b
	for gcpv-vcs-pkg-discuss@m.gmane.org; Wed, 13 Aug 2008 00:18:19 +0000
Received: from w241.dkm.cz ([62.24.88.241] helo=machine.or.cz ident=postfix)
	by alioth.debian.org with esmtp (Exim 4.63)
	(envelope-from <pasky@machine.or.cz>) id 1KT442-0007cY-7l
	for vcs-pkg-discuss@lists.alioth.debian.org;
	Wed, 13 Aug 2008 00:18:15 +0000
Received: by machine.or.cz (Postfix, from userid 2001)
	id 3BD6C393A807; Wed, 13 Aug 2008 02:18:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080812231037.GC16481@lapse.rw.madduck.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on alioth.debian.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00 autolearn=ham
	version=3.2.3
X-BeenThere: vcs-pkg-discuss@lists.alioth.debian.org
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: Discussions on using VCS for distro packaging
	<vcs-pkg-discuss.lists.alioth.debian.org>
List-Unsubscribe: <http://lists.alioth.debian.org/mailman/listinfo/vcs-pkg-discuss>,
	<mailto:vcs-pkg-discuss-request@lists.alioth.debian.org?subject=unsubscribe>
List-Archive: <http://lists.alioth.debian.org/pipermail/vcs-pkg-discuss>
List-Post: <mailto:vcs-pkg-discuss@lists.alioth.debian.org>
List-Help: <mailto:vcs-pkg-discuss-request@lists.alioth.debian.org?subject=help>
List-Subscribe: <http://lists.alioth.debian.org/mailman/listinfo/vcs-pkg-discuss>,
	<mailto:vcs-pkg-discuss-request@lists.alioth.debian.org?subject=subscribe>
Sender: vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org
Errors-To: vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org
X-SA-Exim-Scanned: No (on alioth.debian.org); SAEximRunCond expanded to false
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92159>

On Tue, Aug 12, 2008 at 08:10:37PM -0300, martin f krafft wrote:
> also sprach Petr Baudis <pasky@suse.cz> [2008.08.12.1959 -0300]:
> > How should that work? Maybe there needs to be even an explicit support
> > for this - should TopGit just check the dependency tree when
> > sequencing the topic branches and have a step that says:
> > 
> > 	"I'm going to sequence branch A. If there is branch T that has
> > 	only already sequenced branches + branch A as dependencies,
> > 	use T's content instead of A."
> > 
> > Would that be satisfactory?
> 
> Yes, that's what I was thinking about, if I read you correctly.

But we _REALLY_ want to do this only for stage branches!

> > Of course, in the case of
> > 
> >         A1--A2--A3--A4--C
> >                        /
> >         B1--B2--B3--B4.
> > 
> > the sequenced branches would still be like
> > 
> >         A1--A2--A3--A4--B1--B2--B3--C
> > 
> > unless you create the T1..T4 branches manually.
> 
> Yes. Or add a dependency. I'd just prefer not to add a dependency
> where there is none; instead, I'd prefer if TopGit could be aided
> with the serialisation in cases when it cannot possibly make
> a proper decision.

Yes, and it should certainly warn you about this at any rate, and give
you a chance to resolve this manually - possibly taking advantage of
rerere.

So, my idea: tg export --quilt should set up and maintain a private
working branch where it merges all the exported branches, one-by-one
(possibly doing the sling as described above first). In case there is a
conflict, it either aborts or gives you a chance to resolve it and go on
with the export. It could also offer you to save your resolution in a
new tie branch for future auto-slinging, but it would be tricky to
figure out exactly what patches does it depend on.

Overally, I'd start simply with implementing the sequential merge and
forget about slinging resolutions from tie branches. The former should
be very simple and solve most of the cases, especially when using rerere.
For the hairy cases, you can just add a dependency for now - sort of
preliminary serialization. :-)

The slinging might be feasible, but would be much more complicated
to implement. I think this can simply wait.

But to be clear, I don't plean to do any of this myself in the near
future anyway, since this case is not that important for me - I now need
TopGit to support remote topic branches instead. So if this is a
priority for you, you need to implement this on your own. But the
sequential merge part should be really easy, just something like

	git checkout -b tmp
	foreach patch_branch
		git merge patch_branch
		cat .topmsg >output/patch.diff
		git diff HEAD^..HEAD >>output/patch.diff

with all the frills. ;-) (Maybe make a special "show diff between X and
Y instead of base and head" flag for tg patch so that we can rely on it
for the frills.)

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
