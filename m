From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: auto-packing on kernel.org? please?
Date: Tue, 22 Nov 2005 13:18:53 -0500
Organization: Network Appliance, Inc.
Message-ID: <4383610D.7080100@citi.umich.edu>
References: <Pine.LNX.4.64.0510131113490.15297@g5.osdl.org> <20051121190151.GA2568@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0511211110480.13959@g5.osdl.org> <4382AC11.5090209@citi.umich.edu> <Pine.LNX.4.64.0511212134330.13959@g5.osdl.org>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030502030609000400070705"
Cc: Carl Baldwin <cnb@fc.hp.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 22 19:20:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eecjb-0006zQ-Oo
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 19:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbVKVSTD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 13:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965078AbVKVSTC
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 13:19:02 -0500
Received: from citi.umich.edu ([141.211.133.111]:54202 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S965040AbVKVSTA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 13:19:00 -0500
Received: from [10.58.52.99] (nat-198-95-226-230.netapp.com [198.95.226.230])
	by citi.umich.edu (Postfix) with ESMTP id 01A081C19D;
	Tue, 22 Nov 2005 13:18:53 -0500 (EST)
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511212134330.13959@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12564>

This is a multi-part message in MIME format.
--------------030502030609000400070705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On Tue, 22 Nov 2005, Chuck Lever wrote:
> 
>>there are some things repacking does that breaks StGIT, though.
>>
>>git repack -d
>>
>>seems to remove old commits that StGIT was still depending on.
> 
> 
> If that is true, then "git-fsck-cache" probably also reports errors on a 
> StGIT repository. No? Basically, it implies that the tool doesn't know how 
> to find all the "heads".

indeed.  this is one area where StGIT is "not safe" to use with other 
porcelains.  these raw GIT commands can show a bunch of confusing 
"dangling references" type errors, or actually modify the index in ways 
that eliminate StGIT-related commits that aren't currently attached to 
any ancestry.  (i think Catalin mentioned these are related to the 
unapplied patches in a stack, but there could be others; see below).

> The preferred way would be to just list the references somewhere under 
> .git/refs/stgit, in which case fsck and repack should pick them up 
> automatically (so clearly stgit doesn't do that right now ;).

that could be an extremely large number of commits on a large repository 
with a lot of patches that have been worked on over a long period.  so 
whatever mechanism is created to do this needs to scale well in the 
number of commits.

> It also implies that doing a "git prune" will do horribly bad things to a 
> stgit repo, since it would remove all the objects that it thinks aren't 
> reachable..

yup.  been there, done that.  lucky for me i have an excellent hourly 
backup scheme.

>>git repack -a -n
>>
>>seems to work fine with StGIT,
> 
> 
> Well, it "works", but not "fine". Since it doesn't know about the stgit 
> objects, it won't ever pack them.

ah!

> But maybe that's what stgit wants (since they are "temporary"), but it 
> does mean that if you see a big advantage from packing, you might be 
> losing some of it.

actually, those commits aren't all that "temporary".  the 
history/revision feature i'm working on would like to maintain all the 
commits ever done to an StGIT patch.

the only time you can throw away such commits is when the patch is 
deleted or when it is finally committed to the repository via "stg 
commit".  otherwise, keeping these commits in a pack would be quite a 
good thing.

maybe the first thing to do is to get a basic understanding of an StGIT 
commit's lifetime.

--------------030502030609000400070705
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


--------------030502030609000400070705--
