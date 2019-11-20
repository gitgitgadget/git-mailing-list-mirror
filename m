Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1419EC432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 03:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7D22245C
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 03:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rMMqdxDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfKTD7H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 22:59:07 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57449 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbfKTD7H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 22:59:07 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1DDE9A2C89;
        Tue, 19 Nov 2019 22:59:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ud9hHKFnl7rjPTyZpOH4FmEbN9U=; b=rMMqdx
        DtK26vLF3T2mB7IziVKpesB4Z8ktomj9V6AjT+h60X6nEu4A1OlLc+3esDu1xUiN
        +Bhi4PELakWy+F/roc+Fx3GYbgNSsxeJOxQ2X47ZzbvNsVQ9rGFldxXK2ZDVnY0O
        khuPe/1cNzilbg7xE8HEhWeA1Hu0Tlv+PuMJI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JpYBaHvjPvnuthWrRaqZsUFBuO9KKeSB
        H9AOxbn+ZyhzqiSN4No5n/BqS/FrNYj9adYzTvV8k9YdKyRsWZt05jgpVi1+IRPo
        6KSg5zRv48I/l0pBYUkn+W8/VMqeWJO524dSvAEIZA13+tCUHTGNKJ2AIMsae1cp
        Jcg8gX6lEnQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 16569A2C88;
        Tue, 19 Nov 2019 22:59:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 48FB2A2C86;
        Tue, 19 Nov 2019 22:59:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Holland <anowlcalledjosh@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] userdiff: support Python async functions
References: <20191119150807.8206-1-anowlcalledjosh@gmail.com>
Date:   Wed, 20 Nov 2019 12:59:02 +0900
In-Reply-To: <20191119150807.8206-1-anowlcalledjosh@gmail.com> (Josh Holland's
        message of "Tue, 19 Nov 2019 15:08:10 +0000")
Message-ID: <xmqqeey3ci61.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17CEFE20-0B4A-11EA-B4DA-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Holland <anowlcalledjosh@gmail.com> writes:

> This patch now includes tests for indented declarations, as well as the
> unindented versions which were present before.

Very much appreciated.

I wondered if something like

diff --git a/t/t4018/python-indented-async-def b/t/t4018/python-indented-async-def
index f5d03258af..567c1dafcb 100644
--- a/t/t4018/python-indented-async-def
+++ b/t/t4018/python-indented-async-def
@@ -1,3 +1,6 @@
+async def not_this_one(self):
+    return []
+
 class Foo:
     async def RIGHT(self, x: int):
         return [

would further help, but if a breakage makes us ignore a start of
definition that is indented, we would hit "class Foo:" you added
and notice such a breakage anyway, without additional definition
before it.  So I think what we see in this patch is good.

Thanks.

> ...
>  t/t4018/python-indented-async-def | 7 +++++++
> ...
> diff --git a/t/t4018/python-indented-async-def b/t/t4018/python-indented-async-def
> new file mode 100644
> index 000000000..f5d03258a
> --- /dev/null
> +++ b/t/t4018/python-indented-async-def
> @@ -0,0 +1,7 @@
> +class Foo:
> +    async def RIGHT(self, x: int):
> +        return [
> +            1,
> +            2,
> +            ChangeMe,
> +        ]
> ...
