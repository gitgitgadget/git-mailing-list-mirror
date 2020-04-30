Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36ED0C47247
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 21:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA14D20731
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 21:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pgWYexKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgD3VtT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:49:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54880 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgD3VtT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 17:49:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 325FC60E13;
        Thu, 30 Apr 2020 17:49:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AAYoMYinJfcKEMkcKya58eCbjrM=; b=pgWYex
        KAX61q2GFtPCVX9jLgoHA62gGQRvznGYfKE2ylZADuVUW1tLQtRqFih1JNLaIwiO
        Mys5VEF2+7hTCv2zUrIveiy2OCIYA+GhlvQGkmqT+jzC6dDUdn3hPgNcO/wINvjR
        ntAb/K5l5JLYGDgOFRHYo/ONKeAkIQTWc/NFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QYAPTaMp+Nwp4dsi4LrUXmSI9xigWRI5
        eHwJoE4uXlcm+J7I8OlLQ4qrfzlaEa0DmJcSdMmrl7DCTG7NByLuQGVtDnbdal/Q
        ydqV0VDv4ulcLZrvZTT0IvCVL01SC+JnjDzsbQ0DPr9Gq94U+6GhkFVe4C+nH5n2
        JetqNt3cTd0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A71560E12;
        Thu, 30 Apr 2020 17:49:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 915F460E10;
        Thu, 30 Apr 2020 17:49:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v10 03/12] create .git/refs in files-backend.c
References: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
        <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
        <bc89bcd9c8c9b33e517a21bbe7c441538e288ebc.1588018418.git.gitgitgadget@gmail.com>
        <20200430212410.GF77802@google.com>
Date:   Thu, 30 Apr 2020 14:49:15 -0700
In-Reply-To: <20200430212410.GF77802@google.com> (Emily Shaffer's message of
        "Thu, 30 Apr 2020 14:24:10 -0700")
Message-ID: <xmqq368kr6ec.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 703DD68C-8B2C-11EA-A24F-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> -	safe_create_dir(git_path("refs"), 1);
>> -	adjust_shared_perm(git_path("refs"));
>
> Is the reftable completely replacing the refs/ dir? Or is the idea that
> the refs/ dir is only used by the files backend? The commit message
> makes it sound like it's an additional format to support, so I'm a
> little confused. Why does the other currently-existing backend not need
> the refs/ dir at this stage?

Other current backend being the files-backend, which creates it
below, isn't this a no-op at this stage?

What's more interesting is what would happen when a repo is
initialized with the reftable backend as its sole backend.  

Even then, the repository discovery code of existing versions of Git
needs to see a directory with a ".git" subdirectory, in the latter
of which there must be HEAD and objects and refs subdirectories, so
we'd need to create refs/ directory even if reftable does not use it.

This step, from that point of view, may not be necessary.  But as
long as we make sure any repository creates refs/ and objects/
directories, regardless of the ref backend, we'd be OK.
