Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212FCC2D0E4
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 00:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8BFA221FB
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 00:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XNHXzb4Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgKRAHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 19:07:39 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60331 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgKRAHj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 19:07:39 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BEB4D101431;
        Tue, 17 Nov 2020 19:07:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v+jIbxn0aK3X2aiQnrdSy0w3DA0=; b=XNHXzb
        4Q4LXW7AAS2ZNjqVMXX2w9tTULHEx05jDLknaaWmGokPmginh92p7zg/lpZNek+n
        o7V/nhcPUtUrmm/pLHUvm0pIWMYJyEf58VXqO5aTV7mFlCqUJt//aTaZJQsON9yc
        Flh3jbTkIFEhWBvrBiogk5RMu+rqM5hIs6MXs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UGKlnj2OyXXeKwyimE554QbE2PJRz51H
        0BG74K8y6PlR2N4wb4MsxfKVhsQaoXb3x2q4+j0g1gq6paO3Egj2nnx0vO0/VHrM
        K/dYiZ3Pv3S0akaHIwfw9yzjowv7C2oYz8B9Q4C5TWJkV+sumjpI2qmH7YPsNsFY
        ajbxSmQVfS4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B6142101430;
        Tue, 17 Nov 2020 19:07:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 86F2A10142F;
        Tue, 17 Nov 2020 19:07:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/28] Use main as default branch name
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <87r1oraewl.fsf@x220.int.ebiederm.org>
        <CAMP44s2VJOd3N2zaj8YPv0iLOqTF7vWyZ=zPd9vd0+qO1DbEVA@mail.gmail.com>
        <20201117233313.GB642410@coredump.intra.peff.net>
Date:   Tue, 17 Nov 2020 16:07:28 -0800
In-Reply-To: <20201117233313.GB642410@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 17 Nov 2020 18:33:13 -0500")
Message-ID: <xmqqr1or4jen.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0CDA5436-2932-11EB-85A6-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think Eric's suggestion of using the directory name as a default was
> not previously mentioned. I'm not sure I would like that myself (I find
> value in having a consistent "this is the main branch" name across
> different repositories, at least for my workflows). And it creates all
> of the same "every tutorial is now out of date" issues. But it is
> neutral. I wouldn't be opposed to seeing it as a configurable option.

I actually recall hearing it from Eric, not on this list, directly
back in the timeframe of these previous dicsussions.  I somehow
thought I relayed it to the community, perhaps #git-devel on
freenode, but apparently not to this list.

Yes, init.defaultBranchName is defined to be a string, so it is a
bit tricky to introduce special values that mean "no, not a
hardcoded value but derive dynamically based on X".  Perhaps use a
prefix that is not allowed in a refname, perhaps like this update to
the function that uses the value read from the init.defaultBranch
configuration variable.

 refs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git c/refs.c w/refs.c
index 392f0bbf68..3fbc697cd8 100644
--- c/refs.c
+++ w/refs.c
@@ -576,6 +576,12 @@ char *repo_default_branch_name(struct repository *r)
 
 	if (!ret)
 		ret = xstrdup("master");
+	else if (!strcmp(ret, ":dirname"))
+		ret = ... do the $(basename $(cwd)) thing ...;
+	else if (!strcmp(ret, ":some other magic"))
+		ret = ... do some other magic thing ...;
+	else if (ret[0] == ':')
+		die(_("%s - unrecognised magic", ret);
 
 	full_ref = xstrfmt("refs/heads/%s", ret);
 	if (check_refname_format(full_ref, 0))
