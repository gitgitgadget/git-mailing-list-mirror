From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] grep --no-index: allow to grep without git
 exclusions
Date: Thu, 21 Jul 2011 09:22:32 -0700
Message-ID: <7v62mv4n93.fsf@alter.siamese.dyndns.org>
References: <82218b89c89f733dc0759d648b3a60bca6e20f3e.1311165328.git.bert.wesarg@googlemail.com> <7vzkk86577.fsf@alter.siamese.dyndns.org> <CAKPyHN2TMu2yO4sZDAqCce9P-5==Z2jKQVoU=zUsmUQJhHoeQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 18:22:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qjw1J-0004yc-FP
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 18:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187Ab1GUQWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 12:22:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61758 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753054Ab1GUQWg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 12:22:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25A503469;
	Thu, 21 Jul 2011 12:22:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZpbZT3UbEXoj4t+ci9xe7oBUH1Q=; b=DuwxFl
	SMYn5V0h4fTj7bj7IQ99VDKGVPOvsuh7qR2+jSB39QT2e5AHoSLQfUEub/gaRVnb
	AtEoaWiksUJ1/EMg2k27j2xtaW6tO3kllgppR5P7RoBzwQrL4tTS8bKVZ5qR3xBz
	vRlTbg06wkRglNKft9/KRingHxWShqxXyg7Hc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jpr/J358LFuEjsAAupJbJfsgJ2Y+N/w0
	cLnRCwmJEKTgvTdKtGiGHXdVDsLeTY5H+XJNJesoKscNPsJ/0DiOaOuM7UR4huwt
	3l5mKCprnfZr97b8kl8e05ECtYkV9YDefcAQHXVYe869qUWsK93l7xYfxAqk2FRt
	5E8hc8hLrlU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CACE3468;
	Thu, 21 Jul 2011 12:22:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6B9D3467; Thu, 21 Jul 2011
 12:22:34 -0400 (EDT)
In-Reply-To: <CAKPyHN2TMu2yO4sZDAqCce9P-5==Z2jKQVoU=zUsmUQJhHoeQg@mail.gmail.com> (Bert
 Wesarg's message of "Thu, 21 Jul 2011 09:11:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A43BB25E-B3B5-11E0-9096-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> It should be. But I think that unveils one of the shortcomings of the
> (any) option parser: You wont get notified when an option was given,
> regardless of its value. To handle the above I would have to use
> OPTION_CALLBACK to set an addition flag exc_given (like it is done in
> git-ls-files) and test against this.

Prepare a three-value variable, initialized to -1, set it to 0 on --no-foo
and set it to 1 on --foo. Use the default if the variable is still -1.
