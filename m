From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: fatal: patch fragment without header at line
Date: Mon, 16 Jul 2012 10:19:43 -0700
Message-ID: <7vy5mj39ow.fsf@alter.siamese.dyndns.org>
References: <CAK5QfLMs6CMCTtZ3woQfMim1ssYLKEURAMv8+FgqrKJ7otNcnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: tuxdna <tuxdna@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 19:19:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sqoxb-0001hX-Ec
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 19:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081Ab2GPRTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 13:19:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64535 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751337Ab2GPRTp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 13:19:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C43C8ACF;
	Mon, 16 Jul 2012 13:19:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xAZnhg9YsMi7xDysA5/AAntWpBc=; b=thwnc9
	A5H/AuyNOKg9eb/W4vijWDK6cz1LWWwsEPOgeaTpWqPNOJyIp2ZzkqTXRgUuyjnu
	7JIs6sJ9j4wKL51Sv5EMnjPmbf22VLTi0a9eTEXbfyxB26N90LqFCLak9/Kus0d5
	i6bS0JrcbgoaVKA51nf3PGlzDQBm0LnV5RlXA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kvp0+T0njBlaaB3hbUukzpHoJHTe9N8y
	ONpeqj0vZugjDkf1NlKWtcGfrDRTokBtBnzcpagk6rk8YDzULRAN6bvaae5YpDce
	PoRx2bPqlvIHOuUoFwjhE7VS+WCWzvRQPLkw+kZrC83qqi1l+ENqbqTbUwJvaZCm
	dLM21xUpops=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59A858ACE;
	Mon, 16 Jul 2012 13:19:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B5F838ACD; Mon, 16 Jul 2012
 13:19:44 -0400 (EDT)
In-Reply-To: <CAK5QfLMs6CMCTtZ3woQfMim1ssYLKEURAMv8+FgqrKJ7otNcnw@mail.gmail.com>
 (tuxdna@gmail.com's message of "Mon, 16 Jul 2012 19:06:51 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6FD4BA66-CF6A-11E1-AC3B-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201534>

tuxdna <tuxdna@gmail.com> writes:

> Git version: git-1.7.7.6-1.fc16.x86_64
>
> I am getting an error with a patch that I am applying to a git repository.
> I have created a test case for this issue that I am facing.
>
> $ git apply --check 0001-modified-README.patch
> fatal: patch fragment without header at line 7: @@ -635,9 +635,7 @@
> some_function()
>
> Clearly line 7 appears to be a patch but it isn't. It is the part of
> email body or the patch context.

Yes, but the error detection needs to stay for a more common case in
which the user corrupted the patch by breaking or removing the diff
header.

If you want to quote a patch fragment in your log message, it is
common to indent the part (without removing the "diff" header) which
also has the benefit of making it stand out in the textual
description, e.g. here is a sample patch fragment

    diff --git a/README b/README
    index ce01362..d294257 100644
    --- a/README
    +++ b/README
    @@ -1 +1,2 @@
     hello
    +this is a readme

and here comes a paragraph in the log message that can be made more
understandable by having such a patch fragment.
