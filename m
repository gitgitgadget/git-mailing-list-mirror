Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F07EC433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 20:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377634AbiATU0K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 15:26:10 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55102 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbiATU0K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 15:26:10 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AE50C17B5D6;
        Thu, 20 Jan 2022 15:26:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uBEEr89RmpzO+hNXH41/lSM1vZEOfWIYCM1yIt
        6SMG8=; b=tTC7TmOPPSUTh3P+DrciYPmAhNvaNU3KqawhhnRYaswXKB5WSAp0hi
        uxdXuiIY29QH3eTmUk8fRd9dvIzCSNPW/encwN3jdElBbfZAMpiaMz8KDQnGZRou
        5EMqKnT/IVGpT+IoLdkElt4Zu7x79kwKaZkzXuBdkqZwXz+PFlDrw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A6C1217B5D5;
        Thu, 20 Jan 2022 15:26:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1D70917B5D4;
        Thu, 20 Jan 2022 15:26:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com
Subject: Re: [PATCH] sparse-checkout: create leading directory
References: <20220120185548.3648549-1-jonathantanmy@google.com>
Date:   Thu, 20 Jan 2022 12:26:05 -0800
In-Reply-To: <20220120185548.3648549-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 20 Jan 2022 10:55:48 -0800")
Message-ID: <xmqqv8yegnmq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 328653D4-7A2F-11EC-8351-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When creating the sparse-checkout file, Git does not create the leading
> directory, "$GIT_DIR/info", if it does not exist. This causes problems
> if the repository does not have that directory. Therefore, ensure that
> the leading directory is created.
>
> This is the only "open" in builtin/sparse-checkout.c that does not have
> a leading directory check. (The other one in write_patterns_and_update()
> does.)
>
> Note that the test needs to explicitly specify a template when running
> "git init" because the default template used in the tests has the
> "info/" directory included.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> This problem is being discussed in [1], and we also noticed this problem
> internally at $DAYJOB. Here's a fix.

Interesting, as $GIT_DIR/info is created during "git init".

But it is possible to lose the directory if there is no need for any
of the files---the user may rmdir or rm -fr it, and it is too harsh
to call the repository "corrupted".

Will queue.
