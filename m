Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5F9C04AA9
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 16:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbjITQHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 12:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbjITQG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 12:06:59 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00681C2
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 09:06:52 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 77A7A34DC4;
        Wed, 20 Sep 2023 12:06:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=BXFj+s6h+Sjhe8xG26DKDJ4cNvF5QNJJKec4Py
        TZkDA=; b=DhZqtIuuJPI2aMAZeR76kotanXOPRMjIDcieB+fQhCACXbDO2txrcU
        sp/CAxNMPvAhq3RM/PNzYpc543DqbWionooBfnOFcDaJ23GKP90LEAHGh0z3V19H
        wg8yDuq78i0Z0m1hAYJgcikvCZ0AseGAkIxOA6tesmt906mGHFvJU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6FF7E34DC3;
        Wed, 20 Sep 2023 12:06:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A728234DC1;
        Wed, 20 Sep 2023 12:06:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] attr: attr.allowInvalidSource config to allow invalid
 revision
In-Reply-To: <pull.1577.git.git.1695218431033.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Wed, 20 Sep 2023 14:00:30 +0000")
References: <pull.1577.git.git.1695218431033.gitgitgadget@gmail.com>
Date:   Wed, 20 Sep 2023 09:06:46 -0700
Message-ID: <xmqqfs38akx5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B42159AA-57CF-11EE-8131-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> 44451a2e5e (attr: teach "--attr-source=<tree>" global option to "git",
> 2023-05-06) provided the ability to pass in a treeish as the attr
> source. When a revision does not resolve to a valid tree is passed, Git
> will die. GitLab keeps bare repositories and always reads attributes
> from the default branch, so we pass in HEAD to --attr-source.

Makes sense.

> With empty repositories however, HEAD does not point to a valid treeish,
> causing Git to die. This means we would need to check for a valid
> treeish each time.

Naturally.

> To avoid this, let's add a configuration that allows
> Git to simply ignore --attr-source if it does not resolve to a valid
> tree.

Not convincing at all as to the reason why we want to do anything
"to avoid this".  "git log" in a repository whose HEAD does not
point to a valid treeish.  "git blame" dies with "no such ref:
HEAD".  An empty repository (more precisely, an unborn history)
needs special casing if you want to present it if you do not want to
spew underlying error messages to the end users *anyway*.  It is
unclear why seeing what commit the HEAD pointer points at (or which
branch it points at for that matter) is *an* *extra* and *otherwise*
*unnecessary* overhead that need to be avoided.


