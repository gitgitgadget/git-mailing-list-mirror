Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D23B520954
	for <e@80x24.org>; Mon, 20 Nov 2017 03:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751100AbdKTDFn (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 22:05:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59787 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751050AbdKTDFm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 22:05:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 110ADA8AB8;
        Sun, 19 Nov 2017 22:05:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4VUzjiaC5jx7C9IGR1Els9y5eGA=; b=tdaOb4
        HrD98J38rOOFzviAmQwQ2O52iSZI6PAZfvv7iZ0w3vGop45iyAHOrNlBJMdx3s3L
        M2XCB/CTlAckVlPFAJUTZWVL4yhbtQhyF4oIYjA35VV5WC5NO6qDN+5PiLo1vxZk
        Bg9VtT7EAB/9FgDPwjGwBsp/sUP3QR4nekcvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aHJ2Q02JjzDFR/jzH/8ok8jWKC1tZTKD
        ZmV2DgCjdw5jfZjC2oHVJMkka/qIRK+HmdPDxexBdDb1/RouYDjL2w0Dnh497roF
        F+OH6kOFKT7LwEnT5E7F9PnDRviVAqoW9n2meLn+3z6KSoBdUUroRQwVos5Ih5p/
        7NFZRo75XdQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 08212A8AB7;
        Sun, 19 Nov 2017 22:05:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7E194A8AB5;
        Sun, 19 Nov 2017 22:05:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Pranit Bauva <pranit.bauva@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH v16 6/6] bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
References: <0102015ecc65d695-22151d3b-752b-4c10-a3a3-b8ef52491664-000000@eu-west-1.amazonses.com>
        <0102015ecc65d76b-124658b5-5b79-4321-a6cc-01be807c62aa-000000@eu-west-1.amazonses.com>
        <CAP8UFD3SYU_+MOT-TGCV4uJ-cxrd9VhgOOprkq-XP0CUhtGTig@mail.gmail.com>
Date:   Mon, 20 Nov 2017 12:05:40 +0900
In-Reply-To: <CAP8UFD3SYU_+MOT-TGCV4uJ-cxrd9VhgOOprkq-XP0CUhtGTig@mail.gmail.com>
        (Christian Couder's message of "Sun, 19 Nov 2017 21:34:24 +0100")
Message-ID: <xmqqlgj1myyj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B13F2C3C-CD9F-11E7-9F68-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Sep 29, 2017 at 8:49 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Reimplement `is_expected_rev` & `check_expected_revs` shell function in
>> C and add a `--check-expected-revs` subcommand to `git bisect--helper` to
>> call it from git-bisect.sh .
>
> It looks like this patch forgot to add the `--check-expected-revs`
> subcommand to the usage string.

Usage string of what?  "git bisect"?

I do not think bisect--helper even needs to have end-user facing
"usage string", but "git bisect--helper -h" still gets the new thing
listed in its output for free thanks to parse-options API, so that
is not what you found "this patch forgot to add" and you are making
me scratch my head.

