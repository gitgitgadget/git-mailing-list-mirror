From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git push failure with update hook success
Date: Wed, 7 Mar 2007 12:09:04 -0500
Message-ID: <20070307170904.GB27922@spearce.org>
References: <17902.59497.831409.218529@lisa.zopyra.com> <17902.60536.5890.608883@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 18:09:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOzdi-0005LK-7D
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 18:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422749AbXCGRJJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 12:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422744AbXCGRJJ
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 12:09:09 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43728 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422746AbXCGRJI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 12:09:08 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HOzdL-0002on-Ub; Wed, 07 Mar 2007 12:09:00 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6E14620FBAE; Wed,  7 Mar 2007 12:09:04 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <17902.60536.5890.608883@lisa.zopyra.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41678>

Bill Lear <rael@zopyra.com> wrote:
> On Wednesday, March 7, 2007 at 10:29:29 (-0600) Bill Lear writes:
> >...
> >whether it might be better to call the update hook after everything
> >had actually been written, including the log file.
> 
> I dug into the code: in receive-pack.c, the command 'update(struct
> command *cmd)', calls write_ref_sha1() after run_update_hook()
> and does not check the return code of write_ref_sha1().

Please see the patch I just posted (and CC'd you on).  We should
have caught the return error of write_ref_sha1, the patch now
does that.  :)

You probably want to use the post-update hook to send email.
This hook will always run if it exists and is executable, but it
won't be given a ref that failed to be updated.

Of course an unfortunate downside to the post-update hook is it
does not receive the old SHA-1 of the ref; it just gets the ref name.

-- 
Shawn.
