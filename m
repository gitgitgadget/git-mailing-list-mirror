Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7FDC433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 21:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237600AbiF3VdO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237545AbiF3VdM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 17:33:12 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1A117E3D
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:33:11 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B7E1F12FE5A;
        Thu, 30 Jun 2022 17:33:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nnNcKIhg+B1OMT7ZPL172waZxE/SU6eQC2rEg4
        6GeVY=; b=B7uMFxOJtfA7/KfcpvgYwBMDUfudhm/rJweUwZz9Zmp9d7Xl4M50ZQ
        jFrw1Ci6u4flj/NMyEx6+t7LKFSDImoq4XMONNQ4NjE9dzUYXKujwLx1CRsloR/7
        d8Fl+1IfL9Jog4BdBv05ZAx7otIuzigWkG6lGCzJsqsT1nBMS7CZQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ADBF812FE59;
        Thu, 30 Jun 2022 17:33:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1C3A112FE58;
        Thu, 30 Jun 2022 17:33:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Siddharth Asthana <siddharthasthana31@gmail.com>,
        git <git@vger.kernel.org>, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 3/3] cat-file: add mailmap support
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
        <20220630142444.651948-4-siddharthasthana31@gmail.com>
        <61074b4c-c48f-da89-5d03-b280b9c4fedf@gmail.com>
        <CAP8UFD2tYzoKSr7HnQ+LbCE+YWoNqo3qPQrbr7ZWAMnDt+ajCg@mail.gmail.com>
Date:   Thu, 30 Jun 2022 14:33:08 -0700
In-Reply-To: <CAP8UFD2tYzoKSr7HnQ+LbCE+YWoNqo3qPQrbr7ZWAMnDt+ajCg@mail.gmail.com>
        (Christian Couder's message of "Thu, 30 Jun 2022 19:07:00 +0200")
Message-ID: <xmqqletddegb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3CECBB2C-F8BC-11EC-8B63-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> "Even if git cat-file is a plumbing command, it has gained more and
> more high level features like its `--batch-command` mode."

What batch-command and batch do does not sound like "high level" at
all.  It is just "instead of invoking separate process to ask about
each individual object, a single process answers the same low level
requests".

Independent of what this "The output from 'cat-file commit' is
tweaked" feature, I wonder if we want a command that can be used as
a filter.  Just like "git name-rev --stdin" reads a stream of text,
finds commit-looking references in it, and annotates them, the
command (e.g. "git mailmap") would find ident-looking strings and
replaces with the mapped results, or something.

>> > At this time, this patch only adds a command line
>> > option, but perhaps a `cat-file.mailmap` config option could be added as
>> > well in the same way as for `git log`.
>>
>> As cat-file is a plumbing command that is used by scripts we should not
>> add a config option for this as it would potentially break those scripts.

Absolutely.
