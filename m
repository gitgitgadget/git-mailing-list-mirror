From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Correct conditions to free textconv result data
Date: Mon, 22 Feb 2016 15:08:01 -0800
Message-ID: <xmqqfuwk4a3y.fsf@gitster.mtv.corp.google.com>
References: <1456145545-5374-1-git-send-email-pclouds@gmail.com>
	<1456145545-5374-3-git-send-email-pclouds@gmail.com>
	<20160222180645.GB4587@sigill.intra.peff.net>
	<20160222181224.GA4917@sigill.intra.peff.net>
	<CACsJy8BWgDFq_Dv=omkpDBa_pUF7zKr9cFftNL-KxtMcTkc5-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 00:08:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXzaN-0006e3-6Z
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 00:08:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756375AbcBVXIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 18:08:07 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56727 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755481AbcBVXIE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 18:08:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9DA0D475A1;
	Mon, 22 Feb 2016 18:08:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H+88nByl7QArPa78x1QHGAZPqAs=; b=TTDx25
	90bKUHREBNxUiDD7jHKX8honm9PvjI0pDofsONdayQhevJWbuGjjybWiGubdXiaD
	lIedFdUcGPiWDe+IUwDIJ6gwTx4KVg9faixnt3jmJKvYwgKdUoc3KevyDJB2Ffcn
	6dOtZmSwjSAEZz7mBUZqYjO41FAxlja5GCc3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VUNtSfuKhlRkaK/K9Xx101pvKiEeX5wW
	/7VAXLYVNzF/PYxD5nl2ONbmfE8E+ruQiNkhGRZd/0c9Af8VRxeWX+DFjpmJ7lUc
	str7jRs3pnOyWa9xY5tvPSVjNdZSZsOozH5WFgNb06xXYwKPQEnXfbNIlMJuYUGr
	4ivE1lkjOWk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 94AA4475A0;
	Mon, 22 Feb 2016 18:08:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 123864759F;
	Mon, 22 Feb 2016 18:08:03 -0500 (EST)
In-Reply-To: <CACsJy8BWgDFq_Dv=omkpDBa_pUF7zKr9cFftNL-KxtMcTkc5-w@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 23 Feb 2016 06:03:59 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1FD4B068-D9B9-11E5-A8D6-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286998>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Feb 23, 2016 at 1:12 AM, Jeff King <peff@peff.net> wrote:
>> On Mon, Feb 22, 2016 at 01:06:46PM -0500, Jeff King wrote:
>>
>>> Is there a case I'm missing here where we actually leak memory or try to
>>> free non-allocated memory? I didn't see it.
>>
>> By the way, I saw only patches 2/3 and 3/3 on the list. So maybe there
>> is something interesting going on in 1/3, or in a cover letter that
>> didn't make it. :)
>
> The only thing common in this series is it's the result of
> -Wwrite-strings. 1/3 changes some "char *" to "const char *", you
> don't miss anything.

While reading Peff's clarification patch, I did find the assignment
of "" to the *out pointer disturbing.  That part of your patch (I
presume that is what you mean by the above) may want to be revived.

Thanks.
