From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag: do not show ambiguous tag names as "tags/foo"
Date: Sun, 24 Jan 2016 18:26:50 -0800
Message-ID: <xmqqsi1m9yxh.fsf@gitster.mtv.corp.google.com>
References: <CAAB=nN=RSQuDPdg6Y2heeBXpQVdWSwFAcDDTfxE=XRSOu5gGEg@mail.gmail.com>
	<20160124071234.GA24084@sigill.intra.peff.net>
	<20160124071815.GB24084@sigill.intra.peff.net>
	<xmqqvb6iboxj.fsf@gitster.mtv.corp.google.com>
	<20160124222736.GA29115@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Pete Harlan <pgit@tento.net>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 25 03:26:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNWrr-0007mt-9X
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 03:26:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754487AbcAYC0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 21:26:54 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50843 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753892AbcAYC0x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 21:26:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 782333F6ED;
	Sun, 24 Jan 2016 21:26:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GYH25H5ToJjJN+6UAhpxojVR1P8=; b=qSqjqQ
	7+YFR2UMYB1R6d8AmdqBk/EE9bNYnoc9dbUMQJxsGyBr3/CBB68YAZ+dJ8EtDErx
	7tQSyG5CJiLgFJ41qCe0p7v8vNw46e2n/139aUfuQapFwtSsh/8V1mG3uCgSO2Jr
	zOg2DtjAKYuuqZxroX+A1kxw78C3HFnusis/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=koFkY3yvgdnweyQGJ63uW7xhZ19/5cVv
	YC0z6x94C40/4vCgC+Fcb/4olLyv/Tzwle4vpt01A8IJfgVc3fCKpkubv+uyWVGS
	Nt67S/a5xIh6SEvqgT3pQHJ9ySqs5emsqdHZXyVuKYKtCOQdoRwdmp313IO5tY64
	sbTdR09v8P0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6F8173F6EC;
	Sun, 24 Jan 2016 21:26:52 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E9EB43F6EB;
	Sun, 24 Jan 2016 21:26:51 -0500 (EST)
In-Reply-To: <20160124222736.GA29115@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 24 Jan 2016 17:27:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1804F0CE-C30B-11E5-BDF0-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284714>

Jeff King <peff@peff.net> writes:

> Yeah, "strip=2" would also get the job done, and extends more naturally
> to the branch case.
>
> To be honest, I cannot imagine anybody using anything _but_ strip=2...

I 100% agree, and I do consider this to be internal implementation
detail for the listing modes of "tag" (and "branch"), which may be
exposed to the user (by documenting that %(refname:X) is used by
default), so perhaps even the flexibility of strip=2 is unwanted.

I know what "remove-standard-prefix" is way too long for the value
of X above, but then we can say "the command will error out if you
allow your for-each-ref invocation to step outside of the area that
has standard prefix to be removed." without having to worry about
"what is the sensible thing to do when the prefixes are not what we
expect (too short for strip=2 or no match for short=refs/tags/)".
