From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Perform minimal stat comparison when some stat fields
 are not set
Date: Thu, 6 Dec 2012 12:16:27 +0100 (CET)
Message-ID: <578723621.19434897.1354792587152.JavaMail.root@dewire.com>
References: <50C0475F.1030206@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	spearce@spearce.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Dec 06 12:16:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgZRd-0007FP-2p
	for gcvg-git-2@plane.gmane.org; Thu, 06 Dec 2012 12:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423141Ab2LFLQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2012 06:16:29 -0500
Received: from zimbra.dewire.com ([83.140.172.131]:59284 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964890Ab2LFLQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2012 06:16:28 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 97930825F7;
	Thu,  6 Dec 2012 12:16:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UxckLwyr99Ee; Thu,  6 Dec 2012 12:16:27 +0100 (CET)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id 36B1D825F6;
	Thu,  6 Dec 2012 12:16:27 +0100 (CET)
In-Reply-To: <50C0475F.1030206@viscovery.net>
X-Originating-IP: [194.68.56.41]
X-Mailer: Zimbra 7.2.0_GA_2681 (ZimbraWebClient - FF3.0 (Win)/7.2.0_GA_2681)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211163>



----- Ursprungligt meddelande -----
> Am 12/6/2012 2:09, schrieb Robin Rosenberg:
> >> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
> >>> At least JGit does sets uid, gid, ctime, ino and dev fields to
> >>> zero
> >>> on update. To Git this looks like the stat data does not match
> >>> and
> >>> a full file compare will be forced even it size and mtime match.
> >>> This
> >>> is in practice unnecessary. Sense JGit's presence by checking if
> >>> ino
> >>> and dev is zero.
> 
> Is this meant to better support C git and JGit working on the same
> repository?
> 
> MinGW git sets these two stat fields to zero as well. But we have
> less of
> an interoparability problem between different git implementations in
> practice on Windows, I think.

It is purely for performance in some situations.

> >> Besides, is it sane to do this unconditionally to affect people
> >> who
> >> do not use JGit?
> > 
> > Would a config option like core.minstat be better? The name would
> > imply no dynamic detection.
> 
> A configuration option is the way to go. We already have
> core.trustctime,
> core.symlinks, core.filemode, core.ignoreCygwinFSTricks.
> 
> But your new mode is not "minimal". In some implementations or on
> some
> filesystems, even more bits of stat information could be meaningless
> (think of atime, rdev, nlink, uid, gid). Perhaps core.trustdevandino?

I already excluded uid and gid so the only thing left is mtime and size.
I can't see any reason for anyone to look at atime (somebody read the file,
so what?), ok for rdev and nlink, but we don not look at them my patch
does not avoid looking at them.

> Or
> an enumeration core.ignoreCacheStat=ctime,dev,ino?

That would mean only one configuration option. Good.

-- robin
