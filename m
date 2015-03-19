From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in fetch-pack.c, please confirm
Date: Thu, 19 Mar 2015 12:01:26 -0700
Message-ID: <xmqqtwxgizg9.fsf@gitster.dls.corp.google.com>
References: <0758b2029b41448a77a4e4df1c4e406@74d39fa044aa309eaea14b9f57fe79c>
	<20150316011343.GA928@peff.net>
	<xmqqfv90khpd.fsf@gitster.dls.corp.google.com>
	<20150319185517.GB8788@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 20:01:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYfhI-0000yR-8y
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 20:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbbCSTBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 15:01:31 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55733 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750932AbbCSTBa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 15:01:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A35ED414E4;
	Thu, 19 Mar 2015 15:01:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hthhtI2dHOH2GBntbp3x+zez5V8=; b=SNrXrV
	Z7GQaE/kHFrHJ2XnSm5MtY6ZbHbBu8FTL8YpB1iw26syPS1pZsVkEbHgADNiaqID
	6aW/RxjYe8HIgNflmfVLjSh6mQTLqvhprGdPR7lYwmcv0JTTecj34GALA9fq8VKQ
	KuAgvv6OODtle+ArXPFuJ1HWOPD8pH0VnAWZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MrRb3wcSjyMmsim49AA1IdqmqoqeTvmP
	sTdQoMrvJq6S3Sox52kjPVf6IeLOQcxCcSha8QD1TAsrlg5qtoXayqYosnH6OTat
	oE9Ayy90haBuPggfqLf+zYi6HGBRYITv/WmSZL59htKXgrdI4lNacPjYGHfNx+8A
	63xCREWOkOY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9BE56414E3;
	Thu, 19 Mar 2015 15:01:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1E6D2414E2;
	Thu, 19 Mar 2015 15:01:28 -0400 (EDT)
In-Reply-To: <20150319185517.GB8788@peff.net> (Jeff King's message of "Thu, 19
	Mar 2015 14:55:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 58E784EE-CE6A-11E4-8E25-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265818>

Jeff King <peff@peff.net> writes:

>>  - The only caller of everything_local(), do_fetch_pack(), returns
>>    this list of ref, whose element has bogus new_sha1 values, to its
>>    caller.  It does not look at the elements and acts on them.
>
> I'm not sure what the final sentence means. Should it be "It does not
> look at the elements nor act on them"?

Yes.  "It does not look at the new_sha1.  It does not use the
information to change its behaviour.  Both of the previous two
statements are true." is what I meant.

> do_fetch_pack actually does pass them down to find_common. But the
> latter does not look at ref->new_sha1, so we're OK.

>>  - The other caller of fetch_pack() is fetch_refs_via_pack() in the
>>    transport layer, which is a helper that implements "git fetch".
>>    It only cares about whether the returned list is empty (i.e.
>>    failed to fetch anything).
>
> So I thought I would follow this up by adding a free_refs() call in
> fetch_refs_via_pack. After all, we just leak that list, right?

Yeah, I agree.

> I'm working up a few patches in that area, which I'll send out in a few
> minutes. Once that is done, then I think the explanation you give above
> would be correct.

If a follow-up is coming then I'd just drop this one.  Thanks.
