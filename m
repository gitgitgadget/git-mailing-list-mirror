Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BCCC3F2D1
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 21:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AB022B48
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 21:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ltZkakN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgCBVvQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:51:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54015 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgCBVvM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 16:51:12 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 34A1739670;
        Mon,  2 Mar 2020 16:51:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ynJmpFMDLMFkVIr0eYdnakLzF18=; b=ltZkak
        N8Ty4HUUoQaasP5YKnYSlgLNbp3QdRKTCfTc8lmxUe9mZ1FEi0PnvZayErfUqEhm
        g+Zk+zLi1X5ePeuOF4l+kBI5++qHjL3HXusYZG+jP4sk7eC6cPBhthke4G7euh59
        S9vJDXdIPrWanZ0Yl5x8oe3uGNh1Z8dEpjvtA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rc6JAQPLEfFYC/Gkcrig0JgyMJRPqP+a
        YalqM3NvrvYFkNZybpw/C3YysHHxDUKCV3gUSPgGOUnekbLe5CPtwb0Mbyxi6+4E
        kawAOeSWPS/YbixI0dcLAVBC59Gtx+yWtX+LiB6nmtIqCE+9vKxduw98C9IQe0F3
        AQ0je4vKTKQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C6223966F;
        Mon,  2 Mar 2020 16:51:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 94D9C3966E;
        Mon,  2 Mar 2020 16:51:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Robert Dailey <rcdailey.lists@gmail.com>,
        rsbecker@nexbridge.com, Konstantin Tokarev <annulen@yandex.ru>,
        Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH v3] pull: warn if the user didn't say whether to rebase or to merge
References: <20200229212258.373891-1-alexhenrie24@gmail.com>
        <CABPp-BEewypPoDrWesk=6twgj2TMGFYdaYzdrg5p4K+mExHqeg@mail.gmail.com>
        <CAMMLpeS2Fq3Nj2QjvNT6i_+ceDHW-pUqTRUhmARWen-jWQfsJg@mail.gmail.com>
Date:   Mon, 02 Mar 2020 13:51:08 -0800
In-Reply-To: <CAMMLpeS2Fq3Nj2QjvNT6i_+ceDHW-pUqTRUhmARWen-jWQfsJg@mail.gmail.com>
        (Alex Henrie's message of "Sat, 29 Feb 2020 20:27:56 -0700")
Message-ID: <xmqq36aqbf3n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED3AFF42-5CCF-11EA-AAC9-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> On Sat, Feb 29, 2020 at 4:31 PM Elijah Newren <newren@gmail.com> wrote:
>>
> ... We also want the user to understand that they
> only have to set pull.rebase or pull.ff once, whereas a command-line
> flag applies only to the current pull.

I do not think the phrasing you used has the intended effect.

    You can replace "git config" with "git config --global" to set a
    default preference for all repositories.  You can pass --rebase,
    --no-rebase, or --ff-only on the command line to override the
    configured default per invocation.

may be more appropriate.  "You can use it, but you need to do so
every time you pull" drives readers away by placing stress on how
cumbersome it *can* become, but in practice, nobody would use the
same command line option every time anyway.

In contrast, explaining the command line option as a useful
mechanism for one-shot override, and the configuration variable as a
useful mechanism for set-and-forget convenience feature, would teach
readers in what situation use of the configuration variables and the
command line options shine the best.

Thanks.
