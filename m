Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51C8C433EF
	for <git@archiver.kernel.org>; Thu, 12 May 2022 20:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358402AbiELUhy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 16:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357126AbiELUhv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 16:37:51 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6946C483A5
        for <git@vger.kernel.org>; Thu, 12 May 2022 13:37:50 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26DF711B5C5;
        Thu, 12 May 2022 16:37:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QNquttdiEv0klAv2EWVkBsDtERPFt2AVEsI9W+
        HW6z8=; b=HRA0bhHq+AGRh0GWRa3CTv4gNKzTp+G57X7EtvNICaN/F0iAMFn/CX
        3CuEiATswQVwDqGO1Wmz91OF7mGfBlaCpAzJGkAccdZqiojJKkmMttm6FgtWBM6L
        FHgmXw+S2oEDUfLQAmY+MpenUfw9Nh5Um6GI4yj5al21W/7JYyd3U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1CEB011B5C3;
        Thu, 12 May 2022 16:37:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 867DC11B5C2;
        Thu, 12 May 2022 16:37:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Huang Zou <huang.zou@schrodinger.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v2] pull: only pass '--recurse-submodules' to subcommands
References: <pull.1262.git.git.1652138854255.gitgitgadget@gmail.com>
        <pull.1262.v2.git.git.1652210747614.gitgitgadget@gmail.com>
        <deafd5db-6303-46b3-a5d5-b4117ba16781@gmail.com>
        <xmqqzgjnhf5u.fsf@gitster.g>
        <6e59a82c-22cc-8f0c-f7f7-94da59e8da89@gmail.com>
        <kl6ltu9vy7sc.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Thu, 12 May 2022 13:37:47 -0700
In-Reply-To: <kl6ltu9vy7sc.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Wed, 11 May 2022 16:21:55 -0700")
Message-ID: <xmqqzgjmebc4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62E04D9E-D233-11EC-9AEB-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Hm, yes that makes more sense. The commit message leads with the bug, so
> it's more consistent to mention the bug in the title too.
>
> It's arguably more _correct_ to say that passing only the CLI option is
> the desired result,

Correct.

If it were clear that the title meant "teach 'git pull' to try
affecting the recursive behaviour of subcommands only when it got
'--recurse-submodules' on its command line", I wouldn't have waited
for retitling.

It however is easy to misread the original title in such a way that
the mention of '--recurse-submodules' refers to the fact that 'pull'
invokes 'fetch' and passes the "--recurse-submodules" command line
option, and "only" incorrectly hints that 'pull' passes only that
option and no other option from the command line when it does so.

That will be puzzling because (1) that is clearly not what we do in
today's code, suggesting this is a totally different change from
what we have in the patch, and (2) it is not clear what we want to
achieve by changing the code in such a drastic way to stop passing
"--all" and other options to "fetch".

So, it is arguable, but the original title does not say what we
wanted it to say, exactly.

