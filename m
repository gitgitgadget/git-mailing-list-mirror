Return-Path: <SRS0=cPh9=BE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D301CC433DF
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 15:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29112070C
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 15:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="miLQl4Nc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgGYPbJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jul 2020 11:31:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52772 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgGYPbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jul 2020 11:31:09 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B34DEEB33E;
        Sat, 25 Jul 2020 11:31:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7ZiPJ6QJQsZUnGbG6wRLHTAAKjk=; b=miLQl4
        NcLE160uSP+mS6dmPcxV/LQLyPOvSg+7nWBbJeTS59qrl4b+yUaq9V1hh8cnb3cT
        FMg7ajx9LohyOrFihDYRqoeDrQvSTfvHgKr+SwhrK8LukTd8+T0B7F8/TjLqln6u
        QJ683yUoqkqxaMG5ja7ZaIcsKhC51bf0K6cbE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wRd2bk0VXOXAxzfQEwMqPxumKDGucm3m
        TjvjVlyqMnfRitJvWIcizGOOTQnToh/F5bwR61/0TTDXFkWhApjC64fkju6tb0ry
        3HlJbYF01HYhEKQ1UqEP3RZubYJQA9+swYUixF26NSXMDfi8VjSZ/gbcm35zBb0C
        anHAZ8jBE08=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AB35DEB33D;
        Sat, 25 Jul 2020 11:31:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 03347EB33C;
        Sat, 25 Jul 2020 11:31:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Maxime Louet <maxime@saumon.io>
Cc:     git@vger.kernel.org
Subject: Re: Verbose commit message diff not showing changes from pre-commit hook
References: <CADv3qkGq3jA8iXsjhrqfsUX=gW+KOuLyeVgDzmku1tUpsMdvtw@mail.gmail.com>
        <xmqqr1sziqrm.fsf@gitster.c.googlers.com>
Date:   Sat, 25 Jul 2020 08:31:01 -0700
In-Reply-To: <xmqqr1sziqrm.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 25 Jul 2020 08:00:13 -0700")
Message-ID: <xmqqk0yripca.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9561E0C-CE8B-11EA-9B6C-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Maxime Louet <maxime@saumon.io> writes:
>
>> Is this expected behaviour? I find it somehow confusing that the diff
>> in the commit message isn't the actual commit diff.
>
> Since the designed purpose of pre-commit hook is to examine the
> contents to be committed and reject the attempt to commit if there
> is something wrong found, and Git does not expect it to munge the
> contents to be committed, if the hook does so, you would get an
> undefined behaviour.  So anything is totally expected at that point.

Sorry, I have to take this back.

Even before ec84bd00 (git-commit: Refactor creation of log message.,
2008-02-05), the code anticipated that pre-commit may touch the index
and tried to cope with it.

However, ec84bd00 moved the place where we re-read the on-disk index
in the sequence, and updated a message that used to read:

-	/*
-	 * Re-read the index as pre-commit hook could have updated it,
-	 * and write it out as a tree.
-	 */

to:

+	/*
+	 * Re-read the index as pre-commit hook could have updated it,
+	 * and write it out as a tree.  We must do this before we invoke
+	 * the editor and after we invoke run_status above.
+	 */

Unfortunately there is no mention of the reason why we "must" here.
I think the "run_status above" is what prepared the patch in the log
message template, so it is quite likely that we deliberately did so
to exclude whatever munging pre-commit does to the index from
appearing in the patch in the verbose mode.  If I have to guess, I
think the reason is because pre-commit automation is expected to be
some sort of mechanical change and not part of the actual work that
the end-user produced, it would become easier to perform the "final
review" of "what have I done so far---does everything make sense?"
if such "extra" changes are excluded.

So, in short, it is not "undefined", but rather it seems to be a
designed behaviour that we are seeing.

Thanks.
