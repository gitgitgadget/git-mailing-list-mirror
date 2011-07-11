From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] add object-cache infrastructure
Date: Mon, 11 Jul 2011 12:17:56 -0700
Message-ID: <7vliw4d1hu.fsf@alter.siamese.dyndns.org>
References: <20110711161332.GA10057@sigill.intra.peff.net>
 <20110711161754.GB10418@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Clemens Buchacher <drizzd@aon.at>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 11 22:08:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgMmL-0005Mb-Je
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 22:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368Ab1GKUIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 16:08:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45541 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512Ab1GKUIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 16:08:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EBBDB626E;
	Mon, 11 Jul 2011 16:08:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=HeTSgQeUJOgF5JqyyU1R28RHGsg=; b=IoDb+T4EhtsAAmFU2moy
	yX9atokYzkuSIM3ZuHamkGKUw6pKunHGSeGOd0ZPom/a884vtfpRqYYFIctn+5Gn
	Rb05HA/PS92krEOUv3E8PlZg4WkUlkb+RqKOAa6Tykw6oVukedMi0IlqER27z7ph
	vJmQwqIOdm65lKVvNcc2VVY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=u7EjcUCO/zdLif5aZEUd1r7n+kwOJZuEbIrlDfnAyZQ+cw
	oY8CJqHnoGqQjsKzT3wg+hlqLsWCqmxcNO1Ko0KhiWnMXrJsnykBvJLCfS/usNdI
	MzRhOv6+OmcssJ9P5OgtOUDvbDJxzx0/bfCZUAkIyLNPPG3/GBav/dREZ3gyw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D10D3626D;
	Mon, 11 Jul 2011 16:08:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1BC04626C; Mon, 11 Jul 2011
 16:08:15 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82DA6538-ABF9-11E0-9FA4-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176890>

Jeff King <peff@peff.net> writes:

> As I mentioned earlier, I wanted this to be generic and size-agnostic,
> because I'd also like to try caching patch-ids for git-cherry.

Sounds like a good thing to aim for, but "Object Cache" sounded too much
like giving access to the object data that is faster than either loose or
packed objects.

This is a completely unrelated tangent but because you brought up
patch-ids ;-), the other day I tried to rebase mm patches on top of
updated linux-next while trying to help Andrew, and noticed that in real
life, many "duplicate" patches you find in updated upstream are "slightly
reworded better" and "rebase --skip" is often the right thing to do, but
it is often very difficult to diagnose, as (1) the patch you are trying to
apply from your old series may be part of a long patch series, and (2) the
commit you are trying to re-apply the said patch to, i.e. the updated
upstream, may already contain many of these semi-duplicate patches. The
conflict resulting from "am -3" in such a situation is not very pleasant
to look at (it looks mostly as if you are reverting the effect of updated
versions of later patches in your series).
