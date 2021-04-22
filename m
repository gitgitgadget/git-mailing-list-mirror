Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A279C433ED
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 15:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A4FC61425
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 15:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbhDVPEl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 11:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbhDVPEl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 11:04:41 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A29AC06174A
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 08:04:06 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h10so53845390edt.13
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 08:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=vq4SrwngtK+yRP37BqdHLZfvRCVJSyNx/ul/N1cGAjw=;
        b=djHzJFZwPauCX+BkXCG/uW26VfoA2601+2VjlMWFffFVEHdh/Hcb9OKkX0Vh/GhXjt
         woYoHcVBSDiO1Q2BRHGg79nDb02LFHVBqKNoDaAOkpMcNImVFHNYNru9l0v+jzDyvnSy
         DWPzpb4yHOiewTTr5WmIxE0KVuL6STYh5XBEPCKxUCPEpmdRSfzKKXfTqguHMbBp+xW3
         KOG0+/l9TQvBl1564BHE6tKH2w3YtTBU/spqLkdzcFo8EKKCvB3ylqML+l+HHKQVOpfr
         /YhQ5mizkfIMCyqJVNGF/YOvgVmn5cicBRtO3rnlNeWgdd0VsVSh3SogUTMkkykva0sK
         jADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=vq4SrwngtK+yRP37BqdHLZfvRCVJSyNx/ul/N1cGAjw=;
        b=RPIVUOLVCjwTMUEoVWkrJR5HK0/2o5styY6Qk1fzidMatEm7Q+VmOUxY4GVynscNG7
         Gz0niPSwVhGtIA3tkQcEw2rXOn+vLTKkYZV9AV6dQPNNdzO0bRwR6jS6hXbB8ravPRHS
         m9sNFErQZdZo65qmi/dXTi+Ly+bmqPCIvnrkIp5bSsJIBHczBDNYSlpqyv7+IuyUuAD3
         Vs3Do7XBfcfB2O+5uPXJGC48ddS2WGrLplA/P5GOZXiV/cqO/hl1YULIYyoO5PXn0SYd
         14o64gaObQnnekwqInAQRCteQtK2MO7Iuyqz9Cy7rMDG+fnKewFVuSTdSAZ+NHLMQcye
         bJRw==
X-Gm-Message-State: AOAM533LsMZyQcVwqHl/3Imft0kelC1qKtvMMWNfJ42ThbppMvGHUQBS
        C1BA6XDb3qo8wV5wIkayBL9ZP2dNXio=
X-Google-Smtp-Source: ABdhPJxDCcEFsJp1rHj3NsTrIlWOhtS6+QOV2D6Z+JsBD9C4MhxB1tv9Qq7l4NEoXSs/neL9YJvMaA==
X-Received: by 2002:a05:6402:19a:: with SMTP id r26mr4431918edv.44.1619103844778;
        Thu, 22 Apr 2021 08:04:04 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id u1sm2379670edv.90.2021.04.22.08.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 08:04:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] t6402: check exit status of ls-files
References: <YIAAzJTG1UitiWyu@danh.dev>
 <20210421104102.3409-1-congdanhqx@gmail.com>
 <20210421104102.3409-2-congdanhqx@gmail.com>
 <CAPig+cSh6VNpWbGPpTqY0rmw7zf9s-kSXSOMYvW94UHOF7t80w@mail.gmail.com>
 <CAPig+cS4tkXZLPDEWgEytzEOCR7oGrXyg1CZVKVPSXuJOifLjQ@mail.gmail.com>
 <xmqq5z0fxlgn.fsf@gitster.g> <YIF+0BZGwpMMI1pf@danh.dev>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YIF+0BZGwpMMI1pf@danh.dev>
Date:   Thu, 22 Apr 2021 17:04:03 +0200
Message-ID: <87pmym1huk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 22 2021, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> On 2021-04-21 16:32:40-0700, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>=20
>> > On Wed, Apr 21, 2021 at 12:55 PM Eric Sunshine <sunshine@sunshineco.co=
m> wrote:
>> >>     count_ls_files 5 -s &&
>> >>     count_ls_files 3 -u &&
>> >>     count_ls_files 1 -u one~HEAD &&
>> >>     ...
>> >>
>> >> The nice thing about having a helper function is that it can clean up
>> >> after itself by not leaving a new file lying around, thus you wouldn't
>> >> have to make adjustments to the expected number of untracked files (as
>> >> mentioned in the commit message). If this is the sort of thing which
>> >> comes up often enough (if there are more such cases beyond the two
>> >> scripts you changed in this series), then it might make sense to
>> >> promote the helper function to test-lib-functions.sh.
>> >
>> > The frequency with which this idiom crops up with commands beyond
>> > git-ls-files suggests the more general solution of supporting it
>> > directly in test-lib-functions.sh for any command. For instance:
>> >
>> >     test_cmd_line_count =3D 3 git ls-files -u &&
>> >
>> > Or, perhaps, a new mode of test_line_count():
>> >
>> >     test_line_count =3D 3 -c git ls-files -u &&
>
> Hm, I'm not sure how would we implement such mode:
>
> * Will we run such command in a subprocess and and pipe to "wc -l"
>   directly to avoid a temporary file, but we will lose the exit code
>   of running command in process?

Just use a tempfile.

> * Will we run in a separated chain? Thus, a temporary file would be
>   created, skimming over test-lib-functions.sh, I couldn't find any
>   convention for creating such files, except for specific use cases,
>   let's say "*.config".

Yeah we happen not to have one of those in test-lib-functions.sh, but a
bunch of helpers create those.

> * Another clever hacks that I don't know *shrug*

>>=20
>> That looks nice on paper, but may be going too far.
>>=20
>> We may want to count the lines in the error message,
>
> Let's assume that we solve above puzzle.
>
> Count the lines in the error messages is not too hard to be imagined,
> let's say by -c2 or something like that.
>
>> or we may want
>> to count the lines after filtering the output with pipe.
>
> However, when it involved a pipe, things becomes complicated.

Yes, there's no portable way to both stream stdout/stderr in the correct
order and to intercept it. You'd need a mkfifo. See also how the "--tee"
mode works (i.e. they're squashed).

>> A test file that is dedicated to test ls-files with a file local
>> helper "count_ls_files" smells like a better place to stop, at least
>> to me.
>
> Hence, I'll stick with local help "count_ls_files" for now.

Here's an implementation that works, sans the fancy opts parsing etc. I
just use -1 for "don't care". You can see "test_commit" etc. for how to
do that.

It doesn't emit output, but that's just a matter of re-cat-ing the
relevant files.

Yes we wouldn't have combined output when you do that, but I don't think
we care, you can chain this thing, and most thing that would do so would
only care about piping stdout/stderr to their own files anyway, and not
that we emit one line of stdout, then another of stderr, another of
stdout etc.

diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
index 425dad97d54..c7251102a3d 100755
--- a/t/t6402-merge-rename.sh
+++ b/t/t6402-merge-rename.sh
@@ -154,14 +154,10 @@ test_expect_success 'pull conflicting renames' \
 	git reset --hard &&
 	git show-branch &&
 	test_expect_code 1 git pull . blue &&
-	git ls-files -u A >a.stages &&
-	test_line_count =3D 1 a.stages &&
-	git ls-files -u B >b.stages &&
-	test_line_count =3D 1 b.stages &&
-	git ls-files -u C >c.stages &&
-	test_line_count =3D 1 c.stages &&
-	git ls-files -s N >n.stages &&
-	test_line_count =3D 1 n.stages &&
+	test_line_count_command =3D 1 0 git ls-files -u A &&
+	test_line_count_command =3D 1 0 git ls-files -u B &&
+	test_line_count_command =3D 1 0 git ls-files -u C &&
+	test_line_count_command =3D 1 0 git ls-files -s N &&
 	sed -ne "/^g/{
 	p
 	q
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index b823c140271..10e3cbe0d47 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -817,6 +817,24 @@ test_line_count () {
 	fi
 }
=20
+test_line_count_command () {
+	local op=3D$1
+	local ocnt=3D$2
+	local ecnt=3D$3
+	shift 3
+	"$@" 2>cnt.err >cnt.out
+	local exit_code=3D$?
+	if test "$ocnt" -gt -1
+	then
+		test_line_count "$op" "$ocnt" cnt.out
+	fi &&
+	if test "$ecnt" -gt -1
+	then
+		test_line_count "$op" "$ecnt" cnt.err
+	fi &&
+	return "$exit_code"
+}
+
 test_file_size () {
 	test "$#" -ne 1 && BUG "1 param"
 	test-tool path-utils file-size "$1"
