From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] receive-pack.c: add a receive.preferatomicpush configuration variable
Date: Thu, 30 Oct 2014 13:11:22 -0700
Message-ID: <xmqq7fzhuxlh.fsf@gitster.dls.corp.google.com>
References: <1413924400-15418-1-git-send-email-sahlberg@google.com>
	<1413924400-15418-7-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 21:11:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xjw4A-0004GN-Jx
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 21:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933938AbaJ3UL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 16:11:26 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57002 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932513AbaJ3ULZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 16:11:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D5E119924;
	Thu, 30 Oct 2014 16:11:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1zOY6xN9rrkFFk+NKsv8YtqeWpo=; b=VuI1Xh
	EKenZMkEPj5YcAe/3Vnfy/6wwT+71cuHwQ/uH58uWVe1olQT9OIxyVnrS1YuBrdJ
	shWWyseAZC6jeBRsQe8MRrSFdrMRL7QN+2a1uBps/k40BpLSGj2pLDCcltLeCZ5P
	HWunEYaGaKxUtDLtCuJHk/LvsS+0zXNgxNXHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PbfaOAyqQSqTTO6EArYbQ6dCVFjBPAL2
	CHDmt1GxNqhDkqnpbbYtob3buoi/KVsrrxT1Y6V3Q5Gz24bzb6NGgD4K+zKoVq/H
	16Si2B2+Nwm9Ti3o+g34kPY8hF1aqigbb0pOtO/h3ljM/fawLez5TVR1vCfLkz6F
	KPc5IW0SW6g=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0374419922;
	Thu, 30 Oct 2014 16:11:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4247A19921;
	Thu, 30 Oct 2014 16:11:24 -0400 (EDT)
In-Reply-To: <1413924400-15418-7-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Tue, 21 Oct 2014 13:46:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EC2D1254-6070-11E4-B14F-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ronnie Sahlberg <sahlberg@google.com> writes:

> Add receive.preferatomicpush setting to receive-pack.c. This triggers
> a new capability "prefer-atomic-push" to be sent back to the send-pack
> client, requesting the client, if it supports it, to request
> an atomic push.

I can understand a configuration that says "We take only atomics
when a push tries to update more than one", but this one is iffy.

If the receiver accepts non-atomic from older send-pack, those with
newer send-pack should have a way to say "the receiving end may
prefer atomic, but I choose not to."  Is there a way to do so?

And if there is such a way, what value does the preference add to
the user experience and the server's operation?
