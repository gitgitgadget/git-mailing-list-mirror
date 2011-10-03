From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Sun, 02 Oct 2011 18:46:05 -0600
Message-ID: <3e4aa1b3-5b14-4446-ac83-cef41c18a11f@email.android.com>
References: <4DF6A8B6.9030301@op5.se> <201109301041.13848.mfick@codeaurora.org> <201109301502.30617.mfick@codeaurora.org> <201109301606.31748.mfick@codeaurora.org> <7vwrcola0m.fsf@alter.siamese.dyndns.org> <4E87F462.3000308@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 02:47:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAWgl-00019X-1b
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 02:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269Ab1JCArT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Oct 2011 20:47:19 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:29650 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921Ab1JCArR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Oct 2011 20:47:17 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6487"; a="124226544"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 02 Oct 2011 17:47:17 -0700
Received: from [192.168.1.190] (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id CBFD510004C2;
	Sun,  2 Oct 2011 17:47:16 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <4E87F462.3000308@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182616>



Michael Haggerty <mhagger@alum.mit.edu> wrote:

>On 10/01/2011 10:41 PM, Junio C Hamano wrote:
>> Martin Fick <mfick@codeaurora.org> writes:
>>> I guess this makes sense, we invalidate the cache and have 
>>> to rebuild it after every new ref is added?  Perhaps a 
>>> simple fix would be to move the invalidation right after all 
>>> the refs are updated?  Maybe write_ref_sha1 could take in a 
>>> flag to tell it to not invalidate the cache so that during 
>>> iterative updates it could be disabled and then run manually 
>>> after the update?
>> 
>I
>also have some code (not pushed) that adds some intelligence to make
>the use case
>
>    repeat many times:
>        check if reference exists
>        add reference

Would it be possible to separate the two steps into separate loops somehow?  Could it instead look like this:
 
>    repeat many times:
>        check if reference exists
 
>    repeat many times:
>        add reference

It might be difficult with the current functions to achive this, but it would allow the cache to be invalidated over and over in loop two without impacting performance since all the lookups could be done in the first loop.  Of course, this would likely require checking for dups before running the first loop.

-Martin
Employee of Qualcomm Innovation Center,Inc. which is a member of Code Aurora Forum
