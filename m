Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B35EB64D7
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 23:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjFWXbV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 19:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjFWXbU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 19:31:20 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFB3D3
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 16:31:19 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 083B919F31;
        Fri, 23 Jun 2023 19:31:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OHRCswOWgK0QjiMNEHdihqJmLqDXqUvy3BeraD
        df7qg=; b=ag7FB7t/hNegukDg5nO2wk9KgSU1/JKuwliefqJog/F+/9+deDcAja
        obRnR+JtWuI+0PzEO5UsPkKrwmAATsO1rBxx3oPZhjI75hhlQGnfuVqdVXy8KFDy
        VfgIPEZFeK/MwcI/1KSsCIaYcjytbl4BHC2Aj3SR80IrUlodDsvr4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0180D19F30;
        Fri, 23 Jun 2023 19:31:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 216C419F2F;
        Fri, 23 Jun 2023 19:31:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Joshua Hudson <jhudson@cedaron.com>
Subject: Re: [PATCH] ll-merge: killing the external merge driver aborts the
 merge
References: <6e1b9ce4-e86d-fe30-e5de-27a3be57eefd@cedaron.com>
        <xmqqttuze2fh.fsf@gitster.g> <xmqq4jmzc91e.fsf_-_@gitster.g>
        <CABPp-BG-KDu0fAC=bydz9A56xguSmgwO6SFDdxZ8h=90qR1PUA@mail.gmail.com>
        <xmqqv8feb0vo.fsf@gitster.g>
Date:   Fri, 23 Jun 2023 16:31:15 -0700
In-Reply-To: <xmqqv8feb0vo.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        23 Jun 2023 09:26:51 -0700")
Message-ID: <xmqqjzvt92nw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C67C8BC-121E-11EE-9835-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Elijah Newren <newren@gmail.com> writes:
>
>> Reviewed-by: Elijah Newren <newren@gmail.com>
>
>
> Thanks for a quick review.

Unfortunately Windows does not seem to correctly detect the aborting
merge driver.  Does run_command() there report process death due to
signals differently, I wonder?

https://github.com/git/git/actions/runs/5360400800/jobs/9725341775#step:6:285

shows that on Windows, aborted external merge driver is not noticed
and we happily take the auto-merged result, ouch.

I am tempted to protect this step of the test with a prerequisite to
skip it on Windows for now.  Anybody with better idea?

Thanks.
