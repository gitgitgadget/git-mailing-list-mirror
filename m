Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD79CC0015E
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 20:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbjGMU1N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 16:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGMU1M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 16:27:12 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C0F212E
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 13:27:11 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A7241AB2D3;
        Thu, 13 Jul 2023 16:27:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v1Jr9a8Rm6Zi8QgFgqoD6ugGuURVxwuUtr4HIQ
        pyZzU=; b=o4h8AikOc9ufD1n1tv4eAF0jEq4cCZPYESJGqO9XVYn24bqSqDSLqe
        ylG4FVlJdzOgoZefGfFMT9zXIAp/iqtrtAtI5MwuXHLrpNUGyJYko6BrqhS+AlHC
        m0WlYXqaHD7uFMgLUyGQM01LjyPgQpdmFOsw6YOgz+vnC6e/+pieI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 61C521AB2D2;
        Thu, 13 Jul 2023 16:27:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BBEDA1AB2D1;
        Thu, 13 Jul 2023 16:27:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "D. Ben Knoble" <ben.knoble@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: t2400 on freebsd12
References: <CALnO6CDryTsguLshcQxx97ZxyY42Twu2hC2y1bLOsS-9zbqXMA@mail.gmail.com>
        <CALnO6CCc-J+fe9qKaoyYUMM3xMEUnV5w7NKWSbn6xTgEjbac5w@mail.gmail.com>
Date:   Thu, 13 Jul 2023 13:27:08 -0700
In-Reply-To: <CALnO6CCc-J+fe9qKaoyYUMM3xMEUnV5w7NKWSbn6xTgEjbac5w@mail.gmail.com>
        (D. Ben Knoble's message of "Thu, 13 Jul 2023 15:17:09 -0400")
Message-ID: <xmqqfs5ro8v7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A485721E-21BB-11EE-A700-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> "D. Ben Knoble" <ben.knoble@gmail.com> wrote:
>> CI for an i18n PR [1] is failing on freebsd12, but I cannot reproduce
>> it. Is this known (a search of archives and the master branch doesn't
>> reveal anything)?
>> 
>> Summary output:
>> 
>> Test Summary Report
>> -------------------
>> t2400-worktree-add.sh                            (Wstat: 256 Tests:
>> 227 Failed: 27)
>>   Failed tests:  50-52, 91-93, 107-109, 123-125, 139-141
>>                 159-161, 175-177, 191-193, 207-209
>>   Non-zero exit status: 1
>> 
>> Proximate log entry:
>> 
>> [16:19:43] t2400-worktree-add.sh ..............................
>> Dubious, test returned 1 (wstat 256, 0x100)
>> Failed 27/227 subtests

Those listed in https://github.com/gitgitgadget/git/actions do not
seem to even run Cirrus CI.  Perhaps GitGitGadget folks wanted to
make sure that changes that may break FreeBSD will not escape to the
public list, and added it as an extra for pull requests?  The runs
shown at the end of PR in https://github.com/gitgitgadget/git/pulls
however do run Cirrus CI and some, but not all, of them do fail.

Given that the tests seem to randomly fail, I can believe if this is
due to a flakey test that needs to be fixed, but from what we can
see in the webpage of Cirrus CI, I cannot even guess what the
problem is.

I do not offhand know how well the FreeBSD port has been maintained,
or those who have (or had once in the past) stake in it are keeping
an eye on it.  Anybody?

> Bump: this bug seems to affect several GitGitGadget PRs in CI, which
> also renders GGG unusable for sending mail, IIUC.

By the way, is this really "blocking" use of GGG in any way?  I do
recall seeing messages regarding gitk from Jens Lidestrom that are
shown in https://github.com/gitgitgadget/git/pull/1551 but the CI
run report at the end of that page does have a failing CirrusCI.
