From: Carlos Pereira <jose.carlos.pereira@ist.utl.pt>
Subject: Re: git best strategy for two version development
Date: Sat, 08 Feb 2014 08:55:38 +0000
Message-ID: <52F5F10A.2080708@ist.utl.pt>
References: <52F59131.5000808@ist.utl.pt> <20140208035610.GK635004@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 08 09:43:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WC3Vl-0007zS-AB
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 09:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbaBHInN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Feb 2014 03:43:13 -0500
Received: from smtp2.ist.utl.pt ([193.136.128.22]:40240 "EHLO smtp2.ist.utl.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773AbaBHInM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 03:43:12 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp2.ist.utl.pt (Postfix) with ESMTP id 50CD470003D3
	for <git@vger.kernel.org>; Sat,  8 Feb 2014 08:43:09 +0000 (WET)
X-Virus-Scanned: by amavisd-new-2.6.4 (20090625) (Debian) at ist.utl.pt
Received: from smtp2.ist.utl.pt ([127.0.0.1])
	by localhost (smtp2.ist.utl.pt [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id 8yfhqc0rDukT for <git@vger.kernel.org>;
	Sat,  8 Feb 2014 08:43:09 +0000 (WET)
Received: from mail2.ist.utl.pt (mail.ist.utl.pt [IPv6:2001:690:2100:1::8])
	by smtp2.ist.utl.pt (Postfix) with ESMTP id C77E9700045F
	for <git@vger.kernel.org>; Sat,  8 Feb 2014 08:43:08 +0000 (WET)
Received: from [IPv6:2001:690:2100:1c0:7aac:c0ff:feff:eff7] (unknown [IPv6:2001:690:2100:1c0:7aac:c0ff:feff:eff7])
	(Authenticated sender: ist12604)
	by mail2.ist.utl.pt (Postfix) with ESMTPSA id 7792A200731A
	for <git@vger.kernel.org>; Sat,  8 Feb 2014 08:43:08 +0000 (WET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20121215 Icedove/3.0.11
In-Reply-To: <20140208035610.GK635004@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241828>

On 02/08/2014 03:56 AM, brian m. carlson wrote:
> On Sat, Feb 08, 2014 at 02:06:41AM +0000, Carlos Pereira wrote:
>    
>> Hello,
>>
>> I am a git and CVS newbie, I bought and red most of the excellent
>> Pro Git book by Scott Chacon, but I still have a doubt. I have a
>> package that I distribute in two versions differing only in one
>> library: version_A uses this library, version_B uses my own code to
>> replace it. For strategic reasons I want to keep it this way for the
>> time being. Both versions have the same documentation, the same data
>> files, and 99% of the source code is the same (a few makefile
>> changes, two additional files in version_B and some minor changes: a
>> diff -r has only 170 lines). The question is what is the best
>> strategy to manage a situation like this with git?
>>
>> Shall I maintain two different repositories? I don't think so...
>>
>> Apparently the best solution would be to maintain two long term
>> branches, say mater_A and master_B, and merge all later developments
>> in both branches, keeping the initial difference... Specifically:
>>
>> 1) do some new work in branch master_A, commit, etc.
>> 2) checkout master_B and merge the new work in master_B, without
>> merging the initial diff between the two versions.
>>
>> What is the better way to do that?
>>      
> That's pretty much the way to do it.  If you check in master-A, then
> create the master-B branch off of that, copying in the code from B and
> checking it in, then when you merge from master-A to master-B, git will
> basically do the right thing.  Changes you make on master-A that are
> specific to that version will probably conflict, but they should be easy
> to fix up.
>    
You are right! git does not try to merge everything, only changes 
commited on the other branch (branch-A), after creating branch-B... 
otherwise it would be reverting the work done on the current branch, 
which does not make much sense...

Thank you very much...
C
> I basically do this for a consulting project for a client: there's
> generic code in master, and a special branch for the client.  Since most
> changes don't touch the modified code, conflicts are infrequent, and I
> can fix them up when they occur.  I also do it for my dotfiles, which
> vary slightly between home and work.
>
> You could also make the changes to master-B as a set of commits on top
> of master-A, and always rebase master-B on master-A, but this isn't a
> good solution if other people are going to be using your code.  It has
> the benefits of keeping the history free of frequent merges, which may
> or may not be important to you; it doesn't really bother me very much.
>
>    
