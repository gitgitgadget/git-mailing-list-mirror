From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] builtin/grep: allow implicit --no-index
Date: Mon, 11 Jan 2016 10:37:45 -0800
Message-ID: <xmqqvb70vu6e.fsf@gitster.mtv.corp.google.com>
References: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
	<1452435597-12099-4-git-send-email-t.gummerer@gmail.com>
	<CACsJy8Bs3z0Gk3CjhyZGfOLA7R3pZQz7K5gk4BTytvYkZeyBtQ@mail.gmail.com>
	<20160111111015.GA10612@hank>
	<xmqqlh7wxc0y.fsf@gitster.mtv.corp.google.com>
	<20160111174817.GC10612@hank>
	<20160111175919.GA11724@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gummerer <t.gummerer@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 11 19:37:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIhLk-0004cO-IS
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 19:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933124AbcAKShs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 13:37:48 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62605 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932451AbcAKShs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 13:37:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7B031390E2;
	Mon, 11 Jan 2016 13:37:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DSqW5TlfHfu0R3cBSXRtWWhEVHI=; b=NlxXzs
	vcnNNEq3w7kfskYMGoUtuVD6yJxllB+Krj/HuSe6tK8gEO7mJlpE/ntsKi3G6JUP
	H9j2XcqzggK1c5WOqIQ2kqq2RWYW04OnR9B0ALWCYgYwPE0PTsc20rOnZrU6opNU
	4L/IijC38NK4n7zE4FP/F6dDo4Zzh+fImH8rk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KPCzOw2eG5i9BTsMSraidLa6vWWlCZSE
	+PzfbLk7ZLLLLMk7B5uC3SRWFKpLVYhiWSwTFujVOtND+lBO8AU5f95BmI+IDWLK
	sSY6q3rLXQZET3tSUij8awv1pohdj0p1xQerwD+TrjHEvV6zzr1vPTG8UdGl7K5j
	RVGagBEG0vc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 707DD390E1;
	Mon, 11 Jan 2016 13:37:47 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E565A390E0;
	Mon, 11 Jan 2016 13:37:46 -0500 (EST)
In-Reply-To: <20160111175919.GA11724@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 11 Jan 2016 12:59:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 68E9684A-B892-11E5-8460-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283698>

Jeff King <peff@peff.net> writes:

> On Mon, Jan 11, 2016 at 06:48:17PM +0100, Thomas Gummerer wrote:
>
>> What about a user though who accidentally runs git grep outside of a
>> repository, and is usually warned by git failing quickly, whereas with
>> the changed behavior some time might go by until the user realizes the
>> error.  Not sure if we want to support this use case or not?
>
> Yeah, I don't think git would be _wrong_ here, but I could certainly see
> it being annoying. Several times a week I probably run `git grep` in my
> home directory, and after seeing its error, realize "oops, I meant to
> `cd git`".
> ...
> ..., it sure would be nice not to
> have to say "deal with it; it's the new behavior and there is no escape
> hatch".

Ahh, you two are absolutely right.

I assumed people (after making their new year's resolutions) will be
perfect this year and from now on, and I totally forgot about the
case where somebody runs it by mistake.

"grep.fallbacktoNoindex = true/false" that is by default 'false'
would be our usual approach, then.

Thanks for pointing it out.
