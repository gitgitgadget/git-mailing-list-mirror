Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD04C38BE0
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 19:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2315C2084E
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 19:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mKJ/TKj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbgBXTNp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 14:13:45 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56933 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgBXTNo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 14:13:44 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CCACA47653;
        Mon, 24 Feb 2020 14:13:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Tq2fcg96vh+6wBkUefRAjmhs//E=; b=mKJ/TK
        j18IqnrNUojpLTWS0znAdytVHh1IFlHnfvgFMlcULdFPTb+Yrdg53wwbnBN3xlLc
        YFbIzw3VO/iMZfOtTN8rmXd5jk9yMrJY/QK7ymJqwbArG0va4MlkxoFqdBcOl9UH
        BInRHHX942ghitlV7EdX2Gx2dCva/D2e3qMvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tv8Wv4gpYyx16vyIapgHvNCrBwmmHDIH
        O2M103u94Eftkj9sIgBqdiLepyna5RsW4w3ZxzqPXZyF5EHpkaN5YDKFTRdNlxTO
        pGAnNWt1LqJiAi997bYhe3w0ZmNALpZsP1UV2TsbbvElFCEVd79AmeAu9QrHpNyK
        3iyv5D6U+2I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C4E8647652;
        Mon, 24 Feb 2020 14:13:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2F60A47651;
        Mon, 24 Feb 2020 14:13:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hariom verma <hariom18599@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git <git@vger.kernel.org>,
        johannes.schindelin@gmx.de
Subject: Re: [PATCH v3 1/3] get_main_worktree(): allow it to be called in the Git directory
References: <pull.535.v2.git.1582410908.gitgitgadget@gmail.com>
        <pull.535.v3.git.1582484231.gitgitgadget@gmail.com>
        <8718facbc951614f19407afa6ca8d6110507483d.1582484231.git.gitgitgadget@gmail.com>
        <CAPig+cTh-uu-obh9aeDOV9ptbVwRmkujgucbu9ei1Qa3qSNG_A@mail.gmail.com>
        <CA+CkUQ8ZsxesE=d+DQ+67SEHPJXdHjbSKhWeVifPeKBymqy8pw@mail.gmail.com>
Date:   Mon, 24 Feb 2020 11:13:37 -0800
In-Reply-To: <CA+CkUQ8ZsxesE=d+DQ+67SEHPJXdHjbSKhWeVifPeKBymqy8pw@mail.gmail.com>
        (Hariom verma's message of "Mon, 24 Feb 2020 16:39:08 +0530")
Message-ID: <xmqqtv3fpzmm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C37420D0-5739-11EA-B977-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hariom verma <hariom18599@gmail.com> writes:

> Hi Eric,
>
> On Mon, Feb 24, 2020 at 7:12 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>>
>> This title is a bit too generic; it fails to explain what this patch
>> is really fixing. Perhaps:
>>
>>     get_main_worktree: correctly normalize worktree path when in .git dir
>>
>> or something.
>>
>> "Git directory" is imprecise. As a reader, I can't tell if this means
>> the main worktree into which the project is checked out or the `.git`
>> directory itself. Please write it instead as "`.git` directory".
>> [...]
>> This change makes the code unnecessarily confusing and effectively
>> turns the final line into dead code. I would much rather see the three
>> cases spelled out explicitly, perhaps like this:
>>
>>     if (!strbuf_strip_suffix(&worktree_path, "/.git/.") && /* in .git dir */
>>         !strbuf_strip_suffix(&worktree_path, "/.git/")) /* in worktree */
>>             strbuf_strip_suffix(&worktree_path, "/."); /* in bare repo */
>
> I'll implement these comments in the next revision for sure.
>
>> Also, please add a test to ensure that this behavior doesn't regress
>> in the future. You can probably test it via the "git worktree list"
>> command, so perhaps add the test to t/t2402-worktree-list.sh.
>
> There already exists tests in "t/t2402-worktree-list.sh" which lists and
> verifies all worktrees. Does this make sense to write a new test that
> also does kinda the same thing?

I'd read Eric's suggestion as "please make sure we have a test to
ensure...".  If there already are tests that protects the behaviour
we care about here, there is no need to duplicate it.

Thanks for working on this topic.
