From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/23] expire_reflog(): use a lock_file for rewriting the reflog file
Date: Tue, 09 Dec 2014 10:47:24 -0800
Message-ID: <xmqqfvcomzib.fsf@gitster.dls.corp.google.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
	<1417734515-11812-8-git-send-email-mhagger@alum.mit.edu>
	<20141205002331.GJ16345@google.com>
	<20141205021931.GA29570@google.com> <54857871.5090805@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 09 19:47:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyPop-00036G-CX
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 19:47:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbaLISr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 13:47:27 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62295 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751384AbaLISr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 13:47:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 010CA23679;
	Tue,  9 Dec 2014 13:47:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0aIHDlGox5c0S2XgvqCcbMFBH4U=; b=epwnzf
	4APYRHzmj0bdnhbhNSGCQp5pVy7LSKVUp3GjifWFMiQhhbpgO9H1alUJp8dyaoVt
	KG9oWjdyRx9RBNFzrfsOghevdK7tbq2j1syKPGzImIuImc2Ztg98JY45I2eM2D22
	N2KL668ZWBwbojyHZZFkmpH+5HpGzBqqMjmBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ykeR0G7doN0i3thkWPKF0VG19jjAPhnq
	0K+HPKDWhjmMCeJURhCfqjgRq1c8ZQZ1X0FC4xLMljte/2W6D4OMET22csF87MDB
	hidIIcqi0y+R0sH4bl2reGrzI+SayRjIzlOG0NEVhYxHGCr5Si8HdxL1EHdRffXv
	6d2aTwkg9TI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E89E923678;
	Tue,  9 Dec 2014 13:47:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B85623677;
	Tue,  9 Dec 2014 13:47:25 -0500 (EST)
In-Reply-To: <54857871.5090805@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 08 Dec 2014 11:07:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D1510BE8-7FD3-11E4-A2F1-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261138>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This isn't documented very well. I thought I saw a comment somewhere in
> the code that stated it explicitly, but I can't find it now. In any
> case, my understanding of the locking protocol for reflogs is:
>
>     The reflog for "$refname", which is stored at
>     "$GIT_DIR/logs/$refname", is locked by holding
>     "$GIT_DIR/refs/$refname.lock", *even if the corresponding
>     reference is packed*.
>
> This implies that readers, who don't pay attention to locks, have to be
> prepared for the possibility that the reflog is in the middle of an
> update and that the last line is incomplete. This is handled by
> show_one_reflog_ent(), which discards incomplete lines.

Interesting, as I think I saw Peff did something around that area
recently.

I have some more thought around the "transaction" in general, but
it will be in a separate message.

Thanks.
