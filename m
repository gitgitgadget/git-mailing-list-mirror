Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4467CE7C4EF
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 19:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243791AbjJDT6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 15:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjJDT6w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 15:58:52 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6FCA6
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 12:58:49 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EF082348AB;
        Wed,  4 Oct 2023 15:58:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=+36HgnKp/DcP5ICqECyAqS0vZ9PbgE3H+b+JNB
        TAmBc=; b=TtJwsFxHD3b8z0em2b4SKLEFFfdZHXlM5rXpSdxfQmLwKx3wzsd202
        S73QGZvMqE6lxzp2svUibbA4S8DpF+OEmUMWZdEdhbHwj8B0v8wk7VPG9k2zGfUR
        PIfulICIOdIZbXAwOo3XnJwuM6oAuIGCl98drn9z5nYglMjAD4390=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E7E31348AA;
        Wed,  4 Oct 2023 15:58:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8739C348A7;
        Wed,  4 Oct 2023 15:58:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 1/2] attr: add attr.tree for setting the treeish to
 read attributes from
In-Reply-To: <446bce03a96836f35f94e9ef8548cf4a2b041ba8.1696443502.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Wed, 04 Oct 2023 18:18:20
        +0000")
References: <pull.1577.git.git.1695218431033.gitgitgadget@gmail.com>
        <pull.1577.v2.git.git.1696443502.gitgitgadget@gmail.com>
        <446bce03a96836f35f94e9ef8548cf4a2b041ba8.1696443502.git.gitgitgadget@gmail.com>
Date:   Wed, 04 Oct 2023 12:58:43 -0700
Message-ID: <xmqqfs2qp3bg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D036B72-62F0-11EE-BAB2-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> 44451a2e5e (attr: teach "--attr-source=<tree>" global option to "git",
> 2023-05-06) provided the ability to pass in a treeish as the attr
> source. In the context of serving Git repositories as bare repos like we
> do at GitLab however, it would be easier to point --attr-source to HEAD
> for all commands by setting it once.
>
> Add a new config attr.tree that allows this.

Hmph, I wonder if we want to go all the way to emulate how the
mailmap.blob was done, including

 - Default the value of attr.tree to HEAD in a bare repository;

 - Notice but ignore errors if the attr.tree does not point at a
   tree object, and pretend as if attr.tree specified an empty tree;

which does not seem to be in this patch.  With such a change,
probably we do not even need [2/2] of the series, perhaps?


