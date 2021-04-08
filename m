Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6247C433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC20610E7
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhDHWBl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 18:01:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54783 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbhDHWBk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 18:01:40 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B152C5792;
        Thu,  8 Apr 2021 18:01:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dWEBJQyAloIz
        nAwme9XHKlPJtnM=; b=c2cvq2NvsgsMMtf021xo7TnJRpgx/GmmVL6mHGxyRF87
        Y5TkzfCJllf3Y6BAAPYDjRKbNrnqOq+vZ3k5qoLUWWyoki03YrhpCk59/ftgkH50
        IjiwAaQ1DfvnDR0iubE+aB+6cbRhmqe+kUakUvptA78jzxEhWiJR2OoD/Zz3KVI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NtDIfG
        LckQ3ohpPY0aSBMLXGrp4kXvaBjUcc1g525GwasIkMM1bTs1R6rQShw5z0Kc0qGd
        TFFH89E0gjvmr3An9KciSMte4l52M9h4PENoX9mnHMl2J0ew8JN4/+jQOsPLE5kZ
        Z5mYJKdJhH87ZS9O7UHUSD0uI/1zBAgW+s74g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 01FF2C5787;
        Thu,  8 Apr 2021 18:01:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 740ADC5786;
        Thu,  8 Apr 2021 18:01:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     Sergey Organov <sorganov@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/9] diff-merges: introduce log.diffMerges config variable
References: <20210407225608.14611-1-sorganov@gmail.com>
        <20210407225608.14611-4-sorganov@gmail.com>
        <20210408213736.GB2947267@szeder.dev>
        <20210408215115.GB1938@szeder.dev>
Date:   Thu, 08 Apr 2021 15:01:26 -0700
In-Reply-To: <20210408215115.GB1938@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Thu, 8 Apr 2021 23:51:15 +0200")
Message-ID: <xmqq7dlcsafd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F792080A-98B5-11EB-8A17-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Thu, Apr 08, 2021 at 11:37:36PM +0200, SZEDER G=C3=A1bor wrote:
>> On Thu, Apr 08, 2021 at 01:56:02AM +0300, Sergey Organov wrote:
>> > New log.diffMerges configuration variable sets the format that
>> > --diff-merges=3Ddef will be using. The default is "separate".
>> >=20
>> > Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> > ---
>> >  builtin/log.c |  2 ++
>> >  diff-merges.c | 11 +++++++++++
>> >  diff-merges.h |  2 ++
>> >  3 files changed, 15 insertions(+)
>>=20
>> Please don't forget to document this new configuration variable.
>
> Oh, just noticed that you do document it in the last patch of the
> series, and, similarly, you add new options early in this patch series
> and add the corresponding documentation in the second to last patch.
> Please squash in those documentation updates into the corresponding
> patches.

Since any new topic that adds new configuration variable or update
the description of an existing one would interact badly with the
last step of Emily's es/config-hooks topic, b58f84c4 (docs: unify
githooks and git-hook manpages, 2021-03-10), where the description
of all the individual options are moved to a newly created file, and
it is not practical to take all the new topics that touch the
documentation for the configuration variables hostage to the topic
that seems to be dormant for quite a while, I'll discard the last
step from es/config-hooks topic for now.  We really should get it
moving soon (or discard and reboot it later---it is getting in the
way for other topics to keep it in my tree, either way).

Thanks.
