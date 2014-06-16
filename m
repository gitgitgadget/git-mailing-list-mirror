From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/4] commit test: test_set_editor in each test
Date: Mon, 16 Jun 2014 11:58:55 -0700
Message-ID: <xmqq4mzkr89c.fsf@gitster.dls.corp.google.com>
References: <1402601942-45553-1-git-send-email-caleb@calebthompson.io>
	<1402601942-45553-4-git-send-email-caleb@calebthompson.io>
	<20140613065942.GB7908@sigill.intra.peff.net>
	<xmqqtx7o3dvh.fsf@gitster.dls.corp.google.com>
	<20140613234128.GE23078@sigill> <20140616174640.GA28126@sirius.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Kastrup <dak@gnu.org>, Mike Burns <mike@mike-burns.com>
To: Caleb Thompson <caleb@calebthompson.io>
X-From: git-owner@vger.kernel.org Mon Jun 16 20:59:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwc7X-00086N-W6
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbaFPS7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:59:03 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52405 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755352AbaFPS7B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:59:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0AC3A20A24;
	Mon, 16 Jun 2014 14:58:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h1kF4sCsZkZQs1iGWBHWk2p11BI=; b=VA+BU1
	59svpaAlCdiywmGC991FAqxv7wm7T6f4QNy2HTrCqm80GoV2G1YfsMDemOH7qtcu
	n6/gs2+zIbgISrSuCHmsocD2EpKOhBlE1rdFVsrJuVSG9kusi9IWl5JR+Xr2OJdS
	tEgCEDft4523oJBolEoqO9rndbtxQfBXg1Ir4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LIySLxNfmtbzDrXISMYGNJMF0S4lHFH/
	xMz4Cdgm1O7pA/X6TApKDdkBTGQxTXZ45/neeYxCDmXTd1piwv0ItcknGKt4vPgu
	nXavMr2vDcBLkiA4wxiGvbFmn3j80wWfXmB59ildStrWNzqmTvDnN65s2eS4biwJ
	PFKBQbAz71k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F1BCC20A23;
	Mon, 16 Jun 2014 14:58:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 67D3520A19;
	Mon, 16 Jun 2014 14:58:54 -0400 (EDT)
In-Reply-To: <20140616174640.GA28126@sirius.local> (Caleb Thompson's message
	of "Mon, 16 Jun 2014 12:46:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 43522B72-F588-11E3-B0AF-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251799>

Caleb Thompson <caleb@calebthompson.io> writes:

> On Fri, Jun 13, 2014 at 07:41:29PM -0400, Jeff King wrote:
>> On Fri, Jun 13, 2014 at 10:42:26AM -0700, Junio C Hamano wrote:
>>
>> > Jeff King <peff@peff.net> writes:
>> >
>> > > [1] It might make sense for test_set_editor, when run from within a
>> > >     test, to behave more like test_config, and do:
>> > >
>> > >       test_when_finished '
>> > >         sane_unset FAKE_EDITOR &&
>> > >         sane_unset EDITOR
>> > >       '
>> > >
>> > >     I don't know if there would be fallouts with other test scripts,
>> > >     though.
>> >
>> > The default environment for tests is to set EDITOR=: to avoid
>> > accidentally triggering interactive cruft and interfering with
>> > automated tests, I thought.
>>
>> Ah, yeah, that would make more sense.
>>
>> > If the above sane-unset is changed to EDITOR=: then I think that is
>> > probably sensible.
>>
>> I think the trick is that other scripts may be relying on the global
>> side-effect, and would need to be fixed up (and it is not always obvious
>> which spots will need it; they might fail the tests, or they might start
>> silently passing for the wrong reason).
>
> For this reason, and that the scope of this change has already ballooned, I'd
> rather not make this change in this patch if that's alright.
>
> Caleb Thompson

My comment was not about your series, but "if we were to update
test_set_editor, unsetting EDITOR is not the right thing to do".

I do not think it is reasonable to include such a change to
test_set_editor in this series.
