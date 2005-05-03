From: Chris Wedgwood <cw@f00f.org>
Subject: Re: Careful object writing..
Date: Tue, 3 May 2005 12:27:53 -0700
Message-ID: <20050503192753.GA6435@taniwha.stupidest.org>
References: <Pine.LNX.4.58.0505031204030.26698@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 21:22:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT2xs-0001nt-Uq
	for gcvg-git@gmane.org; Tue, 03 May 2005 21:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVECT2A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 15:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVECT2A
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 15:28:00 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:23720 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261625AbVECT16 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 15:27:58 -0400
X-ORBL: [67.124.119.21]
Received: from taniwha.stupidest.org (adsl-67-124-119-21.dsl.snfc21.pacbell.net [67.124.119.21])
	by pimout2-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id j43JRsFh131354;
	Tue, 3 May 2005 15:27:54 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id 37F46528F22; Tue,  3 May 2005 12:27:53 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505031204030.26698@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, May 03, 2005 at 12:15:08PM -0700, Linus Torvalds wrote:

> So now I do it "right", and create a temporary file in the "top"
> object directory, and then when it's all done, I do a "link()" to
> the final place and unlink the original.

how is this better than a single rename?  i take it there is something
fundamental from clue.101 i slept though here?

also, if you are *really* paranoid you want to fsync *before* you do
the link/unklink or rename --- which is what MTAs do[1]

however, that said it *kills* performance and if it's not critical
it's really a terrible idea

also, shouldn't HEAD (and similar)[2] be updated with a temporary and
a rename too?

> I also change the permission to 0444 before it gets its final name.

cool

> NOTE NOTE NOTE! I have _not_ updated all the helper stuff that also
> write objects.

i thought this was all common code?  if it's not maybe now is the time
to change that?



[1] yes, i know this depends on the fs used and various things and
    ext3 should be fine, blah blah blah, but not everyone uses ext3
    and quite probably not everyone will use git under Linux

[2] i didn't check the code as i'm still using BK in places
