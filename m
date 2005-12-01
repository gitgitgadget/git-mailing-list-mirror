From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: [PATCH 6/7] Add a "--clone" option to "stg branch"
Date: Thu, 01 Dec 2005 16:47:53 -0500
Organization: Network Appliance, Inc.
Message-ID: <438F6F89.7010004@citi.umich.edu>
References: <20051129220552.9885.41086.stgit@dexter.citi.umich.edu>	 <20051129220949.9885.51533.stgit@dexter.citi.umich.edu> <b0943d9e0512011305v3299f27au@mail.gmail.com>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030901050309040601010006"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 22:50:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhwHW-0001T1-1j
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 22:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbVLAVrz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 16:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVLAVry
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 16:47:54 -0500
Received: from citi.umich.edu ([141.211.133.111]:15476 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932492AbVLAVry (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 16:47:54 -0500
Received: from [141.211.133.33] (dexter.citi.umich.edu [141.211.133.33])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by citi.umich.edu (Postfix) with ESMTP id 9C7441BC34;
	Thu,  1 Dec 2005 16:47:53 -0500 (EST)
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <b0943d9e0512011305v3299f27au@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13076>

This is a multi-part message in MIME format.
--------------030901050309040601010006
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit

Catalin Marinas wrote:
> On 29/11/05, Chuck Lever <cel@netapp.com> wrote:
> 
>>Cloning a branch means creating a new branch and copying all of the
>>original branch's patches and its base to it.  Like creating a tag,
>>but this also preserves all the StGIT patches as well.
> 
> [...]
> 
>>--- a/stgit/commands/branch.py
>>+++ b/stgit/commands/branch.py
> 
> [...]
> 
>>+        print 'Cloning current branch to "%s"...' % clone
> 
> 
> I would put a comma after this line and add sys.stdout.flush(). So
> that 'done' is shown on the same line.

d'oh!  that's left over from when the Series.clone() method actually 
printed the name of each patch as it was cloning.  fixed.

> [...]
> 
>>--- a/stgit/stack.py
>>+++ b/stgit/stack.py
> 
> [...]
> 
>>+    def clone(self, target_series):
>>+        """Clones a series
>>+        """
> 
> 
> Wouldn't it be easier to do a recursive copy at the directory level
> (.git/patches/<branch> into .git/patches/<clone> and
> .git/refs/bases/<branch> into .git/refs/bases/<clone>)? Is there
> anything that could go wrong if we do this?

well, then you'd also clone any junk files that were left in there (for 
example, development notes).

also, by doing this a patch at a time, it gives the ability to hook in 
additional functionality in the future, in case we want to do something 
special to each newly cloned patch, like mechanically change the patch 
names, or automatically add some annotation, for example.

it also automatically converts an old-style branch (patches and series 
control files in same directory) to a new-style branch (patches in 
separate directory from series control files).

it follows the same basic pattern of logic as "stg pick".  cloning a 
branch is kind of like 'picking' all of it's patches into a new branch.

but finally (and most practically speaking), i hunted around for Python 
code to copy a directory hierarchy, and interestingly enough it looks 
about as complicated (or maybe more complicated) than the clone 
implementation i finally came up with, which is only about 30 lines.  i 
suppose we could just do a "os.system('cp -r yada yada')" but that's 
just lame  ;^)  and it only works on UNIX.

--------------030901050309040601010006
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
url:http://www.monkey.org/~cel/
version:2.1
end:vcard


--------------030901050309040601010006--
