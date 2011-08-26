From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] RFC: patterns for branch list
Date: Fri, 26 Aug 2011 09:55:37 -0700
Message-ID: <7vwre0dsdy.fsf@alter.siamese.dyndns.org>
References: <4E5607E0.1050300@drmicha.warpmail.net>
 <cover.1314259226.git.git@drmicha.warpmail.net>
 <20110825175301.GC519@sigill.intra.peff.net>
 <4E5759B1.50705@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Schubert <mschub@elegosoft.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Aug 26 18:55:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwzh4-0007Yy-Be
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 18:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664Ab1HZQzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 12:55:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54922 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917Ab1HZQzk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 12:55:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8510A3D7A;
	Fri, 26 Aug 2011 12:55:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fuxhtw28ixuVDNTRfZwHS7Hy2n8=; b=LuQC0B
	uriRmPqR61XHveBn8BhsOnlpcupi2GSxtnUnEoIy/czp9aTZR8HOBiouvOLk/lTy
	iN43WkQFlJXugNVtydNYGzJUyrCv4GxSAEIlJMj7IyPXdfV53L/akMD2max/LNDJ
	q2s0qxixwdPoqjqgeAi2ziXJ10q6INhCyQonk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nIF5i53NyaJBRoA64E3+aiyAtIszB4eI
	AxTjP/8S1goZhY0cZbkpIbv4ufMxPvG5ldVJON7jLRIgJJRNibGyARSCkNoNn0Qi
	j5XYFyf9U+HTL+1FD20aDc9pHwtuONVEFwZLV9o+KghCD+w6aUWiaSHHicBUdiaP
	MylTThGAhmE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C2BA3D6F;
	Fri, 26 Aug 2011 12:55:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6ABC3D6E; Fri, 26 Aug 2011
 12:55:38 -0400 (EDT)
In-Reply-To: <4E5759B1.50705@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri, 26 Aug 2011 10:30:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 39C70976-D004-11E0-A447-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180178>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Jeff King venit, vidit, dixit 25.08.2011 19:53:
>> On Thu, Aug 25, 2011 at 10:30:16AM +0200, Michael J Gruber wrote:
>> 
>>> Both "tag" and "branch" could activate list mode automatically on an invalid
>>> tag name rather than dieing:
>>>
>>> git tag v1.7.6\*
>>> Warning: tag 'v1.7.6*' not found.

If it is not found, the usual action is create it, no?

>>> v1.7.6
>>> v1.7.6-rc0
>>> v1.7.6-rc1
>>> v1.7.6-rc2
>>> v1.7.6-rc3
>>> v1.7.6.1
>> 
>> That just seems confusing to me. What is the exit status? Shouldn't the
>> warning be "error: tag 'v1.7.6*' is not a valid tag name"?
>
> Sure, and sorry, copied the wrong one. I'd just like to have the simple
> way to say "git branch peff/\*" at least as long as we don't have "-l"
> for "--list".

As we use fnmatch() and not match_pathspec() for this pattern matching,
"git branch peff/" will not list all the topics under the peff/ hierarchy
(your example "git branch peff/\*" would be the way), but I would imagine
that we may someday want to update it to allow the leading path match
here. And at that point, distinction between

	git branch peff  ;# to create a "peff" branch
        git branch peff/ ;# to list "peff/" branches, as "peff/" itself is
        		 ;# an invalid branch name and your auto listing
                         ;# heuristic kicks in

while it might be very useful for experts, becomes too subtle and would
confuse new people. We should instead require an explicit -l/--list, and
not use the auto listing heuristics (it is fine for -v to imply -l).
