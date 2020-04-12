Return-Path: <SRS0=e9fP=54=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB6FC2D0EC
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 21:38:24 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED31206C3
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 21:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oBt0jqUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED31206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=git-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgDLViW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Apr 2020 17:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbgDLViW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Apr 2020 17:38:22 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913EBC0A3BF5
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 14:38:22 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 02FBC5A07A;
        Sun, 12 Apr 2020 17:38:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nQWbgh5pNeARen/4WT7Bz3CCUC0=; b=oBt0jq
        UhpLTowQhrysTLu2kElB5Y0gMc60HO0o63xiNmpPivnN3jdsYA/Sp9Ne8QTtXXvZ
        9t5+w1K5Kr297HrAbFVQ7RL7hHT728DIP31O5J1Cvwpv+QKM4R/2BW6rq/LexWqo
        YneelUeCxHdnAcQ5JyL4vZa+mDloK9bXgV6co=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CgB0NuEG+paC8LmnneyaM5BM/Z31UOla
        UiRoI2K7RYhkwghpyVnJQokdgAgPSz8XScLOzkFk2zG67RSUKmzn1EzmYRNbctC3
        IwIE+iJTHlAoo7bzRtdDKxxXaa2B/DdGN11rboSosbWdnza9RmX/r8JGAhfWyaIl
        w0lq1UYKD5Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DE1EB5A079;
        Sun, 12 Apr 2020 17:38:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 503E05A078;
        Sun, 12 Apr 2020 17:38:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v10 3/8] refs.c: refactor to reuse ref_is_hidden()
References: <20200407120813.25025-1-worldhello.net@gmail.com>
        <20200412133022.17590-4-worldhello.net@gmail.com>
Date:   Sun, 12 Apr 2020 14:38:20 -0700
In-Reply-To: <20200412133022.17590-4-worldhello.net@gmail.com> (Jiang Xin's
        message of "Sun, 12 Apr 2020 09:30:17 -0400")
Message-ID: <xmqq1rose65v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE3C5ADE-7D05-11EA-978D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> Add new function `ref_is_matched()` to reuse `ref_is_hidden()`. Will use

ref_is_matched() may not be wrong per-se, but I would imagine that
ref_matches() would sound more natural.

The ancient varilabe hide_refs is probably misnamed and should be
renamed when the codebase is quiescent to hidden_refs but of course
we shouldn't do so before stablizing this series.

