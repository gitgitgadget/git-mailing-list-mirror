Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E755D1FF40
	for <e@80x24.org>; Mon, 20 Jun 2016 16:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747AbcFTQBP (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 12:01:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53726 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753708AbcFTP7x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 11:59:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EADC424AC2;
	Mon, 20 Jun 2016 11:53:18 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QOQGnWZpnvE6e/p8DZfuYQ8dZmg=; b=AK8yfx
	KvKKupLFNK7cP7DAwbL/+/n4iEHNgKHsBtk3wF3JUBo0v+T4kwxgCDkem53rv+hi
	OKlUIbMc1nYcnT8Nry0RJMEVRBW4qJ8bP01aPeiLUrmMZmsxqNt5Cw2LWut1HRWZ
	+eCQ5qhv/RbSxZqduXhSUgnO7X6SzwnYOF5Ts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=odVrXjZwFaKZujcsnTngKZCROPYVzLc7
	WLBGruZNv+itNaF+ZowzV+yUJ8zqT9oNl8QFfmCpQl9k18GW/jcqjKFQ+ZBTqjC3
	7MaKuqvfh7uX/unkI99XR3HdO7Z3zHhe+bYB5Wf+15AHU5+0ap7evpCRtmg1aQNO
	tf8OTVXRBxs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CCF9F24AC1;
	Mon, 20 Jun 2016 11:53:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 41C1D24AC0;
	Mon, 20 Jun 2016 11:53:18 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 0/8] object_id part 4
References: <20160618221407.1046188-1-sandals@crustytoothpaste.net>
	<57665CC6.6070208@kdbg.org>
	<20160619092448.GA12221@sigill.intra.peff.net>
	<alpine.DEB.2.20.1606200853580.22630@virtualbox>
	<20160620100522.GB14058@sigill.intra.peff.net>
Date:	Mon, 20 Jun 2016 08:53:16 -0700
In-Reply-To: <20160620100522.GB14058@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 20 Jun 2016 06:05:23 -0400")
Message-ID: <xmqq8txzvour.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B3B9564-36FF-11E6-B5ED-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I am on the fence regarding oidcpy/oidclr. I agree they _could_ be
> struct assignments, but it is also convenient to have concept wrapped up
> in a function, in case we ever want to do anything more complicated.

Also dedicated functions have documenation value.  There are some
things that currently use the same 40-hex that is the result of
running SHA-1 but are not object names (e.g.  patch id, and rerere
id).  They use the same hashcpy()/hashcmp() helpers as object names
do, but the code that use them probably do not want to be converted
to struct oid and oidcpy().

