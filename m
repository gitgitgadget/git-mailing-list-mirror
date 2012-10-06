From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] MALLOC_CHECK: Allow checking to be disabled from
 config.mak
Date: Sat, 06 Oct 2012 12:22:15 -0700
Message-ID: <7vbogfquc8.fsf@alter.siamese.dyndns.org>
References: <50706B54.8090004@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Elia Pinto <gitter.spiros@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Oct 06 21:22:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKZxF-0006n7-KB
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 21:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060Ab2JFTWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 15:22:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41834 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752507Ab2JFTWS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 15:22:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 187229A69;
	Sat,  6 Oct 2012 15:22:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M30ZWWxE08HbmnoT3h+uDktxgEg=; b=VZ3/lV
	viqiHCdj/1EOxQs5kQ0hPW1u+gPiD/SCm6MqG7VncKv6pMCHtgZI47dnRV+QdjcP
	eyA+yRLFhkBVaLWO3oYUCS9nDOVbTaPBaYRmANWLI30l9KsxyD1M7pY2D5+FD7nz
	Y4UEslKGBFQ6ojrTFidtgWtbFXNehpE60IeeA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pUwX3t+MVp6ruRe2mQxOmIjR+mufFc07
	dlcPFOCzFQpFalJM8yRqt2IZQu2IEOl4u9tjJxEusrjL6oRUVgGfwWKt2j0J+rWe
	58Zy33kEDpbniWfcyxBZkHWDilPFdTgt7p6DjLIu4jp4ZAe14jdRTqkHHCebRtpN
	99oHeFokleM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06B1C9A68;
	Sat,  6 Oct 2012 15:22:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 769B89A67; Sat,  6 Oct 2012
 15:22:17 -0400 (EDT)
In-Reply-To: <50706B54.8090004@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Sat, 06 Oct 2012 18:33:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 24478814-0FEB-11E2-87E3-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207171>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> The malloc checks can be disabled using the TEST_NO_MALLOC_CHECK
> variable, either from the environment or command line of an
> 'make test' invocation. In order to allow the malloc checks to be
> disabled from the 'config.mak' file, we add TEST_NO_MALLOC_CHECK
> to the environment using an export directive.

We would want to encourage people to test with cheap but effective
checks when available.  I do not see "malloc: using debugging hooks"
message anywhere when I run tests, but if you do, I'd rather see us
check if we can tell glibc to stop doing so first without disabling
the whole test.  Your patch feels like the first step to a slipperly
slope whose destination would make us say "we get too many messages
so let's do nothing in "make test" with this configuration." when
taken to the extreme, and obviously we would not want to go there
;-).

Elia, you brought the MALLOC_CHECK_ up.  Did you hear about this
issue elsewhere before, and if you did, do you know how other
projects solves it?

Besides, doesn't a simple instruction to export TEST_NO_MALLOC_CHECK
to your environment before running "make test" suffice?
