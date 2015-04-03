From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH 0/4] diff --cc: relax path filtering
Date: Fri, 3 Apr 2015 19:29:45 +0300
Message-ID: <20150403162945.GE8771@wheezy.local>
References: <1428006853-21212-1-git-send-email-max@max630.net>
 <20150402211310.GA22988@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 03 18:29:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye4Th-0002dm-W1
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 18:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670AbbDCQ3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 12:29:40 -0400
Received: from p3plsmtpa09-02.prod.phx3.secureserver.net ([173.201.193.231]:57142
	"EHLO p3plsmtpa09-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752524AbbDCQ3g (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Apr 2015 12:29:36 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-02.prod.phx3.secureserver.net with 
	id BUVY1q00E5B68XE01UVamJ; Fri, 03 Apr 2015 09:29:36 -0700
Content-Disposition: inline
In-Reply-To: <20150402211310.GA22988@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266715>

On Thu, Apr 02, 2015 at 05:13:10PM -0400, Jeff King wrote:
> On Thu, Apr 02, 2015 at 11:34:09PM +0300, Max Kirillov wrote:
> 
>> For diff --cc, paths fitering used to select only paths which have
>> changed in all parents, while diffing itself output hunks which are
>> changed in as few as 2 parents.
> 
> I'm confused about "used to" here. Is this a regression due to the
> combine-diff rewriting that happened in 2.0, or do you just mean "before
> this patch series, we used to do this other thing".

As far as I can see it was "always", at least since 1.8.0;
the test script did not work before that.

>> Fix intersect_paths() to add paths which have at least 2 changed
>> parents.
> 
> I'd worry a little that this is increasing the cost to do "log --cc", as
> it means we will have to open and look at extra files, and we may find
> in many cases that there aren't any interesting hunks. Which would imply
> we might want to put it behind a flag, rather than as the default
> ("--cc-me-harder").
> 
> But if I'm understanding the issue correctly, this should only matter
> for octopus merges.  That is, the old rule for looking at a path was "is
> there at least one parent whose content we took verbatim", but the new
> one is "are there are at least 2 parents whose content we did not take
> verbatim". With only two parents, those would be the same thing, I
> think.

Yes, I hope so. I tried to reproduce benchamrk which is in 8518ff8fabc
(git log --raw --no-abbrev --no-renames (-c|--cc) v3.10..v3.11),
and saw no difference. But my times was about 3 seconds, not
20 as there, andI cannot say my computer is very fast, so
probably I've done something wrong.

-- 
Max
