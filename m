Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F111C1F955
	for <e@80x24.org>; Fri, 29 Jul 2016 17:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbcG2Rf6 (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 13:35:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57603 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753367AbcG2Rf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 13:35:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C8DB732581;
	Fri, 29 Jul 2016 13:35:55 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A7YtIAdtD480QhLz+AiWHOIvfi0=; b=KV4Qin
	jQCKHxaEIy5rwP49D8zMU5nvorqhXkcVSovfW+W+mdX0UF8O0eZn39RJRpxEEr4d
	GLc8AefL4Z9Jz4ueQw9sqGtDsVBEHZa9CmbDdce6bxooYciLxshuMEAY/jPOBAla
	0ngpvF77cj2x+q7znnu5Hda2CwpCrw47tNuHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cmV5LO9hPS1v3lc8Qiis+hc5rCo0uZeb
	MHc03CK0Fu3xpGWkZJigzBPqLnKGK/d7P4Wn82+ml8sBSqCvio57LBpU/fJz6p24
	bNMb2PEVphYPG2FQfSHQCw7d0csBXeJGEYVMAa/VJeneg08tX8PceL73O/qkuTFU
	nxJ4UoOPRso=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BF19B32580;
	Fri, 29 Jul 2016 13:35:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 32EDF3257F;
	Fri, 29 Jul 2016 13:35:55 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	mlbright@gmail.com,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Eric Wong <e@80x24.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 5/5] convert: add filter.<driver>.process option
References: <20160722154900.19477-1-larsxschneider@gmail.com>
	<20160727000605.49982-1-larsxschneider@gmail.com>
	<20160727000605.49982-6-larsxschneider@gmail.com>
	<57994436.4080308@gmail.com>
	<7F1F1A0E-8FC3-4FBD-81AA-37786DE0EF50@gmail.com>
Date:	Fri, 29 Jul 2016 10:35:53 -0700
In-Reply-To: <7F1F1A0E-8FC3-4FBD-81AA-37786DE0EF50@gmail.com> (Lars
	Schneider's message of "Fri, 29 Jul 2016 10:04:31 +0200")
Message-ID: <xmqqshusny86.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E73408D2-55B2-11E6-A3E2-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> I think sending it upfront is nice for buffer allocations of big files
> and it doesn't cost us anything to do it.

While I do NOT think "total size upfront" MUST BE avoided at all costs,
I do not think the above statement to justify it makes ANY sense.

Big files are by definition something you cannot afford to hold its
entirety in core, so you do not want to be told that you'd be fed 40GB
and ask xmalloc to allocate that much.

It allows the reader to be lazy for buffer allocations as long as
you know the file fits in-core, at the cost of forcing the writer to
somehow come up with the total number of bytes even before sending a
single byte (in other words, if the writer cannot produce and hold
the data in-core, it may even have to spool the data in a temporary
file only to count, and then play it back after showing the total
size).

It is good that you allow both mode of operations and the size of
the data can either be given upfront (which allows a single fixed
allocation upfront without realloc, as long as the data fits in
core), or be left "(atend)".

I just don't want to see it oversold as a "feature" that the size
has to come before data.  That is a limitation, not a feature.

Thanks.
