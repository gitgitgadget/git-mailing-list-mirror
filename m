From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v8 1/5] Refactor parse_loc
Date: Thu, 28 Feb 2013 20:24:44 +0100
Message-ID: <87lia86y2r.fsf@pctrast.inf.ethz.ch>
References: <cover.1362069310.git.trast@student.ethz.ch>
	<d22070b416a1787ece6f98a722614a54826b93ce.1362069310.git.trast@student.ethz.ch>
	<7vobf4icjh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Will Palmer <wmpalmer@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 20:25:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UB96R-0007Sv-Gz
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 20:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759725Ab3B1TYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2013 14:24:51 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:39971 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759677Ab3B1TYu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2013 14:24:50 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 28 Feb
 2013 20:24:39 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.209.233) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 28 Feb 2013 20:24:46 +0100
In-Reply-To: <7vobf4icjh.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 28 Feb 2013 09:16:50 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.209.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217251>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> From: Bo Yang <struggleyb.nku@gmail.com>
>>
>> We want to use the same style of -L n,m argument for 'git log -L' as
>> for git-blame.  Refactor the argument parsing of the range arguments
>> from builtin/blame.c to the (new) file that will hold the 'git log -L'
>> logic.
>>
>> To accommodate different data structures in blame and log -L, the file
>> contents are abstracted away; parse_range_arg takes a callback that it
>> uses to get the contents of a line of the (notional) file.
>>
>> The new test is for a case that made me pause during debugging: the
>> 'blame -L with invalid end' test was the only one that noticed an
>> outright failure to parse the end *at all*.  So make a more explicit
>> test for that.
>>
>> Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
>> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
>> ---
>>  Documentation/blame-options.txt     |  19 +------
>>  Documentation/line-range-format.txt |  18 +++++++
>>  Makefile                            |   2 +
>>  builtin/blame.c                     |  99 +++-------------------------------
>>  line-log.c                          | 105 ++++++++++++++++++++++++++++++++++++
>>  line-log.h                          |  23 ++++++++
>
> Was this churn necessary?  
>
> It is strange to move existing functions that will be tweaked to be
> shared by two different codepaths (blame and line-log) to the new
> user.
>
> The only effect this has, as opposed to tweaking the functions in
> place and making them extern, is to make it harder to see the tweaks
> made while moving the lines, and also make it more cumbersome to
> determine the lineage of the code later.
>  
> It would have been understandable if they were moved to a new
> library-ish file (perhaps "line-range.[ch]"); even though that
> approach shares the same downsides, at least it would have a better
> excuse "We will share this, so let's move it to a neutral third
> place to allow us to hide the implementation details from both
> users".  The arrangement this patch series makes does not even have
> that excuse.  The final implementation still stay with one of the
> users; the only difference is that it is away from the original user
> and close to the new user.

Even though I am moving from builtin/blame.c to line-log.c?  I would
otherwise have to call from a rather lib-ish file into a "frontend"
file.  I always figured I wasn't supposed to do that.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
