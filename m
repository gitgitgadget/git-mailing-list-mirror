From: linux@horizon.com
Subject: Re: [PATCH 1/3] Lazily open pack index files on demand
Date: 28 May 2007 20:09:49 -0400
Message-ID: <20070529000949.28007.qmail@science.horizon.com>
To: git@vger.kernel.org, torvalds@linux-foundation.org
X-From: git-owner@vger.kernel.org Tue May 29 02:10:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HspI1-0006B9-QE
	for gcvg-git@gmane.org; Tue, 29 May 2007 02:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbXE2AJv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 20:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752620AbXE2AJv
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 20:09:51 -0400
Received: from science.horizon.com ([192.35.100.1]:10175 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751872AbXE2AJv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 20:09:51 -0400
Received: (qmail 28008 invoked by uid 1000); 28 May 2007 20:09:49 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48656>

> First off, when comparing O(logn) to O(1), with "n" being less than a 
> billion, they are pretty much exactly the same. Think of it this way: 
> O(logn) == O(9) == O(1), if you know that n < 10**9.

Well, binary searches mean binary logarithms, so O(log n) = O(30).
Still, pretty low.

> Secondly, the cost of Newton isn't "almost O(1)". I don't know _what_ it 
> is (the rule of thumb with Newton-Raphson should be that the number of 
> significant correct digits in the answer doubles with each iteration: I 
> think that probably means that it should approximate O(loglog(n)), but I 
> haven't thought deeply about it.

Excellent intuition!  The algorithm is most commonly known in the computer
science literature as "interpolation search" and it does indeed take O(log
log n) time for uniformly distributed data, which is a good assumption
for SHA-1 hashes.

Of course, for n = 10**9, log(n) is 30 and log log n is 5.
More to the point, for n = 10**6, log(n) is 20 and log(log(n)) is still 5.

Even losing a constant factor of 2, it still seems like it might offer a
factor-of-2 speedup for large repositories.
