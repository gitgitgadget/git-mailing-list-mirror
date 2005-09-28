From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: index file screwed up
Date: Wed, 28 Sep 2005 13:43:04 -0400
Organization: Network Appliance, Inc.
Message-ID: <433AD628.1020308@citi.umich.edu>
References: <433AB170.90608@citi.umich.edu> <Pine.LNX.4.58.0509280831130.3308@g5.osdl.org>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010902090701010902030709"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 19:44:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKfxW-00010t-KB
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 19:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbVI1RnH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Sep 2005 13:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbVI1RnH
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Sep 2005 13:43:07 -0400
Received: from citi.umich.edu ([141.211.133.111]:26413 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751474AbVI1RnG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2005 13:43:06 -0400
Received: from [141.211.133.33] (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 41A911BBB4;
	Wed, 28 Sep 2005 13:44:39 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0.6-1.4.1 (X11/20050719)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509280831130.3308@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9443>

This is a multi-part message in MIME format.
--------------010902090701010902030709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On Wed, 28 Sep 2005, Chuck Lever wrote:
> 
>>i was working with a version of git that had a bug in add_cache_entry() 
>>that introduced a sorting error in my index.
>>
>>[cel@dexter main]$ stg refresh -f
>>Refreshing patch "git-switch-branch"...AUTHORS: unmerged 
>>(098c1d3e9fe5c39b859ccff6c7d36d2c193d1b62)
>>AUTHORS: unmerged (098c1d3e9fe5c39b859ccff6c7d36d2c193d1b62)
>>COPYING: unmerged (d60c31a97a544b53039088d14fe9114583c0efc3)
>>COPYING: unmerged (d60c31a97a544b53039088d14fe9114583c0efc3)
>>INSTALL: unmerged (8d2bebd9d1824f1b7af5cfe6fbd11f9cbfde6d74)
>>INSTALL: unmerged (8d2bebd9d1824f1b7af5cfe6fbd11f9cbfde6d74)
>>MANIFEST.in: unmerged (581d0be2a5fb3569b06681b7d559f1279aa4104b)
>>MANIFEST.in: unmerged (581d0be2a5fb3569b06681b7d559f1279aa4104b)
>>README: unmerged (184ded8e08cb92a14b79c79f9919469ba352ab70)
>>README: unmerged (184ded8e08cb92a14b79c79f9919469ba352ab70)
>>...
>>fatal: git-write-tree: verify_merged: not able to write tree
>>stg refresh: git-write-tree failed
>>
>>[cel@dexter main]$
>>
>>how do i recover?
> 
> 
> You don't. Your index is toast.
> 
> Let's hope you didn't write any unsorted trees with _earlier_ (non-merge) 
> commits.

well, i did get this working, but i "cheated."

first i switched back to a known good version of git.  then, before i 
received your advice, i replaced the damaged index file with a file 
system snapshot backup from a couple of hours earlier.  after a couple 
of "stg refresh" commands, things seem back to normal.

it could be useful to have a few backup versions of the index file (like 
index.1, index.2, etc) and have write-tree rotate them before writing 
out a new index.

btw, the git version was my own, using a trie/list cache.  it mostly 
works, except for this little sorting bug.

> Do this:
> 
>  - build a new and trustworthy git somewhere else (from a tar-file if 
>    nothing else). Install it.
> 
>  - get rid of the index and any half-way data in your working tree (you 
>    might want to save any diffs with "git diff HEAD" first, but I suspect  
>    you don't really care, since the changes came from some stg stuff, so
>    you can always re-create them, no?)
> 
> 	git reset --hard HEAD
> 
>  - run fsck, to verify that all your trees are sorted (if they aren't, you 
>    be screwed, but "git-convert-objects" should be able to fix it for 
>    you - possibly with some additional logic).
> 
> 	git-fsck-objects --full
> 
>  - restart and try again.
> 
> That _should_ get you running again.
> 
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--------------010902090701010902030709
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


--------------010902090701010902030709--
