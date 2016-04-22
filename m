From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] name-rev: include taggerdate in considering the best name
Date: Fri, 22 Apr 2016 11:27:28 -0700
Message-ID: <xmqqeg9xpkhb.fsf@gitster.mtv.corp.google.com>
References: <d58135a6720d6fda4c7bc609e77e2709d161fe25.1461332260.git.johannes.schindelin@gmx.de>
	<20160422181103.GA5920@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Olaf Hering <olaf@aepfle.de>,
	Uwe =?utf-8?Q?Kl?= =?utf-8?Q?eine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 22 20:27:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atfnk-0003ZR-P9
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 20:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348AbcDVS1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 14:27:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59799 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752490AbcDVS1b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 14:27:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1241613B31;
	Fri, 22 Apr 2016 14:27:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i0PmZ2kEiIMHfPdvcXzjlj7sUFM=; b=bAPBwy
	R0d9+E4IqrAwMOw0C0ZQcC3FJVNrrq0XnArIV1ut8ANqzzWlNjDK1Y8QrcrZooIK
	ugD43oYDGToqiG/ClT7vwjQy/QtPZSZvU+qpc5dYXhhuxnGgE/tR+XW/vZ1QORR5
	Jb7p5ZXj8aRaOF5F6ZZKrqre+Fr/LtAWc7sN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ENNNfjvLLIkIhD2hluE7BKheLbl41OnF
	GhasA8hssQdc+7AtcriQqSakyjD2Nfgn/GeIxgihT1CfgdBNY6Eivy6xi9YZ4g+R
	jUuHAobZBpdI9ACwuRG56GVYYxkp2Rd38M3p4fFtXOPEKydam41++ZG5XCuBkD/I
	+YX3Sf+EWO0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0825913B2F;
	Fri, 22 Apr 2016 14:27:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5EC0213B2D;
	Fri, 22 Apr 2016 14:27:29 -0400 (EDT)
In-Reply-To: <20160422181103.GA5920@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 22 Apr 2016 14:11:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DEFF1546-08B7-11E6-B2D3-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292239>

Jeff King <peff@peff.net> writes:

> That turned out to be quite simple (I wasn't sure originally if we'd
> actually visit all of the tags, which is why I had conceived of this as
> an initial pass; but of course it makes sense that we'd have to see all
> of the tags in the existing code).
> ...
> We could _also_ tweak the merge-weight as Linus's patch did, just
> because 10000 has more basis than 65535. But I think it really matters a
> lot less at this point.

I agree, but if we were to go this route of keeping track of "some"
attribute of the tip the traversal started from, I wonder if it is
better to keep the actual tag object, not just its tagger date as an
unsigned long, in the new field.

That way, a tweak may be able to even use the v:refname comparison
if we wanted to do so in the future.  It is easy to go from a tag
object to its tagger date, but it is impossible to go in the other
direction, i.e. given a tagger date to go back to the tag.
