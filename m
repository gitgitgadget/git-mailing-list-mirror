From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid crippled getpass function on Solaris
Date: Mon, 06 Aug 2012 12:57:47 -0700
Message-ID: <7v628vztc4.fsf@alter.siamese.dyndns.org>
References: <1344208672-20028-1-git-send-email-bwalton@artsci.utoronto.ca>
 <7vboio231n.fsf@alter.siamese.dyndns.org>
 <1344220427-sup-3468@pinkfloyd.chass.utoronto.ca>
 <20120806193958.GA10039@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, git <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 06 21:57:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyTR6-0002p6-0e
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 21:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756865Ab2HFT5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 15:57:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65107 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752782Ab2HFT5u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 15:57:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2527A9D6B;
	Mon,  6 Aug 2012 15:57:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ryAgBwBISTUD7Yu5mLjpMm/u57o=; b=ADyDJX
	UHfZt1XCZ6P4jhAqe2OulH6RASAzVx8sajAaiAZccl78iV1k9s6p5mAr7Jk1sT9R
	PtNw+YFv8XVQKNv+vrNUWE0bnjaCfKCE0csra4rzxZE3BhnRlot55ecf3zyFsDW5
	Uf32k82NSqawvyaSxJU1MoiKpnnZgW/igL9U0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dRTqXh6MHniVYPLw1gXfS3XCD9GrvNjM
	RHWh5m1t/B6k1xW9uQqUSdo0Ka8sEnxJe5peW0uCxOK7HKoVlYSJrcNdfR3eJJZb
	+EqZ688aLwinW/CfXzjEUpLt4jY6s75rVJpmydHnZ7fpNZ+xw3Y+4sX+Be3DAoJF
	61yCtltN+YE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1331D9D69;
	Mon,  6 Aug 2012 15:57:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 09CA39D68; Mon,  6 Aug 2012
 15:57:48 -0400 (EDT)
In-Reply-To: <20120806193958.GA10039@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 6 Aug 2012 15:39:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF96452E-E000-11E1-8869-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202980>

Jeff King <peff@peff.net> writes:

> ....  From my reading of
> getpassphrase, it does seem to be a drop-in replacement.
>
> So I'm OK conceptually with the patch if we can't do any better. But
> getpass still sucks. It doesn't handle echoing, and it may or may not
> fall back to reading from stdin if the tty isn't available (which is
> disastrous for remote-curl, whose stdin is speaking the remote-helper
> protocol to git). So I'd really prefer to make HAVE_DEV_TTY work with
> Solaris if we can.

Tay Ray Chuan mentioned in the thread near-by that HAVE_DEV_TTY
codepath worked for him with "FILE *" to fd conversion, I think.
