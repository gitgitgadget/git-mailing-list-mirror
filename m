From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: BUG 1.7.9: git branch fails to create new branch when --edit-description
 is used
Date: Sun, 29 Jan 2012 07:30:34 +0100
Message-ID: <4F24E78A.7060502@alum.mit.edu>
References: <2443.1327701165@plover.com> <7vr4ykybnl.fsf@alter.siamese.dyndns.org> <4F2399B6.8020507@alum.mit.edu> <7vbopoxp5q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mark Jason Dominus <mjd@plover.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 29 07:31:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrOIB-0007JO-7y
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jan 2012 07:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133Ab2A2Gal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 01:30:41 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:49229 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063Ab2A2Gak (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 01:30:40 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEDE2E.dip.t-dialin.net [84.190.222.46])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q0T6UYG5012170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 29 Jan 2012 07:30:35 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111108 Lightning/1.0b2 Thunderbird/3.1.16
In-Reply-To: <7vbopoxp5q.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189280>

On 01/28/2012 08:27 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>>>> Where is branch blarf?
>>>
>>> You haven't created one in that sequence yet.
>>>
>>> This is more of a documentation bug. 
>>>
>>> As the SYNOPSIS section makes it clear, the '--edit-description' is a
>>> separate mode from showing (the first group), creating or repointing (the
>>> second), or renaming (the third).
>>>
>>> After that you should be able to say "git branch blarf" and view its
>>> description.
>>
>> Given this design, shouldn't "git branch --edit-description" fail if the
>> branch doesn't already exist?
> 
> The only use scenario in the original design was to have a way to store
> the description given a branch name, and giving a description to a branch
> that does not yet exist is outside the scope of the design. So it all
> boils down to what is the most convenient and the simplest to explain.
> 
> We could error it out (i.e. you cannot name a thing that does not yet
> exist), or we could consider it is a convenience feature that you can
> prepare a description even before you create one, or we could even tweak
> it more like "-t $name" that tries to work both on existing one (without
> changing any base) or non-existing one, creating it while at it. The last
> approach historically is the most error prone (we had numerous bugs in the
> create_branch() helper after it started allowing an existing branch when
> updating the "track" information) and I would rather not go that route if
> we can avoid it.
> 
> Honestly speaking, I haven't formed an opinion.

I vote for an error.  Otherwise a typo in the branch name would lead to
the description's apparent disappearance into Nirvana.  An error would,
for example, have made it clear to the OP what was happening.

A more useful option might be

    git branch --with-description <branchname> [<start-point>]

i.e., that a branch's description can be set at the same time as the
branch is created.

>> Shouldn't it also resolve ambiguous reference names?
> 
> As this mode, just like other modes of "git branch" _always_ takes a
> branch name, I do not think there is any "ambiguous reference name".
> 
> You give $name to it, and it should always mean refs/heads/$name, and
> there shouldn't be any DWIMming to something like refs/heads/mh/$name
> 
> Or do you have other kinds of ambiguity in mind?

OK, I wasn't aware that only local branches can have descriptions
attached to them.  Given that fact, you are correct that DWIMming
doesn't make sense.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
