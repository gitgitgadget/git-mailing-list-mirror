Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A332C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 19:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE28206E2
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 19:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W40N3kNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgCLTbk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 15:31:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61896 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgCLTbj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 15:31:39 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ABDEF3BE38;
        Thu, 12 Mar 2020 15:31:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3I/dl3itBjABSP5QLDDlXGKAY34=; b=W40N3k
        NtIx7ijUlZX9hym0J0zAK4EZwxwE+cJHg0sjjsJZLAaHkTcphI3RoBzQYWsSvN/u
        vSkqWHv8D5xD3CDyXFUuybveopXpHMiQheWJjS3VV1D9WHoWn6w5aVuX5W4OnGJQ
        tRfoknQgoTfq1bjepdGMeNDt+5OlwYZOFFDL8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DOj+EWhgc6je5hTiM9miLavr/16O5Mxx
        JLNLqak3ueiK0aBUwmsL2p+O8HdSCS/DCuEm7Kbg35sH6q3V0XLOaVq4uSd852qZ
        luYUBK3HtiOQEnJ5NVsL4dhXDnB0l6HmfeSvoVYAGMs8E5JJCJEXl4QG5AQSiGW9
        JElWTB6I/HQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A44803BE37;
        Thu, 12 Mar 2020 15:31:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 294E13BE36;
        Thu, 12 Mar 2020 15:31:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Tokarev <annulen@yandex.ru>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [Feature request] "Hooks" for git log
References: <558831584024173@sas1-438a02fc058e.qloud-c.yandex.net>
        <xmqqo8t1flin.fsf@gitster.c.googlers.com>
        <79741584039971@myt6-4d759d962265.qloud-c.yandex.net>
        <87951584041001@myt5-5e0e3f348369.qloud-c.yandex.net>
Date:   Thu, 12 Mar 2020 12:31:36 -0700
In-Reply-To: <87951584041001@myt5-5e0e3f348369.qloud-c.yandex.net> (Konstantin
        Tokarev's message of "Thu, 12 Mar 2020 22:24:22 +0300")
Message-ID: <xmqqblp1fjzb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 16FF0AF6-6498-11EA-B1F8-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Tokarev <annulen@yandex.ru> writes:

>> When pager is in use, git log loads commits lazily when you scroll down.
>> I find this feature rather crucial for working with any long history, and
>> I don't see how to achieve this with pipe.
>
> Nvm, passing to less -R makes it pause when needed. I've never realized it
> was that simple.

Heh, after all once you realize "git log" internally pipes its
output to the pager, doing the same thing yourself should become
trivial ;-)
