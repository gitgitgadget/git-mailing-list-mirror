Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3884C83F11
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 18:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjH1SMl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 14:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjH1SMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 14:12:16 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7D699
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 11:12:13 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5B321A5859;
        Mon, 28 Aug 2023 14:12:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zQClLRXQ1craNUHHmDxQ9V7niBNnfJUAXCCwaM
        mnSRw=; b=MOYncjLLUwCLcz87R6N1QQ6r1Kd48721RIbNfpNwf++W4dh6zkZrXa
        PMl6BTqOo8b5DU9xuCXF0/gzKsCVhuEwqQ41SdcVgnBjWyGmaQGLMF63GZOwFVup
        h2s+r83z6yFbj+h09qynYbqDw0XzWqnTF+EJ/0QNSlNn7HsBzJGqs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AD4C71A5858;
        Mon, 28 Aug 2023 14:12:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1CF531A5854;
        Mon, 28 Aug 2023 14:12:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Jeff King <peff@peff.net>, Drew DeVault <sir@cmpwn.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] builtin/log.c: prepend "RFC" on --rfc
References: <20230828125132.25144-1-sir@cmpwn.com>
        <20230828144215.GA2537587@coredump.intra.peff.net>
        <ae22b71b-73ea-4634-bd2a-4b64082be955@gmail.com>
Date:   Mon, 28 Aug 2023 11:12:08 -0700
In-Reply-To: <ae22b71b-73ea-4634-bd2a-4b64082be955@gmail.com> (Phillip Wood's
        message of "Mon, 28 Aug 2023 17:30:36 +0100")
Message-ID: <xmqq1qfnhw93.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67C1385E-45CE-11EE-8E78-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I agree it sounds like a good change but if we're going to change it
> than I think we should ensure
>
>     git format-patch --subject-prefix=foo --rfc
>
> and
>
>     git format-patch --rfc --subject-prefix=foo
>
> give the same result.

Good catch.  The implementation with this patch feel philosophically
dirty, in that the new "--rfc" is no longer "we use a different
subject-prefix" but "this new option is independent from the
subject-prefix; whatever string that other option receives goes
before the title, and our string goes even before that".  And to
reflect that independent nature better, it should just grab the
string into a separate local variable and combine the two into a
single prefix string after parse_options() returns.

Thanks.


