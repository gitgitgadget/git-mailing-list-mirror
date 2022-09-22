Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A1CC54EE9
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 19:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiIVTbw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 15:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiIVTbu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 15:31:50 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA46D1075BB
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 12:31:49 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 04E2014A5C3;
        Thu, 22 Sep 2022 15:31:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U1P+lrI60j5skD4Xcr2hCcEk7cX0O4mjoDYhyg
        vsBgk=; b=oxVNE9N2yS/EKCPzvin/zN3RAYc2mlk2M84+fFuFOD7icqCa73zyha
        pUY58e68v7R4eAFuxdn171HMCDP47M1TZGaE/tZMM8piU4BI2c/q6KLctWd0sWX7
        or5oDy1vVMDI0kz5G4RbddIgAZd0rq0Z8NjEwssr8R5dTn8dAYaww=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EFF2A14A5C2;
        Thu, 22 Sep 2022 15:31:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 53CF814A5C1;
        Thu, 22 Sep 2022 15:31:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com
Subject: Re: [PATCH] maintenance: make unregister idempotent
References: <pull.1358.git.1663635732095.gitgitgadget@gmail.com>
        <xmqqpmfo4pc7.fsf@gitster.g>
        <bc57439a-bddc-6c1a-a51d-11498d17c206@github.com>
Date:   Thu, 22 Sep 2022 12:31:46 -0700
In-Reply-To: <bc57439a-bddc-6c1a-a51d-11498d17c206@github.com> (Derrick
        Stolee's message of "Thu, 22 Sep 2022 08:37:47 -0400")
Message-ID: <xmqqtu4zxl25.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 32C13988-3AAD-11ED-978C-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> I am not sure if this is a good idea.  What is the ultimate reason
>> why we want to allow running it blindly without knowing if it is
>> necessary?  Is it because there is no easy way to tell if unregister
>> is needed in the first place?
>
> We want to leave the internal details of what it means to be
> registered as hidden to the user. They could look for the repo in
> the global config, but that seems like a hassle when they just
> want to make sure they are not currently registered. 

OK, so there is no published officially sanctioned way to ask "is
this repository under maintenance's control and cron jobs run in
it?" or "give me the list of such repositories".  

Then I can see why you want to allow users to blindly run
"unregister", with or without "--force".

But doesn't it point at a more fundamental problem?  

Is there a reason why we want to hide the list of repositories
(enlistments?) from the users?


