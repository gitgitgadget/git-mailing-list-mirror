From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG 1.7.9: git branch fails to create new branch when
 --edit-description is used
Date: Sat, 28 Jan 2012 22:42:14 -0800
Message-ID: <7v39azxb5l.fsf@alter.siamese.dyndns.org>
References: <2443.1327701165@plover.com>
 <7vr4ykybnl.fsf@alter.siamese.dyndns.org> <4F2399B6.8020507@alum.mit.edu>
 <7vbopoxp5q.fsf@alter.siamese.dyndns.org> <4F24E78A.7060502@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Jason Dominus <mjd@plover.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jan 29 07:42:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrOT2-0003D1-IX
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jan 2012 07:42:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315Ab2A2GmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 01:42:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44241 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957Ab2A2GmS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 01:42:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 287FE6B3D;
	Sun, 29 Jan 2012 01:42:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dzseeHEWYu4PbwQYXnYRSDk51Mc=; b=ZCPPoC
	lNWIuGckIW3j56dL6/gwBR3kpa4nUjad+NqVSFJDI5no5qhwnsCW4/eGM2SeCON0
	lf1gs81MHmFgAqSK2G87+C3Io1e3lwRjdP7SHuTLoxAr0CH9LvmZH2tN92W+bS4/
	QpDialdXa/TssOVvwiQaiBMFE1q7hasjQ1H3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bWYJyCn/aah6oSqkE0Bd+eUBT4dlhjS7
	nEtzJVi+Y6hNg7pizkG4/oF47aEBl+PjNyMnndNDcl0Nu4UerVfLvq2Wc7+todFf
	qvuPEW6Oe1z4rOD67oQNJE9IXLrcxUL9AanHUWrS4binT525xD/nAIW3AQQxy7Tn
	fYFku1K1Pek=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 204C56B3C;
	Sun, 29 Jan 2012 01:42:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A89AF6B3B; Sun, 29 Jan 2012
 01:42:16 -0500 (EST)
In-Reply-To: <4F24E78A.7060502@alum.mit.edu> (Michael Haggerty's message of
 "Sun, 29 Jan 2012 07:30:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6267A632-4A44-11E1-AE01-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189281>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 01/28/2012 08:27 AM, Junio C Hamano wrote:
>> 
>> We could error it out (i.e. you cannot name a thing that does not yet
>> exist), or we could consider it is a convenience feature that you can
>> prepare a description even before you create one, or we could even tweak
>> it more like "-t $name" that tries to work both on existing one (without
>> changing any base) or non-existing one, creating it while at it. The last
>> approach historically is the most error prone (we had numerous bugs in the
>> create_branch() helper after it started allowing an existing branch when
>> updating the "track" information) and I would rather not go that route if
>> we can avoid it.
>> 
>> Honestly speaking, I haven't formed an opinion.
>
> I vote for an error.  Otherwise a typo in the branch name would lead to
> the description's apparent disappearance into Nirvana.  An error would,
> for example, have made it clear to the OP what was happening.
>
> A more useful option might be
>
>     git branch --with-description <branchname> [<start-point>]
>
> i.e., that a branch's description can be set at the same time as the
> branch is created.

So you are saying either option 1 or 3 is preferrable, while I was saying
I would rather avoid 3 if we could avoid it. Is that the short version?
