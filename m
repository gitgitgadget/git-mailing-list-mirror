Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 649751F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 03:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfKSDKV (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 22:10:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55804 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfKSDKV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 22:10:21 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8CA8B1F3A7;
        Mon, 18 Nov 2019 22:10:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=47Hqt52/wWofpRFrgUUFtQi6/L0=; b=p4+Tc+
        K1SeqojXAVui4d3pIb6R045YSJ1e8vPTlJZZVCNK67w1F7EEvj+RWpJYJSg/Eimc
        VKpWOdw5B3Zpidbcfi4BpSN/TnvvqNBvsZhH2jyL2090wefd70XyDb+9PxMtsF9+
        pHujsRdgll1sDwIz9CUbnltnvJC08+ZwyGd1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mHyoRUTi+Fmid6Cd9WFlyFXwdUBWJ/Zx
        lGfNApzAzXR6J0k8pqaJMSIQdfiUyXw4gEYw8OgnDgITwik/MZpZr5PNbjTTLDMN
        dBAAb3pwB1IMC6GLWLGXOe4W3QBrDfFba7kOK7yu8oNdeyjo4VvL5dxD6tPA4X2g
        +1BMZCl1lW8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71C5C1F3A5;
        Mon, 18 Nov 2019 22:10:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C48521F3A4;
        Mon, 18 Nov 2019 22:10:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v4 11/11] squash! pretty: implement 'reference' format
References: <cover.1573764280.git.liu.denton@gmail.com>
        <cover.1574122784.git.liu.denton@gmail.com>
        <580aa7c88c0b18d752f9aa951166a2c82dbcd031.1574122784.git.liu.denton@gmail.com>
Date:   Tue, 19 Nov 2019 12:10:18 +0900
In-Reply-To: <580aa7c88c0b18d752f9aa951166a2c82dbcd031.1574122784.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 18 Nov 2019 16:21:35 -0800")
Message-ID: <xmqq7e3wzhlx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E42F6E2-0A7A-11EA-94F8-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Note that we explicitly special-case `--pretty=reference` to use
> `DATE_SHORT` by default in get_commit_format(). Although this isn't a
> very elegant way of doing this, it has to be done this way because we
> implement `--pretty=reference` as a user-format and, after this
> function, it is treated as a normal user-format. This is the only part
> of the pretty codepath where we can actually tell that we are dealing
> with a "special" format so we have to do it here.

I was hoping that by extending cmt_fmt_map horizontally, we can
cause the date mode (and other things in the future) to optionally
default to the format specific value, without hardcoding the string
constant in the code.  After all, that (i.e. not having to hardcode
per-format specific constants) is the original point of using
table(s) to describe the customization.

