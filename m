From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 11:32:40 -0800
Message-ID: <7vws1ewgbr.fsf@alter.siamese.dyndns.org>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
 <4B0D2E19.6020100@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Nov 25 20:33:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDNbx-0003Tm-Eo
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 20:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759573AbZKYTcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 14:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759572AbZKYTcm
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 14:32:42 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40291 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759543AbZKYTcl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 14:32:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AB07482B06;
	Wed, 25 Nov 2009 14:32:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=AUXh5+N6hzO5lfYVJR7M3xpqBYc=; b=PxAxNsQFVmXbRkXC8FIJ5sn
	wadD1s9TWXplCaApcyVqfG89pll82bFIOxDxc1+mKED6fVr/yr+1qJI5lwRFpf2o
	Zhq6pF/1cWZKif5h/z25JA2uJ1+aw2rmG/ACQR2R9WEkSwmNg9m88kbrfZa+YWi9
	gsGPyUrZQzC8ODGFN5Do=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=cgdPSmJJNjp8SYJDmDY5FObnw2K4CRZ0LpmvfnaW/04JaDDDG
	1TmdybmHBpa+QAoW95q8RvJUV2/frd2rG+I+Rpj6u4D1sU9saUqwlFz57hzyWW0T
	z82OdDlmZWFi7Q8/9ZMycpncadQhw2VdqYBgc5Yuzv6+HOBGHfr1FVD9CA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 877B582B04;
	Wed, 25 Nov 2009 14:32:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9EB182AFE; Wed, 25 Nov
 2009 14:32:41 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4DED9BC0-D9F9-11DE-80C4-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133661>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 24.11.2009 09:56:
>> While working inside a deep subdirectory, it sometimes is necessary to
>> find a string you see in a file you are working on from the files in the
>> entire project.  This is especially true when you are dipping your toe
>> into an unfamiliar project.
>> 
>> By default, "git grep" limits its search space to the current directory
>> and below (i.e. as if "-r ." is specified), and it is rather cumbersome to
>> repeat ../ as many times as necessary.  This new option tells "git grep"
>> not to limit the search space to the current directory.
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>> 
>>  * In http://article.gmane.org/gmane.comp.version-control.git/111717, I
>>    once argued in the opposite way, but I think it is Ok to aim for making
>>    the default --full-tree in the longer run (cf. $gmane/127885).  This is
>>    the first step in that direction.
>> 
>>    I am not sure if there can be a sane way to flip the default without
>>    hurting existing scripts and users.  Backward compatibility always is
>>    a pain.
>
> On a related note, I had planned for a while now to go through the
> commands and check for inconsistencies w.r.t. to subdir default. For
> example, ls-files behaves like grep, whereas status is different. We
> already had discussions about the commit:path notation from a subdir. (I
> don't remember the outcome.) Of course, defaulting status differently
> could be dangerous. Having --full-tree as default for all commands and
> requiring an explicit "." sounds safer for all commands and not overly
> inconvenient. (I remember once wondering where my committed files are,
> looking at git ls-files output from a subdir.)
>
> I think we should make this behavior as uniform across commands as
> possible. Do we have a time frame for 1.7.0 within which one should
> achieve such incompatible changes?

I do not think there is such a consensus for a blanket change like that.

If you are starting a discussion to build one for a particular change (not
necessarily the one you mentioned above) now, you are way too late for
1.7.0.  The changes scheduled for 1.7.0 were glitches we have known for
quite some time, and more importantly had a concensus on _how_ they should
be handled long before 1.6.3 (May 6, 2009), and the most importantly, the
steps in the transition plan since then have already been executing.

 - The plan for "git push" changes were already announced in 1.6.3, and
   the first step of transition was implemented there.

 - We already had consensus for changing the default "send-email"
   threading behaviour before 1.6.2 and it was scheduled to happen in
   1.6.3 but has been deferred until now.

 - For a long time, it has been known that it is confusing and unexpected
   to users that "git status" is a synonym for "git commit --dry-run".
   The plan to make "git status" different from "git commit --dry-run" has
   been done in mid August this year.

 - For a long time, "git diff" considered -b/-w options are only for
   controlling generation of patch text, and these options didn't affect
   the exit status (when run with --exit-code) nor suppress the patch
   header lines (i.e. "diff --git").  This could be argued as a bug (the
   same way as "some commands are relative to cwd by default and others
   are relative to the whole tree" can be), but it doesn't mean we can
   blame user's scripts for relying on the bug and change the semantics
   all of sudden.  We had been cooking the change since May 2009 and
   announcements were in all issues of "What's cooking" since Aug 2009 for
   this change.

Also, please do not confuse 1.7.0 with a license for "I do not like this
and that, screw backward compatibility, and change things as if we were
building git from scratch without any existing users".  We need a solid
transition plan to ease the pain for existing scripts and users.

As to ls-files, I haven't seen any good proposal of a smooth transition
plan (like what we laid out for a few semantic changes for "git push" for
1.7.0), if we were to eventually change it, and I personally do not think
there can be a smooth transition for that particular command.  It is used
as a very low level building block for people's scripts, and I don't think
of a way to change its fundamental behaviour without causing people a lot
of extra work.  I doubt you can easily build a concensus that the benefit
of "consistency" is worth it for such a change.

    Side note.  What we _could_ do is to make ls-files less (much less)
    necessary at the UI level for you to _type_ from the command line.
    Enumerate in what situations you used the command, think about the
    reason for each of occasions why you used it (e.g. "after a conflicted
    merge I wanted to find out which paths are still unresolved and
    'ls-files -u' was the most convenient way"), and eliminate the reason
    (e.g. "add a new (option to 'merge'|command) that reports the needed
    information in much more readable way than 'ls-files -u' does).

The same applies to "$treeish:$path" syntax.

It may be convenient if there were to specify "I want to name the path in
HEAD~47 that corresponds to this file in the directory I am currently in."
But that does not necessarily mean we should change the semantics and
break existing users.  One way to satisfy the wish without breaking
existing users would be to start accepting "$treeish:./$relative".
