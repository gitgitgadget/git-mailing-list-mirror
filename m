From: Pete Wyckoff <pw@padd.com>
Subject: Re: git-p4 out of memory for very large repository
Date: Sat, 7 Sep 2013 04:19:05 -0400
Message-ID: <20130907081905.GA4377@padd.com>
References: <20130823011245.GA7693@jerec>
 <52170C6A.4080708@diamand.org>
 <20130823114856.GA8182@jerec>
 <20130825155001.GA875@padd.com>
 <20130826134756.GA1335@jerec>
 <20130828154135.GA16921@jerec>
 <20130829224609.GB25879@padd.com>
 <5224EA2C.7090001@diamand.org>
 <20130906190345.GA3239@jerec>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: Corey Thompson <cmtptr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 07 10:13:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIDeW-0002Ou-6y
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 10:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039Ab3IGINi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 04:13:38 -0400
Received: from honk.padd.com ([74.3.171.149]:46252 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032Ab3IGINf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 04:13:35 -0400
Received: from tic.padd.com (82-69-2-221.dsl.in-addr.zen.co.uk [82.69.2.221])
	by honk.padd.com (Postfix) with ESMTPSA id 278711E1D;
	Sat,  7 Sep 2013 01:13:34 -0700 (PDT)
Received: by tic.padd.com (Postfix, from userid 1000)
	id AF5561011FE; Sat,  7 Sep 2013 04:19:05 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20130906190345.GA3239@jerec>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234117>

cmtptr@gmail.com wrote on Fri, 06 Sep 2013 15:03 -0400:
> Finally, I claim success!  Unfortunately I did not try either of the OOM
> score or strace suggestions - sorry!  After spending so much time on
> this, I've gotten to the point that I'm more interested in getting it to
> work than in figuring out why the direct approach isn't working; it
> sounds like you're both pretty confident that git is working as it
> should, and I don't maintain the system I'm doing this on so I don't
> doubt that there might be some artificial limit or other quirk here that
> we just aren't seeing.
> 
> Anyway, what I found is that Pete's incremental method does work, I just
> have to know how to do it properly!  This is what I WAS doing to
> generate the error message I pasted several posts ago:
> 
> git clone //path/to/branch@<begin>,<stage1>
> cd branch
> git sync //path/to/branch@<stage2>
> # ERROR!
> # (I also tried //path/to/branch@<stage1+1>,<stage2>, same error)
> 
> Eventually what happened is that I downloaded the free 20-user p4d, set
> up a very small repository with only 4 changes, and started some old
> fashioned trial-and-error.  Here's what I should have been doing all
> along:
> 
> git clone //path/to/branch@<begin>,<stage1>
> cd branch
> git sync //path/to/branch@<begin>,<stage2>
> git sync //path/to/branch@<begin>,<stage3>
> # and so on...
> 
> And syncing a few thousand changes every day over the course of the past
> week, my git repo is finally up to the Perforce HEAD.  So I suppose
> ultimately this was my own misunderstanding, partly because when you
> begin your range at the original first change number the output looks
> suspiciously like it's importing changes again that it's already
> imported.  Maybe this is all documented somewhere, and if it is I just
> failed to find it.
> 
> Thanks to both of you for all your help!

That you got it to work is the most important thing.  Amazing all
the effort you put into it; a lesser hacker would have walked
away much earlier.

The changes don't overlap.  If you give it a range that includes
changes already synced, git-p4 makes sure to start only at the
lowest change it has not yet seen.  I'll see if I can update the
docs somewhere.

		-- Pete
