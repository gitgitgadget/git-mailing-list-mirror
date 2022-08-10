Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8482FC00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 05:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiHJF4D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 01:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiHJFzi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 01:55:38 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0B863DD
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 22:55:36 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DF24A1AF8C8;
        Wed, 10 Aug 2022 01:55:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=urSOyrw62H7otNfyqGNYj18SvEcw7MSM7Kqrg8ruckw=; b=Yr0+
        QYODFpM3v84IHOhI5Cu/WVjuLRltmZBBUGQBTZa9qePlCKzO1wCAUU/g/fzBIlH4
        MP13I4yD02bLAX3L02L+Aa/PZQNdqarA63nV2GfGm5Wo+EqkIlRl3giJQik3rEd8
        2ZKYEm7dA12M2i2LoEjaVxCh/BnFPDAseV2yNyY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D7DE91AF8C7;
        Wed, 10 Aug 2022 01:55:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8AC7E1AF8C3;
        Wed, 10 Aug 2022 01:55:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Alexander Meshcheryakov <alexander.s.m@gmail.com>,
        git@vger.kernel.org
Subject: Re: [BUG] Unicode filenames handling in `git log --stat`
References: <20220809182045.568598-1-calvinwan@google.com>
Date:   Tue, 09 Aug 2022 22:55:31 -0700
Message-ID: <xmqqsfm4prqk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0BBF7CAE-1871-11ED-98F6-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Hi Alexander,
>
> Thank you for the report! I attempted to reproduce with the steps you
> provided, but was unable to do so. What commands would I have to run
> on a clean git repository to reproduce this?

Sounds like a symptom observable when the width computed by
utf8.c::git_gcwidth(), using the width table imported from
unicode.org, and the width the terminal thinks each of the displayed
character has, do not match (e.g. seen when ambiguous characters are
involved, https://unicode.org/reports/tr11/#Ambiguous).


