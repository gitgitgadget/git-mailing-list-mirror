Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEA4EB64D7
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 23:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345797AbjFPXoM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 19:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFPXoL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 19:44:11 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3032943
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 16:44:10 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D925918DCE7;
        Fri, 16 Jun 2023 19:44:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DRY/wScHyl12TidTi0xaM3taf8he6m+ihL0e84
        wuJtI=; b=sXF/5/rBgEgtHUPgMoCpb8+eVrw7DMflN0XY0Zd24iJ2EzJL13goX+
        yp1y7K/XLSS5zKhyCvtJGclr7/AY2K37NhPFl6KOkvkaaqFo1XD6gmAfIlOtZNeb
        a8zyDTYWRkJTOUBWPHXqD3hvIzuMcAblJn5AX3HsHPFDgjrCJbKYQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF91F18DCE6;
        Fri, 16 Jun 2023 19:44:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3E50E18DCE5;
        Fri, 16 Jun 2023 19:44:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Is MacOS CI flaky?
References: <kl6lilbnrrl1.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Fri, 16 Jun 2023 16:44:08 -0700
In-Reply-To: <kl6lilbnrrl1.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Fri, 16 Jun 2023 15:05:14 -0700")
Message-ID: <xmqqjzw3rn07.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B053E782-0C9F-11EE-BBFE-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> 1. https://github.com/chooglen/git/actions/runs/5294136258
>
> is just
>
> 2. https://github.com/chooglen/git/actions/runs/5292953535
>
> with a fix for "win build", but 2. also failed for completely unrelated
> reasons on osx-*.
>
> Casually clicking through https://github.com/git/git/actions/ suggests
> that others might be experiencing similar failures too?
>
> - https://github.com/git/git/actions/runs/5293250265
> - https://github.com/git/git/actions/runs/5289074140

One of the above two is a topic that mucks with credential seeing a
failure in http test, so I would not be surprised if the topic adds
a test that does not pass on macOS.  Its breakage does seem somewhat
similar to what you are getting.  I didn't check what the above
topic of yours is doing---maybe it is not touching http codepath
and/or the http tests at all?  If that is the case, I would not be
surprised if the existing test is flaky.

The other one is failing tests with p4, which I saw is flaky and
fails to bring up or tear down p4 environment for testing.  I
usually ignore them when I am watching the post-push tests, unless
at a major milestone, in which case I'd "Re-run failed jobs" and
sometimes the breakage goes away (i.e. the failure is flake).

Thanks.
