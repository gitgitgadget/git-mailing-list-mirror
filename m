From: "Zed A. Shaw" <zedshaw@zedshaw.com>
Subject: suffix array/tree deltas (Was: The criss-cross merge case)
Date: Wed, 27 Apr 2005 23:41:40 -0400
Organization: ZedShaw.com
Message-ID: <1114659700.5910.10.camel@thamachine>
References: <Pine.LNX.4.21.0504271854240.30848-100000@iabervon.org>
Reply-To: zedshaw@zedshaw.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Apr 28 05:36:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQzp3-00014s-La
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 05:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVD1Dlo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 23:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVD1Dlo
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 23:41:44 -0400
Received: from smtp04.mrf.mail.rcn.net ([207.172.4.63]:50756 "EHLO
	smtp04.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id S261853AbVD1Dlm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 23:41:42 -0400
Received: from 207-237-211-198.c3-0.80w-ubr3.nyr-80w.ny.cable.rcn.com (HELO thamachine) (207.237.211.198)
  by smtp04.mrf.mail.rcn.net with ESMTP; 27 Apr 2005 23:41:42 -0400
X-IronPort-AV: i="3.92,135,1112587200"; 
   d="scan'208"; a="27681752:sNHT21934932"
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0504271854240.30848-100000@iabervon.org>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-04-27 at 19:32 -0400, Daniel Barkalow wrote:
> On Wed, 27 Apr 2005, Bram Cohen wrote:
> 

> My plan is to implement multi-file diff and merge with a suffix tree-based
> algorithm, and then revisit the history stuff once we have a merger that
> can do sensible things with this information.

Hey, that's neat.  I've already implemented two versions of this very
thing with FastCST.  The original used suffix trees, but I found that
there were plenty of pathological cases which chewed memory and
processor.  Most of these cases were large (>1MB) PDF files.  Don't ask
me why PDF drove suffix tree algorithms insane, but they just did.

I recently switched to a suffix array based algorithm which actually
ends up being faster than the suffix tree alternative.  I'm not using
the most recent fastest algorithm and it still compares favorably with
xdelta.

There's tons of weird things about doing a delta based on suffix
arrays/trees, so feel free to pick my brain or the FastCST code if you
attempt it.  The difficult parts turn out to be making the suffix array
and searching for the matching/non-matching regions.  Once you do that
the actual delta algorithm is a simple while loop that keeps doing the
match/non-match detection.

Zed
