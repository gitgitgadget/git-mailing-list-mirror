From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] convert filter: supply path to external driver
Date: Mon, 20 Dec 2010 00:52:24 -0800
Message-ID: <7vy67kddx3.fsf@alter.siamese.dyndns.org>
References: <20101218223822.GA18902@arf.padd.com>
 <20101219212925.GA7393@arf.padd.com> <4D0F0DFB.20502@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Dec 20 09:52:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUbU2-00079Y-Cd
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 09:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754427Ab0LTIwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 03:52:35 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44671 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322Ab0LTIwe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 03:52:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9C6F424C3;
	Mon, 20 Dec 2010 03:53:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QVP0/KBWk7B8+P98dpfy9n9lZsU=; b=kOkQIH
	fn0/cjkPBlMB90XDfC2FO48BwfSE0LagVIMITCJSzOyS4y8mXi2S9bohAKGlHgAy
	cPnA31oVmPKXDED36U1pgyVKaY0UkM9ZrqV9Tqo1dday/EtviDj8Bga6Vb58Sxts
	9uIOAkEi0QdjcO+kwrebIooOrSS2AzHBD0On0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e213DKr9W/NDzuBOdrvw7AVRws1aSlFg
	Fd0aNr6uleymC1SOn1IBG9fcNvtKdgZ8zvBLqvdYZX3Ar1/fyEUe8odo5hOkmwSj
	Zr4J5V7Viurw399TgDnp1Dg6s147F6c6Gcqsxa+PrHQknmdQtAneU4CMKkKK76Ne
	GMHm6H2luSc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 53DA224BE;
	Mon, 20 Dec 2010 03:52:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 22C9924BD; Mon, 20 Dec 2010
 03:52:53 -0500 (EST)
In-Reply-To: <4D0F0DFB.20502@viscovery.net> (Johannes Sixt's message of
 "Mon\, 20 Dec 2010 09\:04\:11 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8B0CB220-0C16-11E0-AB89-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163989>

Johannes Sixt <j.sixt@viscovery.net> writes:

> What happens if there are any shell special characters in the path name
> (or spaces, for that matter). Does this shell-escape the substituted path
> name anywhere in the call chain?

Good eyes.  Thanks.

You would need something like %'s (that is "'" modifier applied to 's'
placeholder in strbuf_expand() to cause the expansion sq'ed), and then the
caller must write something like

	clean = git-p4-filter --clean '%s'
