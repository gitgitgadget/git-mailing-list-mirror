Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F2C22049B
	for <e@80x24.org>; Fri,  5 Aug 2016 16:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935016AbcHEQbf (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 12:31:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57295 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760029AbcHEQbf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 12:31:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 130EF2F34A;
	Fri,  5 Aug 2016 12:31:34 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z9pZfzwR4Gdpg+wukpHlVlOBjDg=; b=lowCJf
	ixy7+DBURdpIQ++W9XcAfhxcWBXYBalLPDnN1quBIsVk8l3MhLaaIGBL8MlhRuW7
	x6HoQef44r2oORMNmORBNjVyGIEkGrHucXJo5/XO2AqVU7IpC3JQF0Is/JsbKAnj
	uroSVCL50+ECIaTDSdJjiKhmCLqybpo8Sk7/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ErXltEnPqaOrO8sILw+3HaR0D2ELd9CY
	pwuYiD4Y40UX82mPp7FH2AUv+Z5ADIzH3gxCyij8RROFDlyW5kr+FS3bct5WUN+Z
	ocPjPalny146nlvJruMG+1ARWE9fttiykFle8xdEaNP40D7jRWfdXX+Kig4aZutE
	vRuE8k0vx7Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0324E2F347;
	Fri,  5 Aug 2016 12:31:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8415B2F346;
	Fri,  5 Aug 2016 12:31:33 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Jeff King <peff@peff.net>, git@vger.kernel.org, jnareb@gmail.com,
	tboegi@web.de, mlbright@gmail.com, e@80x24.org
Subject: Re: [PATCH v4 01/12] pkt-line: extract set_packet_header()
References: <20160729233801.82844-1-larsxschneider@gmail.com>
	<20160803164225.46355-1-larsxschneider@gmail.com>
	<20160803164225.46355-2-larsxschneider@gmail.com>
	<xmqqd1lp8v2o.fsf@gitster.mtv.corp.google.com>
	<20160803211221.t2zdhvwjum2baeqs@sigill.intra.peff.net>
	<xmqqeg645x6b.fsf@gitster.mtv.corp.google.com>
	<486BA59A-F53B-4893-AE37-8956FCDE7E22@gmail.com>
Date:	Fri, 05 Aug 2016 09:31:31 -0700
In-Reply-To: <486BA59A-F53B-4893-AE37-8956FCDE7E22@gmail.com> (Lars
	Schneider's message of "Fri, 5 Aug 2016 16:55:16 +0200")
Message-ID: <xmqqh9azxjmk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 125BE670-5B2A-11E6-9A67-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> However, besides the bogus performance argument I introduced that function
> to allow packet writs to fail using the `gentle` parameter:
> http://public-inbox.org/git/D116610C-F33A-43DA-A49D-0B33958822E5%40gmail.com/
>
> Would you be OK if I introduce packet_write_gently() that returns `0` if the
> write was OK and `-1` if it failed?

Yes, I agree with you that it would be a good thing to have a
_gently() variant that lets the caller deal with possible error
conditions itself instead of dying.

Thanks.
