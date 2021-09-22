Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC911C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 02:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CFE860EE7
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 02:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbhIVCDj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 22:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbhIVCDi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 22:03:38 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3F6C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 19:02:09 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id co2so3699161edb.8
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 19:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=9SOnJhVXF4QBljCyNwNnvgF276nzTzXZhX/ZHaXGRfQ=;
        b=m1qeBopx6VEewY9qf1CTMVSOqMS8nXpCS35Ns9Uu31qWy4eL7XAc4VfAaHbVNEEFMS
         qknhpm2JTKxzkZqAxEGUtptOd2HXMUXEXiBx6/VA5FGE0+FS0WfKHKG8jCJqFfPVV5XB
         i8NJfGlnMayeG3vYLBwfvLHd/TXGpie1iptLFYaoORvajk9sQ+oSTuVb6OayFQAZs6aH
         DS4BzRsZpzUc5lLUqzMuxseFqyaaIwqLH7b4NBsq6+YKS/fDPsBNoclFAbrN4NhRG1dM
         YTs/3xhOB/tkjlJ14RnAasx7/7kLSz77BO/cmVcdeoemVVaSP595/tv2caRumxaORO1n
         mJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=9SOnJhVXF4QBljCyNwNnvgF276nzTzXZhX/ZHaXGRfQ=;
        b=4XN79A7HvmznMP9d0v7vSHOSC93SZfGIlMW4GMKsNpoaK5EexZv1bT2BQuZJLB5GOP
         uEN1343GpWR3Xl3wSTRxyF5hmyvdSUrXEBlIj7vxZXoITK+fKnBXbUgz79MkGw+Z7ueM
         NcEIcJhy+TE1EAWgGPOXKgsfJY4ymvZkRi1oSCylTnjOvD8eeCIK6YoXEvP8wZkHPHnd
         Goms+qBEQEkIHKPHnYBrgflI6+WQT5wDiYmMakz57S6Q1y6F9ZSvaC+kMcA3Cd1LBMUs
         qIQhxCbyaaPAGggFwS3Fwe4QAPMunX7UO/Kdf21X+EU7sMxGxWuuqQuYpew1EYr7SQ3E
         /b1A==
X-Gm-Message-State: AOAM533kXPQlSLtABPlnAx5anw8pCy/I+QCSlAiToti3B1U7Nu/Erk0N
        mdEjwC/fDPZPTYlkSSF6zxKvhT5d5ptg+g==
X-Google-Smtp-Source: ABdhPJx5Loml6Q4rc6KILV2KJ5Onj/KQVbyRbEc2Vonu8KIsJCNw3SWhEOi/Jq6+pp3LqpxXnrdpBw==
X-Received: by 2002:a05:6402:54:: with SMTP id f20mr40102713edu.382.1632276127466;
        Tue, 21 Sep 2021 19:02:07 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r22sm264876ejj.91.2021.09.21.19.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 19:02:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH v4 5/6] core.fsyncobjectfiles: tests for batch mode
Date:   Wed, 22 Sep 2021 03:58:56 +0200
References: <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
 <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com>
 <afb0028e79648c1f7be8d77df5c6d675bd27d983.1632176111.git.gitgitgadget@gmail.com>
 <87a6k58or9.fsf@evledraar.gmail.com>
 <CANQDOdc3R0H_DS9eqh9vK7JA6=2LsB6q9mANgMgrtbOwp7Fvwg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CANQDOdc3R0H_DS9eqh9vK7JA6=2LsB6q9mANgMgrtbOwp7Fvwg@mail.gmail.com>
Message-ID: <87wnn974gx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 21 2021, Neeraj Singh wrote:

> On Tue, Sep 21, 2021 at 4:58 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Mon, Sep 20 2021, Neeraj Singh via GitGitGadget wrote:
>>
>> > From: Neeraj Singh <neerajsi@microsoft.com>
>> >
>> > Add test cases to exercise batch mode for 'git add'
>> > and 'git stash'. These tests ensure that the added
>> > data winds up in the object database.
>> >
>> > I verified the tests by introducing an incorrect rename
>> > in do_sync_and_rename.
>> >
>> > Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
>> > ---
>> >  t/lib-unique-files.sh | 34 ++++++++++++++++++++++++++++++++++
>> >  t/t3700-add.sh        | 11 +++++++++++
>> >  t/t3903-stash.sh      | 14 ++++++++++++++
>> >  3 files changed, 59 insertions(+)
>> >  create mode 100644 t/lib-unique-files.sh
>> >
>> > diff --git a/t/lib-unique-files.sh b/t/lib-unique-files.sh
>> > new file mode 100644
>> > index 00000000000..a8a25eba61d
>> > --- /dev/null
>> > +++ b/t/lib-unique-files.sh
>> > @@ -0,0 +1,34 @@
>> > +# Helper to create files with unique contents
>> > +
>> > +test_create_unique_files_base__=3D$(date -u)
>> > +test_create_unique_files_counter__=3D0
>> > +
>> > +# Create multiple files with unique contents. Takes the number of
>> > +# directories, the number of files in each directory, and the base
>> > +# directory.
>> > +#
>> > +# test_create_unique_files 2 3 . -- Creates 2 directories with 3 files
>> > +#                                each in the specified directory, all
>> > +#                                with unique contents.
>> > +
>> > +test_create_unique_files() {
>> > +     test "$#" -ne 3 && BUG "3 param"
>> > +
>> > +     local dirs=3D$1
>> > +     local files=3D$2
>> > +     local basedir=3D$3
>> > +
>> > +     rm -rf $basedir >/dev/null
>>
>> Why the >/dev/null? It's not a "-rfv", and any errors would go to
>> stderr.
>
> Will fix. Clearly I don't know UNIX very well.
>
>>
>> > +             mkdir -p "$dir" > /dev/null
>>
>> Ditto.
>
> Will fix.
>
>>
>> > +             for j in $(test_seq $files)
>> > +             do
>> > +                     test_create_unique_files_counter__=3D$((test_cre=
ate_unique_files_counter__ + 1))
>> > +                     echo "$test_create_unique_files_base__.$test_cre=
ate_unique_files_counter__"  >"$dir/file$j.txt"
>>
>> Would be much more readable if we these variables were shorter.
>>
>> But actually, why are we trying to create files as a function of "date
>> -u" at all? This is all in the trash directory, which is rm -rf'd beween
>> runs, why aren't names created with test_seq or whatever OK? I.e. just
>> 1.txt, 2.txt....
>>
>
> The uniqueness is in the contents of the file.  I wanted to make sure that
> we are really creating new objects and not reusing old ones.  Is the scope
> of the "trash repo" small enough that I can be guaranteed that a new one
> is created before my test since the last time I tried adding something to
> the ODB?
>
>> > +test_expect_success 'stash with core.fsyncobjectfiles=3Dbatch' "
>> > +     test_create_unique_files 2 4 fsync-files &&
>> > +     git -c core.fsyncobjectfiles=3Dbatch stash push -u -- ./fsync-fi=
les/ &&
>> > +     rm -f fsynced_files &&
>> > +
>> > +     # The files were untracked, so use the third parent,
>> > +     # which contains the untracked files
>> > +     git ls-tree -r stash^3 -- ./fsync-files/ > fsynced_files &&
>> > +     test_line_count =3D 8 fsynced_files &&
>> > +     cat fsynced_files | awk '{print \$3}' | xargs -n1 git cat-file -e
>> > +"
>> > +
>> > +
>> >  test_expect_success 'stash -c stash.useBuiltin=3Dfalse warning ' '
>> >       expected=3D"stash.useBuiltin support has been removed" &&
>>
>> We really prefer our tests to create the same data each time if
>> possible, but as noted with the "date -u" comment above you're
>> explicitly bypassing that, but I still can't see why...
>
> I'm trying to make sure we get new object contents. Is there a better
> way to achieve what I want without the risk of finding that the contents
> are already in the database from a previous test run?

You can just do something like:

test_expect_success 'setup data' '
	test_commit A &&
	test_commit B
'

Which will create files A.t, B.t etc, or create them via:

    obj=3D$(echo foo | git hash-object -w --stdin)

etc.

I.e. the uniqueness you're doing here seems to assume that tests are
re-using the same object store across runs, but we create a new trash
directory for each one, if you run the test with "-d" you can see it
being left behind for inspection. This is already ensured for the test.

The only potential caveat I can imagine is that some filesystem like say
btrfs-like that does some COW or object de-duplication would behave
differently, but other than that...
