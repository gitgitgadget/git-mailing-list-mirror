Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F387C433DF
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 17:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3626D2053B
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 17:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BqQj+aba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbgFHRAB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 13:00:01 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50028 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730678AbgFHRAB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 13:00:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2821FC36A8;
        Mon,  8 Jun 2020 12:59:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xpfGct9R7Vcj
        b5U6LGuamh8epF4=; b=BqQj+abaltdnzDy1cxvpgesSFUP4hKS8N5Rqry86ne+p
        LkeNQEsM3yzRCZu5u1zfetdWvI81OesdWX3eAP1I512gKTC04kcGlrMG6TitP5Nk
        WRyaSz3JZIdGaPkVkd7G1nLx2E3hxMAuA6//TQ5qNRD92s5LmpWGY9LMHRQnlbU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=TEMbjO
        K6cuhqiVzfzRq5NHZWuVrwsGRBRU/Oh5yEFSITV7DpsvG2v2qAl6GtsxHeapIu7+
        jF5EZZd1/580d46v525nmb7tl7+LMNjZCFz+HxtUPnp7Tk0Qa3vXaiUUrbeyZAkF
        Fp0DQYqzXUSQUV0Vpx7FDBq6hSGBd8WyIINwU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 207DCC36A7;
        Mon,  8 Jun 2020 12:59:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 619B7C36A0;
        Mon,  8 Jun 2020 12:59:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Xin Li <delphij@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6 4/4] check_repository_format_gently(): refuse extensions for old repositories
References: <20200528025359.20931-2-delphij@google.com>
        <xmqqsgfk3xtd.fsf@gitster.c.googlers.com>
        <20200528171924.GC58643@google.com>
        <CAOhzdugK7FQSnWruUrX8gQ98AF6kGvNWqPfHmE+qjGjBgzvmiQ@mail.gmail.com>
        <20200528191739.GA114915@google.com>
        <20200529000432.146618-1-delphij@google.com>
        <20200529010119.GE114915@google.com>
        <xmqqk10uzkcd.fsf@gitster.c.googlers.com>
        <20200605091004.208668-1-delphij@google.com>
        <20200605091004.208668-5-delphij@google.com>
Date:   Mon, 08 Jun 2020 09:59:54 -0700
In-Reply-To: <20200605091004.208668-5-delphij@google.com> (Xin Li's message of
        "Fri, 5 Jun 2020 02:10:04 -0700")
Message-ID: <xmqqpna9lchh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7ADDA658-A9A9-11EA-94E1-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Xin Li <delphij@google.com> writes:

> Previously, extensions were recognized regardless of repository format
> version. =C2=A0If the user sets an undefined "extensions" value on a
> repository of version 0 and that value is used by a future git version,
> they might get an undesired result.
>
> Because all extensions now also upgrade repository versions, tightening
> the check would help avoid this for future extensions.
>
> Signed-off-by: Xin Li <delphij@google.com>
> ---
>  setup.c                  | 12 +++++++++---
>  t/t0410-partial-clone.sh | 11 +++++++++++
>  2 files changed, 20 insertions(+), 3 deletions(-)

Thanks.

People, I think this is the only bit that is potentially
controversial with the risk of breaking existing set-up. =20
Its potentially negative effect can be seen in the patch to
test in the previous step.

     test_expect_success 'enable worktreeConfig extension' '
    +	git config core.repositoryformatversion 1 &&
        git config extensions.worktreeConfig true &&

It used to be that, by mistake, you could just say

    git config extensions.worktreeConfig true

in an existing repository (with extra worktrees) and expect that
alone is enough to let you use per-worktree configuration files.

With this patch, that is no longer true, because the extensions.*
will not take effect unless you upgrade core.repositoryformatversion
to 1.

It is the right thing to do in the longer term (we could even
consider it a bugfix), and the workaround is simple enough.

Unless the user is somehow using a configuration variable whose name
begins with "extensions." for whatever random purpose, that is.  If
the user's setup uses extensions.bar, there is no workaround
possible other than renaming the variable to put it outside
extensions.* hierarchy, and update whatever tool that is using that
variable to use the renamed variable.

Comments?
