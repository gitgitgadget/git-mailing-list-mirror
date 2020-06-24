Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFA1C433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 01:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16A9521527
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 01:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="v3u4I8Kb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388319AbgFXBFQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 21:05:16 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50668 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387916AbgFXBFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 21:05:16 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5915FD57A2;
        Tue, 23 Jun 2020 21:05:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kxjU6EqefEPzaSPv5V8ZjRdFUPQ=; b=v3u4I8
        KbyiYZGaHKSB2wQyXoMTOFOeP8WzcaOiEiVtDillGT0LheH5tGhlOA/fTagq++We
        GQX/qMYHiXkmf8n3d3JI3yQslokzNtydVcVQfutPotS9T25NqaEPVaFvIwmzd15z
        kuWYGbbmQl+qRzMiQxFTb4XEPvmrX35fEKlU0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ch2oj1b2p7FldeBqWyHSpDhAZIV84tl7
        5sVITqiUoy0Vf8qymeAGvYGjSVVR7GQqz+LIA/Kam6MRYXJdFYN8OBp7nxe+M5J5
        R4TWMWgFMazlkYXMQjCl3z/eML18pAh98Wx8ej/NuoOlHF6PfwhxDzY3FqbflkXj
        EOacoZ+7E9I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4FE3AD57A1;
        Tue, 23 Jun 2020 21:05:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8CEFCD57A0;
        Tue, 23 Jun 2020 21:05:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Don Goodman-Wilson via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 5/8] init: allow setting the default for the initial branch name via the config
References: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
        <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
        <a500e0f214a0ea4bf5cf4e26f688ae68a0b84bcd.1592951611.git.gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 18:05:09 -0700
In-Reply-To: <a500e0f214a0ea4bf5cf4e26f688ae68a0b84bcd.1592951611.git.gitgitgadget@gmail.com>
        (Don Goodman-Wilson via GitGitGadget's message of "Tue, 23 Jun 2020
        22:33:27 +0000")
Message-ID: <xmqqftal9su2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C11074B6-B5B6-11EA-9344-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Don Goodman-Wilson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index a898153901..b8634b5f35 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -269,7 +269,7 @@ static int create_default_files(const char *template_path,
>  		char *ref;
>  
>  		if (!initial_branch)
> -			initial_branch = "master";
> +			initial_branch = git_default_branch_name();
>  
>  		ref = xstrfmt("refs/heads/%s", initial_branch);
>  		if (check_refname_format(ref, 0) < 0)

Continuing with the division of labor between this helper and its
caller, I had this funny dislike of falling back here and not in the
caller.  But with the same idea of using "reinit", we could get rid
of this "if the caller didn't give us initial_branch, fall back
to..." logic from the function.  The caller may do

	reinit = create_default_files(...
			initial_branch ? initial_branch : "master",
			...);
	if (reinit || initial_branch)
		warning(_(...));
	
in the previous step and then we can teach the caller to use the
configured value instead of the hardcoded "master".

That's much better ;-)

Other than that, looks good to me.

Thanks.
