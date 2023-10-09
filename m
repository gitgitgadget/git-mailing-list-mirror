Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64956CD613C
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 22:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378642AbjJIWCJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 18:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378238AbjJIWCI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 18:02:08 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D878499
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 15:02:07 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C4B6F1A23C2;
        Mon,  9 Oct 2023 18:02:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=4djkLi+osusVE+usjuk461tXn0gIp6EBJLjPRc
        xmfUo=; b=ekpjdKjo1oC5OdxpQany4st+5FjEo0zjQrHefBwxd88dF+Fb7oeu0T
        W/vM/FkcL6KkBjcVm/9f8Ej0uboN+Z7HsI/2TtMNUFzJ52tLnse3wDUtPZRlwwdf
        0ch0WI2sdifUMLHMRr0bqw2czH9vuI7IFsY6Be4ppR+DfFkd4HCsM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A4E071A23C1;
        Mon,  9 Oct 2023 18:02:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8FCCD1A23BF;
        Mon,  9 Oct 2023 18:02:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] rev-list: add support for commits in `--missing`
In-Reply-To: <20231009105528.17777-1-karthik.188@gmail.com> (Karthik Nayak's
        message of "Mon, 9 Oct 2023 12:55:25 +0200")
References: <20231009105528.17777-1-karthik.188@gmail.com>
Date:   Mon, 09 Oct 2023 15:02:03 -0700
Message-ID: <xmqqwmvvwj38.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7BD89C14-66EF-11EE-ABE6-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

> This series is an alternate to the patch series I had posted earlier:
> https://lore.kernel.org/git/20230908174208.249184-1-karthik.188@gmail.com/.
> In that patch, we introduced an option `--ignore-missing-links` which
> was added to expose the `ignore_missing_links` bit to the user. The
> issue in that patch was that, the option `--ignore-missing-links` didn't
> play well the pre-existing `--missing` option. This series avoids that
> route and just extends the `--missing` option for commits to solve the
> same problem.

Thanks for exploring the problem space in the other direction.

I haven't really thought things through yet, but it looks to me that
the updated behaviour of "--missing" is more in line with what the
option would have wanted to be from day one.

> Karthik Nayak (3):
>   revision: rename bit to `do_not_die_on_missing_objects`
>   rev-list: move `show_commit()` to the bottom
>   rev-list: add commit object support in `--missing` option
>
>  builtin/reflog.c            |  2 +-
>  builtin/rev-list.c          | 93 +++++++++++++++++++------------------
>  list-objects.c              |  2 +-
>  object.h                    |  2 +-
>  revision.c                  |  9 +++-
>  revision.h                  | 20 ++++----
>  t/t6022-rev-list-missing.sh | 74 +++++++++++++++++++++++++++++
>  7 files changed, 145 insertions(+), 57 deletions(-)
>  create mode 100755 t/t6022-rev-list-missing.sh
