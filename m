Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BF7C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 592CA2076E
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HNcQXChl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgHDAHS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:07:18 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54101 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgHDAHR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 20:07:17 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E05A9D5A95;
        Mon,  3 Aug 2020 20:07:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x1pLllHml6pRXccqkg1g2F1x6kk=; b=HNcQXC
        hlYU//LWML6cNpfS6ivRERMad1TIgtnMWYYFbAfJo7M31VIT+xkGKG1Ocp+N8WTy
        KCdWdmk2D7pqxm9r7lMlxQH78EbdQZTrY6L3hGTXxJBGpYLdNqf4P8/Kdj4Q++oa
        AxbaPnA6iZ8lnhtNi2jzUbJThnIKgcIhWNS0A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c2W6CPueRyNR0UcjvoIrUPXKm5WZE+bT
        2qMQubJQE5XXqhBzRvkZOw0j8sdA/X7IqghPDIa5usifvnrqccRJ9ntEhc+h/bnG
        SyPAL1JteuqZOYazQN3OkBEBMgl8A7/laoR9Ie/d9mOG2P3SOWek089o2XI6x9zc
        SHp6JB9T0VI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D8052D5A94;
        Mon,  3 Aug 2020 20:07:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3077BD5A93;
        Mon,  3 Aug 2020 20:07:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 01/18] maintenance: create basic maintenance runner
References: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <63ec602a07756a41f8ccddd745562c567a4b3ed7.1595527000.git.gitgitgadget@gmail.com>
        <20200729221905.GB519065@google.com>
        <5cbdb559-3897-961f-4dd3-0bab11848c5b@gmail.com>
        <20200731003022.GA1029866@google.com>
        <a176ddf5-b45b-fb25-8740-96efbd324edf@gmail.com>
        <20200803174654.GA2473576@google.com> <20200803224631.GA73022@syl.lan>
        <20200803230134.GA58587@google.com> <20200803230814.GA73765@syl.lan>
        <20200803231745.GB58587@google.com>
Date:   Mon, 03 Aug 2020 17:07:11 -0700
In-Reply-To: <20200803231745.GB58587@google.com> (Jonathan Nieder's message of
        "Mon, 3 Aug 2020 16:17:45 -0700")
Message-ID: <xmqqpn87tgsw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 72B96138-D5E6-11EA-ACF5-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> ...  If you're saying that we should
> not change the JSON serialization, then it makes me worry that we made
> a mistake in choosing JSON as a format, since using a well defined
> format with an ecosystem of serialization + deserialization libraries
> was the whole point.

Well said.
