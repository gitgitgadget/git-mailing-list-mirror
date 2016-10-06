Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21AE0207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 19:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752865AbcJFTP0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 15:15:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58659 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751230AbcJFTPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 15:15:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 84E9043957;
        Thu,  6 Oct 2016 15:15:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RVwsBx6AR6JHcsfyZtsEAd0hHwc=; b=wuIhmG
        008NbqAU4M8dlQWKB+mzNCVTTw7UGcLXZ9Dc5BAbpmABi5cndL5KpWDVFq7vL7ps
        vMd5RqoXYWizkuNcWI1PcjWrfzvb53zW6nXs8N1bIcu0MhV/F3r8iBHSNV/0laZF
        KaApGOc6KRNbk+uSz3Z8Sn2h3z/F8glcEVHYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qSxokU4ARgzujMSX0UUWRM94ZxkffeQQ
        Hh7HQ8QRV1R0oHuiC0whzgKFam0dSmrCH7RIyEdbFkIqXbqqBka4VqgCFHHimGBl
        FZf+FHd4FwBQsh+uSzmY5USEYPtANJ+/XLoEEQfDGv4/1SotDVeGQhblrYkUEMnD
        pWqtaNMTZZI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 754C543956;
        Thu,  6 Oct 2016 15:15:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E5D5943955;
        Thu,  6 Oct 2016 15:15:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] Resurrect "diff-lib.c: adjust position of i-t-a entries in diff"
References: <20160928114348.1470-1-pclouds@gmail.com>
        <20160928114348.1470-2-pclouds@gmail.com>
        <xmqqzimrj03j.fsf@gitster.mtv.corp.google.com>
        <CACsJy8D28iq3r3O_uzjyyJT--KQunAySRgUthF3FMrb1VM6XKw@mail.gmail.com>
        <xmqqd1jgw0nx.fsf@gitster.mtv.corp.google.com>
        <CACsJy8D7c8Z_ugasn_scf391+C6GxJp1CYwHY4ndvVtLiJzxnQ@mail.gmail.com>
Date:   Thu, 06 Oct 2016 12:15:20 -0700
In-Reply-To: <CACsJy8D7c8Z_ugasn_scf391+C6GxJp1CYwHY4ndvVtLiJzxnQ@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 5 Oct 2016 16:43:13 +0700")
Message-ID: <xmqqwphljnlj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3AB67004-8BF9-11E6-B22F-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Oct 4, 2016 at 11:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> We don't use it internally _yet_. I need to go through all the
>>> external diff code and see --shift-ita should be there. The end goal
>>> is still changing the default behavior and getting rid of --shift-ita,
>>
>> I do not agree with that endgame, and quite honestly I do not want
>> to waste time reviewing such a series.

I definitely shouldn't have said that, especially "waste".  Many
issues around i-t-a and diff make my head hurt when I think about
them [*1*], but not wanting to spend time that gets my
head hurt and not wanting to waste time are totally different
things.  My apologies.

I missed something curious in your statement above, i.e. "external
diff".  I thought we have pretty much got rid of all the invocation
of "git diff" via the run_command() interface and we do not need the
command line option (we only need the options->shift_ita so that
callers like "git status" can seletively ask for it when making
internal calls), and that is why I didn't want to see it.

> I do not believe current "diff" behavior wrt. i-t-a entries is right
> either. There's no point in pursuing this series then. Feel free to
> revert 3f6d56d (commit: ignore intent-to-add entries instead of
> refusing - 2012-02-07) and bring back the old i-t-a behavior. All the
> problems would go away.

It is way too late to revert 3f6d56d.  Even though I think it was
overall a mistake to treat i-t-a as "not exist" while committing,
people are now used to the behaviour with that change, and we need
to make our progress within the constraint of the real world.


[Footnote]

Here is one of the things around i-t-a and diff.  If you make "git
diff" (between the index and the working tree) report "new" file, it
would imply that "git apply" run without "--index" should create an
ita entry in the index for symmetry, wouldn't it?  That by itself
can be seen as an improvement (we no longer would have to say that
"git apply patchfile && git commit -a" that is run in a clean state
will forget new files the patchfile creates), but it also means we
now need a repository in order to run "git apply" (without "--index"),
which is a problem, as "git apply" is often used as a better "patch".

"git apply --cached" may also become "interesting".  A patch that
would apply cleanly to HEAD should apply cleanly if you did this:

    $ git read-tree HEAD
    $ git apply --cached <patch

no matter what the working tree state is.  Should a patch that
creates a "new" file add contents to the index, or just an i-t-a
entry?  I could argue it both ways, but either is quite satisfactory
and makes my head hurt.
