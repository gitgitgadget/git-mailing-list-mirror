From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git apply --check" successes but git am says "does not match
 index"
Date: Mon, 15 Aug 2011 16:52:55 -0700
Message-ID: <7vhb5ijkq0.fsf@alter.siamese.dyndns.org>
References: <loom.20110814T113311-277@post.gmane.org>
 <20110815232318.GA4699@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zemacsh <ruini.xue@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 16 01:53:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qt6xu-0003qd-Ix
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 01:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684Ab1HOXw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Aug 2011 19:52:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48963 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752551Ab1HOXw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 19:52:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 322074A53;
	Mon, 15 Aug 2011 19:52:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3o2gLm3kKKKCi7zR4bDdh0iQQsw=; b=JvtE5W
	QACRcPqapLkhk/8j/AehCzcPBXsJ/9o1qBHyB9RP4Drjqx1ZfD4pszsTKXS0OPFS
	NJM9vpdW6jutQ2ss40+Mn4V8RfJJcu/HU6K++MvjKLu2ERAL4UB/ICcLz9ihRGzP
	LlMif0C/ta14z7EXuDgsyLU7Gif0n/3GsERV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G7I4T7bJNZl0mDXdwyQfYa80uE3+iYaN
	csfWULUaJbi6aZBUWYqOGVPR7+7mfpnNJ/OAJR6QmuFYuwhalheif8L0JSWMGiwy
	1NNeJ+n1m+ERmDWD0UUyzOdk3Fzl8KJmI3AYEED9oF1F9ENiynje5E/jYrqOg4Oe
	HAAi4zPND3E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 299FA4A52;
	Mon, 15 Aug 2011 19:52:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B383B4A51; Mon, 15 Aug 2011
 19:52:56 -0400 (EDT)
In-Reply-To: <20110815232318.GA4699@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 15 Aug 2011 16:23:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B2F54538-C799-11E0-88B3-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179397>

Jeff King <peff@peff.net> writes:

> We should perhaps call "update-index --refresh" at the start to avoid
> these sorts of false positives. Probably it should happen whenever we
> "git am --continue", as well. But for efficiency reasons, not between
> each patch.
>
> I dunno. Do people want to call "git am" in a tight loop, where the
> index refresh would be a problem? I would think they should instead feed
> a whole mbox in one go.

I am kind of surprised that we have not done the 'refresh once upfront'
already and nobody ever run into this for the past 5 years. It seems that
I inherited that behaviour from git-applymbox ;-)

It is sensible to refresh once at the beginning and also when restarting
with "am --resolved".
