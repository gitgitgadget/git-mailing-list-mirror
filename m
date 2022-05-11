Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E80C433F5
	for <git@archiver.kernel.org>; Wed, 11 May 2022 15:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343662AbiEKP3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 11:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343659AbiEKP3n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 11:29:43 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF4821012B
        for <git@vger.kernel.org>; Wed, 11 May 2022 08:29:40 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D6BBF18FA4B;
        Wed, 11 May 2022 11:29:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EWJz03VVOLZKMqlxKkfaVtBCe8RDOAXNI42s1C
        t9beM=; b=X2vZD2J/94F2O5ACy3rZ1zsJ1VRDv7jFeAR1YGC+brVZ0ulAL6VHj6
        ClrqaekdWrs+n5QlTUQNXbvqmrydpepzKsDDVq2vh729duSSv5OPFlosgXwgn72B
        QS6FPuMvmuQ0WfU0VcVUdmB1a5fWn7Utt65NJP+gOPRvJ9WE0BIlA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CED6E18FA4A;
        Wed, 11 May 2022 11:29:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 68AF618FA47;
        Wed, 11 May 2022 11:29:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v4 3/3] t0034: add negative tests and allow git init to
 mostly work under sudo
References: <20220507163508.78459-1-carenas@gmail.com>
        <20220510174616.18629-1-carenas@gmail.com>
        <20220510174616.18629-4-carenas@gmail.com>
        <xmqqczgl56fi.fsf@gitster.g>
        <CAPUEspiJSn5onUDpGQOtP7-51F87SfKRkcW+RC693EOboymnPQ@mail.gmail.com>
Date:   Wed, 11 May 2022 08:29:34 -0700
In-Reply-To: <CAPUEspiJSn5onUDpGQOtP7-51F87SfKRkcW+RC693EOboymnPQ@mail.gmail.com>
        (Carlo Arenas's message of "Wed, 11 May 2022 07:04:00 -0700")
Message-ID: <xmqqh75wm6jl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29B3C16C-D13F-11EC-B1E2-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

>> > --- /dev/null
>> > +++ b/t/lib-sudo.sh
>> > @@ -0,0 +1,12 @@
>> > +# Helpers for running git commands under sudo.
>> > +
>> > +# Runs a scriplet passed through stdin under sudo.
>> > +run_with_sudo () {
>> > +     local ret
>> > +     local RUN="$TEST_DIRECTORY/$$.sh"
>> > +     write_script "$RUN" "$TEST_SHELL_PATH"
>> > +     sudo "$TEST_SHELL_PATH" -c "\"$RUN\""
>>
>> This is not wrong per-se, but I think
>>
>>         sudo "$RUN"
>>
>> would be sufficient, wouldn't it?
>
> only because currently we rely in a sudo that defaults to "-s" and
> SHELL should be TEST_SHELL_PATH, but that wasn't explicitly tested by
> the prerequisite, and so this just makes sure we ALWAYS use the right
> shell, even if sudo might not want to normally.

Ah, OK.  So giving "$TEST_SHELL_PATH" to write_script and then
running the resulting script explicitly with "$TEST_SHELL_PATH" is
belt-and-suspenders kind of defensiveness.  This was puzzling
without explanation, but starts making sense when explained.

Thanks.

