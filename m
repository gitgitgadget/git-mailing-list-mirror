From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: [Census] So who uses git?
Date: Mon, 06 Feb 2006 16:15:01 -0500
Organization: Network Appliance, Inc.
Message-ID: <43E7BC55.8010908@citi.umich.edu>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com> <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org> <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com> <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net> <1138529385.9919.185.camel@evo.keithp.com> <43DCA495.9040301@gorzow.mm.pl> <20060130225107.GA3857@limbo.home> <Pine.LNX.4.64.0601311314030.7301@g5.osdl.org> <20060131220148.GA19411@steel.home> <20060201013901.GA16832@mail.com> <Pine.LNX.4.64.0601311747360.7301@g5.osdl.org>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080206080401080801060206"
Cc: Ray Lehtiniemi <rayl@mail.com>, Alex Riesen <raa.lkml@gmail.com>,
	Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>,
	Keith Packard <keithp@keithp.com>,
	Junio C Hamano <junkio@cox.net>, cworth@cworth.org,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>
X-From: git-owner@vger.kernel.org Mon Feb 06 22:15:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6DhV-00011H-Ks
	for gcvg-git@gmane.org; Mon, 06 Feb 2006 22:15:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWBFVPF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Feb 2006 16:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWBFVPE
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Feb 2006 16:15:04 -0500
Received: from citi.umich.edu ([141.211.133.111]:51389 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932120AbWBFVPD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2006 16:15:03 -0500
Received: from [141.211.133.33] (dexter.citi.umich.edu [141.211.133.33])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by citi.umich.edu (Postfix) with ESMTP id DBDC01BB85;
	Mon,  6 Feb 2006 16:15:01 -0500 (EST)
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601311747360.7301@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15662>

This is a multi-part message in MIME format.
--------------080206080401080801060206
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
>>for comparison, one of our sandboxes is sitting on an NTFS file system,
>>accessed via SMB:
>>
>>  smbfs$ time git update-index --refresh
>>  real    11m36.502s
>>  user    0m6.830s
>>  sys     0m5.086s
> 
> 
> Ouch, ouch, ouch.
> 
> Sounds like every single stat() will go out the wire. I forget what the 
> Linux NFS client does, but I _think_ it has a metadata timeout that avoids 
> this. But it might be as bad under NFS.
> 
> Has anybody used git over NFS? If it's this bad (or even close to), I 
> guess the "mark files as up-to-date in the index" approach is a really 
> good idea..
> 
> Of course, the whole point of git is that you should keep your repository 
> close, but sometimes NFS - or similar - is enforced upon you by other 
> issues, like the fact that the powers-that-be want anonymous workstations 
> and everybody should work with a home-directory automounted over NFS..

yes, i keep my Linux kernel repository in NFS (and my stgit and git 
repositories too).

there are some things that are slow precisely because my think time is 
longer than the NFS client's attribute timeout, which means that all of 
git's lstat()s turn into GETATTRs.

using the "noatime,nodiratime,actimeo=7200" mount options can have some 
benefit.  however, i found that keeping the repository packed provides 
the greatest positive impact.  that means that most of the objects are 
in a single file, and can be validated with just one GETATTR.

one thing we might conclude from this is that making "packing" an 
efficient operation (or even an incremental one) would go a long way to 
helping performance on network file systems.

--------------080206080401080801060206
Content-Type: text/x-vcard; charset=utf-8;
 name="cel.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cel.vcf"

begin:vcard
fn:Chuck Lever
n:Lever;Charles
org:Network Appliance, Incorporated;Open Source NFS Client Development
adr:535 West William Street, Suite 3100;;Center for Information Technology Integration;Ann Arbor;MI;48103-4943;USA
email;internet:cel@citi.umich.edu
title:Member of Technical Staff
tel;work:+1 734 763 4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668 1089
x-mozilla-html:FALSE
url:http://troy.citi.umich.edu/u/cel/
version:2.1
end:vcard


--------------080206080401080801060206--
