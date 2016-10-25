Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 552E72035F
	for <e@80x24.org>; Tue, 25 Oct 2016 17:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758930AbcJYRVa (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 13:21:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61373 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752881AbcJYRV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 13:21:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DFE948958;
        Tue, 25 Oct 2016 13:21:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LMcoqfvTEihVqGey/+5YiyKu2M4=; b=Mhk71/
        j1Pw99NLTduIttlAulTbE8rio4d8FaUeIfqAjykSEYfspobZRYqf/qPjtfYuX0Fg
        QNBo36jS7H9OKKNQvMKecqoS2XO0HPxpWhDisouVXzF9vCaLYskQinE3thIYpjms
        dBJRI8V3JJEqDMI5djnE4aiFyplgIhE5ASTFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CuNIQ+25vQxgjmgzWd0+Mh/HVr99U7Mh
        /iUWTbIf/dWoubaoAFwGg0MY+O8G9viheB6QjMuSXtMh2I4ebukFBNgmMBDefSUa
        vp9IeGO2xQZuC0Q0poHekA3UCD3+zKDZiHIqFHTlgNUb9w6kxAgbQEne76ZDWS3t
        +kyNUJkHvOk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0970B48957;
        Tue, 25 Oct 2016 13:21:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7E22248956;
        Tue, 25 Oct 2016 13:21:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v1 00/19] Add configuration options for split-index
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
        <xmqq8ttd7h8g.fsf@gitster.mtv.corp.google.com>
        <CACsJy8BBwWRGSyJDYQ7THj7quu4=T1xT_-KojQd45Vye4Kgcng@mail.gmail.com>
Date:   Tue, 25 Oct 2016 10:21:25 -0700
In-Reply-To: <CACsJy8BBwWRGSyJDYQ7THj7quu4=T1xT_-KojQd45Vye4Kgcng@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 25 Oct 2016 16:30:25 +0700")
Message-ID: <xmqqk2cws5t6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76553C8E-9AD7-11E6-B2E3-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> ... But those files
> people generate manually and refer to them with $GIT_INDEX_FILE, we
> can't know where they are.

Then we probably should stop doing that, i.e. disable split-index
automatically for these temporary ones, perhaps, and even with
Christian's series which allows use of split index on the primary
one easier (which is a good idea), make sure we don't auto split the
temporary ones the users create?

> Timestamps allow us to say, ok this base index file has not been read
> by anybody for N+ hours (or better, days), it's most likely not
> referenced by any temporary index files (including
> $GIT_DIR/index.lock) anymore because those files, by the definition of
> "temporary", must be gone by now....

and if we guessed wrong, users will have a "temporary index" that
they meant to keep for longer term that is now broken here.  I am
not sure if that risk is worth taking.

