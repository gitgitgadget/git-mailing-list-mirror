Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFE7C433DF
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BE14206DC
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vp+Vu9Mk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbgFDRJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:09:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65298 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729907AbgFDRJA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 13:09:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0EB76D48E;
        Thu,  4 Jun 2020 13:08:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HBm/syrzsolhFj2KNDf5rA3iKUA=; b=Vp+Vu9
        MkeQ2CVhWvcqeA8R/Tdm7TD6l+1QWUQAuFmSEgZTe1vrMr2Z7/6/zhDprYG4g5Ms
        Uze4HYNpNOVUNEdQQvQwAnZsNZfLGrKqMMZAOqJik01kcb3pyIQsgqDc350Ga2e8
        JsTd1naKSplr4t3Tpgm7J2U9QM6+EM/WcL9zs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eXiaahxT8hc8XyKNvnCXpoKOtHzSa7JU
        QB/8CDSgnmy4/SKKhfg3qv+c5WALtAEYPYQU3AycNw/2BZL066NredBQZKFHfEPA
        O0d+pfnlHvNo1r45ndYhDPVjPPHod5XivNYQQCiLjbD7gY4xDfXPI9olVV05m5dd
        MHjPQQdJ7vE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A945F6D48D;
        Thu,  4 Jun 2020 13:08:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2EBD16D48C;
        Thu,  4 Jun 2020 13:08:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Shaun Case <warmsocks@gmail.com>
Subject: Re: [PATCH] sparse-checkout: avoid staging deletions of all files
References: <pull.801.git.git.1591258657818.gitgitgadget@gmail.com>
        <7c34da8e-87b8-5236-4536-4d8fbc3f1e80@gmail.com>
        <CABPp-BFmFd7gxN7cd04GFD9kCFEMbfXdv7dHCYRB4z21AUpZWQ@mail.gmail.com>
        <6e5970f6-9b9b-19ba-1035-f4f53d9ac030@gmail.com>
Date:   Thu, 04 Jun 2020 10:08:57 -0700
In-Reply-To: <6e5970f6-9b9b-19ba-1035-f4f53d9ac030@gmail.com> (Derrick
        Stolee's message of "Thu, 4 Jun 2020 11:23:26 -0400")
Message-ID: <xmqqzh9ipxli.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1426544E-A686-11EA-8B56-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> So maybe be purposeful and include the -a option and expect only the
> .git dir (along with . and ..)?
>
> Something like:
>
> 	cat >expect <<-\EOF &&
> 	.
> 	..
> 	.git
> 	EOF
> 	ls -a clone_no_checkout >actual &&
> 	test_cmp expect actual &&

Is it guaranteed that everybody has dot and dot-dot in their
directory?  

  https://pubs.opengroup.org/onlinepubs/9699919799/utilities/ls.html

has this to describe the "-A" option:

    Write out all directory entries, including those whose names
    begin with a <period> ( '.' ) but excluding the entries dot and
    dot-dot (if they exist).

whose "if they exist" scares me ;-)
