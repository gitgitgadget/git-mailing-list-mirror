From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-note -C changes commit type?
Date: Tue, 11 Feb 2014 16:06:46 -0800
Message-ID: <xmqqvbwlnqi1.fsf@gitster.dls.corp.google.com>
References: <1392139407.12790.7.camel@kirk>
	<CALKQrgcM7JpZCk4amjo_rwg5uuuWNg-5yd1NXB5p7EtrU9WBGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joachim Breitner <mail@joachim-breitner.de>,
	Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Feb 12 01:06:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDNLr-0007Vq-63
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 01:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbaBLAGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Feb 2014 19:06:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54433 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751435AbaBLAGu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 19:06:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C52C06CCA9;
	Tue, 11 Feb 2014 19:06:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZKgzTWa8ohbvnNvWCtPy35P1eUc=; b=DdA8fp
	se6ZX10uTyt3G3aADdZcjD60dt2Fdx0OANKOuzSbu6xWPR1RQ0jVnPrB7nzMU9/A
	yePEc/0FTIZncCnRqArqJAG1E5M/4Gx3JdGBK8DE+CU6sWytp8nONAt9YGBKECrX
	t0M4GUnvHyDNP3FB52aT1m0Ws5uvj6nwKrG+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iLooWmHA6pFTjtI/e5fq5lwA9Wm2PH9C
	0STOrHL73Y215x9FEH7J4k0Ht0Lz/yLaDYG92NZz8v5uNp0xQ16k+G+/JL1prHdJ
	SojA1XUHmVlrlpysRxiejExSkLVjBD2UlMkWPCEinhhslKvmrd1TfxBIUVpc4z3M
	4VnFRcTOv6A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB0CF6CCA8;
	Tue, 11 Feb 2014 19:06:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EE9F86CC9A;
	Tue, 11 Feb 2014 19:06:48 -0500 (EST)
In-Reply-To: <CALKQrgcM7JpZCk4amjo_rwg5uuuWNg-5yd1NXB5p7EtrU9WBGg@mail.gmail.com>
	(Johan Herland's message of "Wed, 12 Feb 2014 00:52:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 91558718-9379-11E3-B064-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241964>

Johan Herland <johan@herland.net> writes:

> There is currently no way the "git notes" commands will allow you to
> store the 3d7de37 commit object directly as a note. There is also
> (AFAICS) no easy workaround (git fast-import could've been a
> workaround if it did not already require the first N/notemodify
> argument to be a blob object). The best alternative, off the top of my
> head, would be to write your own program using the notes.h API to
> manipulate the notes tree directly (or - suboptimally - use other
> low-level Git operations to do the same).

Even worse. I do not think such a non-blob object in the notes tree
does not participate in the reachability at all, so you won't be
able to fetch "refs/notes/whatever" and expect to get a useful
result.  I do not think storing the raw bits of commit object as a
blob in the notes tree is useful behaviour, either.  The command
probably should refuse to get anything non-blob via that option.

Perhaps the notes entry should just note the object name of whatever
commit it wants to refer to in a *blob*?
