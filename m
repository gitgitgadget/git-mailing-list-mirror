From: David Kastrup <dak@gnu.org>
Subject: Re: possible bug in git apply?
Date: Sun, 05 Aug 2007 21:37:41 +0200
Message-ID: <85odhlhiwq.fsf@lola.goethe.zz>
References: <Pine.LNX.4.64.0708041243070.6905@asgard.lang.hm>
	<alpine.LFD.0.999.0708042141510.5037@woody.linux-foundation.org>
	<7vvebuh8g8.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.999.0708050949220.5037@woody.linux-foundation.org>
	<85hcndj2b5.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708051106020.5037@woody.linux-foundation.org>
	<853ayxiznp.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708051219440.5037@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, david@lang.hm,
	git@vger.kernel.org, rob@landley.net
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 21:37:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHlvK-0004KB-2i
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 21:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755206AbXHEThp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 15:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752907AbXHEThp
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 15:37:45 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:37312 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752494AbXHETho (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 15:37:44 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 41A5F4CBC3;
	Sun,  5 Aug 2007 21:37:43 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 2D7C612DFA2;
	Sun,  5 Aug 2007 21:37:43 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-057-031.pools.arcor-ip.net [84.61.57.31])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id B8C4430A94C;
	Sun,  5 Aug 2007 21:37:42 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 1EF921C3D500; Sun,  5 Aug 2007 21:37:42 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0708051219440.5037@woody.linux-foundation.org> (Linus Torvalds's message of "Sun\, 5 Aug 2007 12\:20\:48 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3864/Sun Aug  5 19:21:44 2007 on mail-in-03.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55060>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 5 Aug 2007, David Kastrup wrote:
>> 
>> But your proposed three passes won't work with a patch removing
>> "x/..."  and creating "x" in its place, since "x/" gets only removed
>> in pass 3, and "x" needs to created in pass 2 already.
>
> Yes, I was wrong. The current two passes are the right thing to do, and we 
> should just always remove empty directories (and my patch was fine: we can 
> leave them alone if it's a pure "modify file in place", but that's really 
> the only case).

The consequence will be that renaming all files in one directory (and
"all" can even be a single file) will temporarily delete and recreate
that directory.  My proposed change of index sort and processing order
would take care of that without requiring multiple passes, at the cost
of changing the index format and processing.  I think that it would be
a sound long-term solution.

Anyway, once directories can be tracked (again necessitating a change
of index format), surprising directory deletion and recreation should
become less of an issue, but it won't help with projects that continue
not tracking directories (presumably most patch-based workflows).

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
