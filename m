Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33DE61F859
	for <e@80x24.org>; Tue, 16 Aug 2016 20:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbcHPU2P (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 16:28:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54639 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753399AbcHPU2N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 16:28:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 008893655A;
	Tue, 16 Aug 2016 16:28:12 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3Co0O1KEsj23
	ErhOE5ZWPxvhQQM=; b=cfCenXyh9mb4VK1uyLH1xwpZboExcNYQj5VFV4BvBqjX
	Cck7ZIoUtT2bBW9o4eDwGwHyMDmDO1woW4/QE8mSJpkaufqH2k8CvPByeB4DGnpY
	CaneVR/XF1w1ESI3/SQRHeWQg3Nr3ozRZFDf5OTTbDUn6dSJ17EIrZ3bhMVuYSs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=P8REvd
	JcYrxeWOdwMjaLreraGuue/vQSOgiq3Vm4vWRy/mQq629wohra9Hpx3d6HMktBPu
	3Bi7nowZ14ZFm6Ml4bPhn3VAmRkYmQ5jU8Nn+itviCiYrjo/vv34kCmuOl9VB7nu
	+7Hwo+sU+G74GnLEiugVlW9tMj7SUvaZ+xWi0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EC0F936559;
	Tue, 16 Aug 2016 16:28:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E41536558;
	Tue, 16 Aug 2016 16:28:11 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, ryenus <ryenus@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] rev-parse: respect core.hooksPath in --git-path
References: <520a941f7472ac1cb4fa41e6bba33a0afc2f5999.1471264971.git.johannes.schindelin@gmx.de>
	<ce8891377cec31cada49208f2d192dda86658e40.1471353054.git.johannes.schindelin@gmx.de>
	<1134106438.1228353.1471361364992.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<alpine.DEB.2.20.1608161739280.4924@virtualbox>
	<1654103856.1228422.1471365329111.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Date:	Tue, 16 Aug 2016 13:28:09 -0700
In-Reply-To: <1654103856.1228422.1471365329111.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Remi Galan Alfonso's message of "Tue, 16 Aug 2016 18:35:29 +0200
	(CEST)")
Message-ID: <xmqq4m6kcvc6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F384713A-63EF-11E6-BB1D-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> Hi R=C3=A9mi,
>>=20
>> On Tue, 16 Aug 2016, Remi Galan Alfonso wrote:
>>=20
>> > Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> > > diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-p=
ath.sh
>> > > index 5e3fb3a..f1f9aee 100755
>> > > --- a/t/t1350-config-hooks-path.sh
>> > > +++ b/t/t1350-config-hooks-path.sh
>> > > @@ -34,4 +34,10 @@ test_expect_success 'Check that various forms o=
f specifying core.hooksPath work'
>> > >          test_cmp expect actual
>> > >  '
>> > > =20
>> > > +test_expect_success 'git rev-parse --git-path hooks' '
>> > > +        git config core.hooksPath .git/custom-hooks &&
>> >
>> > Any reason to not use 'test_config' here?
>>=20
>> Yes: consistency. The rest of the script uses `git config`, not
>> `test_config`.
>
> Fine by me, then. Sorry for the noise.

No, thanks for reviewing.  I'll take Dscho's patch as-is but once it
hits 'next', it probably is a good idea to do a separate clean-up
patch on top to use test_config where necessary.

Having said that, this entire script is about constantly changing
the value of that single configuration variable and see how the code
performs, so any new test added after existing ones is expected to
ignore left-over values in the variable and set it to a value of its
own liking.  So I suspect there is no existing "git config" call in
this script, with or without Dscho's patch, that would benefit from
getting converted to test_config.


