From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] doc: make clear --assume-unchanged's user contract
Date: Tue, 09 Dec 2014 16:44:00 -0800
Message-ID: <xmqqoarcjpv3.fsf@gitster.dls.corp.google.com>
References: <1417878270-4364-1-git-send-email-philipoakley@iee.org>
	<1417878270-4364-2-git-send-email-philipoakley@iee.org>
	<1418096636.19104.31.camel@segulix>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip Oakley <philipoakley@iee.org>,
	GitList <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: =?utf-8?Q?S=C3=A9rgio?= Basto <sergio@serjux.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 01:44:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyVNx-0006un-3J
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 01:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083AbaLJAoE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Dec 2014 19:44:04 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53978 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752760AbaLJAoC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Dec 2014 19:44:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D44AB255A4;
	Tue,  9 Dec 2014 19:44:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=42P/B1+/oh5B
	pA3YzcMaxaKXvLo=; b=tOtvh8KhC57PIORGt4cytKBeZL7Q820kQ274DgirtiMW
	o71xXkgrja3N6SsM/dqnO3Uhj8dDnBI+F/O4lYHUm1Jp26nlyiy4LYbY635KtnM0
	LnwTPynm4l0OrHlRdVkUUvHhd1sbgVysVAvwaVWWNBJaXMzfxa+y8bstbh9h8T4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=unQZkl
	5IfZlDFE0D88Mp9KoB77TMpptdQBjaNZHg2M70B8QELNuKfVEGCjJfmVqDvosBYi
	sHQf7iryXTuJ4thPtK9S2cPLGMHW0BnSy7Fbh/8U/rJpldKiNN0X8QpEhzeX2Uj2
	n8Z9x+Xo61TWZPhauiOAs8HUEVbCKHoornwmE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C98F9255A3;
	Tue,  9 Dec 2014 19:44:01 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 52D14255A2;
	Tue,  9 Dec 2014 19:44:01 -0500 (EST)
In-Reply-To: <1418096636.19104.31.camel@segulix> (=?utf-8?Q?=22S=C3=A9rgio?=
 Basto"'s message of
	"Tue, 09 Dec 2014 03:43:56 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A24DF158-8005-11E4-B03C-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261184>

S=C3=A9rgio Basto <sergio@serjux.com> writes:

> Also don't understand why --assumed-untracked shouldn't deal with
> changed files instead fallback in "the user promises not to change th=
e
> file" and sometimes works others not.=20
>
> Also if this is the contract when a file is different from commit,
> should warning the user that is not in contract (modify files that ar=
e
> assumed-untracked )=20

Unfortunately, that is not even possible in the case where
assume-untracked is meant to be used without breaking the use case
it was invented to support.  The user flips the bit so that Git does
not have to traverse the working tree to run lstat(2) on all of them
in order to see if some have changes relative to the index.

If we cannot trust that bit and need to verify, how would we do
that?

Think.

Yes, by running lstat(2) on these files that the user promised not
to touch.  That just defeats the sole objective the feature was
invented for in the first place.

Having said all that, I know what you wish to have, and I am not
fundamentally opposed to a change to add a new feature to order Git
to pretend that changes that may exist in the working tree are not
there.  It's just that assume-unchanged bit is not that.  It is a
way to allow Git that it can assume the files in the working tree
are not changed.  It is a permission, not a command.

This is a tangent, but somebody may want to check the "Git will fail
(gracefully)" bit in the documentation Philip's documentation patch
did not remove.  Such a detection is not absolutely necessary, and
the paragraph may be describing a wishful thinking by somebody who
misunderstood --assume-unchanged with a cursory observation of what
happened for limited test cases back when the documentation was
added, in which case that paragraph may also want to go.
