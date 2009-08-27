From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCHv4 08/12] Teach the notes lookup code to parse notes
	trees with various fanout schemes
Date: Thu, 27 Aug 2009 14:27:10 -0700
Message-ID: <20090827212710.GV1033@spearce.org>
References: <1251337437-16947-1-git-send-email-johan@herland.net> <1251337437-16947-9-git-send-email-johan@herland.net> <7v7hwp6ebb.fsf@alter.siamese.dyndns.org> <200908271135.31794.johan@herland.net> <7vtyztq8nv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, trast@student.ethz.ch,
	tavestbo@trolltech.com, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 23:27:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgmV4-0008Kt-Ut
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 23:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177AbZH0V1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 17:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753145AbZH0V1J
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 17:27:09 -0400
Received: from george.spearce.org ([209.20.77.23]:55413 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbZH0V1J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 17:27:09 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B2A23381FE; Thu, 27 Aug 2009 21:27:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vtyztq8nv.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127214>

Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
> > 2. Simply decide on a constant 2/2/36 fanout.
> 
> I thought it was Gitney who suggested to use a top-level fan-out based on
> the committer-date.  If you typically have already parsed the commit when
> you want to look up notes objects for it, it won't have extra overhead,
> and when looking at only recent history it will only need to access a
> small subset of trees.  I thought it was a neat idea (except that the
> question becomes what the granularity of the top level fan-out should
> be---one a day?  one a month?---the optimum would depend on commit
> density).  Was that idea shot down for some reason?

Yea, it was me.  I still think it might be a useful idea, since
it allows you better density of loading notes when parsing the
recent commits.  In theory the last 256 commits can easly be in
each of the 2/ fanout buckets, making 2/38 pointless for reducing
the search space.  Commit date on the other hand can probably force
all of them into the same bucket, making it easy to have the last
256 commits in cache, from a single bucket.

But I thought you shot it down, by saying that we also wanted to
support notes on blobs.  I happen to see no value in a note on
a blob, a blob alone doesn't make much sense without at least an
annotated tag or commit to provide it some named context, and the
latter two have dates.

-- 
Shawn.
