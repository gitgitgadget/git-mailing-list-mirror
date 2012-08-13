From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git repack vs git gc --aggressive
Date: Mon, 13 Aug 2012 10:19:56 -0700
Message-ID: <7vr4raemkj.fsf@alter.siamese.dyndns.org>
References: <87zk66r28y.fsf@bitburger.home.felix>
 <20120807184405.GA440@sigill.intra.peff.net>
 <7vvcguv7y2.fsf@alter.siamese.dyndns.org>
 <87ehnewolp.fsf@bitburger.home.felix>
 <7v393ujypq.fsf@alter.siamese.dyndns.org> <50290D1F.20007@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felix Natter <fnatter@gmx.net>, git@vger.kernel.org
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Mon Aug 13 19:20:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0yJC-00032F-O1
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 19:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236Ab2HMRT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 13:19:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54107 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379Ab2HMRT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 13:19:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0DB38CFA;
	Mon, 13 Aug 2012 13:19:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HqxOdIzBkHgBLUGEZ27/K8FnZjA=; b=UIK4Zq
	YxSLbY4BXgLA3HrEhqVSpq8tLQnWFgxelb/VueGKqF219Bdcb5Mj67YgVlRzU1fp
	eihpfcGmoYiN23RW5Ij3xNSjzRZAWZo8xV7jNQKXWbrE+XH/qq/Bg2c+dv5RL+Km
	6wjIUFPEjLDgpQKL5yUzb9rmeQoUCuyqe9Eng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nh5jHaJpUvSDjOuHQaLzWhY2LYtc7ZHY
	6hq0ypiVSUZRV2SLod4lZZ+xhHWDk+OVTMeavpO0NHPwG1dCMi1m82pITGf6zvBD
	7hOrzNNE5wmIx6gOZ4UkuvKRQq03JZwy1SjG0RpA2dAnIyGdOZD6CyvLtHgzCbdf
	0ftXbp0IzXY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DF348CF9;
	Mon, 13 Aug 2012 13:19:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3ECE8CEE; Mon, 13 Aug 2012
 13:19:57 -0400 (EDT)
In-Reply-To: <50290D1F.20007@xiplink.com> (Marc Branchaud's message of "Mon,
 13 Aug 2012 10:20:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B423908-E56B-11E1-941B-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203346>

Marc Branchaud <mbranchaud@xiplink.com> writes:

> On 12-08-10 04:09 PM, Junio C Hamano wrote:
>> Felix Natter <fnatter@gmx.net> writes:
>> 
>>> I have a few questions about this:
>>>
>>>> As I am coming from "large depth is harmful" school, I would
>>>> recommend
>>>>
>>>>  - "git repack -a -d -f" with large "--window" with reasonably short
>>>>    "--depth" once, 
>>>
>>> So something like --depth=250 and --window=500? 
>> 
>> I would use more like --depth=16 or 32 in my local repositories.
>> 
>>>> and mark the result with .keep;
>>>
>>> I guess you refer to a toplevel '.keep' file.
>> 
>> Not at all.  And it is not documented, it seems X-<.
>> 
>> Typically you have a pair of files in .git/objects/pack, e.g.
>> 
>>   .git/objects/pack/pack-2e3e3b332b446278f9ff91c4f497bc6ed2626d00.idx
>>   .git/objects/pack/pack-2e3e3b332b446278f9ff91c4f497bc6ed2626d00.pack
>> 
>> And you can add another file next to them
>> 
>>   .git/objects/pack/pack-2e3e3b332b446278f9ff91c4f497bc6ed2626d00.keep
>> 
>> to prevent the pack from getting repacked.  I think "git clone" does
>> this for you after an initial import.
>
> 1.7.12.rc1 does not.

Sorry, I misremembered.  It was removed at 1db4a75 (Remove
unnecessary pack-*.keep file after successful git-clone,
2008-07-08), so even when the sender gave you a crappy pack, you can
repack locally to correct it.

> Maybe clone should preserve the packs it gets from the upstream repo?

That was part of the intention of the code 1db4a75 removed.

> For
> example, our main repo has a 690MB pack file that's marked .keep, but the
> clone just ends up with a single 725MB pack file.  Would our clones see
> performance improvements if they that big 690MB pack separate from the others?

There is no "pack boundary" in the object transfer protocol.  What
comes out of the wire is a single stream of pack data, so the above
is not feasible without major surgery and backward incompatible
change.
