From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] convert: legitimately disable clean/smudge filter with an empty override
Date: Thu, 28 Jan 2016 15:51:44 -0800
Message-ID: <xmqqa8npl0tr.fsf@gitster.mtv.corp.google.com>
References: <1453638170-52041-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, jehan@orb.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Fri Jan 29 00:51:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOwM2-0001uL-Jn
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 00:51:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbcA1Xvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 18:51:48 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60404 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750832AbcA1Xvq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 18:51:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C480E3F2EF;
	Thu, 28 Jan 2016 18:51:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u6u/7UHIk+4esyaI8aV34BefeQI=; b=yjTDKx
	4SXAmGV3a8D+zLpb3QRQFDFkUAgv3vc+tqWbEupKxBfEjRiE6EBocieawVMtMmco
	eKuErmP8mhViA6Msqq6EbLzkPWoGVO4P84jg8957Gz5+lKvWtNrw5Yvy7YyImT/h
	KyiD9Jg9WFfvc1IlBhRPtX5gcEC2/avVe0HvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bpvn6B9fTO0bPYDmpCtC3BvGNY+jh955
	M3LjD+byUNW1anKU2Bwa5JQtUDxDn98DsA2kIxv2aJXI+B9zF5ArnhxhDYtqMdt1
	MK4htmQrh9yykt0DEwKymqKkpqIClvVJdiCGF4I7zXtT6OO6Irk/uw+ATKOdXZ4D
	SImosX5RCo4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ACE133F2EE;
	Thu, 28 Jan 2016 18:51:45 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 33F1D3F2ED;
	Thu, 28 Jan 2016 18:51:45 -0500 (EST)
In-Reply-To: <1453638170-52041-1-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Sun, 24 Jan 2016 13:22:50
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 166C1CEE-C61A-11E5-AF45-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285047>

larsxschneider@gmail.com writes:

> -	if (ca.drv) {
> +	if (ca.drv && ca.drv->smudge && strlen(ca.drv->smudge)) {

You are not interested in its length, but if it is an empty string
or not, so I'd tweak this like so:

> +	if (ca.drv && ca.drv->smudge && *ca.drv->smudge) {
