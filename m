Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95770C433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2178D205ED
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PRrNUS8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390806AbgEMTzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 15:55:38 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64230 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732218AbgEMTzi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 15:55:38 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4C6D7C610B;
        Wed, 13 May 2020 15:55:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yhYMVSLxemfLBPTFZ8CzwdgZO8o=; b=PRrNUS
        8CeTo34ptBsJtWThqvYdrV/sT+u1Ww7BKa6epbjs8wsK42SaqdKLX22jyMNsk4Jp
        c/jD+BAsqV/SCgRl3lyPC0DsXfq39kFDRJ3SLOf3+v0XES3gfegZpkZIogmjxTzc
        uvfZZECnM/iKoSc0Mcn8lvhsv6L1mK/P9XkVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=obJ3Rninuwkh3uFRLw27HZTOz9cHQrfy
        onLPhjgn8TQ22NIdULytjWwiOSYhwFSVGWxILwVjD04xEM3hPuCPodxvdyOBPDhW
        yg7MiZJ/M+JPVx3DEjsrx0xYPVIMpYVNR/HBpmqcXEANTKnekW0o0vJak8/sxep1
        MBg1y+rE6uU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 44383C610A;
        Wed, 13 May 2020 15:55:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 753DFC6109;
        Wed, 13 May 2020 15:55:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v13 11/13] Reftable support for git-core
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
        <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
        <ace95b6cd88e3344abfb01f7f11da4a8f7c155dd.1589226388.git.gitgitgadget@gmail.com>
Date:   Wed, 13 May 2020 12:55:31 -0700
In-Reply-To: <ace95b6cd88e3344abfb01f7f11da4a8f7c155dd.1589226388.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 11 May 2020
        19:46:26 +0000")
Message-ID: <xmqqd077txsc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B4B8287C-9553-11EA-A734-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/clone.c b/builtin/clone.c
> index cb48a291caf..4d0cf065e4a 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1108,7 +1108,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		}
>  	}
>  
> -	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, INIT_DB_QUIET);
> +	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN,
> +		DEFAULT_REF_STORAGE, INIT_DB_QUIET);

Where does this symbol come from?

In addition, this will be overwritten in a later step to
default_ref_storage(); perhaps in this step we should use that
instead from the beginning?

