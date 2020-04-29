Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8211BC83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 16:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6172820B80
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 16:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vaknkqi4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgD2Qpv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:45:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50717 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgD2Qpu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 12:45:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC74C45445;
        Wed, 29 Apr 2020 12:45:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZCY755qdTVfbWe9shOP+uF8ngQ4=; b=Vaknkq
        i4aHaZPCAZ5cY1krAxOANVAQScV0JIk4IfACS4WJhScG3qpEWMre3Y0EOChnpPlD
        /+8P+lREsQIIVxIga+3DaZJVl1QQ/RfRC09rWc6nBUvPw6D/UyU4G9DYtnsToJcD
        T/KtBvyCKm/Qov0aau+E2iy0NNQ3OV7ekKCwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JzaAjc0se9T1dhcY0m/NfYXL0o5a9lLG
        JmqzYWLI9VdJ5B3n3MiDjoafEhXE2UBKx48ErT5rJEZDwutV1l2Z66uZ7V/0wSCD
        +cfVCXa8m9dDaC+16IE+oPCaJMlAfs37Nmd6PZALrHclA5Uv17n4hWUkyaIcHUMp
        yx5wYKLs2Nc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C45DC45443;
        Wed, 29 Apr 2020 12:45:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 53C9445442;
        Wed, 29 Apr 2020 12:45:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2020, #03; Tue, 28)
References: <xmqqimhjyy9c.fsf@gitster.c.googlers.com>
        <20200429155701.GA83442@syl.local>
Date:   Wed, 29 Apr 2020 09:45:48 -0700
In-Reply-To: <20200429155701.GA83442@syl.local> (Taylor Blau's message of
        "Wed, 29 Apr 2020 09:57:01 -0600")
Message-ID: <xmqqr1w6xmtf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E17581C8-8A38-11EA-AC12-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> * tb/commit-graph-split-strategy (2020-04-15) 7 commits
>>  + commit-graph.c: introduce '--[no-]check-oids'
>>  + commit-graph.h: replace 'commit_hex' with 'commits'
>>  + oidset: introduce 'oidset_size'
>>  + builtin/commit-graph.c: introduce split strategy 'replace'
>>  + builtin/commit-graph.c: introduce split strategy 'no-merge'
>>  + builtin/commit-graph.c: support for '--split[=<strategy>]'
>>  + t/helper/test-read-graph.c: support commit-graph chains
>>  (this branch is used by tb/commit-graph-fd-exhaustion-fix.)
>>
>>  "git commit-graph write" learned different ways to write out split
>>  files.
>>
>>  Will merge to 'master'.
> ...
> In either case, the rest of the series is ready to merge, and other
> topics depend on it, so I figure that we can merge the first 6 patches
> and hold off on the last one for now.
>
> Sound good?

If other topics that depend on it build on the whole series, merging
only the first 6 does not make much sense.  These other ones are
blocked forever.

Applying a single patch to revert the no-check-oids patch on top of
this series, and merging the resulting 8-commit series to 'master',
may be a workable solution, though.  We need to keep an eye on the
merge possibly reintroducing the no-check-oids stuff when the
dependent topics are merged to 'master' (that is why we do not want
to see people build new things on another topic that is slushy), but
I think there is only one topic, so it should be manageable.

Why don't we do this:

 $ git checkout tb/commit-graph-fd-exhaustion-fix
 $ git revert tb/commit-graph-split-strategy
 $ git checkout master
 $ git merge tb/commit-graph-fd-exhaustion-fix
 $ git branch -d tb/commit-graph-fd-exhaustion-fix tb/commit-graph-split-strategy

That's the simplest solution and we'll have two fewer topics we need
to worry about when we are done.


