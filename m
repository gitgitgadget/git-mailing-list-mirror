From: Junio C Hamano <gitster@pobox.com>
Subject: Re: generation numbers
Date: Thu, 07 Jul 2011 17:29:16 -0700
Message-ID: <7vei21haxv.fsf@alter.siamese.dyndns.org>
References: <1307819051-25748-1-git-send-email-avarab@gmail.com>
 <20110707185908.GB12044@sigill.intra.peff.net>
 <7vliw9hoky.fsf@alter.siamese.dyndns.org>
 <201107072231.13181.jnareb@gmail.com> <4E161CA3.2050001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Fri Jul 08 02:29:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qeywe-0002jG-Mm
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jul 2011 02:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146Ab1GHA3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 20:29:22 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52909 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098Ab1GHA3T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 20:29:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 35BD0660C;
	Thu,  7 Jul 2011 20:29:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=clp+M6QdNAJ1SrW8H8SuYEaTW+Y=; b=XnyF+L
	6x05BwPs6oKt8dzOgwCxtixY+kVf18Pwh1XsHLYevus/43mSUOC+S3jU4NO2fvma
	eH6Rc3xqhb/zeqnZS9U3+DHC9ZcmFnLjzXRYRoYpJFy5lV1SDvxe8ZltV19qbLMB
	a6U7jbXGcY3a0kXxc2eJ+lt4qEAMwEqBkI5Zc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tVjL/g5iMHOAX61xU1XTk9uMgxCWYeao
	xAFOxbx9fjYxYVGNLQ1SXfti0jCPLhKDLkdAFUodFyM5jlNMz/CtT3OUUqoI11cG
	0/C8HQEt2GZQo4j+LQm9S0rt2YK92UZ+0kvD0mHLDf2x4DHCImqqCyNNAkfX/7i3
	bOBp6QU+alc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2CAEE660B;
	Thu,  7 Jul 2011 20:29:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7019F6609; Thu,  7 Jul 2011
 20:29:18 -0400 (EDT)
In-Reply-To: <4E161CA3.2050001@gmail.com> (A. Large Angry's message of "Thu,
 07 Jul 2011 16:52:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51458906-A8F9-11E0-A419-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176792>

A Large Angry SCM <gitzilla@gmail.com> writes:

> On 07/07/2011 04:31 PM, Jakub Narebski wrote:
>> On Thu, 7 Jul 2011, Junio C Hamano wrote:
>>> Jeff King<peff@peff.net>  writes:
>>>
>>>> You could "cheat" and instead of storing the sha1 of a blob object in
>>>> the notes tree, use the lower 32 bits to store an actual value. I don't
>>>> think that currently breaks any assumptions in the notes code, but it
>>>> definitely is against the intent of it.
>>>
>>> I highly suspect that it would break fsck rather badly.  You may not even
>>> be able to repack a repository with such a notes tree.
>>
>> Well, we could (ab)use file mode to mark that what would be sha1 actually
>> stores fixed-width content of a file, like we do with submodules.
>>
>> This technique is I think quite similar in idea to filesystems storing
>> contents of small files in file inode, isn't it?
>
> Are the benefits really worth all these hacks?

Not at all. Don't take everything everybody says about low level
implementation too seriously. Most people do not know what they are
talking about ;-).
