From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: [QUESTION] Selective fetch possible?
Date: Tue, 11 Mar 2008 03:26:20 -0400
Message-ID: <47D6341C.7030505@dawes.za.net>
References: <47D5AFF3.90000@yahoo.it> <20080310225302.GE8410@spearce.org> <m3d4q2ywyx.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Filippo Zangheri <filippo.zangheri@yahoo.it>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 08:30:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYyw5-0004R1-Ps
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 08:30:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbYCKH3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 03:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbYCKH3b
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 03:29:31 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:58730 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbYCKH3b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 03:29:31 -0400
Received: from spunkymail-a14.g.dreamhost.com (sd-green-bigip-81.dreamhost.com [208.97.132.81])
	by hapkido.dreamhost.com (Postfix) with ESMTP id B32B517A11C
	for <git@vger.kernel.org>; Tue, 11 Mar 2008 00:29:28 -0700 (PDT)
Received: from [0.0.0.0] (lucas.dreamhost.com [64.111.99.14])
	by spunkymail-a14.g.dreamhost.com (Postfix) with ESMTP id 377DC190E35;
	Tue, 11 Mar 2008 00:27:33 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <m3d4q2ywyx.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76806>

Jakub Narebski wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
>> Filippo Zangheri <filippo.zangheri@yahoo.it> wrote:
>>> Is it possible to git-fetch only a portion of the tree
>>> of the specified repository, say, fetch only one directory or a
>>> subset of files matching some regular expression? This is currently
>>> - to my knowledge - only possible via wget iff the GIT repository
>>> has gitweb enabled. But that's just a workaround.
>> No.
>>
>> You can use a shallow clone to fetch only X commits back into
>> history on any branch, and you can also manually configure the
>> fetch specification in .git/config to only fetch specific branches,
>> but you must fetch the entire tree to get any of the files in it.
>>
>> If the repository is available by git:// protocol you may be able
>> to use git-archive to obtain a tarfile for just the directory you
>> want (service has to be enabled on the remote side) but that is
>> just a raw UNIX tar; there is no Git repository and no ability to
>> commit/fetch/push/diff/apply/log/etc.
> 
> Note that what you wanted is, I guess, something called partial
> checkout or subtree checkout.  This feature appears now and then in
> feature requests; lately Nguyen Thai Ngoc Duy (pclouds) offered to do
> this in "on subtree checkout" thread:
>   http://thread.gmane.org/gmane.comp.version-control.git/74915

I still believe that it could be done fairly easily by simply recording 
the SHA1's of the files and directories that are *not* checked out 
somewhere in the .git directory, and just reusing those when checking 
the working tree. i.e. rather than stat-ing a tree that was never 
checked out, get the known SHA1 for that tree from where it was recorded 
on checkout.

> The problem is twofold, as far as I understand it.  First, what to do
> if there is merge conflicts outside checked out (selected) directory?

This is something that has been repeated many times, and I fail to see 
how it can be an issue. How can there be a conflict in a directory that 
is not, and never has been, checked out, and therefore cannot have been 
modified?

The only possibility that I can see is if the directory has been renamed 
elsewhere, but in that case, it *is* effectively checked out (just with 
a different directory name).

> Second, how to make repository contain only relevant objects: git in
> many places assumes full connectivity, and that if it has an object it
> hass all objects depending on it.
> 

Yes, this is the big problem as I see it.

Rogan
