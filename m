From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Fri, 30 Sep 2011 16:06:31 -0600
Organization: CAF
Message-ID: <201109301606.31748.mfick@codeaurora.org>
References: <4DF6A8B6.9030301@op5.se> <201109301041.13848.mfick@codeaurora.org> <201109301502.30617.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	=?iso-8859-1?q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 01 00:06:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9lE5-0000o6-PX
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 00:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756541Ab1I3WGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 18:06:34 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:12487 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179Ab1I3WGc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 18:06:32 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6485"; a="123781324"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 30 Sep 2011 15:06:32 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 5DAC310004BE;
	Fri, 30 Sep 2011 15:06:32 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <201109301502.30617.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182514>

On Friday, September 30, 2011 03:02:30 pm Martin Fick wrote:
> On Friday, September 30, 2011 10:41:13 am Martin Fick 
wrote:
> Since a full sync is now done to about 5mins, I broke
> down the output a bit.  It appears that the longest part
> (2:45m) is now the time spent scrolling though each
> change still. Each one of these takes about 2ms:
>  * [new branch]      refs/changes/99/71199/1 ->
> refs/changes/99/71199/1
> 
> Seems fast, but at about 80K... So, are there any obvious
> N loops over the refs happening inside each of of the
> [new branch] iterations?

OK, I narrowed it down I believe.  If I comment out the 
invalidate_cached_refs() line in write_ref_sha1(), it speeds 
through this section.  

I guess this makes sense, we invalidate the cache and have 
to rebuild it after every new ref is added?  Perhaps a 
simple fix would be to move the invalidation right after all 
the refs are updated?  Maybe write_ref_sha1 could take in a 
flag to tell it to not invalidate the cache so that during 
iterative updates it could be disabled and then run manually 
after the update?

-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
