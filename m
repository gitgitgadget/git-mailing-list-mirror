Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C152C4BA09
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 03:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655D021744
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 03:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZNHyksfE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbgBZDDR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 22:03:17 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63603 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgBZDDR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 22:03:17 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 44836B3843;
        Tue, 25 Feb 2020 22:03:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kR7l07JXyx70kYYXV8kMv44D6hU=; b=ZNHyks
        fExh1LtTyvPnfe0JtnrNmn+kS9QXbrEzXMXHaw6QwLAqKjf8yhVsKkMEwdeYqHix
        uION2CzQzt3I4u2fhHgx1wnMFdnP8wUx6IFxkDwZX/XDym7rh2H1rRWu8/UmPdmz
        g5Ov/TATGF2Vv8fjUziAxN8NFMBRrygM/eKTo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hlEDCB/2lAYnA/2ATUMVAaaIoF0cw1el
        nPVkpLId/xR+2BiFbLGghcJudFm6Dg/4DZEoto6CV3mhk38Z8wYTzuKHdN7xaS79
        xVyG+JZDFgrUUEbYCDj6SzP4xoSeEys5efkllxmntBQIDnVqxlWw9aRzV2XZ8k/l
        QKtVXf7hry4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3DA91B3842;
        Tue, 25 Feb 2020 22:03:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 64F18B3840;
        Tue, 25 Feb 2020 22:03:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heba Waly <heba.waly@gmail.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] advice: revamp advise API
References: <pull.548.v4.git.1582557199.gitgitgadget@gmail.com>
        <pull.548.v5.git.1582628141.gitgitgadget@gmail.com>
        <b7f10d060a41c1ef3d25e4c07be3747c7902b997.1582628141.git.gitgitgadget@gmail.com>
        <xmqqsgiymupf.fsf@gitster-ct.c.googlers.com>
        <CACg5j27SfWsj2t_z8zxOvjc6MSot2yMi1J+R4HJinFhHgTpveg@mail.gmail.com>
        <xmqqy2sql405.fsf@gitster-ct.c.googlers.com>
        <CACg5j25EdX2fPHpAq3TEhaJPiQg4dA52soOyCMm17wg_O-c4Ng@mail.gmail.com>
Date:   Tue, 25 Feb 2020 19:03:10 -0800
In-Reply-To: <CACg5j25EdX2fPHpAq3TEhaJPiQg4dA52soOyCMm17wg_O-c4Ng@mail.gmail.com>
        (Heba Waly's message of "Wed, 26 Feb 2020 13:37:36 +1300")
Message-ID: <xmqq8skqkq35.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8668CC98-5844-11EA-827D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heba Waly <heba.waly@gmail.com> writes:

> I'm not against this approach as well, but as I mentioned above, we
> need a list of keys to be returned by list_config_advices(), that's
> why defining the constant strings will not be sufficient in our case.

Sorry, but I do not get it.  

Either you use enum or a bunch of variables of type const char [],
"list all of them" would need an array whose elements are all of
them, so

        const char ADVICE_FOO[] = "advice.foo";
        const char ADVICE_BAR[] = "advice.bar";
        ...

        static const char *all_advice_type[] = {
                ADVICE_FOO, ADVICE_BAR, ...
        };

	void for_each_advice_type(int (*fn)(const char *name))
	{
		int i;
		for (i = 0; i < ARRAY_SIZE(all_advice_type); i++)
			fn(all_advice_type[i]);
	}

would be sufficient, and I do not think it takes any more effort to
create and manage than using an array indexed with the enum, no?

