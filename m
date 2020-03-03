Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BE7C3F2C6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 18:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D282072D
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 18:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KfkXAmav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgCCSpd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:45:33 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54867 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgCCSpd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 13:45:33 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 217A8C9104;
        Tue,  3 Mar 2020 13:45:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Zozw7WbiuTer7RMu/D9broTrdvU=; b=KfkXAmavE4keoYj1OfaC
        FFAwiFQ/9SQvPZiT8NWOMBw/hmtUqyjr02Me+yxgmFjHvdW+kIGkwPf3udmTBefV
        YsabR0W1YEe4l0guWoevXmOKmnl++Vc2qpBJEPoYaOcFB7jIB6q9Zxdon+vIxrcF
        MBduVLDQp1lPa5u1qSagZHw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=fVxz+cRAdl+xxT0fODhuqkeJsHrLHL4Bn+LmRrICo4DMyE
        2QrmC0kNIaMaskopNkLVAONS3UhhiITawsCjSbQz0ugpIKSN6hyX6Jq/ZVOAKigF
        ziRhsfU8rqhCvQLePYeJFsUaJOA6B85x8+eBshauFK5YheTSTgvfIXsojqTLo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 05B43C9103;
        Tue,  3 Mar 2020 13:45:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 11F77C9102;
        Tue,  3 Mar 2020 13:45:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Son Luong Ngoc <son.luong@booking.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: Re: [PATCH v2 2/2] stash: remove the stash.useBuiltin setting
References: <20200302181832.GA1571684@cat>
        <20200303174613.3557960-1-t.gummerer@gmail.com>
        <20200303174613.3557960-2-t.gummerer@gmail.com>
Date:   Tue, 03 Mar 2020 10:45:26 -0800
Message-ID: <xmqqeeu98egp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 275DB002-5D7F-11EA-8703-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> +	Unused configuration Variable.  Used in Git versions 2.22 to

s/Variable/variable/;

> +	2.26 as an escape hatch to enable the legacy shellscript
> +	implementation of rebase. Now the built-in rewrite of it in C
> +	is always used. Setting this will emit a warning, to alert any
> +	remaining users that setting this now does nothing.

I am a bit torn between "just document it here as a stale variable
that can safely be removed from your configuration, and do not warn"
and what you did here.  Even if we warn for a few releases, this
entry cannot be removed from the documentation for a lot longer
time, if ever, anyway.  It's not like having an extra entry that is
unused in the configuration file would hurt users, anyway, and it is
not obvious that the warning helps more than it disrupts them by
bugging users to remove it from their configuration file.
