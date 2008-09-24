From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] add GIT_FAST_STAT mode for Cygwin
Date: Wed, 24 Sep 2008 08:16:53 -0700
Message-ID: <20080924151653.GQ3669@spearce.org>
References: <20080923140144.GN21650@dpotapov.dyndns.org> <81b0412b0809230737s7498e214w4c58991e79f76507@mail.gmail.com> <20080923165247.GO21650@dpotapov.dyndns.org> <81b0412b0809240425t63a2a28cw1cc0c0d95b3290f7@mail.gmail.com> <20080924140358.GX21650@dpotapov.dyndns.org> <81b0412b0809240742g2918b300h9114579c4ebf05b4@mail.gmail.com> <20080924150231.GO3669@spearce.org> <81b0412b0809240809y4daa990cl5494d7b7398353f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 17:19:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiW7v-00039m-An
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 17:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbYIXPQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 11:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbYIXPQy
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 11:16:54 -0400
Received: from george.spearce.org ([209.20.77.23]:55162 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbYIXPQx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 11:16:53 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 262743835F; Wed, 24 Sep 2008 15:16:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <81b0412b0809240809y4daa990cl5494d7b7398353f0@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96647>

Alex Riesen <raa.lkml@gmail.com> wrote:
> 2008/9/24 Shawn O. Pearce <spearce@spearce.org>:
> >
> > However Dmitry pointed out that he has cases where this faster
> > function doesn't work correctly, and it was path specific. Some
> > areas of the filesystem work, others don't, on the same system.
> 
> Huh?! What are they? What paths require cygwin's handling
> which aren't handled already? (the absolute paths are handled).

Cygwin lets you mount a filesystem at a different part of the
filesystem.  Sort of like Linux's mount -t bind (IIRC).

For example its possible to remap C:\foo\bar\widget\srcs into
C:\cygwin\home\lib, so you see the files under /home/lib in Cygwin,
even though that folder is empty (or flat out doesn't exist)
in Windows.

That filesystem remount stuff is part of the reason why the Cygwin
stat/lstat routines are so much slower than the native Windows ones.
They have to evaluate the path space twice (once in Cygwin, again
in the Windows kernel).

-- 
Shawn.
