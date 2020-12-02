Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0FFC6369E
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 22:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E814221F7
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 22:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgLBWuM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 17:50:12 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61356 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgLBWuM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 17:50:12 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5BD1699A13;
        Wed,  2 Dec 2020 17:49:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pMcz3p4KBcUoL9WG0X1NfdiJpHQ=; b=J9N7tK
        lj5IjwKUczjJOrNqWZkW6lXV3eo0FzX/ZX7u1QhwIt4W4/c+qTBpXmYCPEoDkcUz
        Bzcv1CIHaWuQ9kGBYAHvK0tnEFBDM611IG9plvYgm6hlwLmEg8C9MmntxvspSzhq
        XtU/RWrsqtNkDuBqQ86h48ShDKSIcfoChvprI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tdZ7Zu1MrQuhZs1Pkna1knKD6GoHhiis
        CVw/lQN9n5pr462E+747W0yb4nhWXkhT/TzSFo4hx3nuSgmLL3AVtxqNS2o173OB
        UJ9zS0QYpMHCPFG8uuiQo7eVJQu4B2/H92IDf45eDMqvcY/n2o8cRiE2dIaH0did
        gWq+GCZvESU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 534A699A12;
        Wed,  2 Dec 2020 17:49:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CA4DE99A10;
        Wed,  2 Dec 2020 17:49:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] Makefile: mark git-maintenance as a builtin
References: <X8b9IyU6E92efYaO@coredump.intra.peff.net>
Date:   Wed, 02 Dec 2020 14:49:27 -0800
In-Reply-To: <X8b9IyU6E92efYaO@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 1 Dec 2020 21:34:11 -0500")
Message-ID: <xmqqa6uvlt6w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1EE70A6-34F0-11EB-A315-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We normally get the list of builtin commands by expanding BUILTIN_OBJS.
> But for commands which are embedded inside another's source file (e.g.,
> cmd_show() in builtin/log.c), the Makefile needs to be told explicitly
> about them.
>
> Since cmd_maintenance() is inside buitin/gc.c, it should be listed
> explicitly in the BUILT_INS list in the Makefile. Not doing so isn't
> _too_ tragic, as it simply means we will not make a git-maintenance
> symlink in libexec/git-core. Since we encourage people to use the "git
> foo" form, even in scripts which have put libexec into their PATH,
> nobody seems to have noticed.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I don't really care that much. I just happened to notice there is a
> git-maintenance pattern in .gitignore which will not ever trigger.
>
> I could actually see an argument that this is not worth doing for new
> commands. The dashed forms of the other commands have worked for a long
> time, so losing them would be a regression. But since git-maintenance
> would never have worked, presumably everybody who cares is using the
> recommended "git maintenance" form already.

I do not care too deeply, but being inconsistent means users have to
remember which ones can still be used in the dashed form when they
use the PATH=$(git --exec-path):$PATH escape hatch, and which ones
cannot.  It strongly discourages folks from writing new scripts with
dashed form "git" commands, which might be a good thing, but it goes
against our commitment to keep dashed form working, so...

> So I'm happy with that direction, too, but in that case we should
> probably remove the .gitignore entry. :)
>
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Makefile b/Makefile
> index d3a531d3c6..1e507b9de0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -769,6 +769,7 @@ BUILT_INS += git-cherry-pick$X
>  BUILT_INS += git-format-patch$X
>  BUILT_INS += git-fsck-objects$X
>  BUILT_INS += git-init$X
> +BUILT_INS += git-maintenance$X
>  BUILT_INS += git-merge-subtree$X
>  BUILT_INS += git-restore$X
>  BUILT_INS += git-show$X
