Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12654211B4
	for <e@80x24.org>; Wed,  5 Dec 2018 06:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbeLEG4R (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 01:56:17 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58257 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeLEG4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 01:56:16 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9C1DF320D8;
        Wed,  5 Dec 2018 01:56:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1D8n+bQGQ/o3/JDqdYiEn+x5ls8=; b=je9YwG
        TFPqVnUh5jUrVlruABVjqjE9BT6rSCfhKzuECv5sed2seHOvdJcTU0KByCLr1Cwn
        ekCwJiS6aLF5di5minQ+vQvDY9rxFKR4jd+LPPEtseM5gXHYCLNrB+8vNR0IiYa7
        3GwdsXPqKdkol9oypy9IHsyNFcQJW4uJvKE/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XDFW/9C30dTOcjM85igbsPheq0EeEK3K
        luSEl7hPaR/10fO6sub/IbndNZHtCBBnkaLKMuPjzL6twzSEY6Ndifi01X/zBtsx
        VibeYWW7tfb7uy9QJ4ENORefmHoBX6oZ3nCF9zqHxTzrSj2EX6Jk3zvzYHj0ePEg
        bjrziUDonzU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 943DE320D6;
        Wed,  5 Dec 2018 01:56:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AC906320D5;
        Wed,  5 Dec 2018 01:56:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>, sxenos@google.com
Subject: Re: [PATCH v3 07/14] checkout: split into switch-branch and restore-files
References: <20181127165211.24763-1-pclouds@gmail.com>
        <20181129215850.7278-1-pclouds@gmail.com>
        <20181129215850.7278-8-pclouds@gmail.com>
        <CABPp-BHQ68pkvO8yXYuy=0D6ne8u=5CUMDqiN0jtRrxCL55n2g@mail.gmail.com>
        <CACsJy8BTs+WKzTTEF2XVTT-LVJk_exYCz_hN+hXU1Dw+oquBpA@mail.gmail.com>
        <CABPp-BGRcaiiD-aks1kaLr7ATLQ_oGSyooQBDD+2acgerA+Phg@mail.gmail.com>
        <CACsJy8D9Rgsf-E6yweQxpopFaOVZ1bgihEbg200yS1gup+Gt7Q@mail.gmail.com>
        <xmqqpnugemks.fsf@gitster-ct.c.googlers.com>
        <CABPp-BGZF8s=ReiC=jTKKQbt1LLO72K7a_2pYbQHrw0ZeA9J5w@mail.gmail.com>
Date:   Wed, 05 Dec 2018 15:56:09 +0900
In-Reply-To: <CABPp-BGZF8s=ReiC=jTKKQbt1LLO72K7a_2pYbQHrw0ZeA9J5w@mail.gmail.com>
        (Elijah Newren's message of "Tue, 4 Dec 2018 20:45:07 -0800")
Message-ID: <xmqqva48bgxi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9A89CDA-F85A-11E8-B0C2-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> What depends on stage#2 coming from the commit that will become the
> first parent?

How about "git diff --cc" for a starter?  What came from HEAD's
ancestry should appear first and then what came from the side branch
that is merged into.

