From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 4/6] transport: add refspec list parameters to functions
Date: Wed, 27 Apr 2016 08:07:53 -0700
Message-ID: <xmqqmvofay46.fsf@gitster.mtv.corp.google.com>
References: <20160419071403.GA22577@sigill.intra.peff.net>
	<1461102001.5540.125.camel@twopensource.com>
	<20160419232243.GF18255@sigill.intra.peff.net>
	<1461109391.5540.138.camel@twopensource.com>
	<20160420011740.GA29839@sigill.intra.peff.net>
	<1461185215.5540.180.camel@twopensource.com>
	<20160420205726.GA17876@sigill.intra.peff.net>
	<1461602647.25914.2.camel@twopensource.com>
	<CAGZ79kYc+uMCJq5tTHujp1YYG5OcNSPiyWuGvVzipuBcwtLNYA@mail.gmail.com>
	<CAGZ79kYGi9bhRfGype7te4cGkxvnKww269kYoykB+76HNnTarg@mail.gmail.com>
	<20160427041138.GA22920@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	David Turner <dturner@twopensource.com>,
	Shawn Pearce <spearce@spearce.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 27 17:08:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avR4Y-0005Rx-1h
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 17:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035AbcD0PIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 11:08:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60417 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752632AbcD0PH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 11:07:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 247F814BB0;
	Wed, 27 Apr 2016 11:07:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OqcjAkOa+tK9ImLax9g00BpPy+s=; b=haVh+F
	R+E13w5VNsRUTEDqwf98i5KfNBQVhPri7rPV6CkhaYizY7W4QIDYniBenENS4IF7
	pnKyyNrVlGT+Q+6PouZhOvC0tFAdKndbaDIJM3rq2PjkRiu9R1j6uMljq+owNGBj
	zOB59AyjkzbbUJ+5TYdaN7huirLWo9VH/UoBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TEPFZENPOaWqystds5JrJKd+4E6yCIVV
	pDksh/Vm5F8gEbi54hx21bD+YBql/P49NuJMc5gtZQ3hYwyDRcEMAvCsIPJFXrML
	477SMhPyQakePoW2zfXZDv985HICCKg85nr1StLhDjyMuaeY5eRGC9X7xW9u6HWc
	uaqbTBmTufY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B9D714BAF;
	Wed, 27 Apr 2016 11:07:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7E74214BAE;
	Wed, 27 Apr 2016 11:07:54 -0400 (EDT)
In-Reply-To: <20160427041138.GA22920@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 27 Apr 2016 00:11:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D1717A7E-0C89-11E6-B4EB-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292728>

Jeff King <peff@peff.net> writes:

> If the plan is something like:
>
>   1. v2 exists, but client/server don't know when they should use it.
>
>   2. smart-http grows an extra parameter for the client to say "hey, I
>      know v2"
>
>   3. Other protocols get some manual v2 support (e.g., client asks for
>      "upload-pack2" if instructed by the user, server either speaks v2
>      then or says "eh, what?").
>
> I like that very much. It lets us "cheat" on the hard part of the
> problem for http, which is what David's series is doing, but it provides
> a clear path forward for the protocols eventually reaching feature
> parity (namely that eventually all servers speak v2, and the client can
> start asking for v2 by default).

Yup, thanks for clearly writing it down. I like the above very much,
too.
