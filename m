From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] tests: fix gzip with exported GZIP variable in environment
Date: Wed, 04 Dec 2013 14:07:08 -0800
Message-ID: <xmqqbo0wjmnn.fsf@gitster.dls.corp.google.com>
References: <1386061054-30796-1-git-send-email-mail@eworm.de>
	<CAPig+cQqKQdVEojYF+-+ZE2hQjxsH4WrgPymj8g7P6pSQzfVpw@mail.gmail.com>
	<20131203131812.GC26667@sigill.intra.peff.net>
	<xmqqy541okwg.fsf@gitster.dls.corp.google.com>
	<20131204193232.GB11024@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Christian Hesse <mail@eworm.de>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 04 23:07:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoKbI-0008Gg-24
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 23:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755394Ab3LDWHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 17:07:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51853 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754216Ab3LDWHO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 17:07:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97C6556BA0;
	Wed,  4 Dec 2013 17:07:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XmagVjNRbF71lXiYF4Ui0JQCuwM=; b=qYCj9T
	xzVPZirIFYAxG3g4q+b6xT7Uj9dh3p0F8WpFbj4U7IaMeV2VGncpaISPoauahIaa
	u6ceBWUdk2KY7r8aD7f0D7Yp0AP8YMsITMdmRr7/xreq2hayv/+qBlplHhdNvdXF
	i+iJS3ygAU6Vq6GdVITtBa8zA1ig2MevibdHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iGOEqAd8qF0oOijH1xR5BRhxERL3VC2w
	HauSFSNz9XkAqdo34dyAkxKhxzF5ILFTYEHvkqmdC00sRSJU8NpYyaZyqfn6TevT
	N8SejG2/quaTLXA6P84m1yIYEaB9d1nXXTTkXrCpd7ZT5cauOQGoYkWSHF2szUIB
	Ml5X+PfwxG4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A8F056B9D;
	Wed,  4 Dec 2013 17:07:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 062BF56B9A;
	Wed,  4 Dec 2013 17:07:11 -0500 (EST)
In-Reply-To: <20131204193232.GB11024@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 4 Dec 2013 14:32:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6D08BD3C-5D30-11E3-875F-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238815>

Jeff King <peff@peff.net> writes:

> On Tue, Dec 03, 2013 at 10:21:35AM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > There are a few options I see:
>> >
>> >   1. Drop $GZIP variable, and hard-code the prerequisite check to
>> >      "gzip", which is what is being tested.
>> > ...
>> > I think I'd be in favor of (1). It's the simplest, and we have not seen
>> > any reports of people who do not actually have gzip called "gzip". Users
>> > can still override it via config if they really want to.
>> 
>> I am OK with (1).
>> 
>> A related tangent is that we may have to worry about is how/if a
>> random setting coming from GZIP in the environment (e.g. "GZIP=-1v")
>> would interfere with the test.  It may be the simplest to unset
>> $GZIP at the beginning of these tests, regardless of which of the
>> above three is taken.
>
> I don't think we should worry about it.
>
> There are two levels to consider here. One, people may put junk in their
> GZIP variable, which will impact normal running of git itself...

This wasn't something I was worried about. We should support
reasonable setting of GZIP without breaking ourselves.

> That leaves options which change the compressed output, like "-9".

Yes, I was solely focusing on the stability of the tests.

> If somebody shows up complaining that a test fails when they have GZIP
> set, then that may be catching a bug, or it may be catching a fragility
> in the test. But since we do not have a real-world complaint yet, I'd
> rather leave it and judge when we have an actual case.

OK.
