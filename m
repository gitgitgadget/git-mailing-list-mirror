From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] connect: treat generic proxy processes like ssh
 processes
Date: Mon, 16 May 2011 16:12:50 -0700
Message-ID: <7vy626i6j1.fsf@alter.siamese.dyndns.org>
References: <20110516063944.GB25731@sigill.intra.peff.net>
 <20110516064607.GA19078@sigill.intra.peff.net> <4DD181C6.4020104@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue May 17 01:13:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM6yP-0002tE-OF
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 01:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756173Ab1EPXNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 19:13:07 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56392 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755766Ab1EPXNG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 19:13:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 26F15555E;
	Mon, 16 May 2011 19:15:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qn/i7OyBYzODsN2MAvjcZpiY9hg=; b=LGY1gv
	DFBpIOUV9V+YNUw4/UfH1ZdzKJX3l1dlLxwov4vdMdcXbZ4HkW6ZThh8Ffg6803X
	Nu4PaGSNOAEjZN5Dy2j681nrp96cEOYnNKjv2E3r4pfcJuCTWuMsrndfjhl4uRNh
	tbmDzxWIqZCFh/JO575JeYfRVDU3BWWSdTNTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kb+/LPPthlJ3XVRrdjVvBbrXmRZ69jFG
	8d9GnTrWloWtL958C108/NdXMQeialfKwu/2q4aXUuHIZvAA0FxvxEDbzkmDTkxw
	eAiUvnZZf9bZvjThtTnOXiRtruL8hOFP1B8+Sc4w5GMsXPOFtlkpxlZsKlHAKJTU
	bsuPlY0YgMU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C94DD555D;
	Mon, 16 May 2011 19:15:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 58B6F555A; Mon, 16 May 2011
 19:14:59 -0400 (EDT)
In-Reply-To: <4DD181C6.4020104@kdbg.org> (Johannes Sixt's message of "Mon, 16
 May 2011 21:57:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56572CD4-8012-11E0-96AC-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173772>

Johannes Sixt <j6t@kdbg.org> writes:

> At this point, proxy->argv would point to automatic storage; but we
> need argv[0] in finish_command() for error reporting. In my
> implementation, I xmalloced the pointer array and leaked it. (And
> that's probably the reason that I never submitted the patch.) I
> wouldn't dare to make argv just static because this limits us to have
> just one open connection at a time established via git_proxy_connect().

Good point. If we really care, I would imagine that struct child_process
can gain a boolean flag to tell finish_command() that the argv[] needs, so
I do not think leakage here is such a big deal.

Will squash all three hunks in.  Assuming no_fork first and updating conn
as we discover what kind of URL we have feels natural.

Thanks, both.
