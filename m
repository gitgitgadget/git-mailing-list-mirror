From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pack corruption post-mortem
Date: Thu, 17 Oct 2013 08:47:05 -0700
Message-ID: <xmqqfvrz3nnq.fsf@gitster.dls.corp.google.com>
References: <20131016083400.GA31266@sigill.intra.peff.net>
	<201310160941.16904.mfick@codeaurora.org>
	<20131017003546.GA12439@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Fick <mfick@codeaurora.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 17 17:47:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWpn9-0001JO-0D
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 17:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757359Ab3JQPrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 11:47:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58209 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756986Ab3JQPrI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Oct 2013 11:47:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCC144A707;
	Thu, 17 Oct 2013 15:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RRSZN3L+ZdDSw24jh1cvy4EJ6uE=; b=lu++Dk
	3B40ILN3foSTQfEpwmIMMyDGlJ9+cDcjOAJk/sEJJ6xjmgokeRowYQ3BngU/dB8T
	Mom5fryOcSTT4rAzg+dv5+caZGCpBn1SZk+dbCaK9VYfqUGf4d732JQrd4sWGokA
	UihlRxMSlp7DqTROegAeXC8O6hf3q9Nleeoxw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CeqCXH+3dmL1Gd0GKkh4m2PK9l9GJDCf
	nAKuANflyePrdD6yMqIGTPP3Rd+vOVDAu7CVXdGJX0z5oEzAK2CxFiSsIDDmje/p
	Dq+7EcxYFarCXO+fbsfibVj41V277c4XxJ406d68Cd3drWkUfjZIkhItVxFBKR0f
	yTBK8dwWRvE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF4774A706;
	Thu, 17 Oct 2013 15:47:07 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2BFE84A704;
	Thu, 17 Oct 2013 15:47:07 +0000 (UTC)
In-Reply-To: <20131017003546.GA12439@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 16 Oct 2013 20:35:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 60759742-3743-11E3-A30C-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236298>

Jeff King <peff@peff.net> writes:

> On Wed, Oct 16, 2013 at 09:41:16AM -0600, Martin Fick wrote:
>
>> I have nightmares about this sort of thing every now and 
>> then, and we even experience some corruption here and there 
>> that needs to be fixed (mainly missing objects when we toy 
>> with different git repack arguments).  I cannot help but 
>> wonder, how we can improve git further to either help 
>> diagnose or even fix some of these problems?  More inline 
>> below...
>
> In general, I don't think we know enough about patterns of recovery
> corruption to say which commands would definitely be worth implementing.
> Part of the reason I wrote this up is to document this one case. But
> this is the first time in 7 years of git usage that I've had to do this.
> So I'd feel a little bit better about sinking time into it after seeing
> a few more cases and realizing where the patterns are.

There was one area in our Documentation/ set we used to use to keep
this kind of message almost as-is; perhaps this message fits there?
