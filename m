From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Weird behavior of shell variables in git aliases
Date: Mon, 21 Mar 2011 15:21:45 -0700
Message-ID: <7v8vw8nmh2.fsf@alter.siamese.dyndns.org>
References: <d9c38309-c433-476c-bba3-f2c5b7e94a89@k15g2000prk.googlegroups.com>
 <20110321215310.GA2122@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dun Peal <dunpealer@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 23:22:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1nUD-00017p-JH
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 23:22:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754693Ab1CUWWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 18:22:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33818 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754689Ab1CUWV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 18:21:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9F2985630;
	Mon, 21 Mar 2011 18:23:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Muf2nC5KLZbdKOfLTgOk7/+jmfY=; b=XYijB3
	BE7pyfcVMj2Z+eS/8WLzshvSKs8RumWwH5ssqEXvFUQ/4ceQCYif0ZFAVNDZqLUn
	D65ftJ4wkOQxrofi/06y80QMeaS0NqTgy9wtu3XAVBOzU87aCMt2HaJMTl1XYMfN
	AhaS+urroqyN2eBn184cd+hfYiFyNMQOPYGe0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LPeZHRmroLLchUwd4+AQsuUWIJ9lKA2w
	ICgWbbcIL6k6kW/Gicnogq3E/3fs5sINsMlzDErpZWAFNZZG8w1zf8xDyrDnSCsx
	SFZoDTPc3AurL3zZZiBlWmnyVeecgOSkKv1DKKFzlP5oarxuKZcy2mHF3+dHtPLm
	5x6LL8Q8q3Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 49A17562B;
	Mon, 21 Mar 2011 18:23:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 023C25623; Mon, 21 Mar 2011
 18:23:26 -0400 (EDT)
In-Reply-To: <20110321215310.GA2122@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 21 Mar 2011 17:53:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DABA4D24-5409-11E0-ABEA-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169681>

Jeff King <peff@peff.net> writes:

> But interestingly, that's _not_ the behavior as of Erik's 7f51f8b
> (alias: use run_command api to execute aliases, 2011-01-07), which is in
> master but not yet released. With that, we end up executing:
>
>   sh -c 'echo $1 && echo $1 "$@"' 'echo $1 && echo $1' 'foo'
>
> which prints "foo foo". So it is technically a regression. I don't know
> how much we care; using positional parameters like this was already
> nonsensical, as shown above.
>
> For reference, what you actually want (in either system) is:
>
>   $ git config alias.test1
>   !sh -c 'echo $1 && echo $1' -

Oh, I should have been paying a bit more attention.  I've been assuming
that we were turning "!anything" into { "sh", "-c", "anything", "-" }
followed by the user supplied arguments.
