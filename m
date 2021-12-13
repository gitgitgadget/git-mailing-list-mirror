Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157D7C433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 21:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243442AbhLMV5e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 16:57:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57244 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243453AbhLMV5c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 16:57:32 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A9ED01114F0;
        Mon, 13 Dec 2021 16:57:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nST16qHZdOV2UNvFjdS257OH/WCvEau//RiXpg
        A/PkY=; b=Gq13UqU3yWsglwGYH1TIOFoG9s4/KYmo+vOTHSSYsiz0/Kx4Z3+QM6
        YyXIbi3VfsSh08Q7FKvgYMIEolO9YQO5XK58aPj/hceE4dUFbVdBbbBbRFwvVDKM
        Aq0GRXb+7BJkKFH2QV4+I74JVwGgW3xsNA1UCMi8GrkrsUS8IQaJA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A1B6C1114EF;
        Mon, 13 Dec 2021 16:57:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 108C21114EE;
        Mon, 13 Dec 2021 16:57:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH V4] git-apply: add --allow-empty flag
References: <20211211031343.15818-1-jerry@skydio.com>
        <20211213202826.7051-1-jerry@skydio.com> <xmqqlf0ob2o0.fsf@gitster.g>
        <CAMKO5Ctq8kzAvHAXxPVd06_Ko7-GW4CQbUmw7g7Eb7Su_Cp8RQ@mail.gmail.com>
Date:   Mon, 13 Dec 2021 13:57:29 -0800
In-Reply-To: <CAMKO5Ctq8kzAvHAXxPVd06_Ko7-GW4CQbUmw7g7Eb7Su_Cp8RQ@mail.gmail.com>
        (Jerry Zhang's message of "Mon, 13 Dec 2021 13:52:42 -0800")
Message-ID: <xmqq5yrsb22e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB843DCA-5C5F-11EC-B067-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

> On Mon, Dec 13, 2021 at 1:44 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Jerry Zhang <jerry@skydio.com> writes:
>>
>> > diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
>> > index a32ad64718..b6d77f4206 100644
>> > --- a/Documentation/git-apply.txt
>> > +++ b/Documentation/git-apply.txt
>> > @@ -14,11 +14,11 @@ SYNOPSIS
>> >         [--allow-binary-replacement | --binary] [--reject] [-z]
>> >         [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--cached]
>> >         [--ignore-space-change | --ignore-whitespace]
>> >         [--whitespace=(nowarn|warn|fix|error|error-all)]
>> >         [--exclude=<path>] [--include=<path>] [--directory=<root>]
>> > -       [--verbose | --quiet] [--unsafe-paths] [<patch>...]
>> > +       [--verbose | --quiet] [--unsafe-paths] [--allow-empty] [<patch>...]
>> >
>> >  DESCRIPTION
>> >  -----------
>> >  Reads the supplied diff output (i.e. "a patch") and applies it to files.
>> >  When running from a subdirectory in a repository, patched paths
>>
>> Applying: git-apply: add --allow-empty flag
>> error: patch failed: Documentation/git-apply.txt:14
>> error: Documentation/git-apply.txt: patch does not apply
>> Patch failed at 0001 git-apply: add --allow-empty flag
>>
>> Hmph....  Where did that "| --quiet" thing come from?
>>
>>
> Apologies, I overlooked a dependence on my other patch here:
> https://patchwork.kernel.org/project/git/patch/20210427194106.14500-1-jerry@skydio.com/
>
> Let me know if you'd like a clean patch off of master. Please give the
> other patch
> a look though, as I've addressed outstanding comments.

I am OK with either a single patch without the other one at all, or
N-patch series if they all have to go in together.

Thanks.

