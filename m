From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch-pack: fix unadvertised requests validation
Date: Sat, 27 Feb 2016 10:38:13 -0800
Message-ID: <xmqq1t7ygfsa.fsf@gitster.mtv.corp.google.com>
References: <1456577034-6494-1-git-send-email-gabrielfrancosouza@gmail.com>
	<xmqqd1riggd7.fsf@gitster.mtv.corp.google.com>
	<xmqq60xagg1w.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 27 19:38:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZjky-0006ma-Mk
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 19:38:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756721AbcB0SiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 13:38:17 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53184 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756590AbcB0SiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 13:38:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2C0AE444ED;
	Sat, 27 Feb 2016 13:38:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dO3qm8g+V61i1vWeskG07RrABOQ=; b=n7mZyh
	D7oc9SlJdSu225GQX4jthqhx24QXfr5eiLM/a0XFy0ee45/7rGJrjFPycA+AOagT
	yT3B0aHExOTy4XQUQrXV3AbmyPVzTAvqXhB/+ZpyjnwHCoh5qt/wZMi1gYd4x/ws
	UOvG12TstA39DIiBlp4sxzocc8uZ9scUxBNkw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SyfHc4urp31OHiR/9HkhtcNEVYsxzl4l
	Wctt0imdp01w5MpuKJcp4GF8c/WoNR/kib+k1krk87z0IlC2Eb+GWsXsyq/twAZE
	HDHEax+WdWD04pzTGOr3ZGQ7p5TOwN029y+n6+IhooiW0/oUqWEKo2w7NLhvDEiY
	1Y6Kwrd88TU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 24342444EC;
	Sat, 27 Feb 2016 13:38:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9D7DA444EB;
	Sat, 27 Feb 2016 13:38:14 -0500 (EST)
In-Reply-To: <xmqq60xagg1w.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sat, 27 Feb 2016 10:32:27 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 42D702C0-DD81-11E5-AD51-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287720>

Junio C Hamano <gitster@pobox.com> writes:

> Nah, I think you just misspelt hashcpy() as hashcmp().  The original
> wanted to get the binary representation of the hex in old_sha1 when
> it continued, and you wanted to delay the touching of old_sha1 until
> we make sure that the input is valid 40-hex.

That much was correct, but...

> , so something like this
> is what Gabriel wants to do (which I agree with), isn't it?

... definitely not that X-<.  The "do this or fail || do that or
fail || ..." chain in the if condition part confused me.

I think Gabriel's patch is exactly what we want.

Sorry for starting a review before caffeine ;-)
