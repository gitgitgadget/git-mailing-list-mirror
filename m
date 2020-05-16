Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E54C433DF
	for <git@archiver.kernel.org>; Sat, 16 May 2020 00:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB7420756
	for <git@archiver.kernel.org>; Sat, 16 May 2020 00:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HMZMlP4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgEPAEt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 20:04:49 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65226 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgEPAEt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 20:04:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 53469CFE9C;
        Fri, 15 May 2020 20:04:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TwarCLd2VRCkdY0kSfWKJGJ/jR4=; b=HMZMlP
        4NAAf7c47X1O1YFiEJgT63Zl9q8JgpuLCg+s9sRltPmm9zWKpGD+tY9tbwjWGTGa
        VzIQ7TJE0PtO1bHzZVNGGRAerlqVKNLpwiDgQ4V+BrysHsXCP2r+YWrVnxAsw3qF
        CFOG485Ojnm9sxoJNfJhHevQ0o/vN4UQGxS5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sp8nprAun+EBtFiYmVp6NzefD7H+AKG3
        EdlagoRzy4d2bIIBh88RDxVTzzQw44REUs+ZVaHZd4KZm9q71suIS88OuJuz0rqt
        4p5OQEShu41MHPUHY/DBxk+AXK58wdfjcnsFytASEO3A6oEBcL0KZ0RUhfrIBKYK
        8/tKQgVJBoA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4B238CFE9B;
        Fri, 15 May 2020 20:04:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 95748CFE9A;
        Fri, 15 May 2020 20:04:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Laurent Arnoud <laurent@spkdev.net>, git@vger.kernel.org
Subject: Re: [PATCH] diff: add config option relative
References: <20200515155706.GA1165062@spk-laptop>
        <20200515233130.GC6362@camp.crustytoothpaste.net>
Date:   Fri, 15 May 2020 17:04:43 -0700
In-Reply-To: <20200515233130.GC6362@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 15 May 2020 23:31:30 +0000")
Message-ID: <xmqq1rnk923o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D91C8896-9708-11EA-9541-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2020-05-15 at 15:57:06, Laurent Arnoud wrote:
>> The `diff.relative` boolean option set to `true` to show only changes on the
>> current directory and show relative pathnames.
>
> Usually when we implement configuration settings like this, we implement
> an option value, such as --no-relative, so that users or scripting tools
> can disable this feature if they need to.  However, I don't see that in
> this series.  Would adding such a feature be possible?

I think I saw a variant that does have --[no-]foobar support on the
list, but I may be hallucinating.  You definitely would want it, or
you've broken "format-patch" forever without a knob to countermand
the configuration (well, you can still say "git -c diff.foobar=no"
but that's kind of cheating).

