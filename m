From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Request: timeout option for remote operations, esp. "git fetch"
Date: Tue, 12 Nov 2013 09:45:33 -0800
Message-ID: <xmqq1u2likea.fsf@gitster.dls.corp.google.com>
References: <527BC8DC.7010108@zytor.com>
	<20131110201751.GA18513@dcvr.yhbt.net> <52825EBF.3050603@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Nov 12 18:45:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgI22-00008m-Ss
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 18:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649Ab3KLRph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 12:45:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53711 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589Ab3KLRpg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 12:45:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C00BC50F07;
	Tue, 12 Nov 2013 12:45:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Lm1SfCztyqcmDhuMzdHXtxhNRvI=; b=nDCBVa
	xawABCqoEBGaL3jVXgw1zpjxhgWLbHtvMlng9SBG0R4GowxNIxi1XIXtGYe/lcjk
	BFUcU6RV8VEwgGON835ptpkoS1+GgLztzE6U/9Jwdn9L1rL0wM1y3NALXa7q4nJ2
	3R1uA49t0+BfXbch8N4nyyKOmL0zIyZdHw1ho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f7BwpND+GLBlTMHURZsjRDqikBzFRwM3
	3fwVictxa2j4EFmHndnnDMG5Zt3yL/aQTJPJhB9q+c1XzipSfsn+J38G12ruoVaI
	36EbD+1OY2bSu6fseFD77GG5TQvZk3QAwtRijIlLBiIlDN1zcWZ+rVxTMv6YldAs
	i/7ulOW1R7I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABC0F50F06;
	Tue, 12 Nov 2013 12:45:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E1F3B50F04;
	Tue, 12 Nov 2013 12:45:34 -0500 (EST)
In-Reply-To: <52825EBF.3050603@zytor.com> (H. Peter Anvin's message of "Tue,
	12 Nov 2013 09:00:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3BBF0ECC-4BC2-11E3-86E3-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237724>

"H. Peter Anvin" <hpa@zytor.com> writes:

> On 11/10/2013 12:17 PM, Eric Wong wrote:
>> "H. Peter Anvin" <hpa@zytor.com> wrote:
>>> When a remote server is unavailable or very slow, some git commands can
>>> stall out indefinitely.  It would be a very good thing if remote
>>> commands -- but especially git fetch -- could be given a timeout.
>> 
>> We've had SO_KEEPALIVE on git and ssh transports since e47a8583 (2011-12-06)
>> SO_KEEPALIVE for http was added recently (a15d069a) and will be in git 1.8.5
>> 
>> Do you want a shorter timeout for slow (but still alive) servers?
>> 
>
> Yes; note that SO_KEEPALIVE only guarantees that the server is alive at
> the TCP socket level.  If the server is overloaded but technically alive
> it may still make no meaningful forward progress.

Which means that your original wish may not be granted with
SO_KEEPALIVE at all, no?  I was wondering if you wanted a forced
timeout based on alarm(2), something similar to what you added to
git-daemon in 960deccb (git-daemon: timeout, eliminate double DWIM,
2005-10-19).
