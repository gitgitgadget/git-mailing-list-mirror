Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C498E2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 22:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S969056AbcHEWGh (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 18:06:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55084 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030575AbcHEWGd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2016 18:06:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9926C323E9;
	Fri,  5 Aug 2016 18:06:31 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WetUK3LFpekt
	1IkNkmDvAdVvR1M=; b=IlGGZPkrMEuJT/4dEdKAwDNDmqdvMY3QfE7YGShPMNGP
	6O7bOGcnJnSlfLV7+COaLoV7ShxdehxaP1SO28t6CSHcnKkHXzLCg7/iLV3gnukL
	bAm3o+PnImEloh+yWq9an2A/7hRC/+xa0KhDFJTpbmH7G6EghKGcLzatWikVSrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qUrbWy
	4bNeWgRj2hEW8bf80TSWLJp1nhSiG9wgKVJ4JrrOnYod+Gv6bAhRXKC7EeFLt/cD
	yL1OGwXDfZlDEoZ78+d/9m1/oXT11qffxHc1/WKsO6t/7xkOttZSE3KDSxpcHLbz
	uVRD61SzojU2hNSZ8WGWV6tuvZEPoGOSOxmmE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 90515323E8;
	Fri,  5 Aug 2016 18:06:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E4BDF323E7;
	Fri,  5 Aug 2016 18:06:30 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:	larsxschneider@gmail.com, git@vger.kernel.org, jnareb@gmail.com,
	mlbright@gmail.com, e@80x24.org, peff@peff.net
Subject: Re: [PATCH v4 11/12] convert: add filter.<driver>.process option
References: <20160729233801.82844-1-larsxschneider@gmail.com>
	<20160803164225.46355-1-larsxschneider@gmail.com>
	<20160803164225.46355-12-larsxschneider@gmail.com>
	<2e13c31c-5ee2-890d-1268-98fb67aba1ea@web.de>
Date:	Fri, 05 Aug 2016 15:06:28 -0700
In-Reply-To: <2e13c31c-5ee2-890d-1268-98fb67aba1ea@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Fri, 5 Aug 2016 23:34:23
 +0200")
Message-ID: <xmqqfuqivpjv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DD576ED4-5B58-11E6-958B-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

> On 2016-08-03 18.42, larsxschneider@gmail.com wrote:
>> The filter is expected to respond with the result content in zero
>> or more pkt-line packets and a flush packet at the end. Finally, a
>> "result=success" packet is expected if everything went well.
>> ------------------------
>> packet:          git< SMUDGED_CONTENT
>> packet:          git< 0000
>> packet:          git< result=success\n
>> ------------------------
> I would really send the diagnostics/return codes before the content.

I smell the assumption "by the time the filter starts output, it
must have finished everything and knows both size and the status".

I'd prefer to have a protocol that allows us to do streaming I/O on
both ends when possible, even if the initial version of the filters
(and the code that sits on the Git side) hold everything in-core
before starting to talk.

>> If the result content is empty then the filter is expected to respond
>> only with a flush packet and a "result=success" packet.
> ...
> Which may be:
>
> packet:          git< result=success\n
> packet:          git< SMUDGED_CONTENT
> packet:          git< 0000
>
> or for an empty file:
>
> packet:          git< result=success\n
> packet:          git< SMUDGED_CONTENT
> packet:          git< 0000

The above two look the same to me.
