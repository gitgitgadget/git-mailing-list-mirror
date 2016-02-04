From: Mike Hommey <mh@glandium.org>
Subject: Re: Bug: Branch Deletion Doesn't Clean Up
Date: Thu, 4 Feb 2016 17:12:20 +0900
Message-ID: <20160204081220.GA11434@glandium.org>
References: <4AC354E1-9E78-42A8-9828-BF1C084A6CBB@me.com>
 <20160204075500.GA21161@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Karl Moskowski <kmoskowski@me.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 04 09:13:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRF2e-0003Kk-Ek
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 09:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbcBDIMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 03:12:48 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:37942 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752004AbcBDIMr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 03:12:47 -0500
Received: from glandium by zenigata with local (Exim 4.86)
	(envelope-from <mh@glandium.org>)
	id 1aRF1Y-0002zy-5A; Thu, 04 Feb 2016 17:12:20 +0900
Content-Disposition: inline
In-Reply-To: <20160204075500.GA21161@sigill.intra.peff.net>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285409>

On Thu, Feb 04, 2016 at 02:55:00AM -0500, Jeff King wrote:
> [resend; sorry, I forgot to cc Michael on the first one]
> 
> On Thu, Jan 07, 2016 at 02:24:41PM -0500, Karl Moskowski wrote:
> 
> > The problem is, deleting a branch whose name contains slashes doesn’t
> > delete the directories in .git/refs/heads/.
> 
> Yes. Git's model is to leave the directories in place, and remove them
> only when they get in the way of creating another ref. In theory, the
> effect is the same as deleting the directories proactively.
> 
> But as you noticed, it does funny things with case-preserving
> filesystems. It also can cause performance problems if you have a very
> large number of empty directories (because git has to open each of them
> just to find out they're empty).
> 
> We can into the latter case at GitHub. Michael Haggerty (cc'd) worked up
> some patches recently for this, but I don't now if they're yet polished
> enough to send upstream.
> 
> > It seems like git branch -d ascend the hierarchy (up to
> > .git/refs/heads/), deleting any empty directories.
> 
> Yes, though it needs to be coupled with making the branch-creation
> process more robust to races (since we might create "refs/heads/foo" in
> order to make "refs/heads/foo/bar" while somebody else is deleting it to
> get rid of "refs/heads/foo/baz").

Can't we come up with a system that would update packed-refs directly
instead of creating files?

Mike
