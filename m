From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Error "fatal: cannot pread pack file: Success"
Date: Wed, 28 Feb 2007 12:43:39 -0500
Message-ID: <20070228174339.GE5924@spearce.org>
References: <17893.42063.186763.291346@lisa.zopyra.com> <20070228155412.GC5479@spearce.org> <17893.43522.511785.121778@lisa.zopyra.com> <17893.44181.129918.669187@lisa.zopyra.com> <20070228163256.GD5479@spearce.org> <118833cc0702280842g3e121fg601d7e102956ba93@mail.gmail.com> <20070228164922.GB5924@spearce.org> <17893.46083.869042.467318@lisa.zopyra.com> <20070228170641.GC5924@spearce.org> <17893.47007.136145.112498@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 18:43:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMSqA-0003Q0-9F
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 18:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbXB1Rnn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 12:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbXB1Rnn
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 12:43:43 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57683 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbXB1Rnm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 12:43:42 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HMSpy-0001Ws-Dq; Wed, 28 Feb 2007 12:43:34 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2762E20FBAE; Wed, 28 Feb 2007 12:43:39 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <17893.47007.136145.112498@lisa.zopyra.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40974>

Bill Lear <rael@zopyra.com> wrote:
> Yes: 1.4.x worked fine.  This was actually my attempt to re-do the 1.4
> clone I had laying around, as I wanted my backup done with 1.5.  I
> still have the 1.4 cloned repo, just moved it out of the way...

OK, is ~/devel/project fully packed?  If it isn't can you repack
it (or a clone of it) so that it is?

Then take the packfile and try to feed it right into index-pack:

	mkdir /austin/users/rael/repos/git/project-test
	cd /austin/users/rael/repos/git/project-test
	git --bare init
	git --bare index-pack --stdin --fix-thin \
	  <~/devel/project/.git/objects/pack/pack-*.pack

Now while that is running it should be creating pack_XXXXXX as a
temporary file (where XXXXXX is replaced with the temp string).
Its this file that we are seeing magically truncate to 0 in the
middle of running.

But I fail to see anything in index-pack that would cause this,
and its the only program that knows about this file at this stage
of the clone.

-- 
Shawn.
