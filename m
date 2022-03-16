Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3BAC433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 19:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351077AbiCPTpp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 15:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346028AbiCPTpp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 15:45:45 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09F1140A7
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 12:44:30 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2349C11F8C7;
        Wed, 16 Mar 2022 15:44:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=K5eG1JoaPaKz/jPtIGBLz9UWUNgboPT2nF4irnXyzfI=; b=F5zB
        aUpcxEP3KwAIX+WXAxzg3jdo7+m/7R0EIqQryAB86pWK/imf/rA9BwlOHQHEV1uP
        sihB81ZGo7J1TTGoyHxxO6rTqsIDeYjaUbJlgrAxykn8cMhMBJaXL6iMfSppiG/q
        v9wI6MghgI7V0ftiUUhaLz6xzGspwreS0lBFMIk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A64D11F8C6;
        Wed, 16 Mar 2022 15:44:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5D6CE11F8C4;
        Wed, 16 Mar 2022 15:44:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jayati Shrivastava via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Hariom verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jayati Shrivastava <gaurijove@gmail.com>
Subject: Re: [PATCH v3] sequencer.c: use reverse_commit_list() helper
References: <pull.1177.v2.git.1647427356490.gitgitgadget@gmail.com>
        <pull.1177.v3.git.1647429623830.gitgitgadget@gmail.com>
Date:   Wed, 16 Mar 2022 12:44:27 -0700
Message-ID: <xmqqee31lm1w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7DE2404C-A561-11EC-ADAD-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jayati Shrivastava via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Jayati Shrivastava <gaurijove@gmail.com>
>
> Instead of creating a new allocation, reverse the
> original list in-place by calling the
> reverse_commit_list() helper.

OK.  I recall that v2 wrapped with longer lines that was easier to
read.

> The original code
> discards the list "bases" after storing its
> reverse copy in a newly created list "reversed".
> If the code that followed from here used both
> "bases" and "reversed", the modification would not
> have worked, but since the original list "bases"
> gets discarded, we can simply reverse "bases"
> in-place with the reverse_commit_list() helper and
> reuse the same variable in the code that follows.

I am 30% surprised to see this in the log message ;-).  There is
nothing incorrect in the description per-se, but it is something I
would expect in a review that reads a patch and follows along
thinking aloud to see if the code makes sense, or below "---", but
it does explain why the patch chose to lose the extra variable, so
probably it is OK.

> builtin/merge.c has been left unmodified, since in its case, the
> original list is needed separately from its reverse copy by the
> code.

Good.

The patch text looks good, too.

Thanks.
