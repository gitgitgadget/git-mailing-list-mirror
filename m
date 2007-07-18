From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Wrong time in git-log when using right/ timezone
Date: Wed, 18 Jul 2007 11:19:46 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707181106280.27353@woody.linux-foundation.org>
References: <20070718153614.GA28815@hartlich.com>
 <alpine.LFD.0.999.0707180948080.27353@woody.linux-foundation.org>
 <Pine.LNX.4.64.0707181849060.1544@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Peter Hartlich <wwsgj@hartlich.com>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Wed Jul 18 20:20:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBE88-0006ZD-OY
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 20:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933802AbXGRSUE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 14:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933631AbXGRSUE
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 14:20:04 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39384 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933500AbXGRSUB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 14:20:01 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6IIJqwA030584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Jul 2007 11:19:53 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6IIJkMt022423;
	Wed, 18 Jul 2007 11:19:47 -0700
In-Reply-To: <Pine.LNX.4.64.0707181849060.1544@reaper.quantumfyre.co.uk>
X-Spam-Status: No, hits=-2.672 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52888>



On Wed, 18 Jul 2007, Julian Phillips wrote:
> 
> Is git working internally in TZ=UTC?

Yes.

The TZ in git terms has no meaning what-so-ever, it's purely for 
"decoration", so that people can see what the local time was. But a git 
time really *is* the UTC seconds-since-1970, and the timezone is saved so 
that it can be shown, but not for anything else.

So git always stores times in UTC, but then when showing them, it shows 
them as relative to the timezone they were done in.

You can see this by doing

	git cat-file commit HEAD

which shows something like

	author Junio C Hamano <gitster@pobox.com> 1184542877 -0700

and that "1184542877" is literally the time in UTC, and is the only thing 
that git really tracks. The "-0700" is informational, so that when you 
show it as a log entry, it shows as

	Author: Junio C Hamano <gitster@pobox.com>
	Date:   Sun Jul 15 16:41:17 2007 -0700

even though that "1184542877" really means "Sun Jul 15 23:41:17 2007".

So git never actually saves anything at all in local time, it just tries 
to show things in whatever the local time was for the person who did 
something (unless you use the "--date=local" option, in which case it 
ignores the saved TZ, and uses your _current_ TZ to show the date)

Unless we have a bug, of course.

			Linus
