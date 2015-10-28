From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git repack command on larger pack file
Date: Tue, 27 Oct 2015 23:47:17 -0700
Message-ID: <xmqqh9lbmqve.fsf@gitster.mtv.corp.google.com>
References: <loom.20151026T065553-934@post.gmane.org>
	<xmqq611ujfn0.fsf@gitster.mtv.corp.google.com>
	<xmqqziz6hzom.fsf@gitster.mtv.corp.google.com>
	<loom.20151027T025257-333@post.gmane.org>
	<20151027234406.GB4172@sigill.intra.peff.net>
	<xmqqlhanmrz7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sivakumar Selvam <gerritcode@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 28 07:47:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrKW4-0004CW-Ii
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 07:47:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755444AbbJ1GrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 02:47:20 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56607 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754774AbbJ1GrT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 02:47:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EEBDC1A9B6;
	Wed, 28 Oct 2015 02:47:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kfHXkvRXwxmRrj4jBqdSa7+li3I=; b=KR5D4g
	Jk9FNoARaDsgJ4YuCtA7tPNgAxOoRp/82nqEzmCOz97lAHAWrMjNsPclO+EyQKVd
	YkiNkz2VmGzHC4DYBDzlE4nQHg82hvJF/rYx9nEijQt//UtbSPNkmPXBkTVKlVCf
	s9rDWmrKGpVYM/nIM5/D/SpFL2sFqhDcGUYfY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rKt/D2jQLoiFoTYMiBmv/cm/rhI0xQPG
	qczzcuFEvNbhq8Z4/kAN07+Qlg3cNBWlSV16dVbCphnkmfy/NrrazZQZhrO1ot37
	FBrtoBm0j+dImSrxKTeWhMsxblt1D3Sl6+UgB4mEl8PEtOxgwbOdpchqDNGOrE0h
	n04fjYVEmoc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E6AC71A9B5;
	Wed, 28 Oct 2015 02:47:18 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6FB521A9B4;
	Wed, 28 Oct 2015 02:47:18 -0400 (EDT)
In-Reply-To: <xmqqlhanmrz7.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 27 Oct 2015 23:23:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BB5FCA1C-7D3F-11E5-88A7-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280354>

Junio C Hamano <gitster@pobox.com> writes:

>> [1] This is all theory, and I don't know how well git actually finds
>>     such deltas, but it is probably better to have a dense tree of
>>     deltas rather than long chains.  If you have a chain of N objects
>>     and would to add object N+1 to it, you are probably not much worse
>>     off to base it on object N-1, creating a "fork" at N.
>
> Yes, your guess is perfectly correct here, and indeed we did an
> extensive work along that line in 2006/2007.  For an example, see
> http://thread.gmane.org/gmane.comp.version-control.git/51949/focus=52003

And here is another, which is probably one of the most important
thread on pack-objects, before the bitmap was introduced:

http://thread.gmane.org/gmane.comp.version-control.git/20056/focus=20134
