From: Tommy Thorn <tommy-git@thorn.ws>
Subject: Re: Bug in .gitignore handling
Date: Wed, 26 Mar 2008 13:35:57 -0700
Message-ID: <47EAB3AD.5070507@thorn.ws>
References: <47EAABB6.30803@thorn.ws> <alpine.LFD.1.00.0803261324380.2775@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 26 21:37:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JecMe-0005v6-HZ
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 21:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755797AbYCZUgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 16:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754910AbYCZUgK
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 16:36:10 -0400
Received: from server204.webhostingpad.com ([69.65.0.218]:45796 "EHLO
	server204.webhostingpad.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753325AbYCZUgJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Mar 2008 16:36:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=thorn.ws;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:X-Source-Dir;
	b=rRBBJJ9s6Ycdiz+Qbzkg/PZ+nhQioGIrzyf3aSTBX6OT3Uqv7CGNKQgDFTShWQm5RxAe3/44dqPfYnVT18EQSRhZ0l0e/8zmzbzXPrXNPAQnVZZzUfouQw6VzZAIzMpM;
Received: from [216.228.112.21] (helo=dhcp-172-16-169-183.nvidia.com)
	by server204.webhostingpad.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <tommy-git@thorn.ws>)
	id 1JecLi-0006wt-5d; Wed, 26 Mar 2008 15:35:54 -0500
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <alpine.LFD.1.00.0803261324380.2775@woody.linux-foundation.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server204.webhostingpad.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - thorn.ws
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78310>

Linus Torvalds wrote:
> On Wed, 26 Mar 2008, Tommy Thorn wrote:
>   
>> My desperate attempts "./foo" and "^foo" also didn't work. Please note that
>> this is a vastly simplified version of the real problem, so I can't just use
>> "!mousetrap/foo".
>>
>> It seems "foo/" _should_ work even though foo isn't a directory.
>>     
>
> Close but no cigar.
>
> Use "/foo" and it should be ok.
>
> Basically, a path with a slash in it is considered absolute, but if the 
> slash is at the end it will only match a directory. A slash at the 
> *beginning* will match the root of the git repository, though.

D'oh, of course that works. I double check the documentation and it 
actually isn't obvious that that is allowed, so I propose this patch.

Tommy


 From c0a003e995e325d5d9e056137b4b02c370c9dc03 Mon Sep 17 00:00:00 2001
From: Tommy Thorn <tommy-git@thorn.ws>
Date: Wed, 26 Mar 2008 13:34:34 -0700
Subject: [PATCH] Documentation/gitginore.txt: Be explicit about the /foo 
form

Signed-off-by: Tommy Thorn <tommy-git@thorn.ws>
---
 Documentation/gitignore.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index e847b3b..941a8a4 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -57,6 +57,9 @@ Patterns have the following format:
    included again.  If a negated pattern matches, this will
    override lower precedence patterns sources.
 
+ - If the pattern begins with a slash '/', the pattern will only
+   match in the current directory.
+
  - If the pattern ends with a slash, it is removed for the
    purpose of the following description, but it would only find
    a match with a directory.  In other words, `foo/` will match a
-- 
1.5.5.rc1
