From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote: allow "-t" with fetch mirrors
Date: Thu, 26 May 2011 10:08:48 -0700
Message-ID: <7vk4ddxucf.fsf@alter.siamese.dyndns.org>
References: <20110526151100.GA2881@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jimmie WESTER <jimmie.wester@stericsson.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 26 19:09:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPe3V-0003dJ-5H
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 19:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757672Ab1EZRI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 13:08:59 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51962 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756933Ab1EZRI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 13:08:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0516B53AE;
	Thu, 26 May 2011 13:11:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YW+A42rf7Z5LnGICudG7dF65yGs=; b=arYpMT
	e0DhwgGI9rAXZJQraJiLMh3I4+/INGBB2S8FAWALvUVNgargAZ0Y5g79Xys7wwq1
	hvpChZP6DFFl5TBU7xrANajSfgBV795gfBrQnUGzxUvYJyc0IspsVXPqaE3RSKZS
	iWvKVJkj6VKbfnG2lFZaKm04HLWSAScRxvab8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KqX5WtBw8Mfn7zW4k3/y6hSkG5Ve69Tc
	tywXVY7FMxfzVKhY9tfW+iV+CuffQceHSjLDEGFRDbQkp/uQVAczXpBhNMj6b5zz
	ntl9mlG9c+djgPzodrJjGifLm85lhHOgSTjhLS2VK38cr0eVlM2a0drsOIzmJLYl
	8ywe7sJdV9Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 689B153AC;
	Thu, 26 May 2011 13:11:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 22BDD53A7; Thu, 26 May 2011
 13:10:56 -0400 (EDT)
In-Reply-To: <20110526151100.GA2881@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 26 May 2011 11:11:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2196C8E6-87BB-11E0-81E8-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174549>

Jeff King <peff@peff.net> writes:

> Commit 13fc2c1 (remote: disallow some nonsensical option
> combinations, 2011-03-30) made it impossible to use "remote
> add -t foo --mirror". The argument was that specifying
> specific branches is useless because:
>
>   1. Push mirrors do not want a refspec at all.
>
>   2. The point of fetch mirroring is to use a broad refspec
>      like "refs/*", but using "-t" overrides that.
>
> Point (1) is valid; "-t" with push mirrors is useless. But
> point (2) ignored another side effect of using --mirror: it
> fetches the refs directly into the refs/ namespace as they
> are found upstream, instead of placing them in a
> separate-remote layout.

Hmmm, I still fail to see the point of ignoring "mirror" aspect and
constricting that with -t.

> So 13fc2c1 was overly constrictive, and disallowed
> reasonable specific-branch mirroring, like:
>
>   git remote add -t heads/foo -t heads/bar --mirror=fetch

I mildly disagree that it is "reasonable".  I would understand if it were
something like this:

  git remote add -t heads/foo:heads/foo -t heads/bar:heads/bar

I am not saying selective copying is bad or useless.  It would be useful
in some situations.  I am saying that is not a mirror, and reusing the
same --mirror option for a different meaning may introduce confusion.
