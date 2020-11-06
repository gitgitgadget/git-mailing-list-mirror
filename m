Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC3CC2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 18:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C5D9206FA
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 18:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f3WI6XKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgKFSGv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 13:06:51 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59398 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgKFSGu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 13:06:50 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4E045E9BFB;
        Fri,  6 Nov 2020 13:06:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jRtqYiBkyJEC
        wB8hIKfqxWsc5O0=; b=f3WI6XKDh/+v5ptuwyVDO09pHTpCRmvDg1cBjDK5rjEE
        4AjlhofdLIlDPH/SmNjbeH9kroc+dygxcG3hL3LbjIIiIQKqciYRyhZgIKdW1w9F
        bVT94h/7JOkN4iGMSF4n9hsjmccdqqZkur8Ecqvod/LHafXLrV6YW11l502++o4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ir2exq
        qC6QduE1SOntiHH4xIHx3Hw6oEZI+g88XhLCpYtYbLm2tL5O8hcjaOGA/vhyBNPr
        mu0U1m/7GFTkIp9L1ifaS6ux6VbdQych84yDSEF1ifhB65S6W0LhxQMh7ZBVU2gG
        ZnTdfQ5c+NJ/PpBHFm3e7WxHjR57hacGxK6lQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4617CE9BFA;
        Fri,  6 Nov 2020 13:06:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8A884E9BF9;
        Fri,  6 Nov 2020 13:06:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org,
        Daniel =?utf-8?Q?H=C3=B6pfl?= <daniel@hoepfl.de>
Subject: Re: Suppressing filter-branch warning
References: <20201106090443.GA20407@black.spass-am-geraet.de>
Date:   Fri, 06 Nov 2020 10:06:42 -0800
In-Reply-To: <20201106090443.GA20407@black.spass-am-geraet.de> ("Daniel
        =?utf-8?Q?H=C3=B6pfl=22's?= message of "Fri, 6 Nov 2020 10:04:43 +0100")
Message-ID: <xmqqo8kafjgt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D44C1094-205A-11EB-9142-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel H=C3=B6pfl <daniel@hoepfl.de> writes:

> Hello there,
>
> What did you do before the bug happened? (Steps to reproduce your issue=
)
> git filter-branch -f --env-filter '' --tag-name-filter cat -- HEAD
>
> What did you expect to happen? (Expected behavior)
> See below (difference).
>
> What happened instead? (Actual behavior)
> When using git filter-branch, the following message is shown:
>
> ----------8<-----------------------------------------------------
> WARNING: git-filter-branch has a glut of gotchas generating mangled his=
tory
>         rewrites.  Hit Ctrl-C before proceeding to abort, then use an
>         alternative filtering tool such as 'git filter-repo'
>         (https://github.com/newren/git-filter-repo/) instead.  See the
>         filter-branch manual page for more details; to squelch this war=
ning,
>         set FILTER_BRANCH_SQUELCH_WARNING=3D1.
> ----------8<-----------------------------------------------------
>
> You can suppress this by setting the environment variable shown.
>
> What's different between what you expected and what actually happened?
>
> Normally, when git introduces this kind of change, there is a
> git config variable that one can set to suppress it.
> That way one has fine grade control when to suppress it (one repo only.=
..globally).

I think this comes from 9df53c5d (Recommend git-filter-repo instead
of git-filter-branch, 2019-09-04). =20

FWIW, I personally do not think an environment is a worse choice
over configuration variable in this particular case.  The large
scale rewriting of the entire history in the repository by its
nature is an one-off operation that ought to happen only rarely,
so a one-shot

	$ FILTER_BRANCH_SQUELCH_WARNING=3D1 git filter-branch ...

that reminds the user every time would be more appropriate than a
configuration variable that has a more permanent squelching effect.

If it were a new command line option may have been even better, as
an environment variable can be defined in .*rc and forgotten, but a
command line option needs to be typed every time and would serve as
a better reminder (yes, I know it can also be aliased away, so it
may not make much practical difference either way).

But I'll let the author of the feature to comment.

Thanks.
