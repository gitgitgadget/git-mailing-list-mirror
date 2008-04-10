From: Toby Corkindale <toby.corkindale@rea-group.com>
Subject: Re: [BUG?] git-archive ignores remote .gitattributes
Date: Thu, 10 Apr 2008 14:14:14 +1000
Organization: REA Group
Message-ID: <47FD9416.1020403@rea-group.com>
References: <47EB0FAE.5000102@rea-group.com> <20080327033341.GB5417@coredump.intra.peff.net> <47EB213F.1020503@rea-group.com> <20080327042925.GA6426@coredump.intra.peff.net> <47EB271F.1050307@rea-group.com> <20080327045342.GC6426@coredump.intra.peff.net> <47EC7DD1.3060102@rea-group.com> <alpine.LSU.1.00.0803281321260.18259@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 06:06:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjo3q-0005ue-Ef
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 06:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbYDJEGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 00:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbYDJEGK
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 00:06:10 -0400
Received: from mel-nat68.realestate.com.au ([210.50.192.68]:54682 "EHLO
	mel-nat68.realestate.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750785AbYDJEGJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Apr 2008 00:06:09 -0400
Received: from [192.168.53.6] ([192.168.53.6]) by mel-nat68.realestate.com.au with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 10 Apr 2008 14:05:43 +1000
User-Agent: Thunderbird 2.0.0.12 (X11/20080227)
In-Reply-To: <alpine.LSU.1.00.0803281321260.18259@racer.site>
X-OriginalArrivalTime: 10 Apr 2008 04:05:43.0576 (UTC) FILETIME=[25A0E980:01C89AC0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79166>

Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 28 Mar 2008, Toby Corkindale wrote:
> 
>> I submit that this is a bug, or at least undesirable behaviour:
>>
>> "git-archive --remote=/some/repo" will ignore /some/repo/.gitattributes, 
>> but check /some/repo/info/attributes.
>>
>> I think the problem is in the loop that looks for .gitattributes, which 
>> seems to do so by taking the current path and iterating down through it?
> 
> The problem is that "git archive --remote" operates on the remote 
> repository as if it were bare.  Which in many cases is true.
> 
> So I'd submit that this is not the usage .gitattributes is meant for, and 
> that you should clone the thing if you want to generate archives heeding 
> the .gitattributes.

If it is not what .gitattributes is for, then what is?
The attributes docs even include specific options for archive mode 
(export-subst), which implies it is exactly meant for archive.

How about $GIT/info/attributes instead? Sadly, that isn't copied during 
clone.

I'd rather not have to clone a potentially large repository just in 
order to make an archive of one specific version. If I was going to have 
to clone it, then I could pass appropriate options to rsync or tar to 
archive instead of calling git-archive.

ie. One could create this:

#!/bin/bash
# Usage: git-archive2  <repo> <treeish>
# note - not actually a real script, don't run this.
REPO=$1
VERSION=$2
git clone $REPO
cd `basename $REPO`
git checkout $VERSION
tar cf - --exclude=.git
cd ..
rm -rf `basename $REPO`


That's silly and shouldn't be required, because git-archive --remote 
exists to perform that work. But it doesn't look at the attributes.

Is there a better way?

thanks,
Toby

-- 
Toby Corkindale
Software developer
w: www.rea-group.com
REA Group refers to realestate.com.au Ltd (ASX:REA)

Warning - This e-mail transmission may contain confidential information.
If you have received this transmission in error, please notify us
immediately on (61 3) 9897 1121 or by reply email to the sender. You
must destroy the e-mail immediately and not use, copy, distribute or
disclose the contents.
