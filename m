Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AEBEB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 23:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjF0XAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 19:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjF0XAO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 19:00:14 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4CE2940
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 16:00:13 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8C5D41ED38;
        Tue, 27 Jun 2023 19:00:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z2cfLiTFTavinEm42otzslEhfnZ6nTtY/ovl8Z
        aget0=; b=hYuMb+5qpP4Wl48qwbbyOSH/jiHgY9+7luYEKMp23DhFhDnAW9PwqS
        avvot6tQqs6mC+G44NhHsd7YdYMECie2c7/9BOkDsk6WmYO3ofGh78Bv+ZyKRKDp
        nso/gi07xENgpcA/VrZoYA9RTm/KTk2a5xyo58XOxw/NX7XA5GJEA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 860801ED37;
        Tue, 27 Jun 2023 19:00:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 75D781ED36;
        Tue, 27 Jun 2023 19:00:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, nasamuffin@google.com, chooglen@google.com,
        johnathantanmy@google.com
Subject: Re: [RFC PATCH 6/8] pager: remove pager_in_use()
References: <20230627195251.1973421-1-calvinwan@google.com>
        <20230627195251.1973421-7-calvinwan@google.com>
Date:   Tue, 27 Jun 2023 16:00:09 -0700
In-Reply-To: <20230627195251.1973421-7-calvinwan@google.com> (Calvin Wan's
        message of "Tue, 27 Jun 2023 19:52:49 +0000")
Message-ID: <xmqq1qhwfr46.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E0AD93E-153E-11EE-A214-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> pager_in_use() is simply a wrapper around
> git_env_bool("GIT_PAGER_IN_USE", 0). Other places that call
> git_env_bool() in this fashion also do not have a wrapper function
> around it. By removing pager_in_use(), we can also get rid of the
> pager.h dependency from a few files.
>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
>  builtin/log.c | 2 +-
>  color.c       | 2 +-
>  column.c      | 2 +-
>  date.c        | 4 ++--
>  git.c         | 2 +-
>  pager.c       | 5 -----
>  pager.h       | 1 -
>  7 files changed, 6 insertions(+), 12 deletions(-)

With so many (read: more than 3) callsites, I am not sure if this is
an improvement.  pager_in_use() cannot be misspelt without getting
noticed by compilers, but git_env_bool("GIT_PAGOR_IN_USE", 0) will
go silently unnoticed.  Is there no other way to lose the dependency
you do not like?

