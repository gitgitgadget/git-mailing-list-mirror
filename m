From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Does content provenance matter?
Date: Mon, 07 May 2012 17:08:09 -0700
Message-ID: <7vaa1j357a.fsf@alter.siamese.dyndns.org>
References: <1336250956.54413.YahooMailClassic@web121505.mail.ne1.yahoo.com>
 <878vh4flh1.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kelly Dean <kellydeanch@yahoo.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue May 08 02:08:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRXyU-0005xJ-Uz
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 02:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757451Ab2EHAIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 20:08:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61404 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755225Ab2EHAIO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 20:08:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCC9663C7;
	Mon,  7 May 2012 20:08:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OnAunEDblOV9S0S8EgmtswIbrYM=; b=xa02VD
	sC6WNvjSrVE/2APc+UitKtdPUda/YompUk8YKMtfesr2yTdM8p0UkdGDFJIDu7H1
	G00aw/0my530GquGsvquYEqzLnuwDtrHXUYtSfdp/vmd5GET64HFRTYdoH23/V3B
	+2NWk9Sy1nUFzJR6dmFqjF5jOGDRif9TkTsUk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e+6v0KJLduKLxoLCtD5UtvQD/KMqR6//
	wuyFxvE69dVwybQdDBtEWPrtJDlbDQtf9u4nzOk/74gh3s6gV65A9mABlsMgFgl9
	M2llo0ArbxtBD7NKyOwIcfjk7xppWs6d0WjdLscBFoF0o8rYmuqF5qiiMAWwbZF1
	dVpQ8w8cSRo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3E8463C6;
	Mon,  7 May 2012 20:08:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C57A063C5; Mon,  7 May 2012
 20:08:10 -0400 (EDT)
In-Reply-To: <878vh4flh1.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Mon, 7 May 2012 10:23:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E5AB5D58-98A1-11E1-8525-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197329>

Thomas Rast <trast@student.ethz.ch> writes:

> Kelly Dean <kellydeanch@yahoo.com> writes:
>
>> [copying B/X over to C/X is not recorded as such], on the theory that
>> just content, not provenance, is what matters.
>
>> [merging branches *is* recorded], on the theory that not only content,
>> but also provenance, matters.
>
>> The basic question is, if provenance doesn't matter, then why does a
>> git commit record its parent(s)? Why not omit this information, and
>> figure it out at search time (by looking at all commits with older
>> timestamps), the same as you're supposed to figure out renames at
>> search time and figure out the movement of lines within/among files at
>> search time (by looking at all files in the parent commit(s))?
>
> What's the difference between the following series of commits?
>
>   Foo
>   Bar
>   Revert Bar
>
> and
>
>   Foo
>
> You claim that they're the same, because the tree state after each is
> the same.  But I learned that Bar was broken, and recorded it for all to
> see.

I am not sure if that is what the original poster was claiming.

But a more illustrative situation to consider is this.  What if the change
were not just "copy B/X to C/X", but was "concatenate the first half of
B/X and the second half of C/X to create a new D/X".

As it happens, because our commit records the whole tree state and its
parent commit, the "content provenance" of what is in D/X is precisely
tracked.  Look at the tree of the parent commit and look at the result,
and you will notice the first half of D/X is identical to the first half
of B/X before the commit and the second half of D/X is identical to the
second half of C/X before the commit.

In a situation where "provenance" is disputed, it does not matter if D/X
was created by mechanically running

	head -n $n B/X >D/X
	tail -n $n C/X >C/X
        
or if you typed the file afresh.  You could try to argue "No, your honour,
I did not copy from these two files.  I typed it myself from scratch and
there is no plagiarism involved.  They are all my words."  But in the end,
by comparing the tree state before your change and after your change, it
would be very clear to any sane person that D/X is identical to the first
half of B/X and the second half of C/X.

Also see http://article.gmane.org/gmane.comp.version-control.git/217 aka
one of the most important messages in the history of the Git mailing list
for inspirations.
