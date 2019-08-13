Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11F1F1F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 20:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfHMULG (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 16:11:06 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62611 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfHMULF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 16:11:05 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F13FB73143;
        Tue, 13 Aug 2019 16:11:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OXyStJOMPobk
        mizT/qmg3O2/wSI=; b=FE7+1SKJKfYXwAdD4HnsBS75bRpDHej2Rx2mCDLneXoL
        i38YtF8bovYLbGQA7DUkkr27uT11h3gZOv2PDSSFC06yZ3985kSxHDsVP21+L/v0
        1UGsYjbED8x+G+cYTpCTjFeTKBwamB1qKavClWSFsdzbP0orOKUkNUeilC1EitM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=YlnJGe
        p0f/fgPjbfOamMnxaKoMu/x5qD//pSCf2OW3vb/97Jo53keqfKdHQ+HyW0aAPjto
        pmmRoQxmiW6r7J+I01xyd7uXjcyxtJl2mJYMr7mZZquNjUS52FJcAWu0XqIF4M3o
        Ffj9VxDXwCQ/ZlM2chfdOWu2Zwn6/P5CCLHQo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E8C9773142;
        Tue, 13 Aug 2019 16:11:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 274C87313F;
        Tue, 13 Aug 2019 16:11:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] worktree remove: clarify error message on dirty worktree
References: <20190813180244.28641-1-szeder.dev@gmail.com>
        <CAPig+cSDxBFhnJSmH+WzNZBjY4O0OczazZ7EOqn1P=zgL+ec4g@mail.gmail.com>
Date:   Tue, 13 Aug 2019 13:10:58 -0700
In-Reply-To: <CAPig+cSDxBFhnJSmH+WzNZBjY4O0OczazZ7EOqn1P=zgL+ec4g@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 13 Aug 2019 14:52:39 -0400")
Message-ID: <xmqqv9v07rn1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 78788192-BE06-11E9-971A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Aug 13, 2019 at 2:04 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com=
> wrote:
>> To avoid data loss, 'git worktree remove' refuses to delete a worktree
>> if it's dirty or contains untracked files.  However, the error message
>> only mentions that the worktree "is dirty", even if the worktree in
>> question is in fact clean, but contains untracked files:
>> [...]
>> Clarify this error message to say that the worktree "contains modified
>> or untracked files".
>>
>> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>> ---
>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> @@ -880,7 +880,7 @@ static void check_clean_worktree(struct worktree *=
wt,
>>         ret =3D xread(cp.out, buf, sizeof(buf));
>>         if (ret)
>> -               die(_("'%s' is dirty, use --force to delete it"),
>> +               die(_("'%s' contains modified or untracked files, use =
--force to delete it"),
>>                     original_path);
>
> Makes sense. This is a different type of "dirtiness" than, say, "git
> rebase --interactive" which cares about unstaged changes but generally
> doesn't mind untracked files. So, it deserves an error message which
> mentions untracked files explicitly.
>
> We could actually parse the output of "git status --porcelain" (which
> is invoked just above this spot) and provide a more specific error
> message ("...contains modified files" or "...contains untracked
> files") but that's probably not worth the effort.
>
> Anyhow, for what it's worth:
> Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

Thanks, both.
