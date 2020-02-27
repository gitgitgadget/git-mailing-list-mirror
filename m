Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E100C3F2C6
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 22:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0912469F
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 22:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WyyxNGwj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgB0W7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:59:12 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62031 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgB0W7L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 17:59:11 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9CDB3B6E77;
        Thu, 27 Feb 2020 17:59:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AlPYbK9jqp2vgYvlUta+uC+Hdgg=; b=WyyxNG
        wjro5WPO97VqiXTQjHskAJEvg/OBDelct5H52dGvjPDfe4ULI+87QNOyvSLXoRbI
        sgAzSSudnDVDoymVLk8KswsBgcMacUnDii3yteeVDBycOkgouFNHxcOX9c4BHAKK
        w02yE4bmdYUlPKQINnRTfMjFdQY5G4BpYmCQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sa5xfbvstvN6iNcvUNIkqTxMcf9G3KPR
        nvYxw44bxWuBR1EKee0QPGB8tFmPhSkMgNl+i/EcJnDI55JmiiQa2MKfxj/YqwN8
        OYGJrsebKmCq0J77sEjB5+JHVyNXJ3rPahKj3kBMpxKiXfSHqwVCk3bmLmHYMxZt
        67jaDXXhmH4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 94BCCB6E76;
        Thu, 27 Feb 2020 17:59:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C3982B6E75;
        Thu, 27 Feb 2020 17:59:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3] mingw: workaround for hangs when sending STDIN
References: <pull.553.v2.git.1581956750001.gitgitgadget@gmail.com>
        <pull.553.v3.git.1581962486972.gitgitgadget@gmail.com>
        <xmqqy2szkfxr.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2002272215210.46@tvgsbejvaqbjf.bet>
Date:   Thu, 27 Feb 2020 14:59:04 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2002272215210.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 27 Feb 2020 22:15:36 +0100 (CET)")
Message-ID: <xmqqy2sneix3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1C57432-59B4-11EA-8B0F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I usually try to refrain from grammar policing, but in this case, the typo
> "then" (instead of "than") threw me.
>
> Other than that, I think the patch is fine. At least it works as
> advertised in my hands.

Thanks, both.

Let's mark it for 'next', then.
