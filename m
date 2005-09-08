From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: [PATCH 0/2] A new merge algorithm, take 3
Date: Thu, 08 Sep 2005 14:16:06 -0400
Organization: Network Appliance, Inc.
Message-ID: <43207FE6.2030108@citi.umich.edu>
References: <20050907164734.GA20198@c165.ib.student.liu.se> <7v1x407min.fsf@assigned-by-dhcp.cox.net> <431F34FF.5050301@citi.umich.edu> <7vvf1cz64l.fsf@assigned-by-dhcp.cox.net> <4320536D.2010706@citi.umich.edu> <7v7jdrwlih.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509081012540.3208@g5.osdl.org>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040004080400080803030508"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 20:17:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDQwc-0001X1-85
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 20:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbVIHSQK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 14:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbVIHSQK
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 14:16:10 -0400
Received: from citi.umich.edu ([141.211.133.111]:17789 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S964916AbVIHSQJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2005 14:16:09 -0400
Received: from [10.58.48.252] (nat-198-95-226-230.netapp.com [198.95.226.230])
	by citi.umich.edu (Postfix) with ESMTP id 8110D1BAA9;
	Thu,  8 Sep 2005 14:16:07 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509081012540.3208@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8208>

This is a multi-part message in MIME format.
--------------040004080400080803030508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On Thu, 8 Sep 2005, Junio C Hamano wrote:
> 
>>Yes, the reading of three trees upfront is probably the culprit
>>in your case
> 
> 
> However, note that _most_ tree reading just reads one.
> 
> Merges may take half a second, and yes, when I did it, the fact that we 
> move things around in the array is by far the highest cost. But the thing 
> is, if merges take half a second, that's still not only damn good, it's 
> not even the most common operation.

in my case the merges were taking significantly longer than a half 
second.  making this change is certainly not worth it if merges are 
running fast...

> Yes, the active_cache[] layout as one big array is inconvenient for 
> read_tree(), which tends to want to interleave different trees in the 
> array and thus forces things to be moved around.
> 
> But remember what the most common use for the index is - it's the "single 
> tree" case from read_cache(). That's _so_ much more common than 
> read_tree() that it's not even funny.

read_cache is fast as implemented.  the issue is that the next thing 
that is often done is a cache insert, which requires a memmove, which is 
slow.

> So the data structure is optimized for a different case than reading in 
> trees. Big deal. That optimization is definitely worth it: it allows us to 
> do the read_cache() with the actual index entries being totally read-only 
> (a linked list would have to add a "next" pointer to the cache entries and 
> not allow the in-place thing that read_cache() does).

they are still read-only with my linked list implementation.

--------------040004080400080803030508
Content-Type: text/x-vcard; charset=utf-8;
 name="cel.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cel.vcf"

begin:vcard
fn:Chuck Lever
n:Lever;Charles
org:Network Appliance, Incorporated;Linux NFS Client Development
adr:535 West William Street, Suite 3100;;Center for Information Technology Integration;Ann Arbor;MI;48103-4943;USA
email;internet:cel@citi.umich.edu
title:Member of Technical Staff
tel;work:+1 734 763-4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668-1089
x-mozilla-html:FALSE
url:http://www.monkey.org/~cel/
version:2.1
end:vcard


--------------040004080400080803030508--
