From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] dir.c::match_basename(): pay attention to the length
 of string parameters
Date: Thu, 28 Mar 2013 22:57:29 -0700
Message-ID: <7vy5d6px2u.fsf@alter.siamese.dyndns.org>
References: <20130328214358.GA10685@sigill.intra.peff.net>
 <20130328214728.GB10936@sigill.intra.peff.net>
 <CACsJy8CcTqkPeOZ7Xa=7J4BH4sSFD6X6hKjrLz3kf0J0E_J+cw@mail.gmail.com>
 <20130329030217.GA1851@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
	avila.jn@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 29 06:58:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULSKR-0003JW-E0
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 06:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632Ab3C2F5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 01:57:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44313 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754589Ab3C2F5b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 01:57:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 536B7E30D;
	Fri, 29 Mar 2013 05:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=94ktjEnNVnb++2ta+BLPr/8p16c=; b=pXZ6oX
	bfPSC4Omlm7mJHBMeDHTqPw3KFblCbCadDXnAZZD0zCLOon3B40aC4ba45N+0WeR
	bcq1crBCG5a88Sbhk6mgBZB1yWLtRFgMoZOwdan23xI9nujSnVbZ3rF7hJeC05hf
	Nasbz6CzqbnmCsuQ/OpUZsEEKbuaDDunblONY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a8Bd4jxzrUrWAGjMCha7hV2t60lWmwLi
	F7o29ZAi3pRq4FRsethyTnbnTDlIp9TgkXaFAnxFTOe0tlYiVvJs96eErlJZSLf6
	EE2ou+NvKAjqVujP8rZHNQ9ZEuznbShAbrBfHxi/Lsddwk9t08qn5vKvGxana8h+
	FLLDgmRf30Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46320E30C;
	Fri, 29 Mar 2013 05:57:31 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ACACDE30A; Fri, 29 Mar 2013
 05:57:30 +0000 (UTC)
In-Reply-To: <20130329030217.GA1851@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 28 Mar 2013 23:02:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8AFF0D52-9835-11E2-A8ED-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219485>

Jeff King <peff@peff.net> writes:

> Eek, yeah, that's obviously wrong. Thanks for catching it. Fixing that
> clears up all of the test failures outside of t5002.
>
> And if you move patch 5 ("special case paths that end with a slash")
> into position 2, it cleans up the mid-series failures of t5002, making
> the series clean for later bisecting.

Yeah, the tip becomes test-clean with that "flags" change, but it
appears that there seems to be some mismerge (there is another topic
or two in flight that want to touch dir.c for pathspecs) that breaks
0003 and 3001 when merged to 'pu'.

Duy, can you take another look?
