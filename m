From: Junio C Hamano <gitster@pobox.com>
Subject: Re: libcurl dependency for implementing RFC3161 timestamps
Date: Wed, 09 Mar 2016 10:53:51 -0800
Message-ID: <xmqq7fhbiitc.fsf@gitster.mtv.corp.google.com>
References: <e57d18f6010c0b581b38a3daef145221.squirrel@faumail.uni-erlangen.de>
	<59de05c280143e7dd3ead6139df7a525.squirrel@faumail.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, i4passt@cs.fau.de, phillip.raffeck@fau.de
To: "Anton Wuerfel" <anton.wuerfel@fau.de>
X-From: git-owner@vger.kernel.org Wed Mar 09 19:54:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adjF9-0003YI-4t
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 19:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933882AbcCISxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 13:53:55 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60730 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933868AbcCISxy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 13:53:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 33C154BB66;
	Wed,  9 Mar 2016 13:53:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dm9wInhUFIrrYoQ63uyxRbcLOl8=; b=CKGYWO
	WApPCL5YyXKsL5JYpC+OpuDnSgBO/qHCT8c1Qm0wxD+H5tg98oOYsaUdv4GH1vT8
	x06t3gL2bbsHkqAOpV+O0+ZmawCKlWYn32WTqbMsUFLEKsmn6umi0+MsgbspA690
	jkUIzO3r1au6ZzyHOVh07JrAa3bfENACrdKKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=piM+QYg4I1bQ8nSjx9b2Y8utQw+F+hC1
	HXe0J+uf4UDfho84YOrpfabLn/cY9UrUKq781WzJ4gBHEZm/+Ro3sFepMM+sxB1N
	GLfch4S4/CUm9yGR+TD+9JjSA1stomGDvt3EII4NVcj0g1234YNF4P/8PwEAiZgw
	6tqaiN61NGU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2AD154BB65;
	Wed,  9 Mar 2016 13:53:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9EF2E4BB64;
	Wed,  9 Mar 2016 13:53:52 -0500 (EST)
In-Reply-To: <59de05c280143e7dd3ead6139df7a525.squirrel@faumail.uni-erlangen.de>
	(Anton Wuerfel's message of "Wed, 9 Mar 2016 12:24:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 447AE808-E628-11E5-9AD8-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288568>

"Anton Wuerfel" <anton.wuerfel@fau.de> writes:

> Is there any best-practice how to introduce this libcurl dependency? There
> are several options:
>
> -As git tag is a builtin part of the main git executable, introduce a
> libcurl dependency for the main executable (maybe not best-practice).
>
> -Move git tag to a separate git-tag binary and introduce a libcurl
> dependency to this new submodule.
>
> -Create an own submodule like git-http-timestamp with a libcurl dependency
> and call it from git tag and from other places where timestamp signatures
> are needed.

If this were to become part of the official Git distribution, I
think the last one would be the most realistic approach.

In fact, just like the way that Git does not care how GPG implements
its crypto, manages the chain of trust, and any other details, I
think the best way to integrate it would be to write your own RFC3161
program that can be invoked just like we invoke GPG, and drive it
via an interface like we drive GPG via gpg-interface.[ch], since Git
shouldn't even care where your timestamp is coming from and over
what transport.
