From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help.c: Pull cmd_version out of this file.
Date: Tue, 31 Aug 2010 23:11:21 -0700
Message-ID: <7v1v9e803a.fsf@alter.siamese.dyndns.org>
References: <2ae543604216146b742253584d8393c5e3179697.1283114573.git.tfransosi@gmail.com>
 <20100830023812.GA4010@burratino> <20100830024020.GB4010@burratino>
 <AANLkTimDjRz=JmiVn+ybQ5ewaj=7N5tp48fUArD5vG_H@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 08:11:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqgXv-0005l1-L8
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 08:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828Ab0IAGLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 02:11:39 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49916 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280Ab0IAGLi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 02:11:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A6A7D20AE;
	Wed,  1 Sep 2010 02:11:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LUGFikVJvdxvJ6yO9EK8qOw0RVY=; b=SORP6x
	Z35Kf/q5mf0mcaFCCqgqj1RGsKKO57bu7XCqgRB4btii6vgVxjf/hVU0Ssw68YML
	rF4Vn5PO35DKQ+3Cs6s3HUwUlSR7+xflmsQTe9/sZ8Gh3InpC30x7v8GSQtfDqfO
	9f6IeKSndymEESwjoDzSHvCF7RpqgZ6pHJ7rc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bf3DaxxhLfkLU0X8j9Br9W8NrgWYQ/co
	0aqo3sIBH/uJ71zKAzrtvVxqh+vtw1UEEEgbsLZFCekP+aMK+fKCB5O3fZgYr7na
	5yQhjPd+dhsM0DiNpAL06kjInSnM+qGOrM6hcjI0pAbGLUMs9tpLZ7pk38mC+Pd5
	8nfz9DGV/Ag=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B116BD20AD;
	Wed,  1 Sep 2010 02:11:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD544D20AC; Wed,  1 Sep
 2010 02:11:26 -0400 (EDT)
In-Reply-To: <AANLkTimDjRz=JmiVn+ybQ5ewaj=7N5tp48fUArD5vG_H@mail.gmail.com>
 (Thiago Farina's message of "Tue\, 31 Aug 2010 23\:38\:57 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C35B326A-B58F-11DF-8EAC-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155018>

Thiago Farina <tfransosi@gmail.com> writes:

> On Sun, Aug 29, 2010 at 11:40 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Jonathan Nieder wrote:
>>> Thiago Farina wrote:
>>>
>>>> Promote cmd_version to a builtin, by moving it to its own file
>>>> in builtin/version.c
>> [...]
>> So for what it's worth,
>>
>> Acked-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Ping Junio.

If the patch were to also move git_version_string[] from git.c to this new
file, whose sole purpose will be to give the version information, then it
might be worth it, as we would need to recompile a file with only 10 lines
instead of git.c with 570 lines, but what the patch does is not even that.

Not that I would be happy to see such a change that affects dependency and
risk causing broken builds this late in the cycle, though.

I ended up spending 10+ minutes re-checking how the dependency between the
version string and the resulting binaries work.  The patch probably would
cause "git clean" to report a new unignored file, too.

What did we gain through this exercise?  Did we fix any real problem?

"git grep" sees directory boundaries through just fine, and I do not find
Jonathan's explanation very satisfactory.


		Junio, who gets a lot more grumpy than necessary at night...
