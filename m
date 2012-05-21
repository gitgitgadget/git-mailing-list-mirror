From: Martin Fick <mfick@codeaurora.org>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Mon, 21 May 2012 12:15:13 -0600
Organization: CAF
Message-ID: <201205211215.14455.mfick@codeaurora.org>
References: <4FB9F92D.8000305@alum.mit.edu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 21 20:15:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWX8d-0002Ds-MF
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 20:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758690Ab2EUSPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 14:15:18 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:28425 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757941Ab2EUSPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 14:15:16 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6718"; a="193195081"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 May 2012 11:15:15 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 3653010004A9;
	Mon, 21 May 2012 11:15:15 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
In-Reply-To: <4FB9F92D.8000305@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198121>

On Monday, May 21, 2012 02:13:33 am Michael Haggerty wrote:
> I just noticed that the remove_duplicates() function in
> builtin/fetch-pack.c is O(N^2) in the number of heads. 
> Empirically, this function takes on the order of 25
> seconds to process 100k references.
> 
> I know that 100k heads is kindof absurd.  Perhaps
> handling this many heads is unrealistic for other
> reasons.  But I vaguely recall numbers like this being
> mentioned on the mailing list.

Yes I have mentioned 100K several times, and I greatly 
appreciate the many fixes already made to make git to better 
handle large ref counts.

However, I would like to suggest that 100K not really be 
viewed as absurd anymore. :) There are many users for whom 
it is not absurd, certainly not if you are including tags.  
But, I know that some of the tag uses have been brushed off 
as abuses, so I will focus on feature branches, of which we 
actually have more than tags in our larger repos, we have 
around 60K in our kernel repo.

Of course, we use Gerrit, so features tend to be called 
changes and each change may get many revisions (patchsets), 
so all of these get refs, but I think that it might be wrong 
to consider that out of the ordinary anymore.  After all, 
should a version control system such as git not support 100K 
revisions of features developed independently on separate 
branches (within Gerrit or not)?  100K is not really that 
many when you consider a large project.  Even without 
Gerrit, if someone wanted to track that many features 
(likely over a few years), they will probably use up tons of 
refs.  

It may be too easy to think that because git is distributed 
that features will get developed in a distributed way and 
therefor no one would ever want to track them all in one 
place, but I suspect that this may be a bad assumption.  
That being said, I believe that we are not even tracking 
external features, and we have over 60K feature revisions 
(gerrit patchsets) in one rep), so if someone were to track 
all the changes for the kernel, I can only imagine that this 
number would be in the millions.

I am sure that 1M refs is even within the sights of some 
individuals already, I know users who actually have 250K.  I 
hope that 10M or even perhaps 100M refs will be considered 
feasible to use long term with git.  

Again, I really hope that this will no longer be seen as 
absurd, but rather just normal for large projects.  After 
all the kernel was (still is?) the primary use case of git.  
Our largest ref project is the kernel so I don't know that 
we should be considered fringe, and I hope that we along 
with other larger kernel contributors will be considered 
normal to git, :)

-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
