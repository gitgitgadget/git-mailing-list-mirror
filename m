From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 80/83] run-command: make dup_devnull() non static
Date: Mon, 09 May 2016 10:40:18 -0700
Message-ID: <xmqq4ma7w2nx.fsf@gitster.mtv.corp.google.com>
References: <1461505189-16234-1-git-send-email-chriscool@tuxfamily.org>
	<alpine.DEB.2.20.1604251704300.2896@virtualbox>
	<CAP8UFD2f1L3YKNBA4zP1bmGe8BQitxZp-aDsGP5UTDv06LbLBg@mail.gmail.com>
	<572BA80E.3000309@kdbg.org>
	<CAP8UFD35L8P2YJbbvg_-n9Nc61xMs+_2qBJwBxFzXeF-jA4WwQ@mail.gmail.com>
	<alpine.DEB.2.20.1605061733170.2963@virtualbox>
	<CAP8UFD0ht+ozCMguGwBc19dd9ViXG4tTE0mdaOQ+JVXhSOk02Q@mail.gmail.com>
	<alpine.DEB.2.20.1605071409490.2963@virtualbox>
	<CAP8UFD2wFZgOzmadm7X2988RyDGve92TsoMHPf2S5Ydyhc=Nyg@mail.gmail.com>
	<alpine.DEB.2.20.1605080811380.4092@virtualbox>
	<CACsJy8DUcLWQ6AwyLE+CF+TxZtqDLS=82peizSf4TrZ3q=qjJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 09 19:42:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azpAR-0000Tn-Ey
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 19:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbcEIRkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 13:40:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63403 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751193AbcEIRkW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 13:40:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E68FF1851C;
	Mon,  9 May 2016 13:40:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aqjxblatnISTFGl6j7DMWthcFo0=; b=un4k8x
	WYMikMbZ/VpI9NwX8+9GWmSKK6fubBs5nDqUy6tcluhIHzX87uNy1DODnyFrYSXP
	2HO0wCke5i6Uw/3dd7Rr4yDUNyH8vVDEWNJq4/SS603Lw4PB1eM+eBYJ2HD6VFlS
	RB3uwY8L5yX5Z6Od7oeRxidc8wO19qSr4PaNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tTronHzCZq91H3xcqGu34Qk9SEJreC24
	iC/LcIvFxESfzc3jAE2kEQMZ6WwMj72ZTUQA4OZo8GW+UPummBA/fquocjL37uR4
	stGH1TyXRdvVNOShkYqhDuD7Z+OWERwz/F/yZ0EpVk7hMj8pbRUfNhb7lJpIVgc9
	O6ZCj+Gks7I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DD36F1851B;
	Mon,  9 May 2016 13:40:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5F3D91851A;
	Mon,  9 May 2016 13:40:20 -0400 (EDT)
In-Reply-To: <CACsJy8DUcLWQ6AwyLE+CF+TxZtqDLS=82peizSf4TrZ3q=qjJg@mail.gmail.com>
	(Duy Nguyen's message of "Sun, 8 May 2016 17:15:53 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 19CDBA6C-160D-11E6-98E8-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294025>

Duy Nguyen <pclouds@gmail.com> writes:

> I vote one step at a time, leave multi-thread support for future.
> There's a lot more shared state than file descriptors anyway, at least
> there are object db and index access and probably a couple of hidden
> static variables somewhere. And I'm not sure if multi-thread really
> helps here. Are we really CPU-bound? If object inflation causes that
> (wild guess), can we just inflate ahead in some separate process and
> pass the result back?

I do not particularly care about multi-thread issues, but I have to
agree with Dscho that the updated code that claims to be "libified"
that futz with the file descriptors like the way this patch does is
not a proper libification.

Unfortunately, the anticipated caller of this code that does "this
may fail and it is OK because it is merely one of the attempts, so
let's not show the errors" is not something we call only when we are
falling back, so "why not do this rare codepath via the usual
run_command() interface to spawn 'apply' as a separate process?",
which would be the most sensible "one step at a time" suggestion if
it were the case, would not apply.

As you will be passing the apply state structure throughout the
callchain, would it be a viable and reasonable endgame state to have
a strbuf in it that accumulates the errors?  That is, instead of
dup()ing the standard error stream out, you would accumulate the
errors for a caller that asks their errors not directly sent to
the standard error stream, so that it can choose to either show it
at the end, or ignore it altogether.

How far can you go with just set-error-routine?  Are there things,
other than the file descriptors, that you need to futz with in order
to covert that "we'd fallback, so this early round must be silent"
codepath?
