Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB6DC2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 21:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1232063A
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 21:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rQVoy+S4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgDJVOY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 17:14:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59176 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgDJVOX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 17:14:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 524B661CA0;
        Fri, 10 Apr 2020 17:14:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d5ijQbeP6x3RraMXpAZ6EZ6aVRg=; b=rQVoy+
        S4UFdL4wuKw/3x9pjSoLPFsHNfL0nfjqrhw29IaortLYuqW7tFoLPvnmzFsp9HrH
        S6kNhzUiTu1XndKQpiysOWUNQ/7ET6nvEdLpffmcOvyyx/BY9foEpIMwW/gRT8zE
        kww6J30fgmJIla4P2FZpl0lw7p3VVUeW3ahEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DDgEYpVyZ6Gjo5yQtmXhEVoAqk8Lgh+r
        efLsN46ty+u9FmCLacLi841Fs00juSjkAzziKxqtY//52NNW7d2FyS1ZE7RNsZM6
        ptyi6s9IQ0xxUGAGNG01j/4acQcYXEC3x2aNi+OJnsZCG225QnjsS2knX/962c0G
        IIVFlvBM7/A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A64A61C9F;
        Fri, 10 Apr 2020 17:14:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D28E161C9E;
        Fri, 10 Apr 2020 17:14:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, bturner@atlassian.com,
        sami@boukortt.com, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 0/3] rebase -i: mark commits that begin empty in todo editor
References: <pull.757.git.git.1586474800276.gitgitgadget@gmail.com>
        <pull.757.v2.git.git.1586541094.gitgitgadget@gmail.com>
        <xmqqpncfhy3g.fsf@gitster.c.googlers.com>
        <xmqqlfn3hx1v.fsf@gitster.c.googlers.com>
Date:   Fri, 10 Apr 2020 14:14:21 -0700
In-Reply-To: <xmqqlfn3hx1v.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 10 Apr 2020 14:04:44 -0700")
Message-ID: <xmqqh7xrhwlu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F6B7B52-7B70-11EA-A6FA-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> This is a total tangent, but when I tried to rebase
> jt/rebase-allow-duplicate that builds directly on top of v2.25.0 to
> a newer base, after resolving conflicts, "commit -a" and "rebase
> --continue", somewhere I seem to have mangled the authorship.  It
> could entirely be a driver error, or it may be a bug in "rebase",
> especially with recent backend change.  I am planning to come back
> to it later to figure out if there is such a bug, but I'd need to
> recover from the authorship screwup first, so it may take some
> time.

I think I know how it happens now.

52e8d1942c662 == jt/rebase-allow-duplicate

Attempting to rebase this on top of the 'master', i.e.

    $ git rebase --onto master 52e8d1942c662^ 52e8d1942c662

results in a merge conflict, but it is easy to resolve in the
working tree.  Then after "git add -u" to record the resolution
in the index

    $ git commit
    $ git rebase --continue

gives me the authorship credit.

Back when the default rebase backend was 'apply', making the above
"mistake" was not even possible; "git commit" would have given me an
empty log buffer to edit, without pre-filling anything, to help me
realize that I shouldn't commit.  

With the sequencer backend, however, the above procedure happily
records the commit under the author's name, it seems.

I am not sure if that is a bug.  I am inclined to say so.
