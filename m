Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90B27203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 19:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930AbcGZThs (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 15:37:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59222 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751468AbcGZThq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 15:37:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E8952F05B;
	Tue, 26 Jul 2016 15:37:45 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1eB6gZ25oV97rss8S+YqH58DvlA=; b=B8453Y
	TrP/UZ68uEJF1EKenx5z0cgTTr/h0ED2hHW5jCjDLBEn455fFVPnHKt6l/73xc+6
	jAT2UEEL/O3p4gX9rhHlbhmKHPPfqcNiNk9DCAt0tC+lAt7befAo8RINclzhiJL7
	AbBMPlv1YFaFv60U5N/wLhbb4jtsSbn1Dxmfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XCg4o59QhoFWTIbvh8BkA3UqZuSUC5ug
	fA7yOkVCzOD5l/Vgb88OuL2kxKvaP/eUq8ONQLUeGrI8/HEFCtAZcJONSTjoy8Vl
	a8U2OLsQzxkImthTAT/Aqw3KTM5D/Xo/w5vu91OgfItE7K76ImGZADHGgzo08tRi
	L4630xeTi6E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 56FDF2F05A;
	Tue, 26 Jul 2016 15:37:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D5FEF2F057;
	Tue, 26 Jul 2016 15:37:44 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v8 35/41] apply: make 'be_silent' incompatible with 'apply_verbosely'
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
	<20160627182429.31550-36-chriscool@tuxfamily.org>
Date:	Tue, 26 Jul 2016 12:37:42 -0700
In-Reply-To: <20160627182429.31550-36-chriscool@tuxfamily.org> (Christian
	Couder's message of "Mon, 27 Jun 2016 20:24:23 +0200")
Message-ID: <xmqqa8h41989.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6CD8F0C6-5368-11E6-B3D6-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> It should be an error to have both be_silent and apply_verbosely set,
> so let's check that in check_apply_state().

Doesn't that suggest that we do not want to have a new be_silent
field at all?  Perhaps we used to have apply_verbosely = <yes,no>
resulting in only two verbosity levels, "verbose" and "normal", and
you want to have another new one "total silence" or something?

If so perhaps it would be more appropriate to rename apply_verbosely
to apply_verbosity that is no longer a boolean?

