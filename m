From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] diffcore-rename with duplicate tree entries can segfault
Date: Wed, 25 Feb 2015 13:50:38 -0800
Message-ID: <xmqq1tldoe35.fsf@gitster.dls.corp.google.com>
References: <20150224214311.GA8622@peff.net>
	<xmqqh9uborrx.fsf@gitster.dls.corp.google.com>
	<20150224224918.GA24749@peff.net>
	<xmqqd24yq517.fsf@gitster.dls.corp.google.com>
	<20150224234737.GA8370@peff.net>
	<xmqq8ufmpouz.fsf@gitster.dls.corp.google.com>
	<20150225214032.GA32295@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 25 22:51:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQjr4-0002FR-Ga
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 22:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461AbbBYVux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 16:50:53 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58748 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752907AbbBYVuv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 16:50:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E262B3A742;
	Wed, 25 Feb 2015 16:50:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cn4pPCabvnkaRLu0u9j3gX/TY+A=; b=fz7fCo
	FftPj/8ZQkv0KD/V6uSg2FI1/UKD1LGQerQIeja1rDrBTdEwBFoQ3hW4jhFCjJTb
	T5uvlBZ1OHoeECi1vmEynsucSgZ8mIDbT1Rcdyi+TnBziBAYXNOESqdQGr3rd3I2
	yrXBprK1U0squgfCu8NJ1VBbkAdV9PhIaU6gY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xqJZryikzKF0Rjr/FpHapqUdbGc3Zb+N
	dQUY700xrmkwvtGeO8dZBdGpXPuEeQBEFRvs3KEblQLb8YOrceL0f4bckltGvNP1
	rAKpbQVKtwAoY8/LP0J/RA+Kzdwhb/HGew5U/M5iyZgW6hQgeUdA1vAOE8UJSX7P
	vbvc1FBBK0Y=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DA0DE3A741;
	Wed, 25 Feb 2015 16:50:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 51EB93A72E;
	Wed, 25 Feb 2015 16:50:40 -0500 (EST)
In-Reply-To: <20150225214032.GA32295@peff.net> (Jeff King's message of "Wed,
	25 Feb 2015 16:40:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5700C494-BD38-11E4-A8DB-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264417>

Jeff King <peff@peff.net> writes:

> But we can also do that with a hash table, or an auxiliary sorted array.
> And sure enough, that's exactly what the rename_dst array is.
> ...
> which I think is a pretty simple and sane fix.

Yeah, good observation.

> So to go forward, I'm happy to prepare a patch, but I'd like to know:
>
>   1. Does something like the above look reasonable to you (I'd probably
>      refactor it to avoid the bizarre return value semantics from
>      locate_rename_dst, though)?
>
>   2. If so, do you want something minimal like what's above, or do you
>      mind if I build it on top of a hashmap conversion? I suspect the
>      logic may also end up more clear with the hashmap (since inserting
>      versus lookup will be more distinct in the callers).

No, I don't mind.  The diff-b-m topic seems to need a lot deeper
rethink than I originally anticipated anyway, and it can wait for a
clean-up to use hashmap to stabilize.

Thanks.
