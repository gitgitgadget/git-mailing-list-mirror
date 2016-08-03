Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C1691F858
	for <e@80x24.org>; Wed,  3 Aug 2016 17:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754438AbcHCRpr (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 13:45:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64030 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754314AbcHCRpo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 13:45:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 49EF530507;
	Wed,  3 Aug 2016 13:45:43 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2ZAdQpJoJ9J7yJS9NyMCrSyrkqU=; b=fESUWG
	2izrBTY80eUGCorI8D5JY+3heBUwfuqQIZ0cTw2drXpjwW9jdsy7Amd5YFy7P8md
	dpnpBQvqbYSniJnv+aKPHShM0QEPtZxWlwz4UQjVpkKGfEYMRvDuXfsLORFD/Nmn
	GAW981Nm3ATz37toQqLU7B08eFQj/vC72RnB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HVDaREr2LNIc591JBUdY6YmcJnv0a3XG
	gGSeQjMA0QQqb7SqCoAzp2fVpV2PXaQp8CcDEQPkTjjnqrLeau8UWxD48dTg2Jgj
	2DcP6pDDZgf1tllZZv7QYijWSksKX/JqJtRJBfwswmSYWKbYn85OqjPWAlW89Hya
	+OXOEs8Z6pI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 403A130506;
	Wed,  3 Aug 2016 13:45:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BCFC030505;
	Wed,  3 Aug 2016 13:45:42 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	larsxschneider@gmail.com
Cc:	git@vger.kernel.org, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net
Subject: Re: [PATCH v4 11/12] convert: add filter.<driver>.process option
References: <20160729233801.82844-1-larsxschneider@gmail.com>
	<20160803164225.46355-1-larsxschneider@gmail.com>
	<20160803164225.46355-12-larsxschneider@gmail.com>
Date:	Wed, 03 Aug 2016 10:45:40 -0700
In-Reply-To: <20160803164225.46355-12-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Wed, 3 Aug 2016 18:42:24
	+0200")
Message-ID: <xmqqtwf19263.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 197BB70C-59A2-11E6-A548-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

larsxschneider@gmail.com writes:

> packet:          git< git-filter-protocol\n
> packet:          git< version=2\n
> packet:          git< capabilities=clean smudge\n

During the discussion on the future of pack-protocol, it was pointed
out that having to shove all capabilities on a single line/packet
was one of the things we would want to fix in the current protocol
when we revamp to v2.  As this exhange between the convert machinery
and an external process is a brand new one, I do not think you want
to mimic the limitation in the current pack protocol like this; the
limitation mostly came from the constraint that we cannot break
existing pack protocol clients and servers before we extended the
protocol to add capabilities.

You may not foresee that the caps won't grow very long beyond
clean/smudge right now, just like we did not foresee that we would
wish to be able to convey a lot longer capability values to the
other side when we added the capability exchange to the pack
protocol, so "but but but we will never have that many" is not a
good counter-argument.

