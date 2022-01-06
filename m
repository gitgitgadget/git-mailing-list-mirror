Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1780BC433FE
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 18:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242879AbiAFSbK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 13:31:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53862 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242869AbiAFSbH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 13:31:07 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B1DBE105E8A;
        Thu,  6 Jan 2022 13:31:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a1mjJGr8IKSZiXQZL1CncpQ5iX8eUGWcGG0ztT
        hqRIE=; b=TP0p3owkL4Tt1Wh5txVtIrA7XhoDfzjPF4VLN/zVOb/+0z7e2Mc3K5
        b/hpjzSUF3z8hj0/Wcy9/QJwohm6t7jxW6xCXIKzcc7SsI5uhOCNdwQNSh81lILq
        vyUJgejsbgGN71n9fGhbtN/a45isIZBNG3Inv9wkKNeYmKcPHQFkA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9695A105E88;
        Thu,  6 Jan 2022 13:31:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DBD93105E87;
        Thu,  6 Jan 2022 13:31:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     John Cai <johncai86@gmail.com>, git@vger.kernel.org,
        levraiphilippeblain@gmail.com, phillip.wood123@gmail.com,
        Tilman Vogel <tilman.vogel@web.de>
Subject: Re: [PATCH v3] builtin/pull.c: teach run_merge() to honor
 rebase.autostash config
References: <20220106150226.77458-1-johncai86@gmail.com>
        <YdcjCKTrK+W/FCw1@nand.local>
Date:   Thu, 06 Jan 2022 10:31:04 -0800
In-Reply-To: <YdcjCKTrK+W/FCw1@nand.local> (Taylor Blau's message of "Thu, 6
        Jan 2022 12:12:40 -0500")
Message-ID: <xmqqee5kemxj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF4BB798-6F1E-11EC-AF8C-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> +	git clone src dst &&
>> +	test_commit -C src --printf "more_content" file "more content\ncontent\n" &&
>
> Same note here, but I think the `--printf` is unnecessary. Running
> `echo` with "\n" characters in its argument is fine, so this could be
> shortened to:
>
>     test_commit -C src blah file "more\ncontent"

Is that true for everybody's shell, or just dash?

$ bash -c 'echo "a\nb\nc"'
a\nb\nc
$ dash -c 'echo "a\nb\nc"'
a
b
c
