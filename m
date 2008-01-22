From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Use FIX_UTF8_MAC to enable conversion from UTF8-MAC to UTF8
Date: Tue, 22 Jan 2008 14:57:41 +0300
Message-ID: <20080122115741.GI14871@dpotapov.dyndns.org>
References: <fn1nl6$ek5$1@ger.gmane.org> <fn1pj9$kkg$1@ger.gmane.org> <fn1ptk$ljj$1@ger.gmane.org> <fn1q6b$ljj$2@ger.gmane.org> <7vve5nzdqx.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801212025050.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Mark Junker <mjscod@web.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 12:58:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHHli-0001DT-Gb
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 12:58:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbYAVL5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 06:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbYAVL5r
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 06:57:47 -0500
Received: from smtp04.mtu.ru ([62.5.255.51]:65395 "EHLO smtp04.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016AbYAVL5q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 06:57:46 -0500
Received: from smtp04.mtu.ru (localhost [127.0.0.1])
	by smtp04.mtu.ru (Postfix) with ESMTP id 0AFE2825ED9;
	Tue, 22 Jan 2008 14:57:43 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-189-197.pppoe.mtu-net.ru [85.141.189.197])
	by smtp04.mtu.ru (Postfix) with ESMTP id 68F0E8259E1;
	Tue, 22 Jan 2008 14:57:42 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JHHl7-0002Je-So; Tue, 22 Jan 2008 14:57:41 +0300
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801212025050.2957@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp04.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71445>

On Mon, Jan 21, 2008 at 08:59:56PM -0800, Linus Torvalds wrote:
> 
> Anyway, even if you do that, our "reencode_string()" is really *so* 
> expensive that you really don't want to do it on a filename by filename 
> basis. It literally does a malloc() for each allocation. It might well be 
> worth it to find something that is more utf-8-specific (and I could well 
> imagine that Mac OS X comes with some UTF libraries, if only because we 
> cannot possibly be the only people with this issue).

Yes, starting with Mac OS X 10.2 there are functions for that.
http://developer.apple.com/qa/qa2001/qa1235.html

Anyway, even if iconv is to be used, I believe it should be possible to
avoid malloc here (I usually allocate 256 on stack and use malloc()/free()
only when I need more than that which in practice never happens!). It is
also avoidable to call iconv_open/iconv_close for each name by putting the
allocated descriptor for character set conversion into a static variable.
Thus leaving iconv() alone, which should not be big overhead provided that
it is done only for non-ASCII names.

Dmitry
