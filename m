Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 679341FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 15:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752690AbcHQPkq (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 11:40:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64540 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752535AbcHQPkp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 11:40:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E8CB35BD0;
	Wed, 17 Aug 2016 11:40:44 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J42/UGGMd912o8txXEesu8VVR9w=; b=ydkUeJ
	MhcTJZIUEW9CZre6VeYQWGSruZF2/uU6kKEEwB706pfdJr3wSPZciZsIJB01OgJc
	7ieNOtn5uubjgepGCNZRLPVtkhFIKk1patRgdBXvepOCdI3viVTeEJyiQTcQTr8c
	Wv+17bjs/neeLA3wNXsrF2sBlPbRAip3aqthE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c9ka2A/ttE9eqOBKVEVYfIi1IMjSf9Iq
	FocUYlIy8LRSyMp9f3B8S1sKBTPqu2sA4b7mED4uty+zyyMVwFmMaN4z7NpgNa46
	waXyV4ipqwpBy3h3wrbROiu8xMYxeF1polge/u5PFU82MRvVh4lsm1VUqvTiyIg3
	1ZvznmuL4uw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6569A35BCF;
	Wed, 17 Aug 2016 11:40:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E5F6935BCE;
	Wed, 17 Aug 2016 11:40:43 -0400 (EDT)
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
	<xmqq4m6kcvc6.fsf@gitster.mtv.corp.google.com>
	<594839500.1229861.1471423409171.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Date:	Wed, 17 Aug 2016 08:40:41 -0700
In-Reply-To: <594839500.1229861.1471423409171.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Remi Galan Alfonso's message of "Wed, 17 Aug 2016 10:43:29 +0200
	(CEST)")
Message-ID: <xmqq1t1nbdza.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F59326B4-6490-11E6-88D4-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
writes:

> I tried to see if the `git config` in other tests were in the
> same case or not but the sheer amount made me reconsider. However
> taking a look at a couple of random ones, there are some scripts
> that would benefit from the conversion.

Yes, that is why I said "it is a good idea to do this where
necessary, but the test Dscho touched here does not need it".
It is a given that there are tons of "git config" users as
we have a lot more tests that were written before test_config
was invented.

It is good to occasionally modernise ancient tests; we usually do so
when we need to make some other changes to them (e.g. I added a
feature, and wanted to add a couple of new tests, but I found it
unreadable and unmaintainable because it kept the ancient style, so
I am updating the existing tests to more modern style first before
doing my changes--and then do my changes on top of the cleaned up
codebase).

