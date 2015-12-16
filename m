From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/7] Rerolling sb/submodule-parallel-fetch for the time after 2.7
Date: Wed, 16 Dec 2015 12:20:43 -0800
Message-ID: <xmqqy4cucfhg.fsf@gitster.mtv.corp.google.com>
References: <1450224252-16833-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 21:21:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9IZd-0007Ey-Ia
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 21:21:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331AbbLPUUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 15:20:47 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58295 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755328AbbLPUUq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 15:20:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E28463308D;
	Wed, 16 Dec 2015 15:20:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=piMqIGsf7CWXtWeiOwtwXIA6fs4=; b=VIZrRT
	S/GGc3qvrD7/STnVciAyevHQVdtNTzv8R7CZ45Oo0s0xTSeGbQRlIbZSzfEgzOTx
	QOgHkbGPXfCk02WuT2GYYYDQF7KCvz9nX3EhwPcJxyS09zrgIMBSWredm/1s8f5g
	5Zei7Xpbv4kRK3zs1hJf4JrlwfYU3Iia8RA6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gTgcS6Il2ibQ3eCIk2yDj/QzCeREkocf
	+aj2pH+iHFNT0r38W3dLFdyh4V6/6xEb3D4BJn8WTyzd+1f2SMQpqQ/KLH0MqNNo
	ZjFFvOFpD0DnWktWwDX/UdrdPTv2N2IgoCyln7iQ4LrQEGWKrgl5J9vk+YIklyZN
	eHgn9qx0Qz8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D9F253308C;
	Wed, 16 Dec 2015 15:20:45 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 24C663308B;
	Wed, 16 Dec 2015 15:20:45 -0500 (EST)
In-Reply-To: <1450224252-16833-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 15 Dec 2015 16:04:05 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7CB60AAA-A432-11E5-8478-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282584>

Stefan Beller <sbeller@google.com> writes:

> I am sending out a new version for replacing sb/submodule-parallel-fetch for
> the time after the 2.7 release.
>
> * Dropped the patch, which introduces xread_nonblock
> * strbuf_read_once uses xread now. This is safe as we poll before using
>   strbuf_read_once, so we know we won't stall.

"That is only true for the current callers" was my first reaction,
but it is safe and sensible even for future callers.  If they have
something better to do than getting stuck before reading some, they
ought to be checking for POLLIN before calling this, and if not,
they do not have to be forced to spin for themselves until this
returns some new payload.

I like that.

> * have the commit message reworded for "run-command: add an
>   asynchronous parallel child processor" with Johannes' suggestion.

Thanks.
