From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use child_process_init() to initialize struct child_process variables
Date: Mon, 03 Nov 2014 10:26:48 -0800
Message-ID: <xmqqmw88rvh3.fsf@gitster.dls.corp.google.com>
References: <54500212.7040603@web.de> <20141029172109.GA32234@peff.net>
	<xmqqlhnyy9e2.fsf@gitster.dls.corp.google.com>
	<20141030213523.GA21017@peff.net>
	<FEC7DC4C920D4F97B5F165B10BC564D2@PhilipOakley>
	<xmqqvbmzsyfy.fsf@gitster.dls.corp.google.com>
	<20141101033327.GA8307@peff.net>
	<F44397C122BB4E63B89EC9BE26007B2E@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Jeff King" <peff@peff.net>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Nov 03 19:27:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlMLI-0008Qt-Tw
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 19:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbaKCS0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 13:26:55 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55605 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753543AbaKCS0w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 13:26:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5CB531B364;
	Mon,  3 Nov 2014 13:26:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0pl6OFO5PRtiupUdoRqWcbUFMKg=; b=N/9FgM
	+J8a3azwjZGeN+KWeQVzP98Ev8QTVpeS60wx7YCqVFO/q9T0XGcdh+XTw+AAYzjs
	pYsBQ8gkHuMNbBSMx5VCn6KWTQwEXo23FSQyuY2i8gPk8ahe6sHkIF563dol27JB
	j22JhgqVb0/5P8/nAMzGN9pm60weVwEecsEXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vCuikZYQqTvuUFUF/0TWTrRL7oH6eqZU
	qZVI/Au1lH9pY/ABIfZr6fzqs45HZWmhbapQwM5X+UIIxn/OWz/rlBq0qE6EWH4B
	zvhlrLqSTVLZcCAWEwVIndtG19UUE9cYONxXV0cnp9ysQvvr+89xoBso1uKdPSB3
	lTHgwsbo91E=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 53E451B362;
	Mon,  3 Nov 2014 13:26:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7B4FC1B361;
	Mon,  3 Nov 2014 13:26:49 -0500 (EST)
In-Reply-To: <F44397C122BB4E63B89EC9BE26007B2E@PhilipOakley> (Philip Oakley's
	message of "Sun, 2 Nov 2014 22:54:57 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F9C5B812-6386-11E4-85C1-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> This certainly looks the way to go. The one extra question would be
> whether the symref should be included by default when HEAD is present,
> or only if there was possible ambiguity between the other listed
> refs.

Just include the "\0symref=..." for any symbolic ref you mention,
and the ref in question does not even have to be "HEAD", I would
say.

The mechanism chosen should be something that will be transparently
ignored by existing implementations, there is no need to make the
data format conditional.  If the new implementations of the reading
side want to make a choice between following the new "\0symref=..."
and ignoring it and use the traditional heuristics for some
unknown/unanticipated reason, that should be the choice for the
readers, not for the writers.
