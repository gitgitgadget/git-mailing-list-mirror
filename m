From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 2/2] submodule: drop the top-level requirement
Date: Fri, 19 Apr 2013 21:23:23 +0200
Message-ID: <517199AB.50109@kdbg.org>
References: <cover.1365539059.git.john@keeping.me.uk> <cover.1366314439.git.john@keeping.me.uk> <cover.1366314439.git.john@keeping.me.uk> <6e4122f3eedec3f520028b5598b78e0d59e5d12b.1366314439.git.john@keeping.me.uk> <7vfvyn4g46.fsf@alter.siamese.dyndns.org> <20130419074632.GC2278@serenity.lan> <7vmwsu31vh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 21:23:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTGuI-0006v0-TY
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 21:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052Ab3DSTXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 15:23:30 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:61202 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753711Ab3DSTX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 15:23:29 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 4B1FDCDF83;
	Fri, 19 Apr 2013 21:23:25 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 80D5719F5A8;
	Fri, 19 Apr 2013 21:23:24 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vmwsu31vh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221795>

Am 19.04.2013 18:45, schrieb Junio C Hamano:
> John Keeping <john@keeping.me.uk> writes:
> 
>> On Thu, Apr 18, 2013 at 03:40:41PM -0700, Junio C Hamano wrote:
>>> John Keeping <john@keeping.me.uk> writes:
>>>
>>>> +relative_path ()
>>>> +{
>>>> +	local target curdir result
>>>> +	target=$1
>>>> +	curdir=${2-$wt_prefix}
>>>> +	curdir=${curdir%/}
>>>> +	result=
>>>> +
>>>> +	while test -n "$curdir"
>>>> +	do
>>>> +		case "$target" in
>>>> +		"$curdir/"*)
>>>> +			target=${target#$curdir/}
>>>> +			break
>>>> +			;;
>>>> +		esac
>>>
>>> Could $curdir have glob wildcard to throw this part of the logic
>>> off?  It is OK to have limitations like "you cannot have a glob
>>> characters in your path to submodule working tree" (at least until
>>> we start rewriting these in C or Perl or Python), but we need to be
>>> aware of them.
>>
>> I think the use of "#" instead of "##" saves us here because even with a
>> wildcard in $curdir the case statement matches literally, 
> 
> If you have curdir=a*b and target=adropb/c/d/e, the chopping itself
> 
> 	target=${target#$curdir/}
> 
> would happily chop "adropb/" from the target, but because the dq
> around "$curdir/"* in the case arm label enforces that target must
> literally match curdir followed by a slash, we do not even come to
> the chomping part.
> 
> I still have not convinced myself that it is impossible for somebody
> more clever than I to craft a pair of target and curdir that breaks
> it, though.  (target="a*b/c/d", curdir="a*b") is correctly chopped,
> so that is not it.

Why not just replace the six-liner by this one-liner:

		target=${target#"$curdir"/}

-- Hannes
