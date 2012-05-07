From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: fix progress-regression
Date: Mon, 07 May 2012 12:47:25 -0700
Message-ID: <7vtxzr4vua.fsf@alter.siamese.dyndns.org>
References: <1336418593-2792-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, j.sixt@viscovery.net,
	peff@peff.net, rctay89@gmail.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 21:47:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRTuB-0001fq-8N
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 21:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757870Ab2EGTra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 15:47:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56952 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757834Ab2EGTra (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 15:47:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3039365C3;
	Mon,  7 May 2012 15:47:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ENLOXVyS1nTKITusbYHsaEi1ey8=; b=K4BsX4
	EQLGBMfPso3T4jwXrIficp2ykm/nifSnd9v1IRGYXDns01NRmFHaEnxmSMl5rkpo
	1rtiRAjLnTzx+xhOULeNgzDAASe37aqeA6X6mw/s9mfm+XvN9WussEZyycpfdllR
	flSPzEbTXNg5+ai2ddmu/3ITpYZr0iR8ScYvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KtzjAUXbDgLUiECMpGSsfcqcDYE1Ozcy
	mLQAjG2cIuQJ87b5Ord0ZCWXe+wl/LGGA2gB8YzrT7xxU6S73TfONMlUPtZoDXdH
	g2ZwPTkLenmBB7wubt1/slG6ik2xgXZCWjQZpUsFk433YKDtBDfubSKT5SZ+5Vy7
	jOOwybR8ybA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2897E65C2;
	Mon,  7 May 2012 15:47:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B16D965C1; Mon,  7 May 2012
 15:47:26 -0400 (EDT)
In-Reply-To: <1336418593-2792-1-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Mon, 7 May 2012 21:23:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7912008A-987D-11E1-9192-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197301>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> In 5bd631b3 ("clone: support multiple levels of verbosity"), the
> default behavior to show progress of the implicit checkout in
> the clone-command regressed so that progress was only shown if
> the verbose-option was specified.
>
> Fix this by making option_verbosity == 0 output progress as well.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---

Thanks.

> Hmpf. While tidying this up for a proper submission, I found out that
> writing a reliable test is tricky due to the start_progress_delay-usage.
> I'd have to clone a repo that does not progress more than 50% of the
> checkout-operation within one second or something like that (I didn't
> quite follow the logic there), which is a lot :P.

In real life, most of the checkout is fairly quick for even projects like
the kernel, and the logic is an attempt to avoid cluttering the terminal
with progress unless it takes unusually long and might make the user feel
worried.

> So perhaps writing a test to avoid similar breakages in the future isn't
> worth it?

I agree that it probably isn't worth it, given that it took forever for
anybody to even complain about this.
