From: Ruth Alkema <ruth@diasoft.nl>
Subject: Re: [PATCH JGIT] fix for 'negative position' error
Date: Wed, 11 Mar 2009 16:51:05 +0100
Message-ID: <49B7DDE9.7070407@diasoft.nl>
References: <49B7D683.1070805@diasoft.nl> <20090311152442.GS11989@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 11 16:53:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhQjn-00007F-Hn
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 16:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbZCKPvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 11:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbZCKPvL
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 11:51:11 -0400
Received: from a82-93-20-178.adsl.xs4all.nl ([82.93.20.178]:51821 "EHLO
	www.diasoft.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750752AbZCKPvK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 11:51:10 -0400
Received: (qmail 24196 invoked by uid 210); 11 Mar 2009 14:38:24 -0000
Received: from 192.168.12.5 by comms (envelope-from <ruth@diasoft.nl>, uid 201) with qmail-scanner-1.25st 
 (f-prot: 4.6.7/3.16.15. perlscan: 1.25st.  
 Clear:RC:1(192.168.12.5):. 
 Processed in 0.429886 secs); 11 Mar 2009 14:38:24 -0000
Received: from unknown (HELO ruth.diasoft.lan) (192.168.12.5)
  by 0 with SMTP; 11 Mar 2009 14:38:24 -0000
User-Agent: Thunderbird 2.0.0.19 (X11/20090109)
In-Reply-To: <20090311152442.GS11989@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112945>

On second thought, I think that my previous patch can still go wrong for large values in 'position' 
I think the following patch should work.

Kind regards, I hope the email is according to the guidelines for submitting patches, I am new to git, I used 'amend previous commit', I am not sure if that is correct in this case.

Ruth Alkema


>From 5e7200f02f91d948278fb515be59bfe2db535b66 Mon Sep 17 00:00:00 2001
From: Ruth Alkema <ruth@diasoft.nl>
Date: Wed, 11 Mar 2009 16:42:45 +0100
Subject: [PATCH] fix for 'negative position' error

Signed-off-by: Ruth Alkema <ruth@diasoft.nl>
---
 .../src/org/spearce/jgit/lib/WindowCache.java      |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
index 4b7e10d..597ad61 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
@@ -253,7 +253,7 @@ private static synchronized final void getImpl(final WindowCursor curs,
 		releaseMemory();
 		runClearedWindowQueue();
 
-		wp.allocWindow(curs, id, id << windowSizeShift, wsz);
+		wp.allocWindow(curs, id, (position >> windowSizeShift) << windowSizeShift, wsz);
 		final ByteWindow<?> e = curs.window;
 		e.chainNext = cache[idx];
 		cache[idx] = e;
-- 
1.6.0.6


Shawn O. Pearce wrote:
> Ruth Alkema <ruth@diasoft.nl> wrote:
>> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
>> index 4b7e10d..5340da9 100644
>> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
>> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
>> @@ -253,7 +253,7 @@ private static synchronized final void getImpl(final WindowCursor curs,
>>  		releaseMemory();
>>  		runClearedWindowQueue();
>>  
>> -		wp.allocWindow(curs, id, id << windowSizeShift, wsz);
>> +		wp.allocWindow(curs, id, ((long) id) << windowSizeShift, wsz);
> 
> Ouch.
> 
> Thanks for the fix!
> 
