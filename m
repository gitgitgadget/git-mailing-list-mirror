Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACE12202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 01:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751800AbdIVBDA (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 21:03:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59599 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751781AbdIVBC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 21:02:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F1E0792086;
        Thu, 21 Sep 2017 21:02:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s/QvKP+oBBrsQvgxOz9apKQhFDU=; b=SUqRi+
        yIbAdPy/9h9VfyRVbDhLQozBPPlaiYcJ5HsZB3/qvZmMWAeLfyKES2rwEWwJ3/mc
        BRNutcpbpe5814VoRAj5qFBnROXyuKFs6J8xoSNf4zgTFd0EtS7bb9kacfLp+8TO
        hcLh+8rneKKBVwJP0TsV6niThXBavr58jEFSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fUe0pjezOsQIZOVzRFObXB3/ngB2RwVT
        dI0Z2SB5SclhLACF9yWVtWoKa6rd+jW8lMsnBPhHGq1BtTDfkj8YO9P30/GsWeME
        8TcTNSp25UOjnVmnLrv7eLGPH7J8CvWfGJKcstaguxbFvVVHsh9vRKsmtmsleoGY
        OXxRd0vl4hE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EACEF92084;
        Thu, 21 Sep 2017 21:02:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 56DB792082;
        Thu, 21 Sep 2017 21:02:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <benpeart@microsoft.com>, David.Turner@twosigma.com,
        avarab@gmail.com, christian.couder@gmail.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: Re: [PATCH v7 04/12] fsmonitor: teach git to optionally utilize a file system monitor to speed up detecting new or changed files.
References: <20170915192043.4516-1-benpeart@microsoft.com>
        <20170919192744.19224-1-benpeart@microsoft.com>
        <20170919192744.19224-5-benpeart@microsoft.com>
        <xmqqr2v2p0gn.fsf@gitster.mtv.corp.google.com>
        <3311de8b-f9df-07e0-6c5d-7f491e9bcaa8@gmail.com>
        <xmqq377gn74p.fsf@gitster.mtv.corp.google.com>
        <a4ab4766-0367-ff18-a3a9-e48ed49ccd80@gmail.com>
        <f50825a4-fa15-9f28-a079-853e78ee8e2e@gmail.com>
Date:   Fri, 22 Sep 2017 10:02:57 +0900
In-Reply-To: <f50825a4-fa15-9f28-a079-853e78ee8e2e@gmail.com> (Ben Peart's
        message of "Thu, 21 Sep 2017 10:35:33 -0400")
Message-ID: <xmqqlgl7mtoe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C620E2E0-9F31-11E7-B5B0-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> Since the fsmonitor data can be trusted and is kept in sync with the
> working directory, the only remaining valid uses are those locations
> where we don't want to trigger an unneeded refresh_fsmonitor() call.

Now that is a lot more assuring ;-)  And the exceptions below also
make sense to me.

Thanks for thinking this through.
