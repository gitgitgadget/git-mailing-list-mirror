From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: [QUESTION] Selective fetch possible?
Date: Tue, 11 Mar 2008 05:07:48 -0400
Message-ID: <47D64BE4.9010009@dawes.za.net>
References: <47D5AFF3.90000@yahoo.it> <20080310225302.GE8410@spearce.org> <m3d4q2ywyx.fsf@localhost.localdomain> <47D6341C.7030505@dawes.za.net> <20080311075053.GQ8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Filippo Zangheri <filippo.zangheri@yahoo.it>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 11 10:10:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ0V2-00065s-2J
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 10:10:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbYCKJJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 05:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbYCKJJJ
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 05:09:09 -0400
Received: from sd-green-bigip-177.dreamhost.com ([208.97.132.177]:47621 "EHLO
	spunkymail-a20.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753499AbYCKJJF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Mar 2008 05:09:05 -0400
X-Greylist: delayed 6088 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Mar 2008 05:09:05 EDT
Received: from [0.0.0.0] (lucas.dreamhost.com [64.111.99.14])
	by spunkymail-a20.g.dreamhost.com (Postfix) with ESMTP id 4F5C9E250C;
	Tue, 11 Mar 2008 02:09:03 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <20080311075053.GQ8410@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76815>

Shawn O. Pearce wrote:
> Rogan Dawes <lists@dawes.za.net> wrote:
>> Jakub Narebski wrote:
>>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>>>
>>>> Filippo Zangheri <filippo.zangheri@yahoo.it> wrote:
>>>>> Is it possible to git-fetch only a portion of the tree
>>>>> of the specified repository, say, fetch only one directory or a
>>>>> subset of files matching some regular expression?
>>> The problem is twofold, as far as I understand it.  First, what to do
>>> if there is merge conflicts outside checked out (selected) directory?
>> This is something that has been repeated many times, and I fail to see 
>> how it can be an issue. How can there be a conflict in a directory that 
>> is not, and never has been, checked out, and therefore cannot have been 
>> modified?
> 
> Given two branches:
> 
> 	code
> 	docs
> 
> and the code people checkout the "src/" subdirectory and the docs
> people checkout the "Documentation/" subdirectory, and they *only*
> every work in that subdirectory, things are fine.
> 
> Until one day some developer also checks out "Documentation/" and
> fixes something in the documentation as part of the same commit
> that makes a code change.  The push this to the code branch.
> 
> Someday in the future a documentation writer merges the code branch
> over to the docs branch, "just keeping it current".
> 
> Now there arises a possiblity of a merge conflict in a part of the
> tree that you do not have checked out.
> 
> 
> If you want to say "don't ever modify stuff outside of your branch's
> purpose" then why aren't you just using submodules (one for docs and
> one for code) and using a supermodule to tie everything together into
> a "release package"?

Ok, fair enough. Thanks for the example.

I think that one should not *expect* to be able to complete merges with 
only a partial checkout, though. It *may* work in cases where there are 
no conflicts, but I think it would be a perfectly valid error path to 
fail if there is a conflicting merge in a part of the tree that has not 
been checked out.

So, for a user working on partial trees, they would be able to modify 
their partial tree, and check in their changes, but merges would have to 
be done by someone with a complete checkout. For the given examples 
where partial trees make sense (documentation workers), this seems like 
a reasonable compromise.

>>> Second, how to make repository contain only relevant objects: git in
>>> many places assumes full connectivity, and that if it has an object it
>>> hass all objects depending on it.
>>>
>> Yes, this is the big problem as I see it.
> 
> This is easy enough that if the above problem could be resolved
> sufficiently to the git gurus' satisfaction you would be able
> to get some advice on how to solve it.  Its not difficult, just
> damn annoying.  We already do it (to some extent) with grafts and
> shallow clones.

How's my suggestion above?

Rogan
