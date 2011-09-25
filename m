From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Sun, 25 Sep 2011 14:43:27 -0600
Organization: CAF
Message-ID: <201109251443.28243.mfick@codeaurora.org>
References: <4DF6A8B6.9030301@op5.se> <1315511619144-6773496.post@n2.nabble.com> <1315529522448-6774328.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 22:44:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7vYR-0001ZE-0g
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 22:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872Ab1IYUns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Sep 2011 16:43:48 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:24680 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734Ab1IYUns (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2011 16:43:48 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6480"; a="121288666"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 25 Sep 2011 13:43:28 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 9DF1F10004BE;
	Sun, 25 Sep 2011 13:43:28 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <1315529522448-6774328.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182082>

A coworker of mine pointed out to me that a simple

  git checkout 

can also take rather long periods of time > 3 mins when run 
on a repo with ~100K refs.  

While this is not massive like the other problem I reported, 
it still seems like it is more than one would expect.  So, I 
tried an older version of git, and to my surprise/delight, 
it was much faster (.2s).  So, I bisected this issue also, 
and it seems that the "offending" commit is 
680955702990c1d4bfb3c6feed6ae9c6cb5c3c07:


commit 680955702990c1d4bfb3c6feed6ae9c6cb5c3c07
Author: Christian Couder <chriscool@tuxfamily.org>
Date:   Fri Jan 23 10:06:53 2009 +0100

    replace_object: add mechanism to replace objects found 
in "refs/replace/"

    The code implementing this mechanism has been copied 
more-or-less
    from the commit graft code.

    This mechanism is used in "read_sha1_file". sha1 passed 
to this
    function that match a ref name in "refs/replace/" are 
replaced by
    the sha1 that has been read in the ref.

    We "die" if the replacement recursion depth is too high 
or if we
    can't read the replacement object.

    Signed-off-by: Christian Couder 
<chriscool@tuxfamily.org>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>



Now, I suspect this commit is desirable, but I was hoping 
that perhaps a look at it might inspire someone to find an 
obvious problem with it.  

Thanks,

-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
