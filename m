Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1660F1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 21:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756577AbeASV5j (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 16:57:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63274 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756461AbeASV5i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 16:57:38 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C9106CB1EC;
        Fri, 19 Jan 2018 16:57:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RrXe2WqATYHyY1L2UQwA9+6ic+c=; b=Edmo0j
        Dj5x17l3xZBMRCquS3hyN02CTS1UE3nowMo7DyriPY09/fSJqdhdAMpsij2Q01Vx
        bdkd2kXHSnBNkZedC2WpxL9q7nH62U7AUt6pwirE21BViCA2oX2d6V0H0tLQHAPJ
        N9hQutbd5PXMP1bwWgQJIp+2kuBjoOwkuCXYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bovA9LhDygUpqFVXRl4AxyCXDQyefSh2
        Sinemo5e6fyD7SdKaTWGdtCur8IBwxlyrSarmztiQsykbzVLsjuvD0W27unGDAkl
        7nJOfhXf5iL82esr9nOY0lYNEfAqvIo2rMyD0MnCajCzuM9LzhZyOiGJwXOEhXiC
        uducJQegHuM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C183ACB1EB;
        Fri, 19 Jan 2018 16:57:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 291B4CB1E9;
        Fri, 19 Jan 2018 16:57:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 1/3] read-cache: fix reading the shared index for other repos
References: <20171217225122.28941-1-t.gummerer@gmail.com>
        <20180107223015.17720-1-t.gummerer@gmail.com>
        <20180107223015.17720-2-t.gummerer@gmail.com>
Date:   Fri, 19 Jan 2018 13:57:35 -0800
In-Reply-To: <20180107223015.17720-2-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sun, 7 Jan 2018 22:30:13 +0000")
Message-ID: <xmqq1silpl4g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2F63D3C-FD63-11E7-98FD-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> read_cache_from() defaults to using the gitdir of the_repository.  As it
> is mostly a convenience macro, having to pass get_git_dir() for every
> call seems overkill, and if necessary users can have more control by
> using read_index_from().

This was a bit painful change, given that some changes in flight do
add new callsites to read_index_from() and they got the function
changed under their feet.

Please double check if I made the right git-dir to be passed to them
when I push out 'pu' in a few hours.

Thanks.
