From: Michael O'Cleirigh <michael.ocleirigh@rivulet.ca>
Subject: Re: [PATCH] git-filter-branch: add --egrep-filter option
Date: Sat, 16 Apr 2011 21:45:50 -0400
Message-ID: <4DAA464E.7010804@rivulet.ca>
References: <4DA8CBB0.6080103@rivulet.ca> <201104161016.51690.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 03:46:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBH3p-0007vi-04
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 03:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187Ab1DQBp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 21:45:56 -0400
Received: from rivulet.ca ([69.164.222.54]:42651 "EHLO smtp.rivulet.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788Ab1DQBpy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 21:45:54 -0400
Received: from [10.79.81.13] (24-246-84-164.cable.teksavvy.com [24.246.84.164])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.rivulet.ca (Postfix) with ESMTPSA id 4C0106195;
	Sat, 16 Apr 2011 21:45:51 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <201104161016.51690.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171707>

Hi Johannes,

Thanks for commenting on this patch.

> On Samstag, 16. April 2011, Michael O'Cleirigh wrote:
>> The --subdirectory-filter will look for a single directory and then rewrite
>> history to make its content the root.  This is ok except for cases where we
>> want to retain history of those files before they were moved into that
>> directory.
>>
>> The --egrep-filter option allows specifying an egrep regex for the files in
>> the tree of each commit to keep.  For example:
>>
>> Directories we want are A, B, C, D and they exist in several different
>> lifetimes.  A and B exist sometimes together then B and C and finally then
>> D.
>>
>> e.g. git-filter-branch --egrep-filter "(A|B|C|D)"
>>
>> Each commit will then contain different combination's of A or B or C or D
>> (up to A and B and C and D).
> Why do you need a new --...-filter option for this? Your implementation is
> merely an instance of an --index-filter, and at that a very specialized one,
> which operates only at the top-most directory level.
>

At work we needed to split out 2 more modules from a 1400 revision 
repository that we imported from subversion.

Each had been originally created under different names at the top level 
and then only recently moved into a more logical single directory per 
project structure.  When we first ran filter-branch with the 
--subdirectory-filter we only had 6 commits instead of the 100 commits 
we ended up with after using the --egrep-filter method.

I tried a tree-filter first but it was slow and then the same method as 
an index filter was slower (I would search for the paths that didn't 
match the filter (egrep -v "pattern") and then remove each of them).

By using this egrep-filter option it only took 5 minutes per repo vs >8 
hours for the tree-filter approach.

I posted to the list incase it might be useful to others;  But I didn't 
really know if it would be useful or not.

After considering your comment I have to agree with you that it is a 
special case of index-filter and probably not useful/general for enough 
other cases to justify adding in a new command line option.

Regards,

Mike
