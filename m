From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] push: further reduce "struct ref" and simplify the
 logic
Date: Mon, 21 Jan 2013 22:21:10 -0800
Message-ID: <7v622pd9gp.fsf@alter.siamese.dyndns.org>
References: <20130121234002.GE17156@sigill.intra.peff.net>
 <1358834027-32039-1-git-send-email-gitster@pobox.com>
 <1358834027-32039-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Chris Rorvick <chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 22 07:21:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxXEl-0006dz-8U
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 07:21:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801Ab3AVGVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 01:21:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36242 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752467Ab3AVGVN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 01:21:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7C7F647A;
	Tue, 22 Jan 2013 01:21:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iyTp0BJnHAhAgZoVfLDqSsNDL1k=; b=WB8pv/
	0y/rLpN2PEEzAUiSAfr8cHjsjCg1t29F2AurPw/t/qo122JnW/NqL+RjRft4fzaL
	a8pgWe+qva5yZgHSdLs+io+ZleXMq3DwmIj9L13s4VGizBXXfIfwfypsBIymaX+C
	7kbN+FjnOy/uNt/A2EktIXBQUnCxpO8r0Xhzg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hvLkw3QgnFK7oyKtS9upTj0pgzFKipj3
	X8Jx8NW+NkHrMqwPOtANxgJLfhJ9iec252NNGhWlKp7KdsrWOq/3a2kmsxIOYl/E
	XDHbYccahSeLmQfaksnuuMI9zqaeYj0XvMQ1Nmsc6F4c0V9/4qmmmSQTLk6/30Qq
	ZV0LvgwfCRo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD2DA6479;
	Tue, 22 Jan 2013 01:21:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4863E646E; Tue, 22 Jan 2013
 01:21:12 -0500 (EST)
In-Reply-To: <1358834027-32039-4-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Mon, 21 Jan 2013 21:53:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EB10365C-645B-11E2-9CAF-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214200>

Junio C Hamano <gitster@pobox.com> writes:

> The "update" field in "struct ref" is only used in a very narrow
> scope in a single function.  Remove it.
>
> Also simplify the code that rejects an attempted push by first
> checking if the proposed update is forced (in which case we do not
> need any check on our end).

Actually, the latter is a bad idea; it changes the semantics and
mark a push that was done with an unnecessary --force option.

I'm rerolling these three patches (the "update" removal will also be
moved to the preparatory clean-up patch).
