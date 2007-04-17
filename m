From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] refs.c: add a function to sort a ref list, rather then
 sorting on add
Date: Tue, 17 Apr 2007 21:17:14 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704172114040.8164@beast.quantumfyre.co.uk>
References: <20070417014307.12486.28930.julian@quantumfyre.co.uk>
 <Pine.LNX.4.64.0704170901170.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 22:17:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdu7Y-0003vA-2d
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 22:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161268AbXDQURS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 16:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161274AbXDQURS
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 16:17:18 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:59123 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161268AbXDQURR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2007 16:17:17 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 2DDD0C629F
	for <git@vger.kernel.org>; Tue, 17 Apr 2007 21:17:15 +0100 (BST)
Received: (qmail 7373 invoked by uid 103); 17 Apr 2007 21:16:33 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3104. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.040429 secs); 17 Apr 2007 20:16:33 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 17 Apr 2007 21:16:33 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <Pine.LNX.4.64.0704170901170.5473@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44814>

On Tue, 17 Apr 2007, Linus Torvalds wrote:

>
>
> On Tue, 17 Apr 2007, Julian Phillips wrote:
>>
>> Rather than sorting the refs list while building it, sort in one go
>> after it is built using a merge sort.  This has a large performance
>> boost with large numbers of refs.
>>
>> Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
>
> Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
>
> Looks fine. I think that even your new times are a bit high (over two
> seconds?) but things are clearly better. Have you looked at what takes so
> long now?

It's the tag auto-following code, I'm calling read_ref to see if I already 
have that tag - and it appears that doing that a few thousand times takes 
a while.

If I comment out that one line (so the code will _always_ think I have 
the tags - but I do have them, so ...) I get:

real    0m0.472s
user    0m0.277s
sys     0m0.181s

Looks like read_ref is the wrong thing to be using ...

-- 
Julian

  ---
"Life is like a buffet; it's not good but there's plenty of it."
