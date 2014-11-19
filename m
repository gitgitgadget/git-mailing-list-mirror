From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] [PATCH] remote: add new --fetch option for set-url
Date: Wed, 19 Nov 2014 12:29:47 -0800
Message-ID: <xmqq61ebrl1g.fsf@gitster.dls.corp.google.com>
References: <6997784.RuzRO1AFsK@al> <20141119190800.GB9908@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Peter Wu <peter@lekensteyn.nl>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 21:29:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrBsx-0005L3-86
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 21:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756447AbaKSU3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 15:29:51 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53429 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756063AbaKSU3u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 15:29:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 222401F50D;
	Wed, 19 Nov 2014 15:29:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+twc+BdoBqfKIGYTWMm9LrhzQ94=; b=n78akv
	nqt5NFvKU7X1ouasXMNOxtpmKN7iNkBFbJ0hhhx01y4zuc+UM/mjtP91om9fnna1
	dMyi6hZHJ19uY7QnaO9wegQZxrCQOzv2IAme4W4uykpJiGREGvufcqo6f6f3TXqj
	DfcT2W0aKJyDtCGUha7lCIKuhBwfoX8YeTmJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yhDXpQ6ThH37KKVswJr4IEM6aEWgGwfb
	LN+tPcfKMbC8oQ0NvGMc5rjH2lgBi2D0oi//ZlpWKrgite3JZNJtBmxb9yawboVI
	r6L/iyim/EMK1p1ucEKyiK3E2jUDluQKCJd9gy2fOyWxWXVKeyamVeCTsrMPDiaZ
	1m/ud+Tixzs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1227F1F50C;
	Wed, 19 Nov 2014 15:29:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A2F91F50A;
	Wed, 19 Nov 2014 15:29:49 -0500 (EST)
In-Reply-To: <20141119190800.GB9908@peff.net> (Jeff King's message of "Wed, 19
	Nov 2014 14:08:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CF19FD20-702A-11E4-BC6A-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I dunno. I guess that is more convenient, but it seems like a lot of
> code for a very marginal use case. But more importantly, I'm a little
> worried that the presence of --fetch creates confusion about what
> set-url without a --fetch or --push does. That is, it implies to me
> that:
>
>   git remote add gh old-url
>   git remote set-url gh --push push-url
>   git remote set-url gh new-url
>
> would replace both the "url" _and_ "pushurl" values in the third step,
> since we did not specify --fetch.  But it is in fact identical whether
> you run it with "--fetch" or not.  That is, it creates a weirdly
> non-orthogonal interface.

Yes, the semantics the updated code gives feel very strange.  I
wouldn't be able to write a three-line summary in the release notes
to advertise what good this new feature brings to users myself.
