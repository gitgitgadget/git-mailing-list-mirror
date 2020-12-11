Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE3CC433FE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 23:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF577221E3
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 23:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407002AbgLKXmT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 18:42:19 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52577 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbgLKXls (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 18:41:48 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C72092D23;
        Fri, 11 Dec 2020 18:41:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CGjlwI5nxGp6JjiTiVUVKYtVjPo=; b=umvXsv
        HFt+W70pvytSGpyDN/JfyGVQcBOOBAiXYtZq4WilzCfOapoGAfWt7Yud8FXdsqk7
        PSXeeOjTbzxBaIGnZ05864yTzA5L5nu21v7KIXEOUy+BXfZsL2btf8cETCEeZJa2
        n5WBoZCzXB2d+2No7qwe2PZ/9crpWO+m+9jBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b0HaWuEGbfC5gs4RJYHlZERrmKHIwYOL
        iKfcHQ2/seqcgsskLZt5QrAu2sBALzvsw3VtluoVKVUmFGWcXQNXrZQxlZwvXXaS
        csdfdoNLUQpcUf3G+3HM+or9s27MLvyD7wmy78POX9m1wyMUIrCOxCXtMpTmq2eH
        ZF4EPLItC1E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30BC192D22;
        Fri, 11 Dec 2020 18:41:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F1A292D21;
        Fri, 11 Dec 2020 18:41:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clone: in protocol v2, use remote's default branch
References: <20201208013121.677494-1-jonathantanmy@google.com>
        <20201211210508.2337494-1-jonathantanmy@google.com>
Date:   Fri, 11 Dec 2020 15:41:04 -0800
In-Reply-To: <20201211210508.2337494-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 11 Dec 2020 13:05:08 -0800")
Message-ID: <xmqqeejvj4hb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 55C8DD26-3C0A-11EB-AA00-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When cloning an empty repository, a default branch is created. However,
> it is named after the locally configured init.defaultBranch, not the
> default branch of the remote repository.

The default branch of the remote repository and the current branch
pointed at by their HEAD in the remote repository can be different,
and we are interested in setting our HEAD to the latter.  So 

	..., not the current branch of the remote repository.

> To solve this, the remote needs to communicate the target of the HEAD
> symref, and "git clone" needs to use this information.

Yes.  That's a good change (I am on vacation today, so I won't be
reading the changes themselves today, but I agree with the intent
100%).

Thanks.
