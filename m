From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Support Out-Of-Tree Valgrind Tests
Date: Tue, 06 Mar 2012 14:21:24 -0800
Message-ID: <7vboo9qskb.fsf@alter.siamese.dyndns.org>
References: <1330903437-31386-1-git-send-email-greened@obbligato.org>
 <1330903437-31386-2-git-send-email-greened@obbligato.org>
 <87aa3vzdoc.fsf@thomas.inf.ethz.ch> <nngy5re29zn.fsf@transit.us.cray.com>
 <878vje86cy.fsf@thomas.inf.ethz.ch> <87mx7tiyhh.fsf@smith.obbligato.org>
 <7vaa3ttvj1.fsf@alter.siamese.dyndns.org>
 <87hay1fkfk.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, <git@vger.kernel.org>
To: "David A. Greene" <dag@cray.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 23:21:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S52lA-0006m1-I5
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 23:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031187Ab2CFWV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 17:21:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61384 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030811Ab2CFWV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 17:21:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8065A5A80;
	Tue,  6 Mar 2012 17:21:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lGPRxqQM1XUb28B2s7BTMGCUFt8=; b=eVtKgp
	VtK+s/HWHuZnx1uPojr80uTHF/eC70/68sJgx80wIS1M0EobyFEhzB214wmFWIjg
	9DNgJvy9Dqm7sYz6bxX0w8NTl2txVw0XPmrtk+zey+6VOg/rDXOVU2lvGqUmgv+r
	H/z/OTR8BqwbI+FUbGxcDhhJdy1/+ohvDpa+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l1i/d+/l9JVAbfcUT04RMfwJUs4iONlm
	YtQCJvHtVWoNKApcskYsXIinwVpjcGbGVEroCmPO495YrBfKCNIxwbcy/ud7EDZ6
	tg3g16SyHfghYpqnoQMVQmkzVfrSKCDHIH3TBjUtzN3Rw55Xcnv7Qv/Shb97iwoA
	E76KGJ6oHAQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77E385A7F;
	Tue,  6 Mar 2012 17:21:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EAF045A7E; Tue,  6 Mar 2012
 17:21:25 -0500 (EST)
In-Reply-To: <87hay1fkfk.fsf@smith.obbligato.org> (David A. Greene's message
 of "Tue, 6 Mar 2012 16:12:31 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B678DDF0-67DA-11E1-AB54-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192405>

"David A. Greene" <dag@cray.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> greened@obbligato.org (David A. Greene) writes:
>>
>>>> Don't we, right now, get stuff as follows:
>>>>
>>>>   item                   path
>>>>   --------------------------------------------
>>>>   test-lib.sh            $TEST_DIRECTORY
>>>
>>> Right now, yes, but it breaks for out-of-tree tests.  In the out-of-tree
>>> case, TEST_DIRECTORY doesn't contain test-lib.sh.  For exmaple, in
>>
>> Could it be that the reason for the breakage is because you are
>> setting TEST_DIRECTORY to the directory that contains out-of-tree
>> tests, instead of $GIT_BUILD_DIR/t/ directory?
>
> Well, yes.  I thought that's what out-of-tree tests are supposed to do.
> They don't live in $GIT_BUILD_DIR/t/ after all.
>
> Perhaps I've misunderstood how the test system is supposed to work.  A
> table as you described in README would be most helpful.  I thought
> TEST_DIRECTORY is supposed to point to where the tests to run are
> located.
>
>> Shouldn't TEST_DIRECTORY merely a short-hand for GIT_BUILD_DIR/t?
>> What do you find relative to $TEST_DIRECTORY that cannot be found
>> relative to GIT_BUILD_DIR/t?
>
> If that's what TEST_DIRECTORY is supposed to be, always, then it should
> be stated in the comments and README.  I had no idea this was an
> invariant.
>
> Thanks for clarifying!

Not so fast. The questions in the message you are responding to were
not rhetorical.
