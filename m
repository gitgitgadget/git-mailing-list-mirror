From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git grep" parallelism question
Date: Mon, 29 Apr 2013 15:22:24 -0700
Message-ID: <7v1u9tgeov.fsf@alter.siamese.dyndns.org>
References: <CA+55aFxY2PJ+L=vCfvQ39UGBr7E6m5q76hO=z3Mqm6vTQmmMbw@mail.gmail.com>
	<7vr4hxw2mp.fsf@alter.siamese.dyndns.org>
	<CA+55aFw+6pL5DoEPsPZpJCAbqEGaWYYKcdjZzbsHVzSSMrQmww@mail.gmail.com>
	<7vip39w14d.fsf@alter.siamese.dyndns.org>
	<CA+55aFx1t_MT+20Bbkse-wHeLz8E06yqaOhbb12GzHNDrE2tWA@mail.gmail.com>
	<CALkWK0k6Gi_J6nDbrGPxDMmWC73CHXdj7a5ugC15YVrrycP=hA@mail.gmail.com>
	<20130429161814.GJ472@serenity.lan>
	<877gjldxid.fsf@hexa.v.cablecom.net>
	<20130429180857.GK472@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Apr 30 00:22:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWwSu-0006kf-LZ
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 00:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759324Ab3D2WWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 18:22:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39832 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758089Ab3D2WW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 18:22:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B60C1ABAA;
	Mon, 29 Apr 2013 22:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HUMx0SluAzr8HZAT5ZnwVbZyAFw=; b=CL3MDA
	R6A4F4iqg1dWBb1RgNES2xRMnLH+zLmel86k3LlSAYonmiTP3MSnJ6JnKxDO1+D6
	/cqI0l9Tf1JgSfNCwhjQ0xHatP/RBy+9CWvigTPDxYOsntHi/Dvk0uT0QjTViiLU
	2r6BCHT5tP9mHCXBGvIeUKZ+rDD8vganaX3/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gXkSZFHVyD/RVwLEKbOinZG0QJSQt8f/
	e7DWflfiHzv7VXAo2MJJWV0xodJGKGxoSJ1gZjJpk4YF5rX72lUB0hfOrdh3AYVM
	VANXg+goX2vgTRadfmu7Mg7r0hqF2BxaBzx8mzNYyWouiKhoc04KdbwjWTWnCYUt
	CdkcxAXHQNY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81FDA1ABA9;
	Mon, 29 Apr 2013 22:22:26 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED3611ABA6;
	Mon, 29 Apr 2013 22:22:25 +0000 (UTC)
In-Reply-To: <20130429180857.GK472@serenity.lan> (John Keeping's message of
	"Mon, 29 Apr 2013 19:08:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 455CA828-B11B-11E2-AB30-8D009ADAE8A5-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222871>

John Keeping <john@keeping.me.uk> writes:

> On Mon, Apr 29, 2013 at 08:04:10PM +0200, Thomas Rast wrote:
>> John Keeping <john@keeping.me.uk> writes:
>> 
>> > On Mon, Apr 29, 2013 at 07:35:01PM +0530, Ramkumar Ramachandra wrote:
>> >> On a related note, one place that IO parallelism can provide massive
>> >> benefits is in executing shell scripts.  Accordingly, I always use the
>> >> following commands to compile and test git respectively:
>> >> 
>> >>     make -j 8 CFLAGS="-g -O0 -Wall"
>> >>     make -j 8 DEFAULT_TEST_TARGET=prove GIT_PROVE_OPTS="-j 16" test
>> >> 
>> >> i.e. always use 8 threads when the task is known to be CPU intensive,
>> >> and always use 16 threads when the task is known to be IO intensive.
>> >
>> > On this tangent, I recently added a TEST_OUTPUT_DIRECTORY line to my
>> > config.mak which points into a tmpfs mount.  Keeping all of the test
>> > repositories in RAM makes the tests significantly faster for me and
>> > works nicely when you have the patches in jk/test-output (without those
>> > patches the individual tests work but the reporting of aggregate results
>> > doesn't).
>> 
>> But that's been possible for quite some time now, using --root, or am I
>> missing something?
>
> No, I was the one missing something (--root to be precise).  But with
> TEST_OUTPUT_DIRECTORY you also get the result files in your temporary
> location, not just the trash directory.

With your patch, doesn't "tXXXX-*.sh --root $there" automatically
use the fast $there temporary location as the result depot, too?
If it doesn't with the current code, shouldn't it?
 
