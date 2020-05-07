Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34537C35280
	for <git@archiver.kernel.org>; Thu,  7 May 2020 23:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1482208D6
	for <git@archiver.kernel.org>; Thu,  7 May 2020 23:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xAzYbyjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgEGXH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 19:07:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55110 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbgEGXH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 19:07:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F626448AB;
        Thu,  7 May 2020 19:07:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o3u2ZraEOrv7zVk/F9YajnpnHh8=; b=xAzYby
        jyuEGGQPYGb8AJofg90fbSnIQtWdyHiAigK59HlykhBHX8mNaysJN1bMZLyJBefO
        AaF6jPtoh4eeRVHPoouDCtyT0HdOlNRIx3FbEsgeEIiZSjNLKBUETEekKFIIRrBc
        2IKBAfXRqtq2K3CUNJmbs+Lc5RrlmfEttVNSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MG+byudsxc+A3sUXMUMaoJ4e8w3Qy3f6
        NmQuH8k0sEy2Sb3Paf/4+gVPvPYhOrWMn3tdEuFfMc2MBIoTsB9reYh6JkFtvj/c
        UH4nTEnn1GTGxSL26g1UviLpYgLeLrwxJFh8yqBexIdkhQAsFCdaLNX0pIVFzxoj
        Mw0xqn2WGBQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 86F46448A9;
        Thu,  7 May 2020 19:07:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0FBCD448A8;
        Thu,  7 May 2020 19:07:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christopher Warrington via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christopher Warrington <chwarr@microsoft.com>
Subject: Re: [PATCH] bisect: fix replay of CRLF logs
References: <pull.629.git.1588886980377.gitgitgadget@gmail.com>
        <20200507222510.GA42822@coredump.intra.peff.net>
Date:   Thu, 07 May 2020 16:07:54 -0700
In-Reply-To: <20200507222510.GA42822@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 7 May 2020 18:25:10 -0400")
Message-ID: <xmqq5zd72vjp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 958F2EC8-90B7-11EA-B325-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The simplest fix is probably to clean up "$file" into another tempfile,
> and then read from that.

Or just tell the users do not break the log file (or they can keep
both halves)?
