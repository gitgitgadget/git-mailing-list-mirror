From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Following history of a copied file from another indirect branch
Date: Thu, 21 Oct 2010 14:06:24 -0600
Message-ID: <4CC09D40.4050303@workspacewhiz.com>
References: <4CC08AA5.8070502@workspacewhiz.com> <9089D1F5-A19B-4030-A6ED-463F250E450B@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 22:06:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P91PI-000512-IU
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 22:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755313Ab0JUUG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 16:06:29 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:37780 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181Ab0JUUG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 16:06:27 -0400
Received: (qmail 14585 invoked by uid 399); 21 Oct 2010 14:06:22 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@69.98.137.222)
  by hsmail.qwknetllc.com with ESMTPAM; 21 Oct 2010 14:06:22 -0600
X-Originating-IP: 69.98.137.222
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.11) Gecko/20101013 Lightning/1.0b3pre Thunderbird/3.1.5
In-Reply-To: <9089D1F5-A19B-4030-A6ED-463F250E450B@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159557>

----- Original Message -----
From: Brian Gernhardt
Date: 10/21/2010 1:39 PM
> On Oct 21, 2010, at 2:47 PM, Joshua Jensen wrote:
>> It has become a necessity to copy a file from one long-lived branch to another.  It is not possible to merge the branches at this time.
>>
>> I would like to have 'git gui blame' follow the copy back through its original history, but I don't believe Git has metadata for storing this.  Something along the lines of a 'followparent' in the commit object, for instance, would allow the revision walking code to wander the history down an alternate line.
> Git stores no per-file metadata.  The closest we come is .gitattributes and .gitignore.
>
>> By comparison, integrates work at a file level in Perforce.  That means I can integrate a file from one branch to another, and parentage is stored such that I can follow the file back through its history.
>>
>> Are there any facilities to do this now?
> Git simply does not have the idea of the history of a file.  Nothing in git will help merge "just a file" from one branch to another.  Either we have merged the two commits or not.
I'm not super interested in per file merging (which is a great concept, 
works well in Perforce, but is irrelevant here).  I merely want to 
preserve the original parentage so facilities like blame (ultimately 
rev-list?) can walk the extended history.  I'm fine even passing in a 
flag.  I do not care in preserving the original parentage for purposes 
of merging.

> You can use git-filter-branch to create a new branch that contains only that single file and only the commits that affected it.  Something like the following (untested):
>
> I would recommend using cherry-pick to pull any further changes to the file across branches (be careful of commits that touch more than that file!).  I think git-filter-branch could be used to keep the one file branch up to date, but that is likely more effort than it's worth.  I would specifically advise against merging the single file branch into both "src" and "dest", as I think any later merge of the two would find these commits as a merge-base.
Thanks for the info.

The problem with using cherry-pick is that the commits in question 
contain more than one file.  Perhaps the individual file should have 
been committed separately, but the damage was long ago done.

git format-patch --stdout HEAD..otherbranch -- the/filename | git 
am           or
git diff HEAD..otherbranch -- the/filename | git apply

Seem to be the appropriate methods of copying the file over with fake 
history or squashed together.

Josh
