Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F95DC433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 16:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 216E022210
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 16:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bIwvRH1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388946AbgJOQXe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 12:23:34 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51364 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388357AbgJOQXe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 12:23:34 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9A532F6212;
        Thu, 15 Oct 2020 12:23:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6Xay1m6q1TvLnyev+QYFZDuEiq8=; b=bIwvRH
        1V9NdIG3fXZBqZvdnyhjxJfTzmcygI7FF8efFcX4omLECvr7c/OQ77Xs/HurhqiP
        dbvEnJ4nCw6Aw9DTDeEi4bcarjx7A4uh3UTS6eI4bTGkc7yTFHKV638jeGbKQk5V
        db+uLu/0lyftX5XkcthFeGm9Tulv5qGM4pfrM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HVVW3vDdkmghhktj2X2Wp+QJYdTaHnrh
        zKcHJx80sy2Qb97UG1Y0E0OMVS35sBWNJLVhQ+SMqKUrsyqsESuqXuY9cEacDe11
        DMZ/h+RFn0kbemYyfvoR8jH1mQ7C1hXxhJzkqQs78D9NTe8NwtZ1CgX4qve6cGnc
        Gsv7N6EnksE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 93D93F6211;
        Thu, 15 Oct 2020 12:23:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D9466F6210;
        Thu, 15 Oct 2020 12:23:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Patrick Steinhardt <ps@pks.im>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 05/13] reftable: utility functions
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
        <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
        <4190da597e65bce072fa3c37c9410a56def4b489.1601568663.git.gitgitgadget@gmail.com>
        <20201002041214.GE3252492@google.com>
        <CAFQ2z_NL1UrmonMH3qLKrEkjsPjm9qTbtoeY0OHQZzkVW2t3-w@mail.gmail.com>
        <20201012152505.GB3740546@google.com> <20201012170527.GA21606@xps>
        <nycvar.QRO.7.76.6.2010131405380.50@tvgsbejvaqbjf.bet>
        <xmqqo8l6ku0y.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2010151346060.56@tvgsbejvaqbjf.bet>
Date:   Thu, 15 Oct 2020 09:23:28 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2010151346060.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 15 Oct 2020 13:46:50 +0200 (CEST)")
Message-ID: <xmqqwnzrh30f.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2E4ADFC-0F02-11EB-9464-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Tue, 13 Oct 2020, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> > Somewhat related: I was wondering whether it would make sense for git.git
>> > to rename `strbuf` to `git_buf`? Would that make it easier to exchange
>> > code between the two projects? Or would it just be unnecessary churn?
>>
>> To us, "git_buf" is just as descriptive as "buf" and does not say
>> anything about the nature of 'buf' (other than apparently it was
>> invented and widely used here).  "git_strbuf" I can understand, but
>> why should we?
>
> If it makes code sharing between git.git and libgit2 easier, why shouldn't
> we ;-)

I see no reasonably explanation why libgit2 is not the one who uses
"#define strbuf git_buf" to make "sharing easier", though.

