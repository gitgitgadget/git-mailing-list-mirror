Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42110C33CA9
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 18:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE405207FD
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 18:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uxVWyyce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgAMSME (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 13:12:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56161 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgAMSME (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 13:12:04 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4EA9540436;
        Mon, 13 Jan 2020 13:12:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+eYHX3JWNAWTULGtJX5+qm847+c=; b=uxVWyy
        cerTInbhjTmfvrwUU7Y7ngRyZVXJ7UJ32DQUpRoFfkKIdi6Y5stDQaFTxLA+ueIm
        hasuO22ur2W53oN84s4M2EFNnwSfNpqI8OMhR/cQILGlhIEroV0gejNZ7HcVoc9u
        2YFYnvps84Aqdj0RCuNaDtyAbFd4jStO+aIP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Jr4tgaQM4yZjAF9o3cE/XQyOidH2heUm
        qgLCohvZ5lNQCln/Sl0l1mgXaAaYhi6rdQyH65ifTCK5QMmyQcel1fLV5gyGCfsO
        uxj7UBmtzn6TL85UfRAVApOex6WHLSOF1obxm6m/DreUDUF9Ge/yTkIib/ZzCr7z
        9IHZCAw3WFA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4231940435;
        Mon, 13 Jan 2020 13:12:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 417F340433;
        Mon, 13 Jan 2020 13:12:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Problems with ra/rebase-i-more-options - should we revert it?
References: <f2fe7437-8a48-3315-4d3f-8d51fe4bb8f1@gmail.com>
        <089637d7-b4b6-f6ba-cce1-29e22ce47521@gmail.com>
        <xmqqeew4l6qf.fsf@gitster-ct.c.googlers.com>
        <xmqq5zhgkwxx.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 13 Jan 2020 10:11:59 -0800
In-Reply-To: <xmqq5zhgkwxx.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 12 Jan 2020 16:43:38 -0800")
Message-ID: <xmqqy2ubjkeo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 31F80F38-3630-11EA-9E55-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I will push out what I wish to be able to tag as the final [*1*]
> shortly but without actually tagging, so that it can get a bit wider
> exposure than just the usual "Gitster tested locally and then did
> let Travis try them" testing.

I haven't heard from any failure report so (taking no news as good
news) I'll cut the final today based on what is already on the
public repositories everywhere.

