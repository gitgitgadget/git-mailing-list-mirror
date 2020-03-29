Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E098C43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 18:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E343A20732
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 18:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="saB8L/X3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgC2SSz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 14:18:55 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50451 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbgC2SSz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 14:18:55 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7A4ADC7DA0;
        Sun, 29 Mar 2020 14:18:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LioNBz1bDBpLAF03bxF6vMGRdOc=; b=saB8L/
        X3EDkt6vtWd5INwdXjfpqDzneREBC1hFzpDvZgfMu/XyzlTtd+AoUWVXy6HVhvBq
        Wcj1vwK/ej2kzRjqP7sqFcbVIfz8JdsJ9GJ8II+e5rW0SySbsyD+GQo8WujZyu4b
        9SYPfTWJ9oX9ScqUIPjl5Y7PkBGYJtc7p/vjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YxX7CX7F2eu8mGAhKxlzWLbOe53IkHFG
        4+l6xT0j8PPaYxFIfMZ4K7nDWeK4/ZitC/Y0ZmEGL3Fwk1Nlu7Kb7vagQ7BCLK/W
        WqPg0kpcEiV4xkEhjbjH84i2FkNb2ebXugQwD0twD7QnYS3FqX/XD2Nv3epRzGtA
        oq05hz6GD4Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 72938C7D9F;
        Sun, 29 Mar 2020 14:18:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BD559C7D9E;
        Sun, 29 Mar 2020 14:18:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Martin Melka <martin.melka@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 1/7] t7063: more thorough status checking
References: <pull.700.v3.git.git.1585164718.gitgitgadget@gmail.com>
        <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
        <752403e339bae098104f41c541c2b0e684586c1f.1585258061.git.gitgitgadget@gmail.com>
        <ffec2a50-e746-370c-1957-3615950bb6fb@gmail.com>
Date:   Sun, 29 Mar 2020 11:18:46 -0700
In-Reply-To: <ffec2a50-e746-370c-1957-3615950bb6fb@gmail.com> (Derrick
        Stolee's message of "Fri, 27 Mar 2020 09:09:19 -0400")
Message-ID: <xmqq369raut5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBA8D88A-71E9-11EA-9EA3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> +# Ignore_Untracked_Cache, abbreviated to 3 letters because then people can
>> +# compare commands side-by-side, e.g.
>> +#    iuc status --porcelain >expect &&
>> +#    git status --porcelain >actual &&
>> +#    test_cmp expect actual

;-)

>> +iuc() {

Missing SP after "iuc".

>> +	git ls-files -s >../current-index-entries
>> +	git ls-files -t | grep ^S | sed -e s/^S.// >../current-sparse-entries

When you see yourself piping grep output to sed, think twice to see
if you can lose one of them.  sed -ne 's/^S.//p' perhaps?

>> +
>> +	GIT_INDEX_FILE=.git/tmp_index
>> +	export GIT_INDEX_FILE
>> +	git update-index --index-info <../current-index-entries
>> +	git update-index --skip-worktree $(cat ../current-sparse-entries)

Are the dances with ls-files and update-index to prepare us for a
possible future in which we do not use .git/index as the index file,
or something?  IOW, would 

	export GIT_INDEX_FILE=.git/tmp_index &&
	cp .git/index "$GIT_INDEX_FILE &&

be insufficient?

>> +
>> +	git -c core.untrackedCache=false "$@"
>> +	ret=$?
>> +
>> +	rm ../current-index-entries
>> +	rm $GIT_INDEX_FILE
>> +	unset GIT_INDEX_FILE
>> +
>> +	return $ret
>> +}
>
> This is a clever way to get around the untracked cache deletion.
>
> Thanks for adding these extra comparisons! It really does help guarantee
> that we are doing the right thing in each case.

Yes, I think it is a great idea to see tested commands behave the
same way with or without the untracked cache.

Thanks.
