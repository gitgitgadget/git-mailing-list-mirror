From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH_v1] add 'git credential' plumbing command
Date: Mon, 11 Jun 2012 08:34:55 -0700
Message-ID: <7vlijt980w.fsf@alter.siamese.dyndns.org>
References: <1339267502-13803-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
 <20120610115619.GA6453@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Javier.Roucher-Iglesias@ensimag.imag.fr, git@vger.kernel.org,
	Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 17:35:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se6eA-0004GB-Hd
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 17:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285Ab2FKPe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 11:34:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52981 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752221Ab2FKPe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 11:34:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACC6B92D9;
	Mon, 11 Jun 2012 11:34:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j/DOWLtNBw/VaMu8uhm0aU5OAzc=; b=umHvwj
	X2L1AsivUQLhSGUBtaN272/HOdigKHmoXdoufV8xUeQiDlZPHzLcxDpGNKon5+Ps
	3QNwCOj6Ho2BU3j4oBplaA6v2RS3y5cfHlvDScWz+eTwbYgogX0jkJX24HowFtFG
	MqZ7V+B+blwOfevZ2NdBzXFktfKeSPFDpi42Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UNV8SzTN72Svyd7be/nYvZmJrYuiZTWe
	bkjYSWSXd3MrsDXS07apTOEYW0F70T9yK1nMs3hf1gqYilTh/fcmflUWM7fTBVLq
	/JClxAM8INKA22WS0KF20PQ8pUQMdyKLtFtqEvUC8RWgvD1gQR/Wg+hgiUQ68wXf
	fZjLCH/XkLg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A172692D8;
	Mon, 11 Jun 2012 11:34:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 330D692D6; Mon, 11 Jun 2012
 11:34:57 -0400 (EDT)
In-Reply-To: <20120610115619.GA6453@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 10 Jun 2012 07:56:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FFBCE956-B3DA-11E1-9233-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199662>

Jeff King <peff@peff.net> writes:

> Perhaps it would be simpler to accept a URL on the command line, and
> also provide a --stdin option for callers that want to feed it directly.
> So:
>
>   git credential fill https://example.com/foo.git
>
> would be identical to:
>
>   git credential --stdin fill <<\EOF
>   protocol=https
>   host=example.com
>   path=foo.git
>   EOF

and "git credential fill https://peff@example.com/foo.git" would be
identical to the latter one with user=peff already filled in?

> I am tempted to suggest that this actually output the _whole_
> credential, not just the username and password. Coupled with the above
> behavior, you would get:
>
>   $ git credential fill https://example.com/foo.git
>   protocol=https
>   host=example.com
>   path=foo.git
>   username=bob
>   password=secr3t
>
> which happens to be exactly what you want to feed back to the "approve"
> and "reject" actions (and it is not really any harder to parse).
>
> We _could_ get by with allowing:
>
>   git credential --stdin approve https://example.com/foo.git <<\EOF
>   username=bob
>   password=secr3t
>   EOF
>
> and having it combine the URL on the command-line with the entries on
> stdin (and indeed, I think that is the only sane thing to do when
> --stdin and a URL are both given).

All good suggestions ;-).
