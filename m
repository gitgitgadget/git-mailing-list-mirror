From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fix potential hang in https handshake (v3)
Date: Fri, 19 Oct 2012 14:21:59 -0700
Message-ID: <7vipa6i2dk.fsf@alter.siamese.dyndns.org>
References: <5081c054.eD2hEWR8K8zW5vdM%szager@google.com>
 <20121019210851.GD24184@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: szager@google.com, git@vger.kernel.org, sop@google.com,
	daniel@haxx.se
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 23:22:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPK1G-0005OY-Vw
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 23:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755259Ab2JSVWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 17:22:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41136 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754746Ab2JSVWC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 17:22:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0088C970B;
	Fri, 19 Oct 2012 17:22:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+cN8nQM4e1dOqekF1mA0c5uMcGs=; b=dnFOis
	rDUesIiqXJVaz29qUzUKwPtTGr0B3ZFb0wNVwn3F/pPOmFxPjHywq4HOU8seglOm
	9KDXXhCpkuKUk+kWBp+K1jVg01WA3o9AFoNnkEzOA4GPhjE3J/v0VqJUO4MlWhAo
	wntVqiEarKzfBxsbWQF4C+06+Wrgk47Vi20oA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G1H3oPkJWuB+UVTwgx1OpIDSM7tgGevN
	WlTE90vexLOqEWmDNXNpbP/ObXavo42ByuklsK0g55tXBInvibsRc5yWBtHNUb1f
	GTpew8Ou9hMnG3sw0CRKtcBqJiETcyXkDxbDj6RVFE9QoU9YLD+IknsciZC6JRNP
	RBVarqLSY9k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2267970A;
	Fri, 19 Oct 2012 17:22:01 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2508C9708; Fri, 19 Oct 2012
 17:22:01 -0400 (EDT)
In-Reply-To: <20121019210851.GD24184@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 19 Oct 2012 17:08:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0572D40A-1A33-11E2-B9B6-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208068>

Jeff King <peff@peff.net> writes:

>> +			if (max_fd < 0 &&
>> +			    select_timeout.tv_sec > 0 ||
>> +			    select_timeout.tv_usec > 50000) {
>> +				select_timeout.tv_sec  = 0;
>> +				select_timeout.tv_usec = 50000;
>> +			}
>
> Should there be parentheses separating the || bit from the &&?

Yeah, I think there should be.  Thanks for sharp eyes.
