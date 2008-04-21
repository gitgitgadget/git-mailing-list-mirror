From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 01/02/RFC] implement a stat cache
Date: Mon, 21 Apr 2008 12:04:37 +0200
Message-ID: <85d4ojseve.fsf@lola.goethe.zz>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl>
	<alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org>
	<FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl>
	<alpine.LFD.1.10.0804191515120.2779@woody.linux-foundation.org>
	<20080420111346.GA13411@bit.office.eurotux.com>
	<alpine.LFD.1.10.0804200836310.2779@woody.linux-foundation.org>
	<20080420215700.GA18626@bit.office.eurotux.com>
	<alpine.LFD.1.10.0804201520370.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luciano Rocha <luciano@eurotux.com>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 21 12:06:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnsu3-0008Ls-Cx
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 12:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754971AbYDUKEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 06:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754872AbYDUKEx
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 06:04:53 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:41527 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754798AbYDUKEw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Apr 2008 06:04:52 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id D06E73027FD;
	Mon, 21 Apr 2008 12:04:45 +0200 (CEST)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id BBE5C2130B8;
	Mon, 21 Apr 2008 12:04:45 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-038-079.pools.arcor-ip.net [84.61.38.79])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 88F3531D8EA;
	Mon, 21 Apr 2008 12:04:45 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id E2A761C39587; Mon, 21 Apr 2008 12:04:37 +0200 (CEST)
In-Reply-To: <alpine.LFD.1.10.0804201520370.2779@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 20 Apr 2008 15:29:02 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92.1/6861/Mon Apr 21 09:50:29 2008 on mail-in-13.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80018>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So I do think your stat cache could be improved, but for the reasons I
> outlined I would much prefer to make it unimportant instead.

Using a cache for a single algorithmic task is probably a mistake: a
cache tries to keep some data around on the assumption that it might get
used.  So it tends to either waste lots of memory or keep the wrong
data.  And the reloads increase with the size of the processed data.

Using a sorted-traverse-and-merge algorithm instead never needs to
reload data and relinquishes it as soon as it is no longer needed.

A stat cache is fine for an operating system which has no clue about
what access patterns to except next.

But in this case, our application has the whole task outlines in
advance, and it makes sense organizing it in the best manner.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
