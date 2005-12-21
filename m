From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] off-by-one bugs found by valgrind
Date: Wed, 21 Dec 2005 16:47:21 -0500
Message-ID: <1135201641.15567.7.camel@dv>
References: <1135197348.3046.7.camel@dv>
	 <7vr7865fq5.fsf@assigned-by-dhcp.cox.net>  <43A9C654.2010009@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 22:49:55 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpBoL-00026o-Og
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 22:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbVLUVrr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 16:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbVLUVrr
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 16:47:47 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:35494 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751136AbVLUVrq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 16:47:46 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EpBm7-0000rx-4r
	for git@vger.kernel.org; Wed, 21 Dec 2005 16:45:38 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EpBnt-0004f1-87; Wed, 21 Dec 2005 16:47:21 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43A9C654.2010009@zytor.com>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13903>

On Wed, 2005-12-21 at 13:17 -0800, H. Peter Anvin wrote:
> >>quote_c_style_counted() in quote.c uses a dangerous construct, when a
> >>variable is incremented once and used twice in the same expression.
> > 
> > Sorry, I do not follow you.  Isn't && a sequence point?

The patch is right, but my comment was wrong, sorry.

The actual problem detected by valgrind is that sp is dereferenced
before it's checked for the upper boundary.  So, if e.g. namelen is 6,
the code reads name[6] into ch and then leaves the loop.

> && is a sequence point.  The code is techically fine, but it's harder 
> than necessary to read.

That alone should be a good reason to apply this patch.

-- 
Regards,
Pavel Roskin
