From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretty-print: de-tabify indented logs to make things line up properly
Date: Wed, 16 Mar 2016 14:37:59 -0700
Message-ID: <xmqqk2l23xzc.fsf@gitster.mtv.corp.google.com>
References: <alpine.LFD.2.20.1603160926060.13030@i7>
	<xmqq7fh25mkc.fsf@gitster.mtv.corp.google.com>
	<CA+55aFxV5PWdSn9Gj=zV464TtJo=QvciZrhc5Pwe+Qfyqt8sXw@mail.gmail.com>
	<xmqqwpp243sb.fsf@gitster.mtv.corp.google.com>
	<xmqqoaae4340.fsf@gitster.mtv.corp.google.com>
	<CA+55aFwbNXJnwEYrKE5dDRk_6eZeGT6Z11uSQS8RmCSq43PkdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 16 22:38:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agJ99-0007PO-Gc
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 22:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965394AbcCPViW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 17:38:22 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:64471 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755734AbcCPViE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 17:38:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 92D2B4DB82;
	Wed, 16 Mar 2016 17:38:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PlUBt33Co929N+Qk3vrzHA/uCa4=; b=Z7NfwG
	p6Wnb4xp+x0cVooUzNCZm87QtiWDX0p5aG4xB6n16GIs13I+LlFXQjJESzB6b2Ad
	E39t6/BpDxri8qA6hrAL/w8+z0z6mC4LeITjdaDn212gpoNEL3El2A5JXe7DnP5d
	xBE/sWFzZfrcU//6aBT3LR4dKMSRymoV5oY6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VYcQBdCnlbpVsQcQFrNJlq8hhIZCNzpj
	MfMFU+yU61WNMTN11pmWcsCF7hVv6k9Ap+QfTiorTRH7bredtcMPMjLhC9jYI68K
	VtD1S7gItLcJX/3QSjz2BpWhMJ3m2XMs6+mYoHMNVqeYwr9n3x+FyZTkQSSamehd
	V/5w2wrsYfE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 898AA4DB81;
	Wed, 16 Mar 2016 17:38:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AF1A94DB7B;
	Wed, 16 Mar 2016 17:38:01 -0400 (EDT)
In-Reply-To: <CA+55aFwbNXJnwEYrKE5dDRk_6eZeGT6Z11uSQS8RmCSq43PkdA@mail.gmail.com>
	(Linus Torvalds's message of "Wed, 16 Mar 2016 12:59:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5BE247F6-EBBF-11E5-9B5A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289046>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Mar 16, 2016 at 12:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Strangely running t4201 with your patch (without any squashing)
>> seems to show a breakage in shortlog.  I won't be able to come back
>> to this topic for at least a few hours, so this is just a single bit
>> "breaks" report, without "how and why" analysis, sorry.
>
> It's because those things have tabs in their first line, so the output
> now differs from the expected one exactly because of the tab-vs-space
> expansion.

What surprised me was that this new expand logic triggered for
shortlog, actually.  I somehow assumed the caller that called
de-tabify helper was only called for --pretty=medium.
