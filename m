Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F53AC2BC11
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 21:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C98FD20659
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 21:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lmz1a+YB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgIHVEY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 17:04:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59250 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbgIHVEX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 17:04:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 76D808B7D2;
        Tue,  8 Sep 2020 17:04:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/3sikMnPCEdQve5Y/ifvx0WJePY=; b=lmz1a+
        YBXfcWRlz5KqQCtsSJqIHkZdi2Z9ctrRrFUPC/Qblt7iY7Yej+2PJ+A4V1FfcuPI
        yhAIwHLg9P/Bo2yyLtIH/3xTr0DVndYgAEJ94uV53l82qNFFQQNk5Z2XL/rri5Tw
        MJhqiVqj9NJPQE9MCILaoT+sqA2uCWw8q4B58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I3F0CGDW6qcjOC0/FAjskmvuNcffrclE
        hyKWliw647DCF7jIrMbrSuXgztX/ltqHSYkXsUzTpB+Lf81buKhv4Jct7JAcpERW
        7TeINj2N0pWOTPk/CG1eYxLOw7S2g9cHSgNfNQCvQHTo5bPv86FqUn21KWJ2gXqV
        lOu4tXRUtWI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F1B98B7D1;
        Tue,  8 Sep 2020 17:04:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DDCCB8B7D0;
        Tue,  8 Sep 2020 17:04:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] refs: move REF_LOG_ONLY to refs-internal.h
References: <pull.712.git.1598628333959.gitgitgadget@gmail.com>
        <CAFQ2z_MJ8nD3Z3m8P9HS4O6jbs7u3y5h8a6Nvy3Pa=d6s40=9g@mail.gmail.com>
Date:   Tue, 08 Sep 2020 14:04:20 -0700
In-Reply-To: <CAFQ2z_MJ8nD3Z3m8P9HS4O6jbs7u3y5h8a6Nvy3Pa=d6s40=9g@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Tue, 8 Sep 2020 20:17:14 +0200")
Message-ID: <xmqqimcox9nv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD9983CE-F216-11EA-A9B0-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Fri, Aug 28, 2020 at 5:25 PM Han-Wen Nienhuys via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> REF_LOG_ONLY is used in the transaction preparation: if a symref is involved in
>> a transaction, the referent of the symref should be updated, and the symref
>> itself should only be updated in the reflog.
>
> Jun, are you waiting for me to do anything with this patch?

If I said somthing, perhaps I am, but since I do not remember, it is
likely that the list traffic has exceeded my bandwidth and this
slipped through the cracks, I think.

Thanks for pinging to keep the thread refreshed.  It helps.

