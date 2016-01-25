From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] convert: legitimately disable clean/smudge filter with an empty override
Date: Sun, 24 Jan 2016 17:25:57 -0800
Message-ID: <xmqqr3h6bgbe.fsf@gitster.mtv.corp.google.com>
References: <1453638170-52041-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, jehan@orb.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Mon Jan 25 02:26:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNVuv-0006DT-Sb
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 02:26:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655AbcAYB0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 20:26:01 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50121 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752194AbcAYB0A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 20:26:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8532C3FB3A;
	Sun, 24 Jan 2016 20:25:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y0F29TFsHEjoZ+jQvpdkpUj6BiU=; b=d3ILkL
	C4+nKobm51PHN1/m0xS6+0COZ4+1IU3/5cFFRWMa5hU99IKYtCqwcAl2PzSJ3XTa
	WGO9AvpPC7fRYXbouOOdeQw7t7FUCDpUdzyoPVg3KhH5qB8VI95ktnfJNzjOqc7W
	Z/LMieh2mtNgTrC876+RXikgpra6YCCg67HQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xw/Jt/QNAteEk0SxoXGGk69M9qlCxL67
	LWELjCTiXn+mj8njr4PMLql8ay+68/4wuLG5hvPbT9/0k5s3VHAibMDk1TnTLUpq
	J73+mqtnFKUERaPiY1jPUbaM99bDtrDS11yBxI2FMaY8Kvv269UlbCi2EdcVc4qd
	Y9ZjwwvqnxE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7C08F3FB37;
	Sun, 24 Jan 2016 20:25:59 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 01EF43FB36;
	Sun, 24 Jan 2016 20:25:58 -0500 (EST)
In-Reply-To: <1453638170-52041-1-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Sun, 24 Jan 2016 13:22:50
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 96B127B6-C302-11E5-B26F-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284705>

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> A clean/smudge filter can be disabled if set to an empty string. However,
> Git will try to run the empty string as command which results in a error
> message per processed file.

The above two sentences do not make any sense to me.  You observe
that the command refuses to work when the variable is set to an
empty string--why then can you claim "filter can be disabled if set
to an empty string"?  I'd consider that the system is not working
with such a configuration, i.e. "filter cannot be disabled by
setting it to empty; such a request will result in an error".

> Teach Git to consider an empty clean/smudge filter as legitimately disabled
> and do not print an error message.

On the other hand, this does make sense to me, as I do not think of
a good way to say "earlier configuration entry said we should use
this filter, but we actually do not want to use that one (or any)"
because a configuration, unlike attributes entry, cannot be reset.
The closest you can do is to set it to empty, so it may be a good
new feature to do this.
