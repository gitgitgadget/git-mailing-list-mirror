Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A83C433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 18:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEA7A20899
	for <git@archiver.kernel.org>; Wed, 27 May 2020 18:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NEjp1eTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgE0SDx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 14:03:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62170 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgE0SDw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 14:03:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE3224E25F;
        Wed, 27 May 2020 14:03:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cTLd4PPgRNzaQGjounuyH4OE6rY=; b=NEjp1e
        TH4KeGUkrYaHhmKUHvN8aRiXrHEPKJRxZiPaS/mwb0hR8BzinXL6SOROK1VdQV14
        YYZq1A1F88enTO3S+f+SCOOYeCbuqMV9E/+Z4YBZExWQxlBED0YpaKWNSmmhNd8B
        3xJlYIWVy+hCa6dPP6OUOuw+rpLAR7xiK8O94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JM3fX8P9FoTCZ4ObJXF7XvTeq5ibwmjU
        W5VWqMtj6q3PYPAdn+OKX9j9SrWkzIPiPGNlFfosDMjdRTzpSC6Gau6AJbUrmdqw
        gEt0l73aSWAbtDBBP1RD4F1lTvyVyOHFOK+BY891vSePIryy+Ywe4uMKAX1bqDDH
        Uj94QAP6PFc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A56664E25E;
        Wed, 27 May 2020 14:03:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1A1174E25D;
        Wed, 27 May 2020 14:03:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 2/9] completion: improve handling of DWIM mode for switch/checkout
References: <20200527113831.3294409-1-jacob.e.keller@intel.com>
        <20200527113831.3294409-3-jacob.e.keller@intel.com>
Date:   Wed, 27 May 2020 11:03:50 -0700
In-Reply-To: <20200527113831.3294409-3-jacob.e.keller@intel.com> (Jacob
        Keller's message of "Wed, 27 May 2020 04:38:24 -0700")
Message-ID: <xmqqimghl0ft.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B93781C-A044-11EA-A9E1-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> This new logic is more robust, as we will correctly identify superseded
> options, and ensure that both _git_switch and _git_checkout enable DWIM
> in similar ways.
>
> Add several tests which demonstrate the new expected behavior. Note that
> some of the git switch tests are marked as failures because the default
> git switch completion with --guess is sub-par as discussed in a previous
> commit. This will be fixed in a future change.

"as discussed in a previous commit"?  1/9 does not mention --guess
at all.  Perhaps this is an unintended damage due to rebasing?

In any case, up to this point, the log messages are a bit
frustrating read, primarily because the author has spent too much
time on DWIM and expect everybody understands exactly what he means
when he says "DWIM mode is enabled", while a reader in me keeps
asking:

 - what refs get included when I type <TAB> without DWIM mode?

 - what extra refs get included when DWIM mode is enabled?

 - under DWIM mode, do certain refs (that would be included without
   DWIM mode) stop appearing in the completion?

and without getting any answer to them.  Perhaps the proposed log
message for [1/9] can be made a bit more robust to cover it?

Thanks.

