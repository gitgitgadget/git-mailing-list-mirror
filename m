Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87061200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 19:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755976AbcL0TNy (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 14:13:54 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63277 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754570AbcL0TNw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 14:13:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F15559B5C;
        Tue, 27 Dec 2016 14:13:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         s=sasl; bh=qtA1Q2oVYhDF2ao00Ln9ydPS7t8=; b=Ql/+h1OGWswql2ou1xns
        fXrfH1qwblofFkIJDUA2Csei9wE8CtR3QP215faLRl13ixjrGh/i1lxj9noMgsrT
        j9H8k2DdWJHsWDvxO1y+SqqRBK2b0zRX29SQ0h2SJ1GetOU72oTuxb52HGlDEz/C
        K5DMtv+f17fEzpNChP+HpTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         q=dns; s=sasl; b=kNZsRRlCM9wlVkUFo3+lleIcK3K7DVpeFj3lFl2mZxgxEo
        TYQqBYfiTxFVoFM1GpWjX7OWO4up+lXoFLMxnLIxTJShviinNEEcCSbuSPgFCFS+
        20lQP3edEf1m07k69YK+RHUjiX4ux3FWd/AdKwUcLXxgv6FIP/tOb4o07EOHI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8759E59B5B;
        Tue, 27 Dec 2016 14:13:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F300D59B5A;
        Tue, 27 Dec 2016 14:13:50 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 06/21] t1700: add tests for core.splitIndex
Date:   Tue, 27 Dec 2016 11:04:31 -0800
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
        <20161226102222.17150-7-chriscool@tuxfamily.org>
Message-ID: <xmqqvau59ocy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 99D31C18-CC68-11E6-9605-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> +test_expect_success 'set core.splitIndex config variable to true' '
> +	git config core.splitIndex true &&
> +	: >three &&
> +	git update-index --add three &&
> +	git ls-files --stage >ls-files.actual &&
> +	cat >ls-files.expect <<EOF &&
> +100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
> +100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	three
> +100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	two
> +EOF
> +	test_cmp ls-files.expect ls-files.actual &&

It does not add much value to follow the "existing" outdated style
like this when you are only adding new tests.  Write these like

        cat >ls-files.expect <<-\EOF &&
	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	three
	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	two
	EOF

which would give incentive to others (or yourself) to update the
style of the existing mess ;-).
