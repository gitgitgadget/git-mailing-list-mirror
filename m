Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699D9C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 18:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJLSMX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 14:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJLSMV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 14:12:21 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D575DED0C
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 11:12:20 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B0F2E154DFA;
        Wed, 12 Oct 2022 14:12:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mz7RGaiRx/Zj5MwX1hnFZcmYlWG9ZkZy7cYYWV
        OfY+I=; b=NzDt9xJ29UEG6+s6+m9tBefQN08sC1U9sri8SXUG4YNXcvYB8Df4kx
        iJDPlZzn4XG9whbdHycTLifwm10YK+KaGy43dFjNdiY0GJf3Yj/OgSrMMK2mxXEM
        Qy5449rMnOvM+HH17GABGl/yWX/2fNrurB0gR3SjlPS7fpQzb4718=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A8A0F154DF9;
        Wed, 12 Oct 2022 14:12:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 02DA2154DF8;
        Wed, 12 Oct 2022 14:12:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH] mergetool: new config guiDefault supports auto-toggling
 gui by DISPLAY
References: <pull.1381.git.1665590389045.gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 11:12:15 -0700
In-Reply-To: <pull.1381.git.1665590389045.gitgitgadget@gmail.com> (Tao Klerks
        via GitGitGadget's message of "Wed, 12 Oct 2022 15:59:48 +0000")
Message-ID: <xmqqpmewlxmo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67AD6746-4A59-11ED-8187-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Tao Klerks <tao@klerks.biz>
>
> When no merge.tool or diff.tool is configured or manually selected, the
> selection of a default tool is sensitive to the DISPLAY variable; in a
> GUI session a gui-specific tool will be proposed if found, and
> otherwise a terminal-based one. This "GUI-optimizing" behavior is
> important because a GUI can make a huge difference to a user's ability
> to understand and correctly complete a non-trivial conflicting merge.
>
> Some time ago the merge.guitool and diff.guitool config options were
> introduced to enable users to configure both a GUI tool, and a non-GUI
> tool (with fallback if no GUI tool configured), in the same environment.
>
> Unfortunately, the --gui argument introduced to support the selection of
> the guitool is still explicit. When using configured tools, there is no
> equivalent of the no-tool-configured "propose a GUI tool if we are in a GUI
> environment" behavior.
>
> Introduce new configuration options, difftool.guiDefault and
> mergetool.guiDefault, supporting a special value "auto" which causes the
> corresponding tool or guitool to be selected depending on the presence of a
> non-empty DISPLAY value. Also support "true" to say "default to the guitool
> (unless --no-gui is passed on the commandline)", and "false" as the previous
> default behavior when these new configuration options are not specified.
>
> Signed-off-by: Tao Klerks <tao@klerks.biz>
> ---
>     RFC: mergetool: new config guiDefault supports auto-toggling gui by
>     DISPLAY

This somehow felt somewhat familiar, so I had to go the list archive
to find https://lore.kernel.org/git/xmqqmtb8jsej.fsf@gitster.g/,
which seems to be the previous discussion.

It would have been much easier if you gave readers the original
context that inspired this design.

