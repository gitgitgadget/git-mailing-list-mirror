From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/2] Correctly handle transient files in shared repositories
Date: Mon, 11 Jan 2016 13:54:05 -0800
Message-ID: <xmqq1t9nwznm.fsf@gitster.mtv.corp.google.com>
References: <cover.1452085713.git.johannes.schindelin@gmx.de>
	<cover.1452537321.git.johannes.schindelin@gmx.de>
	<xmqqa8obx1ll.fsf@gitster.mtv.corp.google.com>
	<xmqq60yzx14w.fsf@gitster.mtv.corp.google.com>
	<20160111213801.GB21131@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Yaroslav Halchenko <yoh@onerussian.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 11 22:54:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIkPl-0005U8-Vc
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 22:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759682AbcAKVyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 16:54:09 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65297 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753760AbcAKVyH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 16:54:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ECBAF3A8C0;
	Mon, 11 Jan 2016 16:54:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BSkEbiD9e24voDQYfUNw78KN1ms=; b=fPgo0z
	tedgyE3f3xfq0DjLcPtJjKfxBoJRbaK4pwOhLbG8gRKkRvTITBTU+1bO9K0zCslq
	2snQ0luoN5FSF3vvjKZjLxW25bPvhD2KU4uCMsIZ8U3tLtSugETKChtXm5Babf15
	oy65mZ4Q+F1v/NwtguS5HJ3iSD459Fwsu9ND8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cfb9l7aU+LVDHsDoUmSpbaTqAqaD1WKU
	Y9p95tDrubz1RBgAvui9dnn5g9j+y/cRCJiK+GPXMRmfjBkbkLAkqpbG8CBgczct
	zEFQMRcvaQv7XQx2YjhQ88Nh/1pmdLuBmYfboab+w8/npoJepyXrNxNl42csn/5/
	J1fJL4RwIVs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E4AE03A8BE;
	Mon, 11 Jan 2016 16:54:06 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 650463A8BD;
	Mon, 11 Jan 2016 16:54:06 -0500 (EST)
In-Reply-To: <20160111213801.GB21131@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 11 Jan 2016 16:38:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D606CF7E-B8AD-11E5-8AFC-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283728>

Jeff King <peff@peff.net> writes:

> I'm not sure I buy this argument. Yes, you should not be writing
> anything else, but that does not change the fact that "fsck" will
> unceremoniously abort:
> ...
> So I think this would be a reasonable candidate (or alternatively, to
> treat EPERM on an existing file as a soft error). I am totally fine not
> to address it as part of this series, though.

Yeah, that crossed my mind (and I agree with the conclusion).

Listing what is left deliberately and why is still a good idea, as
that would force people to think twice before wasting effort to
convert blindly without thinking.  Listing what is left behind like
"git fsck" that we know we shouldn't leave behind is even better to
mark low-hanging fruits.  How do you like this one instead?

     - git fsck, when writing lost&found blobs (this probably should
       be changed, but left as a low-hanging fruit for future
       contributors).
