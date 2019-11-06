Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFC7F1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 01:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbfKFBYs (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 20:24:48 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57725 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730054AbfKFBYs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 20:24:48 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A7D07A46EB;
        Tue,  5 Nov 2019 20:24:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HFUZVfI3rQ42xYrX96xlMefAIuo=; b=i7vYnI
        qRxBj9vwbCXrl2DMu8FrdDKYKrlUyZKjpzkmTblcU9Js9XijRYbOJyF1mWtEkJM4
        kpoDBGZveTV79iZVJtYpzTVe3CSkR4gKrAZeNNiYP3VSY2iNrEhrmDbljMMpfwj8
        mKnX3qZrWJy8mo1G4PXya703ZNBEmn9sf087Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EvJDWxl9WxsHoFA4iO2Wa/dg5OrDO3kg
        Xdp/qgKC7huGgyOrcb5o2zKb0MLj0cSZV/4evvIiZcsZbmvj8SHZy8Zio2B/BIHY
        4I+X+LtdljbqxBsIJfEQi243EJ9SqSh90NtlGBRw1IgyktidFRt9iCGdI44DWFSo
        YKi7ZcuV3lo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A15E2A46EA;
        Tue,  5 Nov 2019 20:24:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CF3C9A46E8;
        Tue,  5 Nov 2019 20:24:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH v2] git-shortlog.txt: include commit limiting options
References: <20191030203603.27497-1-me@yadavpratyush.com>
        <20191104130858.23673-1-me@yadavpratyush.com>
Date:   Wed, 06 Nov 2019 10:24:42 +0900
In-Reply-To: <20191104130858.23673-1-me@yadavpratyush.com> (Pratyush Yadav's
        message of "Mon, 4 Nov 2019 18:38:58 +0530")
Message-ID: <xmqqk18dyexx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36F6CBFA-0034-11EA-8601-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> But since rev-list-options.txt contains some other options that don't
> really apply in the context of shortlog (like diff formatting, commit
> ordering, etc), add a switch in rev-list-options.txt that excludes those
> sections from the shortlog documentation. To be more specific, include
> only the "Commit Limiting" section.

I think this is much better than duplication, and we can improve it
further with follow-up patches.

Many options for history simplification are useful for shortlog.  I
very often use "git shortlog -- cache.h" myself (i.e. limiting to
the given pathspec).  I suspect most of the "--dashed-options"
listed there would make sense for some workflows, even though I do
not use them often enough with shortlog.  The only exception I can
think of that may not be useful at all for the purose of shortlog is
"--simplify-by-decoration".

I agree with the patch that all other sections (i.e. bisection
helper, commit ordering, object traversal, commit formatting and
diff formatting) make little sense to use with shortlog.

> Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
> ---
> That ifdef covers almost the entire document. Is there a better way in
> Asciidoc to do something like this?

I would have excluded each section independently with "Heh, this
part is not needed for shortlog"; that would make it less error
prone against future shuffling of sections in the file.

Thanks.
