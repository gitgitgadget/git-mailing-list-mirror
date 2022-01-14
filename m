Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7993BC433EF
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 05:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236454AbiANFrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 00:47:15 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55940 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbiANFrO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 00:47:14 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 745F3162B56;
        Fri, 14 Jan 2022 00:47:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f7MXA/N85NUu4r6BKCw4vKhcAl/eJYkzLVukpq
        s16YU=; b=mpi9q4HZooF+WDUxibnos0o3uGoapJrUz2p4eokFnusNPYXTKnjPfR
        rusH/MwQ24NQjw07T/7Wgaqk9inJ96LV6lAI0xgRvcoXJu3VdbWwOK7pbWDXJk45
        lgzxs3jOEMN6szpISiBqifOqQTtdbkZczogZqTA9LXtd72G8q6ii0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6C6D5162B55;
        Fri, 14 Jan 2022 00:47:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D2C8E162B54;
        Fri, 14 Jan 2022 00:47:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH v1 0/1] ls-remote: inconsistency from the order of
 args and opts
References: <cover.1642129840.git.dyroneteng@gmail.com>
Date:   Thu, 13 Jan 2022 21:47:10 -0800
In-Reply-To: <cover.1642129840.git.dyroneteng@gmail.com> (Teng Long's message
        of "Fri, 14 Jan 2022 12:24:22 +0800")
Message-ID: <xmqqfspqeun5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B625996-74FD-11EC-9FEE-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> +test_must_fail 'Exchange the order of "--heads" and <remote>' '
> +    git --version &&
> +    git init "test.git" &&
> +    test_commit -C "test.git" one &&
> +    git -C "test.git" ls-remote --heads ./. > result.1 &&
> +    git -C "test.git" ls-remote ./. --heads > result.2 &&

I would say that this is working exactly as designed.  As with the
unix tradition, after the command name, first come options
(e.g. "--heads", "-v", etc. that begin with a dash or two dashes),
then arguments like "origin", "master", "." that are not dashed
options/flags.

Then among the arguments, we generally take revs first and then
pathspecs.  "git help cli" explicitly mentions this, because it is
specific to "git" command suite, but it does not mention "dashed
options/flags first and then args", primarily because, at least back
when the documentation was written, this was taken as granted, iow,
those who wrote the "gitcli" documentation thought it was a common
knowledge among users that did not need to be spelled out.

Apparently, it is not a common knowledge at least for you (and
probably others).  Perhaps we should add a paragraph to the cli help
and explicitly mention "options first and then args", before we go
on to say "among args, revs first and then pathspecs".




