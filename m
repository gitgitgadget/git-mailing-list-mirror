Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F71C48BCF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 07:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A39E8611C0
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 07:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhFMHjE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 03:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhFMHjE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 03:39:04 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F282C061574
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 00:36:52 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id x10so4971719plg.3
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 00:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PsNxXjx4fK+Kg/+lyrQi5pvY+IvIDJ97Nh5ErgLtffs=;
        b=oYCWUFQLjGQmGmCp7Vgi/LIjh0ZW62Bh/ueAUnrqtjCMJDPziDlJ6Q0ICV/NtCTSdO
         eo0J2vyDkfDCw1kmiMRu8K1hG1U7yXyAeqMOK1WiU4o8M/7xLkoi3CsraTsNxU8awmmK
         2WSVqNhegBptMJaT2BfyPex7EdhsgEHh9i/c/rsZBWIosQ8D9azSRNCWDx+cjanYyia2
         phv1sHFmrdTSabBH2gfWWzoUwSV155MkLup8aNTiWY/7J8YEncIT4pkJeBAQXC0EmZ7z
         fy8YP32Dw3URBhNuEuANqVUw6OCGjn+quX5x9s4np+E6r0qIBdA7B/1wx5UJ4jtMrJ9V
         Vthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PsNxXjx4fK+Kg/+lyrQi5pvY+IvIDJ97Nh5ErgLtffs=;
        b=QmrZGCViX9p3n+GiqqgYdELDA2UcDJw472XNHIrXiHHA8ivTxvvG3arfUD/7tGDilw
         IL4eH69VoXyHIJ5tXpmKwvVRPxgrIQhJL42EuDqMlWwdXBzs0KCroemnYUx3OOSVZ41q
         vfqfxNh+Anm+8OqhSUgxejjLYPvBaEIgyLBnJbzSchMzYinw/3Y0HN0qjm+HU8Hsfa/d
         K/8rJ7TBmHmKH69kOo9Y5hAVgIJIyS/sDumgwiHhBIwhm1GCEOtcRdgdctxLPXpcQS8r
         dqRuUpVesRwi75x+gNFTmYgVLJ/jr9r8U03NiCB6OiHkt0Ae5zNQ/dLMf0RfAO5HCOre
         8O+Q==
X-Gm-Message-State: AOAM530oHHrsPhvMETU8Njl+VSxIJWPam6lrbujp79AeZCZVsHwSsndR
        T4r74C2aHokQyP/vFo3jQ150cMbq19w=
X-Google-Smtp-Source: ABdhPJwPWjBfyugHpQdfM01HNdgcBmurKd2EGm4RvZn/Xozgd2l2bmsPz+fi/y4ZNxfHigMIxlZdCA==
X-Received: by 2002:a17:90a:bb13:: with SMTP id u19mr17603514pjr.92.1623569811029;
        Sun, 13 Jun 2021 00:36:51 -0700 (PDT)
Received: from localhost ([2402:800:63b8:a3d1:fb64:d06b:ab01:2de4])
        by smtp.gmail.com with ESMTPSA id u9sm9474629pgp.90.2021.06.13.00.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 00:36:50 -0700 (PDT)
Date:   Sun, 13 Jun 2021 14:36:48 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] test-lib-functions: introduce test_line_count_cmd
Message-ID: <YMW1kH4PZWx2NWjW@danh.dev>
References: <20210612042755.28342-1-congdanhqx@gmail.com>
 <20210612042755.28342-2-congdanhqx@gmail.com>
 <CAPig+cR9OnRHYxzVsd6aX=Q_5Fkm4dMxPR2n6kXE+r+cTdw5ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cR9OnRHYxzVsd6aX=Q_5Fkm4dMxPR2n6kXE+r+cTdw5ug@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-06-12 23:10:19-0400, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Jun 12, 2021 at 12:28 AM Đoàn Trần Công Danh
> <congdanhqx@gmail.com> wrote:
> > In Git project, we have multiple occasions that requires checking number
> > of lines of text in stdout and/or stderr of a command. One of such
> > example is t6400, which checks number of files in various states.
> >
> > Some of those commands are Git command, and we would like to check their
> > exit status.  In some of those checks, we pipe the stdout of those
> > commands to "wc -l" to check for line count, thus loosing the exit status.
> >
> > Introduce a helper function to check for number of lines in stdout and
> > stderr from those commands.
> >
> > This helper will create 2 temporary files in process, thus it may affect
> > output of some checks.
> 
> If the presence of these files is a concern, I wonder if it would make
> sense to turn these into dot-files (leading dot in name) or shove them
> into the .git/ directory? (Not necessarily an actionable comment; just
> tossing around some thoughts.)

The presence of those files is concern to some command likes:

* git ls-files -o; or
* ls -a

Shoving into ".git" would be actionable if we are testing inside a git
repository. Should we testing outside, we don't have that luxury.

I think we can accept that limitation (only allow this helper inside
a Git worktree to avoid surpising behavior).

> 
> > Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> > ---
> > diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> > @@ -817,6 +817,70 @@ test_line_count () {
> > +# test_line_count_cmd checks the number of lines of captured stdout and/or
> > +# stderr of a command.
> > +#
> > +# NOTE: this helper function will create 2 temporary files named:
> > +# * test_line_count_cmd_.out; and
> > +# * test_line_count_cmd_.err
> > +#
> > +# And this helper function will remove those 2 files if the check is succeed.
> > +# In case of failure, those files will be preserved.
> > +test_line_count_cmd () {
> 
> It would be good to have some usage information in the above comment
> so that people aren't forced to consult the implementation to learn
> what options this function takes. At minimum, it should mention
> `--out`, `--err`, and `!`, and should explain the arguments each
> option takes (even if just through examples).

Make sense!

> 
> > +       local outop outval
> > +       local errop errval
> > +
> > +       while test $# -ge 3
> > +       do
> > +               case "$1" in
> > +               --out)
> > +                       outop="$2"
> > +                       outval="$3"
> > +                       ;;
> > +               --err)
> > +                       errop="$2"
> > +                       errval="$3"
> > +                       ;;
> > +               *)
> > +                       break
> > +                       ;;
> > +               esac
> > +               shift 3
> > +       done &&
> 
> This is really minor, but if test_line_count_cmd() ever learns some
> new option and that option does not consume two arguments, then the
> `shift 3` at the end of the `case/esac` will need to be adjusted in
> some fashion. It might make more sense, therefore, to perform the
> `shift 3` closer to where it is needed (that is, in the `--out` case
> and in the `--err` case) rather than delaying it as is done here. (Not
> necessarily worth a re-roll.)

Make sense, too. I think I'll add another leg here for "-*" to avoid
potential break when adding/removing options. Not that I imagine about
new options, but I can't think of any command starts with "-"

> Another minor comment: Since you're &&-chaining everything else in the
> function, it wouldn't hurt to also do so for the `local` declarations
> and the assignments within each `case` arm, and to chain `esac` with
> `shift 3`. Doing so could help some future programmer who might (for
> some reason) insert code above the `while` loop, thinking that a
> failure in the new code will abort the function, but not realizing
> that the &&-chain is not intact in this area of the code.

Will do, too!

> > +       if test $# = 0 ||
> > +          { test "x$1" = "x!" && test $# = 1 ; }
> > +       then
> > +               BUG "test_line_count_cmd: no command to be run"
> > +       fi &&
> > +       if test -z "$outop$errop"
> > +       then
> > +               BUG "test_line_count_cmd: check which stream?"
> > +       fi &&
> > +
> > +       if test "x$1" = "x!"
> > +       then
> > +               shift &&
> > +               if "$@" >test_line_count_cmd_.out 2>test_line_count_cmd_.err
> > +               then
> > +                       echo "error: '$@' succeed!"
> > +                       return 1
> > +               fi
> > +       elif ! "$@" >test_line_count_cmd_.out 2>test_line_count_cmd_.err
> > +       then
> > +               echo "error: '$@' run into failure!"
> > +               return 1
> > +       fi &&
> 
> Do we care that the "!" negated case doesn't have the same semantics
> as test_must_fail()? If we do care, then should there be a way to tell
> the function whether we want test_must_fail() semantics or `!`
> semantics (i.e. whether we're running a Git command or a non-Git
> command) or should it infer it on its own? (These are genuine
> questions -- not necessarily requests for changes -- as I'm trying to
> reason through the implications of this implementation choice.)

I think that we shouldn't care, in my mind, I would let users to chain
test_line_count and test_must_fail if they do care about that sematic.
So, we have the freedom to use test_line_count_cmd with both Git and
non-Git commands.  E.g:

---------8<---------------
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index ad4746d899..94c8cfc9f2 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -288,9 +288,8 @@ test_expect_success 'OPT_CALLBACK() and OPT_BIT() work' '
 '
 
 test_expect_success 'OPT_CALLBACK() and callback errors work' '
-	test_must_fail test-tool parse-options --no-length >output 2>output.err &&
-	test_must_be_empty output &&
-	test_must_be_empty output.err
+	test_line_count_cmd --out = 0 --err = 0 \
+		test_must_fail test-tool parse-options --no-length
 '
 
 cat >expect <<\EOF
------------>8--------------
> 
> > +       if test -n "$outop"
> > +       then
> > +               test_line_count "$outop" "$outval" test_line_count_cmd_.out
> > +       fi &&
> > +       if test -n "$errop"
> > +       then
> > +               test_line_count "$errop" "$errval" test_line_count_cmd_.err
> > +       fi &&
> > +       rm -f test_line_count_cmd_.out test_line_count_cmd_.err
> > +}

-- 
Danh
