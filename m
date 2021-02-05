Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB08C433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 11:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 486C064E55
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 11:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhBELkh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 06:40:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56036 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhBELiS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 06:38:18 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33BCE91FEA;
        Fri,  5 Feb 2021 06:37:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NOx0myjjREiS
        PmRy03AXBpBjeIs=; b=GOpOVF6WDDECHhlo7zCPRCn1v84h37gO8n9jLAnaA6Ww
        Sjg9HSRKMGjhQuC28hg5E/4fk8ckAOITJ3coUYK0eOtX0qZOrPv3/UXTj5Yvq/xP
        VIgzpVPAoW1lPGLryBaFcLdsk5+lUVgAgwC6bL0GOb334CPac9e86Pu3Abk31No=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=XlSJFv
        Pukj8CftGKjLwq6ek01i6WwWsV+xJWbAjgHVyCFPNwD9DRr4NmFCPb8saTke6oEb
        Zr23BRG3pL67lqw/DjcpIrc8gRPvJrGLBEhSLTWVMnUrip+Mrsuppm2Ia7HcD8Se
        mxBiC6bci+nhdcboP4wNXeIRe3aE6oBZgdM3g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 186C691FE7;
        Fri,  5 Feb 2021 06:37:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 481EB91FE6;
        Fri,  5 Feb 2021 06:37:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Vincent Lefevre <vincent@vinc17.net>,
        Chris Torek <chris.torek@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 4/5] pager: properly log pager exit code when signalled
References: <20210201144921.8664-1-avarab@gmail.com>
        <20210202020001.31601-5-avarab@gmail.com>
        <5f5c5018-9fcc-6a9f-66fc-81d1c09946c3@kdbg.org>
Date:   Fri, 05 Feb 2021 03:37:32 -0800
In-Reply-To: <5f5c5018-9fcc-6a9f-66fc-81d1c09946c3@kdbg.org> (Johannes Sixt's
        message of "Fri, 5 Feb 2021 08:58:42 +0100")
Message-ID: <xmqqr1lu21ab.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8972098C-67A6-11EB-A71C-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 02.02.21 um 03:00 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> When git invokes a pager that exits with non-zero the common case is
>> that we'll already return the correct SIGPIPE failure from git itself,
>> but the exit code logged in trace2 has always been incorrectly
>> reported[1]. Fix that and log the correct exit code in the logs.
>
> There's a more severe problem here, not with your patch, but with trace=
2
> in general: it invokes async-signal-unsafe functions from a signal
> handler, in particular, realloc, vsnprintf, gettimeofday, localtime_r
> (and probably a lot more) via fn_child_exit_fl of trace2/tr2_tgt_normal=
.c
>
> Is that something that we should care about?

Yes, indeed X-<.
