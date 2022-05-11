Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A377C433EF
	for <git@archiver.kernel.org>; Wed, 11 May 2022 23:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348996AbiEKXHY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 19:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348992AbiEKXHW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 19:07:22 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CD95839C
        for <git@vger.kernel.org>; Wed, 11 May 2022 16:07:20 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6E0E91979D1;
        Wed, 11 May 2022 19:07:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GLqTWYxV17ReBsfgvAf0SzgIb+n9e0JK6hNUt6
        /sIEg=; b=xk1karo7jeSD3se+QiDcxAELEB/ptOxtBG23FpA2X0q866TWJhSCDz
        mj4S4zoJouHDy1Coa4Wc+7p3zfHJlTGOeSgLvw9Kz7/WQV6Hhioa9/RJKc6WeIGL
        CnUMkrFzYNoykQCkUScCapXbihvgqWJBpY1r2MqeR7kgdvZf50TBE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6841B1979D0;
        Wed, 11 May 2022 19:07:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1A8C51979CF;
        Wed, 11 May 2022 19:07:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Goss Geppert <gg.oss.dev@gmail.com>
Cc:     git@vger.kernel.org, christian w <usebees@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 1/2] dir: consider worktree config in path recursion
References: <20220505203234.21586-1-ggossdev@gmail.com>
        <20220510171527.25778-1-ggossdev@gmail.com>
        <20220510171527.25778-2-ggossdev@gmail.com>
Date:   Wed, 11 May 2022 16:07:14 -0700
In-Reply-To: <20220510171527.25778-2-ggossdev@gmail.com> (Goss Geppert's
        message of "Tue, 10 May 2022 17:15:26 +0000")
Message-ID: <xmqqsfpfhdnh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 198B353C-D17F-11EC-B2D9-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Goss Geppert <gg.oss.dev@gmail.com> writes:

> Since 8d92fb2927 (dir: replace exponential algorithm with a linear one,
> 2020-04-01) the following no longer works:
>
>     1) Initialize a repository.
>     2) Set the `core.worktree` location to a parent directory of the
>        default worktree.
>     3) Add a file located in the default worktree location to the index
>        (i.e. anywhere in the immediate parent directory of the gitdir).

I think I've mentioned this ealier, but the above only describes the
scenario and does not say what behaviour is expected and what behaviour
is observed.  "no longer works" is OK, but not sufficient.

Easily remedied by saying "It used to do X, but now it does Y" after
the above description of the scenario to describe what happens and
what you want to happen.

> +	git --git-dir="test1/.git" config core.worktree "$(pwd)" &&

I wonder if this lets funny paths to be added to the index, e.g.
would "git add test1" recursively add everything in that directory?

Thanks.

