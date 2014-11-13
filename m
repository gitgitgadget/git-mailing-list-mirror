From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] approxidate: allow ISO-like dates far in the future
Date: Thu, 13 Nov 2014 14:36:53 -0800
Message-ID: <xmqqtx22ybga.fsf@gitster.dls.corp.google.com>
References: <20141113110325.GD8329@peff.net> <20141113110722.GB4386@peff.net>
	<xmqqr3x6ztyl.fsf@gitster.dls.corp.google.com>
	<20141113213647.GB7563@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Colin Smith <colin.webdev@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 13 23:37:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp30e-0000Ax-DE
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 23:37:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934477AbaKMWg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 17:36:56 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65431 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933604AbaKMWgz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 17:36:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F2E2B1E976;
	Thu, 13 Nov 2014 17:36:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jv1Kw0D8Ed5sUGgCbfeiB0+arjY=; b=jHXuRN
	YcKC+1SEIdUg8RO541cdizLoEib3dd03Ey05ffbpTVguRC3x8E6jBA/FAmqDp1r4
	qwTbJ3WBatmcQy1BQQk04qOOECP+OMP0CYQ9gSc4YZc1ZiLfwF4UQGCrIQSzaVQZ
	g0+TxXPUKoI3+W57sw2KJtU5OvSdPirayFnEo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jK6YRSkVeYnmLQoVfZ4cRSD1VkQDa0IP
	/H7oKQzEIHCzCeyHz+P3v7jtUViIeb/S4mr9I2b9Ln81vpa7J6xoZg1wP9SVY71b
	8UF4GR6PL8oSRMN2hyBXM9okJELNV9H1yMB4Kfk5xeMe6EZ6xmfxaJfObMKrwkq1
	YJhQAuqPElA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E98131E975;
	Thu, 13 Nov 2014 17:36:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 661A21E973;
	Thu, 13 Nov 2014 17:36:54 -0500 (EST)
In-Reply-To: <20141113213647.GB7563@peff.net> (Jeff King's message of "Thu, 13
	Nov 2014 16:36:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 91863BB2-6B85-11E4-8D93-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Nov 13, 2014 at 01:11:46PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> >  		if (c != '.' &&
>> > -		    is_date(num3, num, num2, refuse_future, now, tm))
>> > +		    is_date(num3, num, num2, refuse_future, now, tm, 0))
>> >  			break;
>> 
>> Doesn't the new argument '0', which is "allow-future", look somewhat
>> strange when we are already passing refuse_future?
>
> To be honest, I had trouble figuring out what the name "refuse_future"
> really meant. We do skip the future check, but it also means that
> is_date will munge the "struct tm" directly, even if we do not find a
> valid date. That worried me a bit.

Ah, OK.  That worries me, too, now you mention it.  I just didn't
see it myself ;-)
>
> But yeah, in theory, the callers I wanted to tweak can just pass in a
> NULL refuse_future.
>
> -Peff
