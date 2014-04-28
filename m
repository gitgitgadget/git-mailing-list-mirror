From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Sleep 1 millisecond in poll() to avoid busy wait
Date: Mon, 28 Apr 2014 11:58:50 -0700
Message-ID: <xmqqfvkxqo0l.fsf@gitster.dls.corp.google.com>
References: <20140428083931.GA10257@camelia.ucw.cz>
	<CABPQNSaC30p7TEOvc85u=+skjrFj17182vWWSL=QNVuvzVFE=w@mail.gmail.com>
	<20140428113815.GA10559@camelia.ucw.cz>
	<20140428114224.GA11186@camelia.ucw.cz>
	<CABPQNSbDkE+Vff=4MmPO9oMfjRay6Oin51zZRoZ8mOEhGoaD3Q@mail.gmail.com>
	<535E6E4B.6070308@viscovery.net>
	<20140428153527.GB12357@camelia.ucw.cz>
	<CABPQNSbpyFzg8A8gLp2nJZeTRSLSb0Qs8ytZDsJLmi6VyER71Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stepan Kasal <kasal@ucw.cz>, Johannes Sixt <j.sixt@viscovery.net>,
	GIT Mailing-list <git@vger.kernel.org>,
	Theodore Leblond <theodore.leblond@gmail.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Apr 28 21:18:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wer4g-0007p4-1i
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754978AbaD1TPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:15:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59994 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751804AbaD1TPM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:15:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25F0D81221;
	Mon, 28 Apr 2014 14:58:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AlAg5/dYeMjW+lRwl2+4DVR24Bs=; b=Z+UVTL
	m58YlvbbeOLLlpTNJc3yLagHTjQeUDUBvtF0njHJ5JpInm93WGnqMeWs7xB9Dyaw
	oLYGjrSDW+ahPhhGuv7H+ZNW9Yap6NKODHrYU+sReQrOMNP7nom7wr9+fhfsp7GF
	bRuyJ8wR83G7RyfaUSD+PFINybNUXQPC10Tdo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R//ttm95AeDeQnzU+7NZSuii1SxGm5SH
	ksRXcx/d+oo7BUiVcpDRR8D9yAgcTs1wzxuAAXMquZQaJlLf/rtNfWQ03jOynt0T
	LX+1bbOvoDiCahUq5KccOkQ2bAH6pkHEWM+LjXfTyxmGEzsCYHpvWp92O7bj44z+
	OurduuBqUqk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04C7A81220;
	Mon, 28 Apr 2014 14:58:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 173428121F;
	Mon, 28 Apr 2014 14:58:52 -0400 (EDT)
In-Reply-To: <CABPQNSbpyFzg8A8gLp2nJZeTRSLSb0Qs8ytZDsJLmi6VyER71Q@mail.gmail.com>
	(Erik Faye-Lund's message of "Mon, 28 Apr 2014 17:37:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 23AB1952-CF07-11E3-A8F0-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247395>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Mon, Apr 28, 2014 at 5:35 PM, Stepan Kasal <kasal@ucw.cz> wrote:
>> From: theoleblond <theodore.leblond@gmail.com>
>> Date: Wed, 16 May 2012 06:52:49 -0700
>>
>> ...
>> I also tested the very fast local case, and didn't see any measurable
>> difference. On a big repo with 4500 files, the upload-pack took about 2
>> seconds with and without the fix.
>> ---
>>
> Good stuff!

Do I expect to be forwarded this patch with proper provenance
sign-off chain thru you?

I do not mind adding Ack from you and J6t I saw in this thread
myself, perhaps like the following:

    Subject: compat/poll: sleep 1 millisecond to avoid busy wait
    From: Theodore Leblond <theodore.leblond@gmail.com>

    SwitchToTrhead() only gives...
    ...
    seconds with and without the fix.

    Signed-off-by: Theodore Leblond <theodore.leblond@gmail.com>
    Signed-off-by: Stepan Kasal <kasal@ucw.cz>
    Acked-by: Johannes Sixt <j6t@kdbg.org>
    Acked-by: Erik Faye-Lund <kusmabite@gmail.com>

I am just having this feeling that I lack the background on the
evolution of this patch to say the above properly records the
provenance.

Oh, also in the last paragraph, who is "I" who tested?  Theodore, or
Stepan?

Thanks.
    
