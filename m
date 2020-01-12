Return-Path: <SRS0=w3fS=3B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BEBC33CA2
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 21:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1A82080D
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 21:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xYXsF/fO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387404AbgALVX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jan 2020 16:23:28 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62205 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732825AbgALVX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jan 2020 16:23:28 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E3B3199155;
        Sun, 12 Jan 2020 16:23:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9kxlrwekkLgmdI0iYViwIqo2lFU=; b=xYXsF/
        fOczYumAHnziCg4yqbs7ECNz64ZZ2Y+nIK7LiV95bM9A44RBe8/IamljunMNyT4r
        daZFenbw7gWWxKbjwB8RdzKb49Uky85PX9Psyou8Nc6zAYrkU/n8vDXgCCr2iWK7
        b3mdRoEI++bygXBulLRs9FwiuX8yG36ZIJnPE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BS1caYIcVYtM05Hg+QjvFJG2OmDw99bw
        0whBOODMRaaGCh8MI+i46K7tb65Aly0QcEL/KtuUe2FP1eSRwd03JFBqpvsM8dxu
        QwvHwzZNJ8BZUj83APRP5WkXFzsNT4pfrBt2D1E+Q2oBc9ZK6GM8QGD0+N9yu2Hs
        JKQauPGuWVU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DA81299154;
        Sun, 12 Jan 2020 16:23:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 135F399153;
        Sun, 12 Jan 2020 16:23:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Denton Liu <liu.denton@gmail.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 15/15] rebase: change the default backend from "am" to "merge"
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
        <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
        <044853fd612ee8cf6928bb7c4ebb1eacaa172aa3.1577217299.git.gitgitgadget@gmail.com>
        <20200110231436.GA24315@google.com>
        <CABPp-BEGwJ=0+6TMYXvMzpds0h6bz4gZA8Pi95SH9M4CKBtfOw@mail.gmail.com>
        <052fdedc-2beb-91ab-c5c3-53fb99e64810@gmail.com>
Date:   Sun, 12 Jan 2020 13:23:17 -0800
In-Reply-To: <052fdedc-2beb-91ab-c5c3-53fb99e64810@gmail.com> (Phillip Wood's
        message of "Sat, 11 Jan 2020 14:41:36 +0000")
Message-ID: <xmqqa76sl67u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1753B04-3581-11EA-BFB0-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Looking through the history the am based rebase has never run the
> post-commit hook as am has its own set of hooks and the scripted
> version used commit-tree.
>
>> But the big question here, is what is correct behavior?  Should rebase
>> call the post-commit hook, or should it skip it?  I haven't any clue
>> what the answer to that is.
>
> It's creating a new commit so I lean towards thinking it should run
> the post-commit hook. As an example I have a post-commit hook that

The reason why "am" did not run "post-commit" is because
"post-commit" was (originally) meant to be for cases where the end
user types "git commit", IOW, the notion of "since we are creating a
new commit object, let's run the post-commit hook" used to be
totally misguided way of thinking.  The hook was "the user _ran_
'commit', so post-commit is run immediately afterwards".

These days, I think most of our tools subscribe to the newer "a
commit got created--have hook the chance to report it" idea, simply
because the original position is untenable---"git merge" may not
want to run the post-commit hook according to the initial design,
and it is fine to make it not to run it when clean automerge was
recorded, but sometimes the end users have to type "git commit" to
conclude a conflicted merge.

So from that point of view, I do not think it is too bad to bring
"am" into the new ear and start running post-commit from it.

The "pre-commit" hook is a different story, though.  From purely
practical point of view, starting to run extra verification that may
veto new commits from getting created only because we changed the
implementation detail for some reason is a disservice to the users.

