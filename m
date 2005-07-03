From: Brian Gerst <bgerst@didntduck.org>
Subject: Re: [PATCH] Cogito: Use git-rev-parse instead of cg-Xnormid.
Date: Sun, 03 Jul 2005 08:25:09 -0400
Message-ID: <42C7D925.2070007@didntduck.org>
References: <42C77ECE.2080903@didntduck.org> <20050703065920.GA11765@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 03 14:25:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dp3Wo-00011L-PF
	for gcvg-git@gmane.org; Sun, 03 Jul 2005 14:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVGCMYs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jul 2005 08:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVGCMYs
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jul 2005 08:24:48 -0400
Received: from quark.didntduck.org ([69.55.226.66]:60088 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261398AbVGCMYp
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Jul 2005 08:24:45 -0400
Received: from [192.168.1.2] (24-236-201-214.dhcp.aldl.mi.charter.com [24.236.201.214])
	(authenticated)
	by quark.didntduck.org (8.11.6/8.11.6) with ESMTP id j63CNpx06849;
	Sun, 3 Jul 2005 08:23:53 -0400
User-Agent: Mozilla Thunderbird 1.0.2-7 (X11/20050623)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050703065920.GA11765@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
> Dear diary, on Sun, Jul 03, 2005 at 07:59:42AM CEST, I got a letter
> where Brian Gerst <bgerst@didntduck.org> told me that...
> 
>>Use git-rev-parse instead of cg-Xnormid.  This allows Cogito to work 
>>properly with packed objects.
>>
>>Signed off by: Brian Gerst <bgerst@didntduck.org>
> 
> 
> But git-rev-parse sucks. It won't detect invalid IDs (--revs-only?), and
> does not support short object IDs (that's a must, it's tremendously
> useful). You need to add that for it to be useful first.

cg-Xnormid is terminally broken in the presence of packed files, since 
it cannot look into them to find objects.  Moreover, many uses of 
commit-id in the scripts can be eliminated because the underlying git 
commands can already understand tags directly, and will check for 
invalid ids then.  The only thing missing is the short id matching.

> 
> 
>>diff --git a/tree-id b/tree-id
>>--- a/tree-id
>>+++ b/tree-id
>>@@ -5,8 +5,8 @@
>> #
>> # Takes ID of the appropriate commit, defaults to HEAD.
>> 
>>-id="$1"
>>-normid=$(${COGITO_LIB}cg-Xnormid "$id") || exit 1
>>+id="${1:-HEAD}"
>>+normid=$(git-rev-parse "$id")
>> type=$(git-cat-file -t "$normid")
>> 
>> if [ "$type" = "commit" ]; then
> 
> 
> This is broken too. You need to be able to pass _tree_ ID to tree-id too,
> not just commit ID. Hmm, or is git-rev-parse able to process any ids?
> Then it's terribly misnamed too. :-) A comment would be useful in that
> case. (Or better a patch to rename it.)

Yes you can still pass in the tree id.

--
				Brian Gerst
