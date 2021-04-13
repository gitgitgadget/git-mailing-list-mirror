Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5969CC433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 20:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BC1C611EE
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 20:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbhDMUJM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 16:09:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62976 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346406AbhDMUJI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 16:09:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7935E123299;
        Tue, 13 Apr 2021 16:08:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=88Y7gzOHgWjIRzGQbzEMkUNSiLc=; b=h6gTC6
        kbmYRUjxjSkPVdhPQz0/9a2pFkfcIasodFm8ipNcefPCPcHW91IniHxCrrx46kfE
        jxzth5Ez8I3GElywt9oEQhMWFZk8LBhH4vrY7jrHV7MbKQjQ0gHcgxEp2NgeedOk
        TidfGp4g3yh+IwXlnQhqhD1Z1ZXCHvo8QsoCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hUDaDemnJdOY9W3jXKcTglc7l7nmOwEC
        bRWfxdPPsbhBB6cYs5iaxy66Zn49iRlMRyw6JgpbaYQjn+PvTyvqSYWKszXfITMA
        xHihcspfDCEtLG2dNvc0MdIU31a4h2BAQWtRIHc1M9mJIrm97sTG6IkXj9LpKjVi
        K1PobA9jg4c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 72228123297;
        Tue, 13 Apr 2021 16:08:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B8F3A123296;
        Tue, 13 Apr 2021 16:08:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH] refs: print errno for read_raw_ref if GIT_TRACE_REFS is
 set
References: <pull.1002.git.git.1618255954484.gitgitgadget@gmail.com>
        <xmqq4kgbb2ic.fsf@gitster.g>
        <CAFQ2z_MnZOfo4Bt6SsRJnL+F70r9wr_jYSf2KGvcvyX-8PfVRQ@mail.gmail.com>
Date:   Tue, 13 Apr 2021 13:08:43 -0700
In-Reply-To: <CAFQ2z_MnZOfo4Bt6SsRJnL+F70r9wr_jYSf2KGvcvyX-8PfVRQ@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Tue, 13 Apr 2021 13:58:42 +0200")
Message-ID: <xmqqy2dmkkvo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D552118-9C94-11EB-8B3C-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

>> I do wonder if we want strerror(errno) instead of the number, but I
>> can go either way (it's just a trace output).
>
> For tracing, it would be most useful if we got the actual symbol (eg.
> ENOENT). Is there a way to get at that?

I do not think there is.

And that is the reason why we see everywhere calls to die_errno(),
error(..., strerror(errno)), etc.

As this is interpolated into trace with untranslated string,
I suspect that strerror() is not a good match, so let's live with %d
for now.

Thanks.


