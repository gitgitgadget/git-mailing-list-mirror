Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F26BC4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 09:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiJNJLF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 05:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJNJLD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 05:11:03 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84773E4C19
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 02:11:02 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 119D115CB85;
        Fri, 14 Oct 2022 05:11:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=c2I+uOH3MueUZcwFFek/zBU7Ka8pXSdm0e8a1IsMaWo=; b=fap+
        4qdWICZSgd22t0KtEMCJv2pSIEfsncOAIZpMEgoeFr1Sof5kA7pKtRWFQbnFpGMn
        ustM59pKt1f1ZLmx5dp6V84B/ohTGamHrEVWqahvP4W5nCkY8HT+WRO9mDcwdqc9
        0DLLTWi1qCSExFaGj4h13/uuO49aFN6L+wuZUDg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 96BD815CB83;
        Fri, 14 Oct 2022 05:11:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AEE6315CB82;
        Fri, 14 Oct 2022 05:10:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] mergetool: new config guiDefault supports auto-toggling
 gui by DISPLAY
References: <pull.1381.git.1665590389045.gitgitgadget@gmail.com>
        <xmqqedvbcrnn.fsf@gitster.g>
        <CAPMMpoigKVzhXu1WqSrx13MP1jR0J+ajkwRVVtY_LwHYAoWeTg@mail.gmail.com>
Date:   Fri, 14 Oct 2022 02:10:58 -0700
Message-ID: <xmqqsfjqbwil.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E86A42C-4BA0-11ED-8932-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

> 1. Why add an OPT_CALLBACK_F arg handler, rather than keeping a simple
> OPT_BOOL arg type?
> Because OPT_BOOL always overwrites with either true or false, so in
> order to have use_gui_tool retain its "_BY_CONFIG" value in the
> absence of an arg, the explicit arg handler function is required.

That is exactly why you want to initialize the variable to something
other than 0 or 1 (say "-1") and use that as "not explicitly
specified from the command line" aka _BY_CONFIG value, isn't it?

And once you do so, you do not need callback and you do not need
enum.  The original "int" can take tri-state, (unspecified = -1,
false = 0, true = 1).

Am I missing something?
