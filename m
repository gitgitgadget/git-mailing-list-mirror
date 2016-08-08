Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D17EA2018E
	for <e@80x24.org>; Mon,  8 Aug 2016 18:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561AbcHHS2J (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 14:28:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59387 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752554AbcHHS2G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 14:28:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E2C0D32B9A;
	Mon,  8 Aug 2016 14:28:04 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L62FJ/6bwr4YicqdZz+q1L8duq8=; b=rqSpMM
	IwWytxeT/HXETB3w/QKHOn80D3QoK62xctSYqe+foBBoUoK/C/zSY4tNycONm1Mi
	3gg3tH2MPtVy67MQSNolM+9Np3sm8g6iJ3ZpA9ZisU5iDcIhSBxHSYT6w/QJVeSI
	OhrJL7CyeDSJxAWEMsAW4R8Rk6JScCBPNWr5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g5GsUiMPP6ksYdC4gf+Z7hbmL3sY0EFm
	h2Ieqk/R+Y6W50Pr1MwKUHCFb3kp/qHZ2giqdqGVVNFLH8Tfbq1EtFFowDcXEosm
	4Jy91bjqpsS46yMlkAKMwHeU2z4TvfrKEf9+Adw0OFfcHbY2TpoZtRaErdvSNr7M
	Tn2ZCFrQjPI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D91E432B97;
	Mon,  8 Aug 2016 14:28:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A8A032B96;
	Mon,  8 Aug 2016 14:28:04 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Kirill Smelkov <kirr@nexedi.com>
Cc:	Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
	=?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 2/2] pack-objects: Teach it to use reachability bitmap index when generating non-stdout pack too
References: <20160729074051.GA5987@teco.navytux.spb.ru>
	<20160729074746.31862-1-kirr@nexedi.com>
	<20160808135600.c6hdlqwwtqe7thd5@sigill.intra.peff.net>
	<20160808154054.GB3995@teco.navytux.spb.ru>
	<xmqq60rbf80t.fsf@gitster.mtv.corp.google.com>
	<20160808181353.GC3995@teco.navytux.spb.ru>
Date:	Mon, 08 Aug 2016 11:28:02 -0700
In-Reply-To: <20160808181353.GC3995@teco.navytux.spb.ru> (Kirill Smelkov's
	message of "Mon, 8 Aug 2016 21:13:53 +0300")
Message-ID: <xmqq1t1zf74d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D86B79BC-5D95-11E6-991E-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Kirill Smelkov <kirr@nexedi.com> writes:

> Another question: I'm preparing another version of "pack-objects: Teach
> --use-bitmap-index codepath to  respect --local ..." and was going to
> put
>
>     ( updated patch is in the end of this mail )
>
> in the top of the message. Is it ok or better not to do so and just respin
> the patch in its own separate mail?

That would force those who pick leftover bits to _open_ and read a
first few lines.

Definitely it is better than burying a patch after 60+ lines, but a
separate patch with incremented "[PATCH v6 1/2]" on the subject line
beats it hands-down from discoverability's point of view.
