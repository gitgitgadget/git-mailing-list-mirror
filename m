Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C9BEB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 16:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjGUQiy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 12:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjGUQib (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 12:38:31 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F824207
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 09:36:55 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C6D3E1A8BE2;
        Fri, 21 Jul 2023 12:36:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tLHNZUEYAdHUeaBOdNpHSnAs4TfIRJ3CR1VVpQ
        98t00=; b=X6ASwUzrFM40Dh2TCjaclcT8TlllxKoYvsGhvqpv+rNxUoyF0XNT+b
        8nytr5eSDwkjVCbmBPlwhvdjL3dYmTzAvgsWKX2IcKiHN9F6hknRbZnOhBXO5I1m
        9qEDnCV1zrDG6I6uLsd5J8nYQJ8S6zetstSDXkvZ1ZgRYh6HAs26A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE3521A8BE1;
        Fri, 21 Jul 2023 12:36:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2D30D1A8BE0;
        Fri, 21 Jul 2023 12:36:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH 1/2] config: return positive from git_config_parse_key()
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com>
        <99244816307b822bd8ffcbff8690ef449c797a23.1689891436.git.gitgitgadget@gmail.com>
        <xmqq4jlx28c6.fsf@gitster.g>
        <kl6ltttxz1jj.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Fri, 21 Jul 2023 09:36:12 -0700
In-Reply-To: <kl6ltttxz1jj.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Fri, 21 Jul 2023 09:12:32 -0700")
Message-ID: <xmqqa5vpw7b7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B4A8180C-27E4-11EE-8ABF-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Oh, interesting. I was trying to follow the conventions of the
> surrounding config.c code and many other parts of the codebase, which
> returns positive values. Why do we choose to return postive values
> throughout the codebase, by the way? Is it because they were really
> intended for exit(3), and not to be used as a library.

If config.c does that, I'd say that was poorly designed oddball.
Looking at read-cache.c (which is older parts of the codebase
written back when the developer base was smaller) may give you a
better examples to follow.  After all, error() returns negative
exactly because we want to follow the usual "negative is an error"
convention.
