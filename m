Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF44C47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 14:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E171206A3
	for <git@archiver.kernel.org>; Mon, 11 May 2020 14:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FDniNieA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbgEKOdg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 10:33:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63057 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbgEKOdg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 May 2020 10:33:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D098A4D08D;
        Mon, 11 May 2020 10:33:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QYKXjyYhj53u/tZsK2Q7PwyeHTQ=; b=FDniNi
        eAm4ZsqqS/toMKB1WL3PfS3vzklnd0KJZRze2/C+FxxpoV6KrQk3XPhJk7qYp6uP
        k7xHg/iFcs60der/mXiGD1wEfO+zS/idtVnjOFFExoXwU97oUfwTnqPsz3GsEqvh
        EnD1vpQDlFrJlOWdCSPAXRn41i6lo7jZTleZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fs6dMalKtgIYhz9JA05eFiHoEWvejI6/
        ofJYPXR0PxnU2gIU/TzDCwpND4iXH6+HTVgDW8g9gPVYF1fv0ta82EI9776Z9inV
        Nb63hlz1N6aGcRvP4pX65+4BgmeFHwQzseNHxHtkzHZIAKFL9r6zlg50NkNHeYwS
        1vE6zUGa8cU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C39E44D08C;
        Mon, 11 May 2020 10:33:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 325FD4D08B;
        Mon, 11 May 2020 10:33:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Benjamin <ben.knoble@gmail.com>
Cc:     321.george@gmail.com, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] contrib/git-jump: cat output when not a terminal
References: <4CFBC77A-6518-4BEE-A210-6A7C818B9738@gmail.com>
Date:   Mon, 11 May 2020 07:33:32 -0700
In-Reply-To: <4CFBC77A-6518-4BEE-A210-6A7C818B9738@gmail.com> (Benjamin's
        message of "Sun, 10 May 2020 16:26:33 -0400")
Message-ID: <xmqq1rnqtubn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 641C9E18-9394-11EA-A66A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Benjamin <ben.knoble@gmail.com> writes:

> Junio writes:
>
>> I somehow doubt that users of vim types "!git jump diff" (or
>> whichever submode they want) from within vim's command prompt;
>> wouldn't they typically wrap the invocation in a vim macro?
>
> Vim-user here. I run "git jump (options)" from a shell quite a bit, but when I'm
> in vim I tend to use ":Ggrep" and similar commands from the fugitive plugin [1].
> I don't *think* I'm alone in this.

I can believe there are tons of users of the plugin.  My point still
stands---such a plugin can export GIT_EDITOR=cat when running "git
jump" and there is no need to change "git jump".
