From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 01/02/RFC] implement a stat cache
Date: Mon, 21 Apr 2008 10:41:41 +0200
Message-ID: <200804211041.41760.johan@herland.net>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl>
 <alpine.LFD.1.10.0804201556290.2779@woody.linux-foundation.org>
 <20080421005340.GA2631@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Luciano Rocha <luciano@eurotux.com>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 10:43:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnrcD-0006uP-TD
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 10:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753935AbYDUImW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 04:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753834AbYDUImV
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 04:42:21 -0400
Received: from smtp.getmail.no ([84.208.20.33]:58011 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753423AbYDUImV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 04:42:21 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JZO0063G2UHU500@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 21 Apr 2008 10:42:17 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZO00FDW2TIHQC0@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 21 Apr 2008 10:41:42 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZO00IAL2TH08C0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 21 Apr 2008 10:41:42 +0200 (CEST)
In-reply-to: <20080421005340.GA2631@dpotapov.dyndns.org>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80014>

On Monday 21 April 2008, Dmitry Potapov wrote:
> On Sun, Apr 20, 2008 at 04:07:35PM -0700, Linus Torvalds wrote:
> > Junio, what was the logic for that whole "has_symlink_leading_path()"
> > thing? I forget. Whatever, it's broken.
> 
> ===
> commit f859c846e90b385c7ef873df22403529208ade50
> Author: Junio C Hamano <junkio@cox.net>
> Date:   Fri May 11 22:11:07 2007 -0700
> 
[snip snip]
> ===
> 
> And there are some cases where stat() on path is desirable:
> http://www.spinics.net/lists/git/msg63988.html
> 
> So while stat information for regular files is cached in the index,
> stat information for directories is not cached, and that appears to
> be wrong. Maybe, Lucano's cache makes sense if it stores only stat
> information for directories.
> 
> IIRC, some time ago, an otherwise reasonable patch for .gitignore was
> rejected just because it would drive the number calls to lstat() up as
> these calls on directories are not cached in the index.

Pardon me for butting in (and I'm honestly NOT trying to start a flamewar),
but I'm wondering if this could be solved by tracking directories in the
index. AFAICS it would:

- Help bring the number of lstat() calls down (since we can cache the
  lstat() results for directories like we currently do for regular files)

- More easily detect complicated cases like "add across symlinks" (see
  Junio's email at the spinics.net link above)

- (less important) When discussing empty directory support several months
  ago, ISTR one of the biggest hurdles being that directories were not
  tracked in the index


I don't know much about how the index is implemented (few do, I think), so
if there is a glaringly obvious reason why tracking directories in the
index is a bad idea, please enlighten me.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
