Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEDAC433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 20:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F28BD22BF3
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 20:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgLUUKu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 15:10:50 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50533 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgLUUKu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 15:10:50 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 27173F8BD0;
        Mon, 21 Dec 2020 15:10:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4gIGZyITArFmEK4GYX9iB8gMgME=; b=NdwOWE
        jOmWuk7n6qYTXHuimTyxrDpKIKTKhGsUk6eiiP+S6G1pYh52UYlUzs58kNgOVi3i
        NpKDr5FjFKxUDuv77IIEbUgj4O0p86kOqMTZUhJiBdb6elaYK1Bd8cFz6CSjevls
        rfcYGpH3DIwXKdZePLtkIyR/R+QPJAxRWzXgM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fNxtTR3Kk0IUB+UHry6/D/ocZ2vXDdc/
        q5RF0K9azGzisbP4xKE5kyX6HKufGbRj1AIie6yPQu7+OgnNopjKfbiaxCv7t/Ha
        TIftQ4TShz0q38jZ0D2B6dEGddJ1vjxCg7Y6+EMP6Jy8+CiAyoQmuZa96kLqJFBh
        3rd51oHJRbo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 20418F8BCF;
        Mon, 21 Dec 2020 15:10:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 606F0F8BCC;
        Mon, 21 Dec 2020 15:10:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        git <git@vger.kernel.org>, Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] test: bisect-porcelain: fix location of files
References: <20201218151406.1193792-1-felipe.contreras@gmail.com>
        <CAP8UFD0X5HR67T6msOhJwgAGKQfgW4JxH+pJprseBi9XAZ2rCw@mail.gmail.com>
Date:   Mon, 21 Dec 2020 12:10:02 -0800
In-Reply-To: <CAP8UFD0X5HR67T6msOhJwgAGKQfgW4JxH+pJprseBi9XAZ2rCw@mail.gmail.com>
        (Christian Couder's message of "Fri, 18 Dec 2020 16:36:40 +0100")
Message-ID: <xmqqo8imly3p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8386CB04-43C8-11EB-9706-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Dec 18, 2020 at 4:14 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>>
>> Commit ba7eafe146 (t6030: explicitly test for bisection cleanup,
>> 2017-09-29) introduced checks for files in the $GIT_DIR directory, but
>> that variable is not always defined, and in this test file it's not.
>>
>> Therefore these checks always passed regardless of the presence of these
>> files (unless the user has some /BISECT_LOG file, for some reason).
>>
>> Let's check the files in the correct location.
>
> This looks good to me, but...
>
>> index 34099160ed..6d5440d704 100755
>> --- a/t/t6030-bisect-porcelain.sh
>> +++ b/t/t6030-bisect-porcelain.sh
>> @@ -926,14 +926,14 @@ test_expect_success 'git bisect reset cleans bisection state properly' '
>>         git bisect bad $HASH4 &&
>
> ...if we wanted this kind of bug not to happen again, we could add a
> test here, before `git bisect reset`, to check that here one of the
> files below actually exists.

It may make sense in the larger context of making sure "git bisect"
keeps the log in expected location.

If we do not have the basic test to do so, we probably should add
one separately.  But "git bisect reset cleans" test should be able
to assume that these files are stored in their correct place, and
test only their removal.

An alternative and possibly a better way may be, before reset, to
ask "git bisect" command itself to see if it can retrieve what is
stored in one of these files.  Perhaps "git bisect terms" would work
only when .git/BISECT_TERMS is there.  You need to cover other files
in a similar way.

Such a testing strategy would make sure what we truly care about
will keep working, no matter how internal implementation changes in
the future.  In a sense, we do not really care the log file is
called BISECT_LOG or stored directly under .git/ directory ---we
care that the information is kept somewhere to allow "git bisect" to
work with, and upon "git bisect reset", the information is wiped
away (so you'd test that, after "git bisect reset", "git bisect
terms" would behave differently without the BISECT_TERMS file).

Hmm?

For now, the hunk I see below looks like a pure improvement, but I
do not have the original patch handy, so... 

>>         git bisect reset &&
>>         test -z "$(git for-each-ref "refs/bisect/*")" &&
>> -       test_path_is_missing "$GIT_DIR/BISECT_EXPECTED_REV" &&
>> -       test_path_is_missing "$GIT_DIR/BISECT_ANCESTORS_OK" &&
>> -       test_path_is_missing "$GIT_DIR/BISECT_LOG" &&
>> -       test_path_is_missing "$GIT_DIR/BISECT_RUN" &&
>> -       test_path_is_missing "$GIT_DIR/BISECT_TERMS" &&
>> -       test_path_is_missing "$GIT_DIR/head-name" &&
>> -       test_path_is_missing "$GIT_DIR/BISECT_HEAD" &&
>> -       test_path_is_missing "$GIT_DIR/BISECT_START"
>> +       test_path_is_missing ".git/BISECT_EXPECTED_REV" &&
>> +       test_path_is_missing ".git/BISECT_ANCESTORS_OK" &&
>> +       test_path_is_missing ".git/BISECT_LOG" &&
>> +       test_path_is_missing ".git/BISECT_RUN" &&
>> +       test_path_is_missing ".git/BISECT_TERMS" &&
>> +       test_path_is_missing ".git/head-name" &&
>> +       test_path_is_missing ".git/BISECT_HEAD" &&
>> +       test_path_is_missing ".git/BISECT_START"
>>  '

Thanks.
