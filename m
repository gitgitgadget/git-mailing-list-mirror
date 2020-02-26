Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC57C4BA24
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 21:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BCDD24653
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 21:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mMndv15C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbgBZVbq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:31:46 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59815 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbgBZVbq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 16:31:46 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B9A5659648;
        Wed, 26 Feb 2020 16:31:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=54TouMLWwWPbOVE8Q3EeD+/pSc4=; b=mMndv1
        5CVLW3qjFq6O+pq6b9r+7+9Awi6ZUYSVccRVMxHqTEgvHyxec79bpptL+Rk7GcBd
        LmN8p7C6W9Ll8t17cEyDptwAyw/0ddApMFORmEfglJ/3PGTkNwRJJcyzWi/okKZX
        dadUv+Rd1u3IwFT9e3sqbX9T81JgOS74XpWQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rEEae+wuZGt15d5YHk2SOKmaNH46aNVB
        W/yYlmpaR/Xwu6TVxYGCiCoyme7HxWYxX+i9g4cVC8UPwr4zTS/DChLpA8HUKrMR
        yBJUD+5MufL/APdJ4j9KHzDTJLnRsXjbKLyJgPMZEoRXCtlhiI7Fk6pxf9W7wdfk
        wU6GD2gifLU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B108959647;
        Wed, 26 Feb 2020 16:31:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F0DDD59646;
        Wed, 26 Feb 2020 16:31:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v7 6/6] Reftable support for git-core
References: <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
        <pull.539.v7.git.1582706986.gitgitgadget@gmail.com>
        <a622d8066c7fe27accc5101c3341c30bf706dae1.1582706986.git.gitgitgadget@gmail.com>
Date:   Wed, 26 Feb 2020 13:31:38 -0800
In-Reply-To: <a622d8066c7fe27accc5101c3341c30bf706dae1.1582706986.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Wed, 26 Feb 2020
        08:49:46 +0000")
Message-ID: <xmqqwo89ghmt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6003BF68-58DF-11EA-AF13-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  int init_db(const char *git_dir, const char *real_git_dir,
> -	    const char *template_dir, unsigned int flags)
> +	    const char *template_dir, const char *ref_storage_format,
> +	    unsigned int flags)
>  {

This change, and Brian's SHA-256 work, obviously will introduce a
conflict as the other side wants to add an extra parameter to choose
from different hash algorhtims.

I wonder if we should rather add a single pointer to a struct that
can hold various initialization options as an extra parameter.  That
way, each topic can add and manage its own new member in the struct.

>  static int create_default_files(const char *template_path,
> -				const char *original_git_dir)
> +				const char *original_git_dir,
> +				const char *ref_storage_format, int flags)

Pretty much the same story here, too.  The other side aims to be
more generic and passes a "struct repository_format *" as an extra
parameter.  I think the repository-format structure needs to have
what ref backend is in use, so instead of passing only the string
like this patch, we can use the appropriate member from the struct?

Please try to apply this series to 'master', and try to merge the
result with the tip of 'pu', to see if there are other areas that a
better coordination between you and Brian would help moving these
two topics together and work well with each other.

I am not sure how quickly Brian's SHA-256 work solidifies enough to
build on top of, but if it is a good option to build on top of the
topic, that may save some work from this topic, too, as the
mechanism to choose something (i.e. hash algorithm for Brian's
topic, ref backend for this topic) fundamental to the repository at
runtime and at initialization time needs similar supporting
infrastructure, such as changes in "[12/24] setup: allow
check_repository_format to read repository format", and "[13/24]
builtin/init-db: allow specifying hash algorithm on command line"
of that series.

Thanks.
