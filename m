Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEB9EED619
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 17:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbjIORZZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 13:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235732AbjIORYy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 13:24:54 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D4B10F7
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 10:24:49 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 099242C8ED;
        Fri, 15 Sep 2023 13:24:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=DRHkGxs+PnmmsILcC0c5BZO5BuCsrwhV0zy4fG
        OS5OA=; b=ETylpTj7ehC5Gb06xBARgkdXWXlMabmBXSN0a8SreVqsIyGRHdU4sO
        EOncVzl+3FhZPiv/4Wn/9qqQ3IQC1liT/uV8+7UxCVICsa5a58k5xU5RsbnFJ8zn
        NN3bS6IqGZq/l0IzF4aTQ639VU+AAUM2G2qDw1FvfCZXV0zKtnNu8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 00F862C8EC;
        Fri, 15 Sep 2023 13:24:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0B3FC2C8EB;
        Fri, 15 Sep 2023 13:24:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] diff-merges: introduce '-d' option
In-Reply-To: <87y1h8wbpo.fsf@osv.gnss.ru> (Sergey Organov's message of "Fri,
        15 Sep 2023 02:56:35 +0300")
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20230909125446.142715-3-sorganov@gmail.com>
        <xmqqtts0tof8.fsf@gitster.g> <87o7i7hler.fsf@osv.gnss.ru>
        <xmqqled8h01w.fsf@gitster.g> <87y1h8wbpo.fsf@osv.gnss.ru>
Date:   Fri, 15 Sep 2023 10:24:43 -0700
Message-ID: <xmqqzg1nfixw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C364E90E-53EC-11EE-85DA-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> I don't see why desire to look at diff-to-first-parent on "side"
> branches is any different from desire to look at them on "primary"
> branch

Yeah, but that is not what I meant.  The above argues for why
"--diff-merges=first-parent" should exist independently from the
"--first-parent" traversal *and* display option.  I am not saying
it should not exist.

But I view that the desire to look at any commits and its changes on
the "side" branch at all *is* at odds with the wish to look at
first-parent change for merge commits.  Once you decide to look at
first-parent change for a merge commit, then every change you see
for each commit on the "side" branch, whether it is shown as
first-parent diff or N pairwise diffs, is what you have already seen
in the change in the merge commit, because "git log" goes newer to
older, and the commits on the side branches appear after the merge
that brings them to the mainline.

Making "log -d" mean "log --diff-merges=first-parent --patch" lets
that less useful combination ("show first-parent patches but
traverse side branches as well") squat on the short and sweet "-d"
that could be used for more useful "log --first-parent --patch",
which would also be more common and intuitive to users, and that is
what I suspect will become problematic in the longer run.

Thanks.

