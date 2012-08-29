From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Funny 'git describe --contains' output
Date: Tue, 28 Aug 2012 23:36:46 -0700
Message-ID: <7vharmxkzl.fsf@alter.siamese.dyndns.org>
References: <20120829044840.GA25869@kroah.com>
 <7vr4qqxmt8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Greg KH <gregkh@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Wed Aug 29 08:37:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6btf-0004Vf-4B
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 08:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268Ab2H2Ggt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 02:36:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37209 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956Ab2H2Ggt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 02:36:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41D3874AE;
	Wed, 29 Aug 2012 02:36:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I2ube1lDnu+8UvYvCVNSGvNoof8=; b=gZAW32
	XnJ4RGDnJ9UzWvLeWJG0+NfqDb3eEuvozXbYRyyxsb8fubHp6b6hZPB+71+K1vWp
	V1e7arK4MUOYmTTeDMVGCDdBoWAqu1Z9vQermsJJR0aWiEQ5hoHvQxfWFb3dkkPX
	I6yTWR5i9EFKsLjU90URiaP4DJZjI0b6ht7OE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MsWAXuW3CFb5bAfb6rnZDbJ5cAT1mbo9
	UMXnbHXygcuWdNpUQu+R+f2o7Yht3KWDu3XY0ClIHpdwjdnaLfaTw4A1nHEVj6ed
	IH4k74JL0meCBLVyqO3R8YKud3si+dZf2GDgrfoU5f5kyda+DCffvFkCmBMGh/K4
	7DpSvEm0S94=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3003774AD;
	Wed, 29 Aug 2012 02:36:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 852E974AA; Wed, 29 Aug 2012
 02:36:47 -0400 (EDT)
In-Reply-To: <7vr4qqxmt8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 28 Aug 2012 22:57:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8345844-F1A3-11E1-BC66-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204468>

Junio C Hamano <gitster@pobox.com> writes:

> Greg KH <gregkh@linuxfoundation.org> writes:
>
>> In the Linux kernel tree, commit 0136db586c028f71e7cc21cc183064ff0d5919
>> is a bit "odd".
>>
>> If I go to look to see what release it was in, I normally do:
>> 	$ git describe --contains 0136db586c028f71e7cc21cc183064ff0d5919
>> 	v3.6-rc1~59^2~56^2~76
>> ...
>> Any ideas?
>
> That is 59 + 1 + 56 + 1 + 76 = 193 steps away from the tag v3.6-rc1.
>
> $ git name-rev --refs=refs/tags/v3.5-rc1 0136db58
> 0136db58 tags/v3.5-rc1~83^2~81^2~76
>
> which is 83 + 1 + 81 + 1 + 76 = 242 steps away from that tag.
>
> So it _is_ odd that the newly tagged tip merged a branch that had
> smaller development since it merged the commit, but name-rev seems
> to be measuring the steps it takes from the tags to reach the commit
> and giving us the one that gives the shortest path correctly.
>
> Obviously, that is not the same as "which tag is the oldest one
> among the ones that can reach this commit?"

As is usual for what I say, the above is an explanation of what we
are seeing, not necessarily a justification.

Given a history of this shape:

        o---o---o---o TONS!!!
                     \
 ---o--o--o--o--o--Y--o---o---Z
     \   /               /
      \ /               /
       X---------------o

where Y is v3.5-rc1 and Z is v3.6-rc1, "name-rev X" measures the
distance of the shortest path between Z and X (Z^^2^ = 3 steps away)
and between Y and X (Y~3^2 = 4 steps away), and uses the tag with
the shortest path.

But in order to answer "which is the earlier tag that merges X",
what "name-rev" measures is not very interesting.

What we want to see is the tag whose "weight" (imagine these commits
are beads on strings, and you hold the tag between your fingers and
lift it, pulling all the commits behind it on the history) is the
smallest and reaches the commit X in question.  The distance on the
shortest path to X totally ignores tons of merges that went into the
mainline between Y and Z.  That is what makes name-rev not useful
for this purpose.

That "weight" is what Linus's "rev-list | wc -l" showed, but it is
fairly expensive to compute.  We do have a code that computes such
weight in the history bisection code (it computes this exact weight
for each and every commit that is still suspect, and picks the one
that is half-way).  We know how to compute it, but I suspect that
applying that code naively to name-rev would make it unusably slow.
