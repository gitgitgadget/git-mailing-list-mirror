Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1A1E94100
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 19:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbjJFTJz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 15:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbjJFTJy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 15:09:54 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093AE95
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 12:09:54 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AFC351AF016;
        Fri,  6 Oct 2023 15:09:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=khUecw6pJ8vw3qVHCPHrhHn5tmU+AwtE0Dyx7y
        0FYkc=; b=tTwJwDD/P/CyybivkJZk1hyK5v6xCt9gZXVLYQNXQt9peEa7FHubBu
        M8pn77m5FWS02Xh84dano3uR5DgZpXMkD4D3W/+WoOLZtEYu8amBh8r8fAOidPVa
        ZBl2qRNk3eI4KzBx+0gKL0AFtDi5aQ4lhBSfl3KUya+wn4zmWYSik=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A6E581AF015;
        Fri,  6 Oct 2023 15:09:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 16E241AF014;
        Fri,  6 Oct 2023 15:09:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 0/4] Performance improvement & cleanup in loose ref
 iteration
In-Reply-To: <pull.1594.git.1696615769.gitgitgadget@gmail.com> (Victoria Dye
        via GitGitGadget's message of "Fri, 06 Oct 2023 18:09:25 +0000")
References: <pull.1594.git.1696615769.gitgitgadget@gmail.com>
Date:   Fri, 06 Oct 2023 12:09:51 -0700
Message-ID: <xmqqwmvz8t4w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EDF651FE-647B-11EE-A7C7-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> While investigating ref iteration performance in builtins like
> 'for-each-ref' and 'show-ref', I found two small improvement opportunities.
>
> The first patch tweaks the logic around prefix matching in
> 'cache_ref_iterator_advance' so that we correctly skip refs that do not
> actually match a given prefix. The unnecessary iteration doesn't seem to be
> causing any bugs in the ref iteration commands that I've tested, but it
> doesn't hurt to be more precise (and it helps with some other patches I'm
> working on ;) ).
>
> The next three patches update how 'loose_fill_ref_dir' determines the type
> of ref cache entry to create (directory or regular). On platforms that
> include d_type information in 'struct dirent' (as far as I can tell, all
> except NonStop & certain versions of Cygwin), this allows us to skip calling
> 'stat'. In ad-hoc testing, this improved performance of 'git for-each-ref'
> by about 20%.

Yay.  That is a very obvious one, once it is pointed out.  Thanks
for noticing and improving.  Looking forward to reading the patches
themselves.

