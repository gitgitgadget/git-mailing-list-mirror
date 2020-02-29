Return-Path: <SRS0=C4D3=4R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66997C3F2C6
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 16:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166782073D
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 16:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FQtqe4Ly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgB2Qvn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Feb 2020 11:51:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54213 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbgB2Qvm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Feb 2020 11:51:42 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AAAA05051A;
        Sat, 29 Feb 2020 11:51:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UpN/MYa7zzBhvw6pKaqHX6aes6g=; b=FQtqe4
        LymcXNVES9m53bSPtHq2mCrSJurC6POrK1JSSrwjrQSLDXUbDpuRDcmbYkL2NdDu
        bAaf3LYThdrR2zWMra+0XgRshwL+ZAPZexkXnOIQSprpFfRf6ApLzFx6HwJ8538/
        pePmYewIz/lL7wU7oNPwjXUEZXR/pkArKGzv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=An2HMPLPIdjETzLGkRjmdrh1pLwX/3fE
        lM0K+DDArHFmt6H5blP5umqyK1olMKM1gvecOw5nIRvwtbZTRMTGBdyVsWxe9Rug
        Kdw8hLaA4ROWCwQcSgVULisT8R+RV8zirTNdSZeZ7MPKT3/fL2X8OUnD/ESyRh1M
        LG7Hj90gT9s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1E8E50519;
        Sat, 29 Feb 2020 11:51:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 10F2850518;
        Sat, 29 Feb 2020 11:51:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, rcdailey.lists@gmail.com, newren@gmail.com,
        rsbecker@nexbridge.com, annulen@yandex.ru
Subject: Re: [PATCH v2] pull: warn if the user didn't say whether to rebase or to merge
References: <20200229010927.335119-1-alexhenrie24@gmail.com>
Date:   Sat, 29 Feb 2020 08:51:38 -0800
In-Reply-To: <20200229010927.335119-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Fri, 28 Feb 2020 18:09:27 -0700")
Message-ID: <xmqqzhd1balh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1B98CC0-5B13-11EA-AB19-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> +		warning(_("Pulling without specifying whether to rebase or to merge is discouraged\n"
> +			"and will be disallowed in a future Git release.\n"

Sorry for not catching this in the earlier round, but I do not think
anybody argued, let alone the community came to a concensus on
doing, such a strong move.  Am I mistaken?

I certainly did not intend to, at least when I commented on the
earlier round and proposed an updated log message, I wasn't even
aware of the possibility that we may want to turn this into die()
after a transition period.

Not that I'd object strongly to the idea, but it was somewhat
unexpected.

If we are proposing to make it a long-term plan, that should
certainly be written down in the proposed log message.

> +			"Next time, run `git config pull.rebase (true|false)` first\n"
> +			"or pass --rebase, --no-rebase, or --ff-only on the command line.\n

I am somewhat puzzled by "first, or".  You certainly mean the config
to be "set and forget", and you do not want to say "before you pull,
do this first, always", but somehow the latter is the impression I
got.

But it does not sound to me like "Next time, and only next time, do
this configuration.  You can countermand the choice you make from
the command line later if needed", which I think is what you meant
to convey to your readers.
 
    You can squelch this message by `pull.rebase` configuration
    variable to show your preference.  By passing --[no-]rebase
    or --ff-only from the command line, you can countermand the
    choice per invocation.

is what I came up with, but I am not quite happy with it.  It is
overly long to start with X-<.

"));
> +	}
> +
>  	return REBASE_FALSE;
>  }
