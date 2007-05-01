From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 8/8] git-repack --max-pack-size: add option parsing to enable feature
Date: Tue, 1 May 2007 02:27:14 -0400
Message-ID: <20070501062714.GE5942@spearce.org>
References: <46367ADC.2090704@gmail.com> <20070501054528.GC5942@spearce.org> <56b7f5510704302315v3d985dcfodb48fcd0bf49853f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 08:27:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hilpt-000285-Ol
	for gcvg-git@gmane.org; Tue, 01 May 2007 08:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbXEAG1U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 02:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031109AbXEAG1U
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 02:27:20 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33740 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030285AbXEAG1T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 02:27:19 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HilpT-0001pH-S3; Tue, 01 May 2007 02:27:16 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AF53120FBAE; Tue,  1 May 2007 02:27:14 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <56b7f5510704302315v3d985dcfodb48fcd0bf49853f@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45924>

Dana How <danahow@gmail.com> wrote:
> >I think this particular change needs to either preceed the prior
> >commit, or be part of it.  If someone tries to bisect this patch
> >series with a large enough project that multiple packfiles are being
> >produced then you run into some ugly problems in this repack script.
...
> Sorry, you lost me.  git is being bisected, or a project managed by git?
> My intent was that the pack splitting wouldn't be available until
> _all_ patches were applied (active).  Bisecting git _within_ this patchset
> would still be useful -- it could be used to isolate where some of
> this new code broke some pre-existing feature.

git bisecting itself, to search for bugs in itself...  In that
case a bisect could stop at any random point in the middle of this
series, even if this series isn't the one that is at fault for the
given breakage.  In such a case we try to hope that git.git is
always in a working state at any given commit.

On second thought looking at your series I see how you were able to
assure that here.  You didn't activate the option until the shell
script could also handle more than one name, so since the option
is not available in any prior commit there's no way to turn on the
multiple-name-output that git-repack.sh would have broken on.

But lets just say the 7/8 patch actually did break git, and we are
bisecting to look for it.  We wouldn't actually see the breakage
activate until 8/8, which is misleading, as the broken code is
actually in 7/8.  But if you are looking at 8/8 as broken and see
the lines broken, you can easily run git-blame to really figure
out what changed, and why.  So its not really a big deal that the
series is organized like this.  I blew it out of proportion.  :-)

-- 
Shawn.
