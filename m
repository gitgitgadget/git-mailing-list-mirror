Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 575CF207E6
	for <e@80x24.org>; Thu, 15 Sep 2016 20:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754921AbcIOUB0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 16:01:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52530 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751948AbcIOUBY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 16:01:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B4B13EEB9;
        Thu, 15 Sep 2016 16:01:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GY1qzpm+EIQA
        wBC5q1BjY1g0QUU=; b=lx4Ln10tbAddiSsgSYqc3tRnk5EHK6tJTiWJbb/eUaZT
        k7Y/IRbaNlqmAOPs8SuZto7SVsebPhydQlbIXDoeI+EtMXC2kUYIrXDiy4qaIyZD
        6PLDiw7s0INV9n5ECJJCPbYNTF9QL+OUn1PxQvkOzZS+DGLSr491ZPVAEYHJhao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=TDCGbi
        NGKHH5UkAlttu5EBirFzy3NRdWzdKGAZKkZdMqPCwwfXOGFirIQyG1XmtPT5Xt51
        OT7jhaPaWFx94uClo/jJggIvPcx7lBJGs7XRZQfBFM0gSb6gBdfDGULuRhrHYJDR
        rg+jfQfCNkCZFyYz7yjKzltplgCPwdE/m3dfU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 876A03EEB8;
        Thu, 15 Sep 2016 16:01:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0923C3EEB7;
        Thu, 15 Sep 2016 16:01:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] use strbuf_addstr() for adding constant strings to a strbuf, part 2
References: <f7294ac5-8302-03fb-d756-81a1c029a813@web.de>
        <20160915184448.awipvg2kmlq7weei@sigill.intra.peff.net>
        <xmqqbmzpnex4.fsf@gitster.mtv.corp.google.com>
        <20160915193804.d2mmmeard2rj6vye@sigill.intra.peff.net>
        <79f6cfb5-3b9b-2ae7-d9a3-5c1c65c7d4cf@web.de>
Date:   Thu, 15 Sep 2016 13:01:19 -0700
In-Reply-To: <79f6cfb5-3b9b-2ae7-d9a3-5c1c65c7d4cf@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 15 Sep 2016 21:55:09 +0200")
Message-ID: <xmqq7fadnd9s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2C96A9C4-7B7F-11E6-83E6-46717A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Take this for example:
>
> -			strbuf_addf(&o->obuf, _("(bad commit)\n"));
> +			strbuf_addstr(&o->obuf, _("(bad commit)\n"));
>
> If there's a language that uses percent signs instead of parens or as
> regular letters, then they need to be escaped in the translated string
> before, but not after the patch.  As I wrote: silly.

Ahh, OK, so "This use of addf only has format part and nothing else,
hence the format part can be taken as-is" which is the Coccinelle rule
used to produce this patch is incomplete and always needs manual
inspection, in case the format part wanted to give a literal % in
the output.  E.g. it is a bug to convert this

	strbuf_addf(&buf, _("this is 100%% wrong!"));

to

	strbuf_addstr(&buf, _("this is 100%% wrong!"));

Thanks for clarification.  Perhaps the strbuf.cocci rule file can
have some comment to warn the person who builds *.patch file to look
for % in E2, or something?

