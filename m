From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Check order when reading index
Date: Wed, 27 Aug 2014 14:11:26 -0700
Message-ID: <xmqq61hdd4e9.fsf@gitster.dls.corp.google.com>
References: <xmqq38cpsmli.fsf@gitster.dls.corp.google.com>
	<1408903047-8302-1-git-send-email-jsorianopastor@gmail.com>
	<xmqqvbpgmqmh.fsf@gitster.dls.corp.google.com>
	<20140825194430.GI30953@peff.net>
	<CAPc5daW-ZckFfhyueNLnPaBeriAmCUVJjFc1cw0O5iRi8F+Kng@mail.gmail.com>
	<CAPuZ2NHafXQthtuq-RnTvpjVfNPaXHEy8SejuhPEnG+MwCK=sg@mail.gmail.com>
	<20140826122008.GC29180@peff.net>
	<xmqqmwarjiq7.fsf@gitster.dls.corp.google.com>
	<CAPuZ2NGTQoKnSfeN2zte5=fqswN5PcfAULdFy9WnGWPtc2Zskg@mail.gmail.com>
	<xmqqy4ubi1ty.fsf@gitster.dls.corp.google.com>
	<CAPuZ2NFzHjUSfi1H0RFvOuWdRptwxv-gsUOAJv0Uh5BFLWmnRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Jaime Soriano Pastor <jsorianopastor@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 23:11:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMkVM-0006ja-Dj
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 23:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbaH0VLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 17:11:39 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63293 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965028AbaH0VLh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 17:11:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6487B351E5;
	Wed, 27 Aug 2014 17:11:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LI34plnbLBjsQPsugIh4b61Lwb4=; b=WvYoh9
	sZebCueduwJFbMW6gT7m1+2+q7DfEc9myAj4xTZmz5+Z8imv3jJn2NdKXz38F3WZ
	6nSF3oBu8G0r+EcVuYcCzRvANtWb0cvQp7cnmvQ/EAorb+iaNkPcdWa0shKKs9aJ
	QuLWxCpgPV9uX6f3RpqYawsQFqaw3uxBFQBu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DKPccYieRfwM8HS3waibBpWhMeTwUXiy
	FBzuFApxDrxEBpaji8DE4fMQ/dA1C+a9KyRbF86AUuSJpln61l+SYB/OS9Fxf84j
	sIMhr+oWjeC/gqYgE7m3MM6/YdeOg6CNQy/d38zl8kLKcSzdtnF0Whn0+SCo3ucR
	vPZaRwIlo6E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5B7F4351E4;
	Wed, 27 Aug 2014 17:11:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4416B351DD;
	Wed, 27 Aug 2014 17:11:28 -0400 (EDT)
In-Reply-To: <CAPuZ2NFzHjUSfi1H0RFvOuWdRptwxv-gsUOAJv0Uh5BFLWmnRA@mail.gmail.com>
	(Jaime Soriano Pastor's message of "Wed, 27 Aug 2014 21:52:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B5E3AC22-2E2E-11E4-827C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256044>

Jaime Soriano Pastor <jsorianopastor@gmail.com> writes:

> On Tue, Aug 26, 2014 at 7:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Does the current codebase choke with such entries in the index file,
>> like you saw in your index file with both stage #0 and stage #1
>> entries?
>
> Not sure, I couldn't reproduce an scenario with an index with multiple
> entries in the same stage for the same path.

I think we have been discussing how to protect broken index file
left by tools other people wrote, so I wouldn't be so surprised if
our current toolset does not let you recreate certain breakages ;-)

I was asking for an answer more from what you know about the code.
For example, would read_index_unmerged() choke if the index has two
or more stage #1 (or stage #3) entries for the same path (provided
that the index is otherwise normal, i.e. no stage #0 entry for that
path, entries are sorted by pathname order and stages are in an
order that does not decrease)?
