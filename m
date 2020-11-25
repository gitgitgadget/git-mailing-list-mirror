Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E46C2D0E4
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 03:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92C2C20872
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 03:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QxPPdHHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgKYDMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 22:12:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53394 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgKYDMM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 22:12:12 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B0A098DA1;
        Tue, 24 Nov 2020 22:12:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8GSC5Vf4rmeGgVgleyoKvwdBXAI=; b=QxPPdH
        HqUrMvhMN05HDOpCZZo+57DegqJJvqM7sSIDlCvuIUdiVm8i5WTE5UFWXYIXNsn6
        ffxJxbneGcNLZBDHhZg4GGqvn7ykHTd/pKG1V+lY1pX5SSAqG03/Ux/7gmrfP1+1
        6U6if5fEx+1AnurBGcu3mQq5Vwj2NNNaCDVZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q1gkLdxFR7VYeyZHW4GyRz4/0NdvogZO
        3wxOxCjT8TG2P4fAGMNUJC9gNhF8CYlnhKBPMhwGM+1bMO6m6oMBGoH/CwFrTy5W
        u0ca3P47xDUJkVEJqt6WTnYkPmlIq9RvNVFQl5bdh0QubMafGszsMIfOVDwvbvA1
        +67SHkRD7F8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DC9798DA0;
        Tue, 24 Nov 2020 22:12:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 65CF898D9F;
        Tue, 24 Nov 2020 22:12:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Han-Wen Nienhuys via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>, "'Han-Wen Nienhuys'" <hanwenn@gmail.com>,
        "'Han-Wen Nienhuys'" <hanwen@google.com>
Subject: Re: [PATCH] move sleep_millisec to git-compat-util.h
References: <pull.922.git.git.1606245012068.gitgitgadget@gmail.com>
        <xmqq8saqifu3.fsf@gitster.c.googlers.com>
        <011801d6c2ae$dcdbaad0$96930070$@nexbridge.com>
Date:   Tue, 24 Nov 2020 19:12:08 -0800
In-Reply-To: <011801d6c2ae$dcdbaad0$96930070$@nexbridge.com> (Randall
        S. Becker's message of "Tue, 24 Nov 2020 17:12:08 -0500")
Message-ID: <xmqqy2iqf7uf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01441608-2ECC-11EB-B3BF-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> I have a platform fix that I'd like to apply once this makes it into the
> main code. The sleep_millisec uses poll(), which is rather heavy-weight on
> the NonStop platform. We have a much more efficient sleep function available
> (with microsecond resolution), which would be more useful unless there is a
> poll side-effect on which git depends. Would this be acceptable? I could
> push this at any time really.

We strongly prefer not to contaminate generic part of source with
platform specific conditional compilation.

If this were a much larger helper function, it might make sense to
perform the compat/*.c dance, but in this case:

 * [PATCH 1/2] that implements sleep_millisec() in git-compat-util.h
   as a static inline function; and then

 * [PATCH 2/2] that does the equivalent of your patch below, but in
   git-compat-util.h

might be the cleanest.

> index bcda41e374..972ecd67bf 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -4,6 +4,10 @@
>  #include "cache.h"
>  #include "config.h"
>
> +#ifdef __TANDEM
> +#include <cextdecs> /* for PROCESS_DELAY_ */
> +#endif
> +
>  static int memory_limit_check(size_t size, int gentle)
>  {
>         static size_t limit = 0;
> @@ -650,7 +654,11 @@ void write_file(const char *path, const char *fmt, ...)
>
>  void sleep_millisec(int millisec)
>  {
> +#ifdef __TANDEM
> +       PROCESS_DELAY_(millisec * 1000LL);
> +#else
>         poll(NULL, 0, millisec);
> +#endif
>  }
>
>  int xgethostname(char *buf, size_t len)
>
> Regards,
> Randall
