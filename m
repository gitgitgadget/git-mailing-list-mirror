From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: fixup fixup! fixup!
Date: Sat, 15 Jun 2013 18:19:53 -0700
Message-ID: <7vy5aakg1y.fsf@alter.siamese.dyndns.org>
References: <20130611180530.GA18488@oinkpad.pimlott.net>
	<87obbc8otc.fsf@hexa.v.cablecom.net> <1371237209-sup-639@pimlott.net>
	<1371278908-sup-1930@pimlott.net>
	<7vk3lvlmat.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git <git@vger.kernel.org>
To: Andrew Pimlott <andrew@pimlott.net>
X-From: git-owner@vger.kernel.org Sun Jun 16 03:20:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uo1dQ-0006Kz-56
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 03:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825Ab3FPBT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 21:19:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57393 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754809Ab3FPBTz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 21:19:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 718CB28B81;
	Sun, 16 Jun 2013 01:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oz6rUYSM64mTbRouF4lrxiiq6nc=; b=uktadd
	evi6pWGnxrfY4clVtEiaDAMJ8EGLX2oPzp/f7uITAIjsbFNJSF8/ueMTvY3faKnp
	P1+sDhdF2SMKdLSQnT15OGurTgHDwQ2LeGpiFeQJxXs7IynwKDNxXRh6N1ILzwij
	Bj+8DnRgCIZ68FEaDd4b4U8R5bPrXyGhbweH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TvGqgV3BlJ7aOQwUxy51ENPSXFrGFuIg
	XZYhTOn/XL+XIDknHZenGc6dwTXq8bgyplLeG7SpV5Cdes2sbiP+inlFZzKV/bTJ
	K9aH32LsoBW0pwqw/rXDW2EVYUe+RhRwHBeTiMzbHAHX4lgeTiB7jb6Kuliz/999
	snmoj7d2klQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6010928B80;
	Sun, 16 Jun 2013 01:19:55 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D215028B7F;
	Sun, 16 Jun 2013 01:19:54 +0000 (UTC)
In-Reply-To: <7vk3lvlmat.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 15 Jun 2013 03:07:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D9F965D0-D622-11E2-B225-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227979>

Junio C Hamano <gitster@pobox.com> writes:

> Andrew Pimlott <andrew@pimlott.net> writes:
>
>> Excerpts from Andrew Pimlott's message of Fri Jun 14 12:31:57 -0700 2013:
>>> It happened to work and I added a test.  But then it occurred to me that
>>> it might have been better to fix commit --fixup/--squash to strip the
>>> fixup! or squash! from the referenced commit in the first place.
>>> Anyhow, below is my patch for --autosquash, but unles someone has an
>>> objection to doing it in commit, I'll work on that.
> ...
> If you strip out the prefix when you make commits, you may lose the
> information if you want to use in order to express these different
> orders.

One design principle I would use as a yardstick is to see any code
that deliberately lose information to achieve something as highly
suspicious.  You can discard extra information when you read and
use, if you do not need it, but if you do not record it in the first
place, you cannot later enhance the reader to take advantage of it.

In general, whenever you see yourself _discarding_ information to
solve an issue, you should carefully ask yourself if that is the
right solution.

I wish we can make sure contributors can learn various design
principles we have benefited from over the course of this project
much better.

But it is a bit difficult to _teach_ others.

Writing them down is difficult, not because the rules are vague, but
because they are like air.  I am sure regular contributors with good
design taste share this sentiment.

You will know a violation of them when you see one, you naturally
stick to them yourself without even having to think about them, but
enumerating them without seeing concrete issues takes effort.

And this "lets squash multiple --fixup/--squash" happened to realize
that "we try not to deliberately lose information" is one of them.

Thanks.
