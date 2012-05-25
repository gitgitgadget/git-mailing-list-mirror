From: Martin Fick <mfick@codeaurora.org>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Thu, 24 May 2012 18:54:56 -0600
Organization: CAF
Message-ID: <201205241854.56934.mfick@codeaurora.org>
References: <4FB9F92D.8000305@alum.mit.edu> <201205241817.46034.mfick@codeaurora.org> <20120525003920.GB11300@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 25 02:55:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXio3-0007RH-C1
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 02:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759577Ab2EYAy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 20:54:58 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:38456 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759365Ab2EYAy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 20:54:58 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6721"; a="192224366"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine02.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 24 May 2012 17:54:57 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id A309310004A9;
	Thu, 24 May 2012 17:54:57 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
In-Reply-To: <20120525003920.GB11300@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198457>

On Thursday, May 24, 2012 06:39:20 pm Jeff King wrote:
> On Thu, May 24, 2012 at 06:17:45PM -0600, Martin Fick 
wrote:
> > Were your tests mostly warm cache tests?
> 
> Yes, exclusively warm. And all of the refs were packed,
> which makes the warm/cold difference less interesting
> (it's one 30MB or so file).  I don't think there's much
> point in thinking about the performance of 400K loose
> refs (which would be absolutely horrific cold-cache on
> most traditional filesystems). If you have that many,
> you would want to keep the bulk of them packed.

Mostly true, except for one strange case still I think?

When cloning a gerrit repo, users to not get the changes 
since they are not under refs/heads but refs/changes.  So 
later, if they choose to fetch refs/changes/*, all of those
new incoming refs are loose.  Yes, someone should pack those 
refs right away, but I think it actually churns the hell out 
of my disk and takes a significant amount of time during the 
initial fetch.  I am not certain about this, and the 
behavior may depend on the filesystem in use, but I think 
that this time might even be asynchronous (journals and 
all), it feels like my disk keeps churning for a while even 
after this is over.  I believe that this might still be the 
worst case left with refs, and it can be pretty bad,

-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
