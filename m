From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "./t0001-init.sh --valgrind" is broken
Date: Thu, 03 Mar 2016 07:56:09 -0800
Message-ID: <xmqqk2lj3692.fsf@gitster.mtv.corp.google.com>
References: <CAP8UFD0-FxoPe5-35NAKSkegFBoRPy1+BOsqN-y+QJUoXAqR3g@mail.gmail.com>
	<CACsJy8AL_RGEb2z44-yoL+3yF7n1+FMLqZkmWwUDFJnEPYS_nw@mail.gmail.com>
	<56D7DFD5.8010108@kdbg.org>
	<CACsJy8CVfJdCmwWo50wHsc6DP6ft71d5bfBaFSJpv9XcNRwdSQ@mail.gmail.com>
	<CACsJy8AE9VovwuviwOLxRDTAbTXCivRVhk8ia4mdUnMN-0Y4OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 16:56:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abVc7-0000aO-Q6
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 16:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758174AbcCCP4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 10:56:16 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55535 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756104AbcCCP4N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 10:56:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E9B4A480AD;
	Thu,  3 Mar 2016 10:56:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0+44Qy5IMWyI7RxuXq35gib8FNY=; b=YO2jfs
	YqwMWyDTWuKubgXdirWoF4Vd9t0AJbuboBlH2VzQy79jdKTiP/pKX6VI159utFSW
	o6u9tafAI3RFp8Wx9pol49lhW3wlW5UXrBznrqIr4Ns6SdNsnhu5Vb8WvZUnF8sl
	L0Ba0aUhrm10t/muf0SkUYW/pYwWJjk4J3GKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k7HStAIPj8RefjZa1Dchc/0AL1JPQPIu
	vC495TIhl+pcF+An9cdFZuWTaHAHO0e1Vhyy4SMhWMaqJ+bF/fvKmw4jH0VhFva2
	LeB3Dsrm22J8HvHz8GQykKywrRth10QY3Gim8T22OAFabNgWRX8xdrKTmflyKlLB
	eEc6Vys4sTo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E06F3480AB;
	Thu,  3 Mar 2016 10:56:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 54D16480AA;
	Thu,  3 Mar 2016 10:56:11 -0500 (EST)
In-Reply-To: <CACsJy8AE9VovwuviwOLxRDTAbTXCivRVhk8ia4mdUnMN-0Y4OA@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 3 Mar 2016 19:16:55 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 735E97E8-E158-11E5-8532-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288184>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Mar 3, 2016 at 7:09 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> But it's probably better that we inject valgrind command
>> from inside bin-wrappers script, the same way we inject gdb, I think.
>
> For the best of both worlds, we should recreate bin-wrappers in
> test-lib.sh (i.e. the valgrind way), not in Makefile.
>
> Somewhat
> unrelated, but because topdir is getting really crowded and
> bin-wrappers is used for the test suite only, it should be moved
> inside t/ (i'm going to move all test-* to t/ too, later).

Weren't there people who pointed their bin-wrappers/ with $PATH to
test/use freshly baked Git before they convince themselves that they
want to install it?  Not building it from the top-level Makefile
and moving it to elsewhere would be two breakages for them.

I am not sure if that is a good idea.

Moving test-* sources out of the top-level is a good idea, and
placing test-* binaries somewhere other than the top-level is also a
good idea.  Just like t/lib-*.sh are helpers for tests, these are
also test helpers that happen to be written in C and compiled, so I
don't have a strong objection to make t/ the new location for
them--a different location (e.g. a new "test-helpers/" directory) is
also something I can go with.

Thanks.

In any case, are these two messages objections to J6t's fix, or are
you fine with the fix for 2.8-rc1 and merely raising ideas to redo
it in a different (i.e. your) way after 2.8 final, or are you
planning to do a fix in a different way for 2.8-rc1?
