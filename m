From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Why does diff --binary include content of files being deleted?
Date: Sat, 21 Jun 2008 23:51:18 -0400
Message-ID: <20080622035118.GD11793@spearce.org>
References: <20080622033454.GA10578@lifeintegrity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Allan Wind <allan_wind@lifeintegrity.com>
X-From: git-owner@vger.kernel.org Sun Jun 22 05:52:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAGdI-0001oH-Ox
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 05:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103AbYFVDvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 23:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752003AbYFVDvX
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 23:51:23 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41602 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbYFVDvW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 23:51:22 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KAGbc-0002DM-I7; Sat, 21 Jun 2008 23:51:08 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C1A8220FBAE; Sat, 21 Jun 2008 23:51:18 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080622033454.GA10578@lifeintegrity.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85747>

Allan Wind <allan_wind@lifeintegrity.com> wrote:
> Between tag1 and tag2 I am deleting a number of binary files, and I was 
> surprised seeing the binaries being added to the diff when said files
> are to be deleted:
> 
> git diff --binary tag1 tag2 > /tmp/diff && ls -l /tmp/diff
> -rw-r--r-- 1 allan users 555135993 2008-06-21 22:37 /tmp/diff
> 
> git diff tag1 tag2 > /tmp/diff2 && ls -l /tmp/diff2
> -rw-r--r-- 1 allan users 12862 2008-06-21 23:33 /tmp/diff2

In order to apply the diff in reverse we need the old binary data
in the diff output.  So that's why its larger.

In other words lets say you actually wanted to go back to tag1,
after having tag2 for a while:

	$ git checkout tag2
	$ git diff --binary tag1 tag2 | git apply --index -R

without the binary data in the diff, apply cannot run in the
reverse direction to restore back to tag1.  :)

-- 
Shawn.
