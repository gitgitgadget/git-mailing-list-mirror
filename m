Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B712C47247
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 19:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 188C820731
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 19:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HBHUE9fQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgD3TwB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:52:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63181 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgD3TwA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 15:52:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A78360189;
        Thu, 30 Apr 2020 15:51:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AgkAE+N+SZu1gteELjR/S09w5WQ=; b=HBHUE9
        fQPkHm/dT8DBrCukKGmPzuera3SMeuDp2dbDgh78AiQE2a1dA8VoNUHPZgYeg3CG
        UCmDjz3tT0awM5djd95Pf/gycwIQAC1TmsWmyH76NlADZiR+/f4DqXYOY6qht241
        i7g95uvvJknpiO86yt6OCg03lo9oGpFdwu8UI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H5YTra/MFwipGRJSSRRW9jOZg4DnzakG
        Gx+wR6FKDnuNoOyHOB2E0Zg4X7m8TfQnHaQIXABGD/mr36oV9utERG8pZEcwCNTu
        I+KD58BQEk+U8yL8yCyZ8TYtPn6JKNqwjIHtYHtTAKAMdkr0eQ7V0FTgeqsRbOQT
        X9fNzJaJ6io=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9197E60188;
        Thu, 30 Apr 2020 15:51:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 212FA60187;
        Thu, 30 Apr 2020 15:51:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Ivan Tham <pickfire@riseup.net>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] branch: add '-' to delete previous branch
References: <20200429130133.520981-1-pickfire@riseup.net>
        <20200429185851.GF83442@syl.local>
        <20200430145221.z3lpgjstybqztfqb@arch>
        <20200430155904.GA30682@syl.local>
Date:   Thu, 30 Apr 2020 12:51:57 -0700
In-Reply-To: <20200430155904.GA30682@syl.local> (Taylor Blau's message of
        "Thu, 30 Apr 2020 09:59:04 -0600")
Message-ID: <xmqqftcksqea.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0CFD826C-8B1C-11EA-B1B1-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> It is the case that 'git branch -D @{-N}' already works, which was
> surprising to me. I am suggesting that you make documenting the existent
> behavior a new first patch.
>
> Of course, that might be the only patch that you end up sending in v2,
> since it seems that consensus has formed around not supposing '-' as a
> shorthand for '@{-1}' with 'git branch -D'.

Thanks for concisely summarizing the current status of the
discussion.
