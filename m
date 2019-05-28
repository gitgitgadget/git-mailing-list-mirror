Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C261C1F462
	for <e@80x24.org>; Tue, 28 May 2019 19:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfE1THg (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 15:07:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61779 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfE1THg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 15:07:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 46484149FB9;
        Tue, 28 May 2019 15:07:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zBSD6yDqSQVc
        VsLLoNHRdqPouS4=; b=Yy2Ll4a1RWJfFJ6i5haTCBvEdnntFsA2RltuOKdv3mID
        rexaxZEQE4FsQH6wpuotqZH6I3ObEa80/1Ts6F+6CxdpA9xLwjDn5o0FJW6cYxNs
        GZk5Y6nrmYgS73Sakq9+d834kdrTs9eMzjJqnzdARdkuEjN+2lJ2qMcTzUJogD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=pkpbMW
        iftXw0NSQSHLhcXzd9fMw6ZzlLOHkmGPUkCys6LJrI0pav/W/x/WvzbBkbCKUtKF
        NJkKfM3dFXr0PFSO/RC+9RTchP6Owb2G4ApmdkHjDYxuoqJOwlW0LxRkx1tWK55M
        4IQTCd9d48d+ktjXwL4D1jAodqEvFo/qeECmI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EC902149FB7;
        Tue, 28 May 2019 15:07:30 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 22786149FB3;
        Tue, 28 May 2019 15:07:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vishal Verma <vishal@kernel.org>
Cc:     git@vger.kernel.org, Vishal Verma <vishal@stellar.sh>,
        Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4] merge: refuse --commit with --squash
References: <20190523225338.14619-1-vishal@kernel.org>
        <20190524183617.8291-1-vishal@kernel.org>
Date:   Tue, 28 May 2019 12:07:29 -0700
In-Reply-To: <20190524183617.8291-1-vishal@kernel.org> (Vishal Verma's message
        of "Fri, 24 May 2019 12:36:17 -0600")
Message-ID: <xmqq1s0i2ya6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D71E6A9E-817B-11E9-B7E0-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vishal Verma <vishal@kernel.org> writes:

> From: Vishal Verma <vishal@stellar.sh>
>
> Convert option_commit to tristate, representing the states of
> 'default/untouched', 'enabled-by-cli', 'disabled-by-cli'. With this in
> place, check whether option_commit was enabled by cli when squashing a
> merge. If so, error out, as this is not supported.
>
> Previously, when --squash was supplied, 'option_commit' was silently
> dropped. This could have been surprising to a user who tried to overrid=
e
> the no-commit behavior of squash using --commit explicitly.
>
> Add a note to the --squash option for git-merge to clarify the
> incompatibility, and add a test case to t7600-merge.sh
>
> Cc: Junio C Hamano <gitster@pobox.com>
> Cc: Rafael Ascens=C3=A3o <rafa.almas@gmail.com>
> Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Vishal Verma <vishal@stellar.sh>
> ---

I personally feel that "merge --squash --commit" that does not
complain and leaves the result in the working tree to be tweaked and
then committed is perfectly fine, especially given that the reason
why "--commit" option exists is primarily because we need to allow
"--no-commit" to stop the normal merge from recording the result in
a new commit.

A user who really wanted to record what a merge would bring to the
current state in a single-parent commit would have to do "git
commit" after that anyway, and with this patch, the user would
instead need to run the same "git merge" command again, without
"--commit", before being able to do so, so in the sense, it is
likely that this change makes it more cumbersome to use for such a
user to use the command.=20

But I guess that this change will give an incentive to actually
allow the combination to "just work" by making it more obvious that
the combination is not supported, so it would be a slight
improvement in that sense ;-)
