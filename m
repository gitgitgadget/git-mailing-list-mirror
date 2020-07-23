Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30EDC433E0
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 23:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B4DB20792
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 23:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IvKDB8JS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgGWXYh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 19:24:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64163 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgGWXYh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 19:24:37 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B6C076D97C;
        Thu, 23 Jul 2020 19:24:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gBrHjtEIG6jnw4EnLK5wSdlKeHI=; b=IvKDB8
        JSs3a2sZyFv/0YRBmXgR97e27yH9irw5BKX0lHGv/XAJktg6vLi5NC2sIEVFsrxk
        rrUyMrsO5szYyCVfPnWWilr2R71WTxJ4N9JbDL9X6F1/6+XEsQMfogVJEIhRD8Xk
        zAc2hX5gHhNWz7eemlKEZn3k48I++ung3hkBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CIUtJAVYbBiC4A9Li+LIk6zjUesNi4CV
        J1PoTStUtFcc1JdV0EkH+tPDgqvT9Qw0LguMwjdoz/yFYA72XWW59V/naOnsan+Y
        QwcljA+2TQEWadiYDKgPMZMh+bbl7cWxtKQBMQBobZBOEv6H7kX+yylvs/GFlhk1
        bjiRzEeMAv8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ADABD6D97B;
        Thu, 23 Jul 2020 19:24:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3C9776D97A;
        Thu, 23 Jul 2020 19:24:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        steadmon@google.com, Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        Doan Tran Cong Danh <congdanhqx@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 11/18] maintenance: auto-size incremental-repack batch
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <478c7f1d0b858755c2c4b98605405214910b6f4c.1595527000.git.gitgitgadget@gmail.com>
        <xmqqa6zpq3nt.fsf@gitster.c.googlers.com>
        <CAPig+cRXdrg6ceZV27yjV_jB58iDuMi=54SvtArV1BfxExRgMQ@mail.gmail.com>
Date:   Thu, 23 Jul 2020 16:24:33 -0700
In-Reply-To: <CAPig+cRXdrg6ceZV27yjV_jB58iDuMi=54SvtArV1BfxExRgMQ@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 23 Jul 2020 19:09:55 -0400")
Message-ID: <xmqqsgdholvy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AAEE209C-CD3B-11EA-8F76-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Jul 23, 2020 at 6:15 PM Junio C Hamano <gitster@pobox.com> wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> > +     struct strbuf batch_arg = STRBUF_INIT;
>> > +
>> > -     argv_array_push(&cmd, "--batch-size=0");
>> > +     strbuf_addf(&batch_arg, "--batch-size=%"PRIuMAX,
>> > +                 (uintmax_t)get_auto_pack_size());
>> > +     argv_array_push(&cmd, batch_arg.buf);
>> >
>> > +     strbuf_release(&batch_arg);
>>
>> I think I saw a suggestion to use xstrfmt() with free()  instead of
>> the sequence of strbuf_init(), strbuf_addf(), and strbuf_release()
>> in a similar but different context.  Perhaps we should follow suit
>> here, too?
>
> Perhaps I'm missing something obvious, but wouldn't argv_array_pushf()
> be even simpler?
>
>     argv_array_pushf(&cmd, "--batch-size=%"PRIuMAX,
>         (uintmax_t)get_auto_pack_size());

No, it was me who was missing an obvious and better alternative.
