From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Fri, 29 Apr 2016 13:29:06 -0700
Message-ID: <xmqqa8kcxip9.fsf@gitster.mtv.corp.google.com>
References: <1461079290-6523-1-git-send-email-sbeller@google.com>
	<1461079290-6523-3-git-send-email-sbeller@google.com>
	<CA+P7+xoqn3fxEZGn02ST1XV-2UpQGr3iwV-37R8pakFJy_9n0w@mail.gmail.com>
	<20160420041827.GA7627@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git mailing list <git@vger.kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 29 22:29:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awF2L-00048z-17
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 22:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808AbcD2U3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 16:29:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58720 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752560AbcD2U3K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 16:29:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D705B17EEE;
	Fri, 29 Apr 2016 16:29:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2mKlRGsm+kZ4zIzJdjuGhjbkch4=; b=qBpT6/
	87ICrX8VeN1OicI4iD66bQ680Oo7Xnhma7MFonPOefIsH2TO6KWXZfX0yy4pxRDY
	T7/4lm/gApG7n4HuTk/YL0v4DK6rXHXB8i2hD3HaW7zG3YIke8BamVMNH/WpPlPZ
	1zCBhUgu5Bznz6vL9cBU7xPbHe8UVI4XcHrY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bgPyKBetBzx11HVn09+7jljFWzrSpco7
	DDayuHS6qBvirzImO0d4eL8RqnzgzP5phm0FwUxCSqp+HWoeGvZYV9WxnSMNURtK
	R1x1WLiaEYP+H/1ZuxIBGn+OZP0QFsrumnFqEThvKS7BhDJc7B8DnOptZyr3V0g7
	X5NbTb75LWA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CE3F117EED;
	Fri, 29 Apr 2016 16:29:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 34D2A17EEC;
	Fri, 29 Apr 2016 16:29:08 -0400 (EDT)
In-Reply-To: <20160420041827.GA7627@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 20 Apr 2016 00:18:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0653AE7C-0E49-11E6-A2D7-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293049>

Jeff King <peff@peff.net> writes:

> ... Having the two directly next to each other reads
> better to me. This is a pretty unusual diff, though, in that it did
> change the surrounding whitespace (and if you look further in the diff,
> the identical change is made elsewhere _without_ touching the
> whitespace). So this is kind of an anomaly. And IMHO the weirdness here
> is outweighed by the vast number of improvements elsewhere.

So... is everybody happy with the result and now we can drop the
tweaking knob added to help experimentation before merging the
result to 'master'?

I am pretty happy with the end result myself.
