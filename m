From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Some issues when trying to set up a shallow git mirror server
Date: Wed, 13 Jan 2016 09:14:10 -0800
Message-ID: <xmqqlh7tpfkt.fsf@gitster.mtv.corp.google.com>
References: <20160107165417.GB3397@logi.codethink.co.uk>
	<xmqq4mep5kyg.fsf@gitster.mtv.corp.google.com>
	<xmqqd1tb21oh.fsf@gitster.mtv.corp.google.com>
	<20160111155153.GE3397@logi.codethink.co.uk>
	<xmqqy4butzw8.fsf@gitster.mtv.corp.google.com>
	<20160113113743.GF3397@logi.codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Richard Maw <richard.maw@codethink.co.uk>
X-From: git-owner@vger.kernel.org Wed Jan 13 18:14:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJOzy-0000tF-8d
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 18:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755024AbcAMROO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 12:14:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55978 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753712AbcAMROM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 12:14:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3A52F3A6AC;
	Wed, 13 Jan 2016 12:14:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xXk1LpH9t5YKOOcYsV31YpAWuvE=; b=ehQ2WU
	K6pTe4I/6CrncLslX7m1Yos+FNAxfs97LIgT6qCRD6GzKlkXmfdPzHY78zN4NmTx
	WqtYssLsAmJNVYnl1rPUi22ymiDRQH7FG1iFPZmul28tZcWDkggl/rUPjz+b5PRw
	gi86lq5Z3Js+AEyZAmBNDGiuX8SCSNfzmH5Ys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c+qKYggzquWUugbE8T/6oOU2yQ+lb/1I
	vxhEOWp5OzOvR4bsTDNcm/8PqcUO7jZqLtCmCBrGDk7aFNnRl6VchEGAF6j05hUz
	h0dmeD5L5bs+FxtH9FxBnp9tJnL0G7hknSeoAcN0JU8oR5TrvN3ZOJj+YpBuR2Mx
	eFIAA+NfYII=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 323673A6AB;
	Wed, 13 Jan 2016 12:14:12 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9D1773A6AA;
	Wed, 13 Jan 2016 12:14:11 -0500 (EST)
In-Reply-To: <20160113113743.GF3397@logi.codethink.co.uk> (Richard Maw's
	message of "Wed, 13 Jan 2016 11:37:43 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 10638CE0-BA19-11E5-80E4-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283943>

Richard Maw <richard.maw@codethink.co.uk> writes:

> 1.  Before any "want" requests.
>
>     This would also let you extend ls-remote to let it display ancestry.
>
>     This is complicated by the fact that normally the client responds
>     with which features it supports in the first "want",
>     so the sender would have to support "check-ff N O <FEATURES>"
>     if it advertised "ancestry-check".

Yes, that sounds like a good thing.  Actually, ls-remote is a
degenerated case of fetch that sends 0 "want" requests, so the above
may be identical to what I suggested in the message you are
responding to.

> 2.  After the pack is transferred.

I do not think the protocol is structured to allow you to do this
easily.  The reading side is expected to read thru til the end of
the stream, not stopping at the end of the packdata, IIRC.
