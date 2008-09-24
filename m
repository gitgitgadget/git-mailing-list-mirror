From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] add GIT_FAST_STAT mode for Cygwin
Date: Wed, 24 Sep 2008 18:03:58 +0400
Message-ID: <20080924140358.GX21650@dpotapov.dyndns.org>
References: <20080923140144.GN21650@dpotapov.dyndns.org> <81b0412b0809230737s7498e214w4c58991e79f76507@mail.gmail.com> <20080923165247.GO21650@dpotapov.dyndns.org> <81b0412b0809240425t63a2a28cw1cc0c0d95b3290f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 16:06:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiUzX-0007Pd-HQ
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 16:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbYIXOEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 10:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbYIXOEH
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 10:04:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:59214 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbYIXOEF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 10:04:05 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2091084fgg.17
        for <git@vger.kernel.org>; Wed, 24 Sep 2008 07:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0v+fQsKuab2nqhAPO4HQSlLQjgrQY0k65jsqYzlyu5o=;
        b=BniV++q11b9tXTnqg8VtJnzEcKeAVZNQFqZvYF/dxDt70kDYxENleqDXkFsvBmDrSi
         ztQbvPDAznxSLAzkXxT5RHB78Wfcc+BXc5sPSJPTyxeZdLoTZq6Rp5oAmh24g/0n2HNX
         faKwmYTnu6V6gECmg3wnaCN1xXfCs/7Rra+zI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=S7R+W/1SlaiMGpq+v2882X6RCplTQ7QYjr8QHIXdQFleMulpL8T9XaLvpKk+IMeUv3
         W9UZMng4FKvR9md4a6ZMRGjXO1VZDMBqUGU8mWj8kV/8BuE0KVuu7fX9r0UfJKHB6n8E
         lJEEjsiVhC+qbDVnh2UDI2k9i0THYowDseGhA=
Received: by 10.86.26.11 with SMTP id 11mr7394752fgz.71.1222265043339;
        Wed, 24 Sep 2008 07:04:03 -0700 (PDT)
Received: from localhost (ppp85-141-236-118.pppoe.mtu-net.ru [85.141.236.118])
        by mx.google.com with ESMTPS id e20sm9379315fga.1.2008.09.24.07.04.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Sep 2008 07:04:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <81b0412b0809240425t63a2a28cw1cc0c0d95b3290f7@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96633>

On Wed, Sep 24, 2008 at 01:25:06PM +0200, Alex Riesen wrote:
> 2008/9/23 Dmitry Potapov <dpotapov@gmail.com>:
> >
> > I thought that in rather unusual circumstances (such as using Cygwin
> > mount to connect separately directories in one tree), this fast version
> > may not work. So, I made it conditional. It is runtime conditional,
> > because most users do not build Git themselves but install a ready
> > Cygwin package.
> 
> So? How about make the fast version _always_ work? We don't seem
> to fallback to copy+unlink everytime the POSIX rename fails.

I am not sure that I understand your analogue here. First, rename has
never meant to work as copy+unlink. Second, I don't fall back on some
other code when the implementation provided by Cygwin fails. I replace
the Cygwin implementation with a faster but a bit hackish version. Yes,
it works fine in almost all practical cases I aware of, but I cannot
guarantee identical behavior in _all_ cases.

Frankly, I don't have strong preference here neither for making this
fast version always work nor leave it conditional (perhaps, with the
default setting use-fast-version). So, whatever the majority decides
is fine with me.

> Besides it will remove your setup code, which looks bigger and provoked
> more discussion than the real subject itself.

I believe Shawn wanted it to be configurable on per-repository basis.
I have just finished re-writing the code in the way he suggested, so I
hope all objections with the setup code are resolved now. I will send
the new version a bit later, I did not have time to test it yet.


Dmitry
