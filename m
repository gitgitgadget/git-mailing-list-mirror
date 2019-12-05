Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF82AC43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 17:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7DEF21835
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 17:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M+mubqUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbfLERn6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 12:43:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56504 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729711AbfLERn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 12:43:58 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0860A1B631;
        Thu,  5 Dec 2019 12:43:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=51AYIVLpDvaHWRxer/LL1DKhyKc=; b=M+mubq
        UZEF9iR/yM6x9aACy79sVYWPVHDXh57B4UmBiT5DmizmQiq2YsjoCuqiy8ImU349
        3tXd/RcD49zeemtocpSA5GX6XGuwLnMEiCAFaiYn293Fg6djSBXwYmE8eXtFrnPO
        gcAB+i39wS1eWHqGUv4W9hhzxXo4mTl+VGsL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mrCifmX4plfUGL6TTSHIaKjW+qOEuF9l
        QgzzPh0axUuR237U+Iqr91v6dlxak1pXDpr1l3JJkwndUNI20kSE6r+ekL7CGcN/
        zkL0WbBwgf0zaJIgHKYVW/WbN1Rt2eCi/n8G3b4Zd+0MYLZhbBawpSL8jsvVMvb8
        TiynoibvmVM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F31D61B630;
        Thu,  5 Dec 2019 12:43:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 53BE01B62C;
        Thu,  5 Dec 2019 12:43:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Nathaniel Manista'" <nathaniel@google.com>, <git@vger.kernel.org>
Subject: Re: [ISSUE] Stop accessing, storing, and sharing the user's time zone
References: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
        <047b01d5ab92$159a8240$40cf86c0$@nexbridge.com>
Date:   Thu, 05 Dec 2019 09:43:54 -0800
In-Reply-To: <047b01d5ab92$159a8240$40cf86c0$@nexbridge.com> (Randall
        S. Becker's message of "Thu, 5 Dec 2019 12:33:13 -0500")
Message-ID: <xmqqwobazmzp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CEF74326-1786-11EA-A105-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> .... I currently am
> running a repository located at UTC+2, with developers at
> UTC-5. It is driving us a bit wonky. I would rather see only UTC.

If "seeing" is the primary reason (i.e. you want to compare times
your people worked on their commits), you can always do that on the
display side (e.g. "git log --date=local").  It is not a good excuse
to advocate for information loss.

I also feel that TZ being PII is not particularly a brilliant
argument against recording TZ---of course it is PII, so are the
committer e-mail address and the committer name.  Those who want to
hide can hide but in order to keep track of provenance who did what
when, we do record them.

As you can guess from the above reasoning, I am not fundamentally
opposed to introducing user.tz to complement existing user.name and
user.email configuration variables.
