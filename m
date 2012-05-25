From: Martin Fick <mfick@codeaurora.org>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Thu, 24 May 2012 19:32:36 -0600
Organization: CAF
Message-ID: <201205241932.37045.mfick@codeaurora.org>
References: <4FB9F92D.8000305@alum.mit.edu> <201205241854.56934.mfick@codeaurora.org> <20120525010434.GA11861@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 25 03:32:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXjOW-0006Xq-Cw
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 03:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802Ab2EYBcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 21:32:39 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:30560 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754009Ab2EYBci (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 21:32:38 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6721"; a="194562549"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 24 May 2012 18:32:38 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 13EDA10004A9;
	Thu, 24 May 2012 18:32:38 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
In-Reply-To: <20120525010434.GA11861@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198459>

On Thursday, May 24, 2012 07:04:34 pm Jeff King wrote:
> On Thu, May 24, 2012 at 06:54:56PM -0600, Martin Fick 
wrote:
> > > Yes, exclusively warm. And all of the refs were
> We'd have to give some thought to potential race
> conditions, though. Usually pack-refs isn't modifying
> the ref, so it can just write out the value to the
> packed-refs file, then delete the loose ref if nobody
> has touched it since we wrote. But here we're combining
> it with a modification, so I suspect there would be a
> race with another process trying to modify it.

Yeah, I thought about that.  Could you just right the new 
packed-ref file with the new refs and the old refs which 
were in the file already, then just delete any loose refs 
which were ones which were just added by this operation, 
only if they have not changed?

This way, if someone else modifies one of the same refs, 
they could just win?

-Martin


-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
