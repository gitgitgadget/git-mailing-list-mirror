From: Junio C Hamano <gitster@pobox.com>
Subject: Re: misleading diff-hunk header
Date: Tue, 21 Aug 2012 10:52:03 -0700
Message-ID: <7vfw7gdtfg.fsf@alter.siamese.dyndns.org>
References: <503385D0.5070605@tim.thechases.com>
 <87a9xoi82i.fsf@thomas.inf.ethz.ch> <5033AC55.8080405@tim.thechases.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Tim Chase <git@tim.thechases.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 19:52:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3scm-000750-2h
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 19:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212Ab2HURwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 13:52:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36893 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932205Ab2HURwG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 13:52:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2218C77D9;
	Tue, 21 Aug 2012 13:52:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kU7MjHIn+A0Ka2pW7ZwhVA0tSY8=; b=yN9CEm
	8K56s0NtkOA4eU6DvS2hZZJ0EpbXg+IGf92JHvLRdUXjMEP/iT/uq8zuHo0B8zcY
	RRRZZ4vm/Fm5JIoAVZHmt6Rn/mx9UBLIpbbfthWWAcM6i+XQDotHD3ScBFYKA/7B
	Sk4XtfdOEw28qX+ExHxV1eEiDKP4g2TtyTkT8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ip/RPNLq9kB7xEy5Qaj5Si02SA6kZJHv
	JSHLlaKQfD5xPlNUHHpbN6wu7AJ+06P+23jka0zpe2ZW+z3xpc1XYF7y7cj2dhVx
	HWY5mwted1+C/4mLttfS69vf/W95ANUCFtJryhUMHg57isH8ziRiqv63ReCHF4dT
	gpVs7fwx7VE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F193577D8;
	Tue, 21 Aug 2012 13:52:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5832777D3; Tue, 21 Aug 2012
 13:52:05 -0400 (EDT)
In-Reply-To: <5033AC55.8080405@tim.thechases.com> (Tim Chase's message of
 "Tue, 21 Aug 2012 10:42:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EB667510-EBB8-11E1-ABF5-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203976>

Tim Chase <git@tim.thechases.com> writes:

> On 08/21/12 10:22, Thomas Rast wrote:
>> Tim Chase <git@tim.thechases.com> writes:
>> 
>>> diff.{type}.xfuncname seems to start searching backwards in
>>> from the beginning of the hunk, not the first differing line.
>> [...]
>>>   @@ -4,4 +4,5 @@ int call_me(int maybe)
>>>
>>>    int main()
>>>    {
>>>   +  return 0;
>>>    }
>>>
>>> misleadingly suggesting that the change occurred in the call_me()
>>> function, rather than in main()
>> 
>> I think that's intentional, and matches what 'diff -p' does.  It gives
>> you the context before the hunk.  After all, if a new function starts in
>> the leading context lines, you can see that in the usual diff data.

Correct.  It is about "give the user _more_ hint/clue on the context
of the hunk", in addition to what the user can see in the
pre-context of the hunk, so it is pointless to hoist "int main()"
there.

> ...  It just makes it hard for me to gather some stats on the
> functions that changed, and requires that I look in more than one
> place (both in the header, and in the leading context) rather than
> having a single authoritative place to grep.

The right way to answer "which functions were touched?" question is
to ignore what you see on the hunk header "@@ .. @@" lines and only
look at the patch text, running "git diff" with larger number of
context lines as necessary.

If you have a large patch hunk that adds or removes two or more new
functions, you would have to look at the patch text _anyway_ to
learn about these two or more names---they cannot possibly both
appear on the hunk header lines, so looking at the context hint
there is pointless for the purpose for which you are using "diff"
output.
