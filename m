Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57BCC2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 23:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7854E2467C
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 23:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qZb/4s+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgA0XMZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 18:12:25 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59778 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgA0XMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 18:12:25 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 56DC4281D7;
        Mon, 27 Jan 2020 18:12:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D7jAwPmWG5cnmHVhvFb6VAwdC+Q=; b=qZb/4s
        +24MPIOwjlDIz9D+tT67mbJs8ee/HpIU+YLdqqsYgcUhYfuJHIUN4V20aQhso9Kp
        OpZU5BVZOw72I3/PuDcncfZmpuY8CcpJJgLJpad/7hR9J9MCpxWANgKbrjCquqGB
        HQWFF1GcRCxDmh3EC9iZVIX53AlJZt9isbDsw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bDxB4xOszOV2qxD9J+mSmcUqRsRc7lhE
        8VthCkZoT3wL1wZQhXLSfqTR6ujv1uM17H5fuwQEIbswCH9miaKxkcqpnT1cMKG8
        I1kz6qfTvaDCxKYgo3P+Q4ZylcK6hItJFyGvSrITUQxFBObzY9gBoWFS3bcw3GSu
        8xhJjqZEtFQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DDDA281D6;
        Mon, 27 Jan 2020 18:12:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B1908281D4;
        Mon, 27 Jan 2020 18:12:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v5 6/6] config: add '--show-scope' to print the scope of a config value
References: <pull.478.v4.git.1579825267.gitgitgadget@gmail.com>
        <pull.478.v5.git.1579912764.gitgitgadget@gmail.com>
        <2e979d9fa5066f61eb89e3c1a1a34ac813d71700.1579912764.git.gitgitgadget@gmail.com>
Date:   Mon, 27 Jan 2020 15:12:21 -0800
In-Reply-To: <2e979d9fa5066f61eb89e3c1a1a34ac813d71700.1579912764.git.gitgitgadget@gmail.com>
        (Matthew Rogers via GitGitGadget's message of "Sat, 25 Jan 2020
        00:39:24 +0000")
Message-ID: <xmqq7e1ca3ze.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7960694E-415A-11EA-9096-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Matthew Rogers <mattr94@gmail.com>
>
> When a user queries config values with --show-origin, often it's
> difficult to determine what the actual "scope" (local, global, etc.) of
> a given value is based on just the origin file.
>
> Teach 'git config' the '--show-scope' option to print the scope of all
> displayed config values.  Note that we should never see anything of
> "submodule" scope as that is only ever used by submodule-config.c when
> parsing the '.gitmodules' file.
>
> Signed-off-by: Matthew Rogers <mattr94@gmail.com>
> ---
>  Documentation/git-config.txt | 15 ++++++---
>  builtin/config.c             | 36 +++++++++++++++++++---
>  config.c                     | 26 +++++++++++++++-
>  config.h                     | 21 +++++++------
>  submodule-config.c           |  4 ++-
>  t/helper/test-config.c       | 19 +-----------
>  t/t1300-config.sh            | 59 ++++++++++++++++++++++++++++++++++++
>  7 files changed, 141 insertions(+), 39 deletions(-)
>
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 899e92a1c9..2e47765aab 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -9,18 +9,18 @@ git-config - Get and set repository or global options
>  SYNOPSIS
>  --------
>  [verse]
> -'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] name [value [value_regex]]
> +'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] name [value [value_regex]]
>  'git config' [<file-option>] [--type=<type>] --add name value
>  'git config' [<file-option>] [--type=<type>] --replace-all name value [value_regex]
> -'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] --get name [value_regex]
> -'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] --get-all name [value_regex]
> -'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] [--name-only] --get-regexp name_regex [value_regex]
> +'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] --get name [value_regex]
> +'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] --get-all name [value_regex]
> +'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--name-only] --get-regexp name_regex [value_regex]
>  'git config' [<file-option>] [--type=<type>] [-z|--null] --get-urlmatch name URL
>  'git config' [<file-option>] --unset name [value_regex]
>  'git config' [<file-option>] --unset-all name [value_regex]
>  'git config' [<file-option>] --rename-section old_name new_name
>  'git config' [<file-option>] --remove-section name
> -'git config' [<file-option>] [--show-origin] [-z|--null] [--name-only] -l | --list
> +'git config' [<file-option>] [--show-origin] [--show-scope] [-z|--null] [--name-only] -l | --list
>  'git config' [<file-option>] --get-color name [default]
>  'git config' [<file-option>] --get-colorbool name [stdout-is-tty]
>  'git config' [<file-option>] -e | --edit
> @@ -222,6 +222,11 @@ Valid `<type>`'s include:
>  	the actual origin (config file path, ref, or blob id if
>  	applicable).
>  
> +--show-scope::
> +	Similar to `--show-origin` in that it augments the output of
> +	all queried config options with the scope of that value 

There is a trailing SP on this line.  I think I fixed it up when I
queued the last round on 'pu'.  Please double check.

> +	const char *scope = scope_to_string(current_config_scope());

???  Are we using scope_to_string() back again?

I thought I queued a fix-up patch when I queued the last round on
'pu' to unblock the other topic that wanted to build on top.  Please
double check.

Thanks.
