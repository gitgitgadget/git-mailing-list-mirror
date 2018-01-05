Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D2A91F428
	for <e@80x24.org>; Fri,  5 Jan 2018 18:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeAESur (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 13:50:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58823 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752121AbeAESur (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 13:50:47 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 79504C4BB1;
        Fri,  5 Jan 2018 13:50:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UTxtT+Ky4ag4qW7QY6plx7TXY2M=; b=kgOvT1
        HCp2Lv8UckDQN+v/MoEycmXsRh8m/Ma88apqB0HzqpQo4O4h0sfMGeXl0K4UoMqC
        pNDWPl9tLKYg/d8Y6m7x09ZSGrR5hQ/RDAMcob+IrXbCBfi/JCkRSIv8rbpPpUMA
        Nua/AxrSeCWMVS1kbMDLJl6wd+a0tzHY16ZvE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h2xnjGZUksyruFv0Kcmemkz8AdQYlZL8
        fdg5SJfF6C3Bffcm54MrPwoBo7l3iL4z0TShyDLVhqYum6hmI86hLOMDULCXzWQL
        0Q2xEIHDVx99brpCqZBrunLgTWDP7wOoDmDesPln7m9VuSFVTynsQdWR3fmSESrV
        yicuNbIMwWI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 71325C4BB0;
        Fri,  5 Jan 2018 13:50:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E2464C4BAE;
        Fri,  5 Jan 2018 13:50:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Stephan Janssen <sjanssen@you-get.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] clone: do not clean up directories we didn't create
References: <20180102210753.GA10430@sigill.intra.peff.net>
        <20180102211139.GD22556@sigill.intra.peff.net>
        <CAPig+cQOU7d21kDELtFAkM0qJh8pvj7F56oWVYw+kYiUftQEuA@mail.gmail.com>
        <20180102233932.GA27884@sigill.intra.peff.net>
Date:   Fri, 05 Jan 2018 10:50:44 -0800
In-Reply-To: <20180102233932.GA27884@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 2 Jan 2018 18:39:32 -0500")
Message-ID: <xmqq373kdtrv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 56B665CC-F249-11E7-A060-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Oops. The second one should be "wt" (since the idea was to flip the
> logic from the previous). Like so:
>
> diff --git a/t/t5600-clone-fail-cleanup.sh b/t/t5600-clone-fail-cleanup.sh
> index 5cd94d5558..4a1a912e03 100755
> --- a/t/t5600-clone-fail-cleanup.sh
> +++ b/t/t5600-clone-fail-cleanup.sh
> @@ -89,7 +89,7 @@ test_expect_success 'failed clone into empty leaves directory (separate, git)' '
>  	test_path_is_missing no-wt
>  '
>  
> -test_expect_success 'failed clone into empty leaves directory (separate, git)' '
> +test_expect_success 'failed clone into empty leaves directory (separate, wt)' '
>  	mkdir -p empty-wt &&
>  	corrupt_repo &&
>  	test_must_fail git clone --separate-git-dir no-git foo empty-wt &&

Squashed; thanks.
