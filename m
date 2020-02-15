Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6164DC2BA83
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 18:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2822D2083B
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 18:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JyoymQuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgBOSYr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 13:24:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56249 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgBOSYr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Feb 2020 13:24:47 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3520B4F186;
        Sat, 15 Feb 2020 13:24:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/nCLytZ4bwSCTvueBWcaQ7y9gBg=; b=JyoymQ
        uNGGJg6zaZy9owTMTAtoSb2zalA6x4juVW5lujDwCEcls12YWBv44EwNns1jUSDy
        IBm3CVu0nzOtCRM4SOP7gqJnuysh11lak7g+xq8DoyPIAMBOssN7QbrHvbVHiXE3
        tFu7dj7cItVyVDJ6CGP3d68OGdlF6E0C7fn+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ijNkDRICXsMiTyMmNjHz7OQ5+Fm+N4zC
        MSfO0e9as0BFHiCe5WvLtLvukQlZdmVEiqz+7HqmHmbDAID2aOSE5mARyrOwbaUe
        4LC/HgxvM2WPZdPIVXMiYBmTXDGPZzcagNxalShoBRV1d/FwQx5mkpieUzrXvUj4
        nJxCBZd9yzs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C4324F185;
        Sat, 15 Feb 2020 13:24:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7F8814F184;
        Sat, 15 Feb 2020 13:24:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 03/15] bugreport: add tool to generate debugging info
References: <20200214015343.201946-1-emilyshaffer@google.com>
        <20200214015343.201946-4-emilyshaffer@google.com>
        <xmqqzhdlnksn.fsf@gitster-ct.c.googlers.com>
        <20200215015729.GN190927@google.com>
Date:   Sat, 15 Feb 2020 10:24:40 -0800
In-Reply-To: <20200215015729.GN190927@google.com> (Emily Shaffer's message of
        "Fri, 14 Feb 2020 17:57:29 -0800")
Message-ID: <xmqq1rqvogif.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6EBE554E-5020-11EA-AE86-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> On Fri, Feb 14, 2020 at 09:25:12AM -0800, Junio C Hamano wrote:
>> Emily Shaffer <emilyshaffer@google.com> writes:
>> 
>> > +	switch (safe_create_leading_directories(report_path.buf)) {
>> 
>> This helper is about creating paths in the working tree and Git
>> repository,
>
> It's also used by cmd_format_patch() with --output-directory specified,
> which is how I found it.

And that is an example of a good use of this helper.  What will be
written out there should be visible by the same people as those who
have access to the repository; get_shared_repo() and adjust_perm()
based on what the repository you are taking patches from is
perfectly sensible.  And as it is format-patch, we know we have
get_shared_repo() working, and we know which repository we are
working on.

Output directory for bugreport is on the same boat when we know the
users are producing a report on their use of Git within a
repository.  It is not clear if the tool is started without any
repository---it happens to do a random safe thing (i.e. I think
get_shared_repo() gives PERM_UMASK, which tells adjust_perm() not to
do anything especial) right now, but there is no guarantee that we
will keep it working like that.  Somebody may come and demaind
get_shared_perm() to die() when outside a repository, for example,
and that would break the nice property that lets bugreport working
outside a repository.

I just wanted to make sure that somebody will be keeping an eye to
remind those who propose such a change in the future.  A comment
near where get_shared_repo() happens may be something that can be
done with a minimum effort when code that depends on that property
is introduced at the same time.

>> I thought I read somewhere that this tool is meant to be usable
>> outside a repository?  If that is not the case, then the use of this
>> helper is OK.  If not, we may want to make sure that it will stay to
>> be safe to use the helper (I think it happens to be OK right now,

I am actually OK if we limit the use of this tool to "use with a
repository that is not corrupt", as coping with these kinds of
breakages that in the main Git executable we deem "needs manual
intervention" inside a single process is too painful (it would have
been easier to cope with these too if we stuck with a script that
invokes many discrete commands and acts on their errors, but that is
optimizing for rare case and not recommended).  But we should tell
users about the limitation and encourage them to ask for help in non
automatable means.

Thanks.
