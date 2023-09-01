Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A913CA0FEF
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 18:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350531AbjIASLC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 14:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244823AbjIASLC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 14:11:02 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985C610F9
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 11:10:57 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 44E0B2730A;
        Fri,  1 Sep 2023 14:10:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=TTUn8HIwvKmWxHE20xucVZU5zP33aaxML9B+Tx
        5VWMU=; b=HaXdxr8RcVYi7E7FyxyHzDioUToJIOYdqX13IgNNj+Jwy9HNGI8JT9
        yt3yCPdEIsdr6fgx95dx5ldfooMCJAmyx2q5OjUQCZeM5h1iUGkzePzHN31Aqv4m
        WlZe/hC244OhIKDloMF7FFfE2+li/ZDvIxv8oNdpuE8+0ENOmmwPE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3DAD727308;
        Fri,  1 Sep 2023 14:10:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CC155272E9;
        Fri,  1 Sep 2023 14:10:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wesley <wesleys@opperschaap.net>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: [PATCH 1/2] builtin/rebase.c: Emit warning when rebasing
 without a forkpoint
In-Reply-To: <a168fe69-f305-4280-b0e6-9406fbac796f@opperschaap.net> (Wesley's
        message of "Fri, 1 Sep 2023 13:13:37 -0400")
References: <20230819203528.562156-1-wesleys@opperschaap.net>
        <20230819203528.562156-2-wesleys@opperschaap.net>
        <6127b570-5e9b-404f-9802-9135a1c9f31f@gmail.com>
        <a168fe69-f305-4280-b0e6-9406fbac796f@opperschaap.net>
Date:   Fri, 01 Sep 2023 11:10:52 -0700
Message-ID: <xmqqledppxw3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3F03E9E-48F2-11EE-9451-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wesley <wesleys@opperschaap.net> writes:

> The quirk is this: --fork-point looks at the reflog and reflog is
> local. Meaning, having an remote upstream branch will make
> --fork-point a noop. Only where you have an upstream which is local
> and your reflog has seen dropped commits it does something.

Why do you lack reflog on your remote-tracking branches in the first
place?  

The fork-point heuristics, as far as I understand it, was invented
exactly to protect you from your upstream repository rewinding and
rebuilding the branch you have been building on top of.  The default
fetch refspec +refs/heads/*:refs/remotes/origin/* has the "force"
option "+" in front exactly because the fetching repository is
expected to keep the reflog for remote-tracking branches to help
recovering from such a rewind & rebuild.

Puzzled.  
