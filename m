Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69E8C2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 20:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D7F20936
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 20:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tEfcjMGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgDJUmN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 16:42:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59175 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgDJUmN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 16:42:13 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 072D0618D2;
        Fri, 10 Apr 2020 16:42:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Epr3KA49RgFSlyCHNAvNIJvismk=; b=tEfcjM
        GL7PjM/y6dNulgJubICVoTZJDIDs3uHKLkVuJKGD80RJs9GUMQCMHIrWtTxyQ13i
        HG4HDKMCxT1i0l6qquRzP/ds+7ttWs6YukYgYObmwFhY/ba/IDVFlh3qQmezb8WT
        NMEIfD8V5+fpSb1NHNvP10t38shfeT51xk8ec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e+IAQRrZiMtwzaykBTPzopWBcasG93eQ
        z+NkqW0RVaex01SHGuBhbQjQxbMwZHjyQI+wDKlkYXSGPgQCz4GL5RupIFxk+wMB
        vxOTGzVFuqYlWZg0xw7ahIWsTJjkrHkvr8jt80meykxCCubqZsR9K0DQqlNNpzDx
        AqUKeoSuhbY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F2198618D1;
        Fri, 10 Apr 2020 16:42:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7806B618CF;
        Fri, 10 Apr 2020 16:42:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, bturner@atlassian.com,
        sami@boukortt.com, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 0/3] rebase -i: mark commits that begin empty in todo editor
References: <pull.757.git.git.1586474800276.gitgitgadget@gmail.com>
        <pull.757.v2.git.git.1586541094.gitgitgadget@gmail.com>
Date:   Fri, 10 Apr 2020 13:42:11 -0700
In-Reply-To: <pull.757.v2.git.git.1586541094.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Fri, 10 Apr 2020 17:51:31
        +0000")
Message-ID: <xmqqpncfhy3g.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0D4B46A-7B6B-11EA-880C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> I wanted to base this commit on jt/rebase-allow-duplicate, in particular to
> add a patch moving his new --[no-]keep-cherry-picks arguments to be close to
> the --empty={drop,keep,ask} and --[no-]keep-empty flags, since all three are
> related. But unfortunately that series was based on 2.25, and my series
> needs to be based on 2.26.

Even though this one might qualify as a regression fix to be based
on an older track, the other one is a new "feature" and is not even
in 'next' yet, so there is no reason why we must keep its base on
maintenance tracks (perhaps its earliest round was first queued when
2.25 was the latest tagged release?)

So I am OK to rebase the other topic to v2.26.0; would that help?  I
already saw there was some entanglement with the other topic in one
of the patches in this series, so...
