Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FF2C35E04
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 20:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7F921744
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 20:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="r4TrjPlb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgBYUfn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:35:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60487 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbgBYUfn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 15:35:43 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 398F250BEA;
        Tue, 25 Feb 2020 15:35:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z4LnYthXNvzr5/OFZh27btrRqoA=; b=r4TrjP
        lb/S2A3ltr0qnqhnEDi5rLhLubgaRF5YHu79Id/AdoTDiR+htvpjBubBG2zrO4aU
        /jNcW4CvCiCt/+sQ9Ggu0KHAgcmZWSLKIBNMsH06iZVlPkd/OSzvQrvYrJE2nc2k
        hpnCmIN6hT1z8PfiSHXpNGUDutV5DOzbj13xQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X8Y8ZcTxPKvRmDm8n9PsyoqTMhO6lhkK
        FECyPn3UYu030EyH5yvXNAh60avIhIcvNqh6WU/Y+RXQq6l0PLYxTuBmY25X1mUs
        0Qfc/2jyVD4i3nrIICzW/FTeIYGqrbpiu7QuQeho5IejTh/sU8GMv+qotUS8r+dx
        42N7B2BGSZI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3136A50BE9;
        Tue, 25 Feb 2020 15:35:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 97C9E50BE8;
        Tue, 25 Feb 2020 15:35:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v5 2/3] advice: revamp advise API
References: <pull.548.v4.git.1582557199.gitgitgadget@gmail.com>
        <pull.548.v5.git.1582628141.gitgitgadget@gmail.com>
        <b7f10d060a41c1ef3d25e4c07be3747c7902b997.1582628141.git.gitgitgadget@gmail.com>
        <xmqqsgiymupf.fsf@gitster-ct.c.googlers.com>
        <20200225195648.GA212281@google.com>
        <xmqqblpmmntj.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 25 Feb 2020 12:35:39 -0800
In-Reply-To: <xmqqblpmmntj.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 25 Feb 2020 12:09:12 -0800")
Message-ID: <xmqq36aymmlg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 634361E6-580E-11EA-9238-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Emily Shaffer <emilyshaffer@google.com> writes:
>
>>> ...  Your get_config_value() would then become a mere lookup
>>> in advice_setting[] array, e.g.
>>> 
>>> 	int advice_enabled(unsigned advice_type)
>>> 	{
>>> 		static int initialized;
>>> 
>>> 		if (!initialized) {
>>> 			initialized = 1;
>>> 			git_config(populate_advice_settings, NULL);
>>> 		}
>>> 		if (ARRAY_SIZE(advice_setting) <= advice_type)
>>> 			BUG("OOB advice type requested???");
>>> 		return !advice_setting[advice_type].disabled;
>>> 	}
>>> 
>>> with your "push-update-rejected has two names" twist added.

One beauty of the approach is that the "twist" can be done in the
initialization codepath, e.g.

 	int advice_enabled(unsigned advice_type)
 	{
 		static int initialized;
 
 		if (!initialized) {
 			initialized = 1;
 			git_config(populate_advice_settings, NULL);

                        advice_setting[ADVICE_PUSH_UPDATE_REJECTED] &=
                        advice_setting[ADVICE_PUSH_UPDATE_REJECTED_ALIAS];
 		}
 		if (ARRAY_SIZE(advice_setting) <= advice_type)
 			BUG("OOB advice type requested???");
 		return !advice_setting[advice_type].disabled;
 	}

which means that the function literally becomes an array access that
is guarded for out-of-bounds index.

Thanks, Emily, for making me look at the suggested code again to
realize this ;-)
