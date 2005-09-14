From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: [PATCH 21/22] teach the merge algorithm about cache iterators
Date: Wed, 14 Sep 2005 15:49:31 -0400
Organization: Network Appliance, Inc.
Message-ID: <43287ECB.8090308@citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu> <20050912145629.28120.70337.stgit@dexter.citi.umich.edu> <Pine.LNX.4.63.0509121633480.23242@iabervon.org> <43284368.8010004@citi.umich.edu> <Pine.LNX.4.63.0509141214490.23242@iabervon.org>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090604030200050609050703"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 21:52:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFdGU-0006qS-Eh
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 21:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbVINTtd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 15:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbVINTtc
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 15:49:32 -0400
Received: from citi.umich.edu ([141.211.133.111]:9539 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932513AbVINTtb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 15:49:31 -0400
Received: from [141.211.133.33] (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 46C011BAFC;
	Wed, 14 Sep 2005 15:49:31 -0400 (EDT)
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509141214490.23242@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8558>

This is a multi-part message in MIME format.
--------------090604030200050609050703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Daniel Barkalow wrote:
> The really exciting thing to do would be to have different programs use 
> different implementations, by way of linker magic.

yes, i've been considering that, but i'm not sure it is really worth the 
effort.  see below -- the right data structure should be good for just 
about any git workload.

> My guess for the ideal is to have a linked list with a hashtable for 
> finding entries by looking up names, because we don't look things up by 
> index. This combination gives O(1) in-order iteration, O(1) lookup by 
> name, O(1) append, O(n) insert, and O(1) remove. This means that 
> git-update-cache --add would be slow, but everything else would be fast. 
> (Except, of course, for the overhead of actually reading and writing the 
> index file, rather than mmaping it.)

[ i'm not sure why you think insert would be O(n). ]

keeping the linked list for O(1) next/prev and delete, and augmenting it 
with a hash table to allow O(m/n) insert and find would be ideal.  with 
a fairly large hash table, we do better than a tree for any reasonably 
sized repository i can imagine.

and, i believe simply adding a hash table to my list implementation will 
be easy, and simpler overall than a tree implementation.  famous last words.

mmapping the index file is still OK.  i haven't changed the cache_entry 
structure at all.

--------------090604030200050609050703
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
tel;work:+1 734 763 4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668 1089
x-mozilla-html:FALSE
url:http://www.monkey.org/~cel/
version:2.1
end:vcard


--------------090604030200050609050703--
