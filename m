From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] patch-ids.c: cache patch IDs in a notes tree
Date: Sun, 12 May 2013 15:19:49 -0700
Message-ID: <7v1u9bvo1m.fsf@alter.siamese.dyndns.org>
References: <9d9e56d323b40fe9ea2a6484e35f0afcd3a3a85b.1368301939.git.john@keeping.me.uk>
	<CA+55aFyn0+Q4CA6yQZipaCRB0w9cW4YpuL3XuxU2JR5QPp98XQ@mail.gmail.com>
	<20130511214900.GF2299@serenity.lan>
	<CA+55aFzinmXA2HtA3hmN1VVOcLPWedfqJRws0RJMEc1By1VLLg@mail.gmail.com>
	<7v1u9cx5pf.fsf@alter.siamese.dyndns.org>
	<20130512085934.GG2299@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon May 13 00:20:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubecl-0002To-V7
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 00:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376Ab3ELWTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 18:19:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51080 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297Ab3ELWTv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 18:19:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D5AC1DE7A;
	Sun, 12 May 2013 22:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oU4p0dzt1ARToTJUtTM07zerS/s=; b=LFZL9b
	iDFxQCx6JQFIzoMxy0sMHjX+wJ3ou4EgQsVcVSfKHuK+yF6sChdZctsrZYqv1QqA
	P/78IBgmVGEaXRCBkUw3EvFefPC7Jo7KzW+7z2Fiwwg3E9iGEE6e+Cnfec/FwWcJ
	Ef5Hb7r7cF92dXOXZ0+mpF3fc2ry9gP87TJw8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xo9wi7XDN3qzvaSexIjHqBIkDWlMFlwk
	CVu5WyTiA90Hr0+PUaF9Jv1HGZpf+0ij1P00LKW1ow/mV1+rRKF1UqULA+WUlyfR
	sNY646qYcJ7hfDQdMMxKxfq7iknwRwT6Jod83ET+oo/YFOvOeEsmOq/rSoyS6E90
	hAlAAdd61oo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 234C51DE79;
	Sun, 12 May 2013 22:19:51 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B6B41DE78;
	Sun, 12 May 2013 22:19:50 +0000 (UTC)
In-Reply-To: <20130512085934.GG2299@serenity.lan> (John Keeping's message of
	"Sun, 12 May 2013 09:59:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 101AF9B2-BB52-11E2-AB32-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224065>

John Keeping <john@keeping.me.uk> writes:

>> But it is not a big problem.  Either 3-way merge notices that there
>> is nothing new, or you get a conflict and have chance to inspect
>> what is going on.
>
> It's not a problem here, but false negatives would be annoying if you're
> looking at "git log --cherry-mark".

The primary thing to notice is that it is not a new problem with or
without the caching layer.  As Linus mentioned how patch-ids are
computed by ignoring offsets and whitespaces, the filtering is done
as a crude approximation and false negatives are part of design, so
making the cache more complex by recording hash of the binary and/or
options used to compute misses the fundamental.
