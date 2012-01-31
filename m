From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Tue, 31 Jan 2012 09:57:17 +0100
Message-ID: <4F27ACED.2050709@alum.mit.edu>
References: <4F24E287.3040302@alum.mit.edu> <7vwr8bvvxj.fsf@alter.siamese.dyndns.org> <4F263AEE.4080409@alum.mit.edu> <7v39axc9gp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 31 09:57:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rs9XI-0000hp-4w
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 09:57:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400Ab2AaI5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 03:57:45 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:57883 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360Ab2AaI5p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 03:57:45 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q0V8vIga025441
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 31 Jan 2012 09:57:18 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111108 Lightning/1.0b2 Thunderbird/3.1.16
In-Reply-To: <7v39axc9gp.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189446>

On 01/30/2012 07:48 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> [3] If commit 0000000 were treated specially, then there would be no
>> unborn branches but only branches pointing at the empty commit.  In that
>> case, my expectation would change--the old branch should be left
>> pointing at 0000000.  But currently git has no concept of an unborn
>> branch that is not HEAD.
> 
> And it probably is not a good thing to add such. Under that constraints,
> HEAD that says refs/heads/foo where foo does not exist yet needs to be
> special cased at places where it matters.
> 
> For that matter, even if we artificially created refs/heads/foo before any
> commit is made and made it point at 0{40}, you would need to add special
> cases to other parts of the system

No, the idea is to avoid special casing by making 0{40} into a real (but
empty) revision.

> (e.g. "commit" needs to notice that the
> result should be a root, not a child of 0{40};

No, commits that were previously generated as orphans *would* now be
generated as children of the special 0{40} commit.

> "checkout other_branch"
> needs to notice that it should refrain from running the equivalent of
> "read-tree -m HEAD other_branch" because HEAD does not point at a real
> tree;

No, it would merge the 0{40} commit with other_branch like usual,
resulting in the same contents as other_branch.  Indeed, if other_branch
is also ultimately a descendant of 0{40}, this would be like a
fast-forward merge.

> etc.

This "etc" might include problems.

> so it does not change the fact that the unborn branch is case
> is special.

On the contrary, I believe that much special casing could be eliminated
and the UI made more uniform by treating everything as a descendant of a
special "NULL" commit.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
