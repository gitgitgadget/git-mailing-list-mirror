From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH 00/18] Add --index-only option to git merge
Date: Fri, 8 Apr 2016 15:01:51 +0200
Message-ID: <5707ABBF.2050701@drmicha.warpmail.net>
References: <1460098726-5958-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: Elijah Newren <newren@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 15:02:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoW2z-0000j9-Fb
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 15:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263AbcDHNBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 09:01:54 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60441 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751757AbcDHNBy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Apr 2016 09:01:54 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id EF6BF21A08
	for <git@vger.kernel.org>; Fri,  8 Apr 2016 09:01:52 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 08 Apr 2016 09:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=2O0Tzb17l7uqBd1fTh7v0KkNGUA=; b=Lgval3
	bFfN0zeyMvErkZ5FNYutLqjkCL7kh0iIeAc6Wnvgjn/rVk6ygGInkzZemwNst/1A
	GVhXxyZnYdRK6wJD7Ljxwb/KTPfR77yXWkor/sYs0EZPsFNv+zCw4Sfjc22dboGq
	MKLRrCtULE7/ldEDsrTOEtAiRV5vChtyL12rA=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=2O0Tzb17l7uqBd1
	fTh7v0KkNGUA=; b=FISqTAixK24y59qK4/bYNDyp//KHJGP+EWsGd2+KAquYY3f
	zsvPCqY6RZSe6KDCJxINxYGRyIyq5bN59SHmGzWRrh1bS+MwBF5nrb0B9IhChCRW
	MI4DCyFuxdLQb5C2vyl+EnNdDQmjERAOoSaP787SNbPvzD5/b9hKUREgc0FE=
X-Sasl-enc: bo50W4E4JUYIv84MHNEKg+puTrzNIOsi1LxTRKdo1gp4 1460120512
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 3A523C00014;
	Fri,  8 Apr 2016 09:01:52 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
In-Reply-To: <1460098726-5958-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291032>

Elijah Newren venit, vidit, dixit 08.04.2016 08:58:
> This patch series adds an --index-only flag to git merge, the idea
> being to allow a merge to be performed entirely in the index without
> touching (or even needing) a working tree.
> 
> The core fix, to merge-recursive, was actually quite easy.  The
> recursive merge logic already had the ability to ignore the working
> directory and operate entirely on the index -- it needed to do this
> when creating a virtual merge base, i.e. when o->call_depth > 0.  It's
> just that o->call_depth was also used for other purposes, so I just
> needed to introduce a new flag to disambiguate and switch all the
> necessary index-only-related call sites to use it.  It actually seems
> to make the code slightly easier to read too, which is a nice bonus.
> That was all done in patch 12 of this series.
> 
> Adding all the necessary testcases and switching over the other merge
> strategies turned out to be the harder part...and still has a problem,
> as I'll mention below.

I haven't looked at your series thoroughly but immediately had to think
of 'tr/remerge-diff' (on 'pu'), see
http://permalink.gmane.org/gmane.comp.version-control.git/256591

There, Thomas used index-only merge to reproduce an automatic merge as
the base for a useful "remerge-diff".

I've been rebasing (and using) that series on 'next' for a while now
without any problems; some reasons kept it from being merged on next,
see the thread.

So, it would be interesting whether you solve the same problem
differently, or face the same problems ;)

Michael
