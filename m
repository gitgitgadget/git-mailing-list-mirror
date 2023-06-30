Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2F8EB64D9
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 01:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjF3BFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 21:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjF3BFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 21:05:09 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D67B1FCD
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 18:05:07 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-528ab71c95cso812090a12.0
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 18:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688087107; x=1690679107;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Im8GJqKhtUiL9pfQ9CvcLlOXRcIL3zcjb0/Rbnc/Pjk=;
        b=uDwqPpOHwCccfvHjAfmQavBnLBwrghABQUdT5pNTTSAOsRhVP2aTi83gDm92TNeGX7
         IA+AjnMd32+1BVNjl+VXll5vXGjI0iGKqg53kiDkKWjrC9RlhLw5QLvR/Wz+NNx23uyd
         CtYsoutCIHFZnUJTHXMGH9XOkuRyKOXGcSdd54mjmrGmWi4Dvipz0u9MCDGOh9SuTSYy
         c/aro7DmbEJHavVE0r2G2FA5UOncM/CzyjJl65O7aANeUrIhVv8/q1TKXM/aO5WGGvEm
         z/M4qfu08IaSdhPQX6d8TcYAQ1AFlIBZEvwa8Ma8Fyq4DPPKu33BI5OYD/a8bFcsw4/t
         6NqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688087107; x=1690679107;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Im8GJqKhtUiL9pfQ9CvcLlOXRcIL3zcjb0/Rbnc/Pjk=;
        b=AXSFeT5oJcge9ly1OY6gLexYizGO8S38ycuC1qPT6VE7YheGF7Z+8vdxAR2bb7yLay
         pC0FuPuRkAR0mVR8Fxfrw2bxMfaaaS6xCNNfd9iYmsmUL/fLqQG7kEWqYd/m4TQhFIkG
         hlu+LwYe5kB/cMD2M62ricKQUxC7vbmhV03PdhyeULCDQ9GLNN6B1uF2N4EfE9BwIYHn
         HRjBm3rTxx2C00ByeF8QK8pEZHm9idbcVPD9AcE6kxsN5TM8BgpNjcg5CURUoUw01vmG
         Xrdsmn6lj7xOJbXonOyka1TI+LMewXVXXB5DJbY5i4Mp1Gnfn5eOX8JbAbgnNTJqjEvy
         JCHw==
X-Gm-Message-State: ABy/qLZd5pqNi9es3aKimM6rtwr7CQUDYDGqzSybqysZz9N2p0+w2ytZ
        Pakc7lmCOT6frkHbuTgQs4K3sGpuCnrR2Q==
X-Google-Smtp-Source: APBJJlGIaFcbIGkUG8s4T7wAV/9DzPcA2HFCd7INKpiBC8cgoLW1oML+ih1ymLfl5u8wYi8EayWDrsjMCrbAlA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a63:1520:0:b0:553:a9aa:965d with SMTP id
 v32-20020a631520000000b00553a9aa965dmr230417pgl.2.1688087107034; Thu, 29 Jun
 2023 18:05:07 -0700 (PDT)
Date:   Thu, 29 Jun 2023 18:05:05 -0700
In-Reply-To: <20230627132026.3204186-1-siddhartth@google.com>
Mime-Version: 1.0
References: <20230531155142.3359886-1-siddhartth@google.com> <20230627132026.3204186-1-siddhartth@google.com>
Message-ID: <kl6l5y75rc8u.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [RFC PATCH v2] khash_test.c : add unit tests
From:   Glen Choo <chooglen@google.com>
To:     Siddharth Singh <siddhartth@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some comments on mechanical issues...

It seems that you dropped the other participants from your reply.

  https://git-scm.com/docs/MyFirstContribution#v2-git-send-email

Do CC them as it helps them keep track of discussions they were in. I
think they will not mind if you send a new message to this thread, CC
them, and explain that you didn't mean to omit them.

Siddharth Singh <siddhartth@google.com> writes:

> Signed-off-by: Siddharth Singh <siddhartth@google.com>
> ---
> Since v1
> - rewrote the code keeping coding style guidelines in mind.
> - refactored tests to improve their implementation..
> - added a few more tests that cause collisions in the hashmap.
> In the v1 patch, there were concerns that new tests were unnecessary beca=
use of upstream tests. However, I believe it would be beneficial to have te=
sts based on the khash implementation in the git codebase because the exist=
ing tests[1] for khash do not use the same code for khash as the git codeba=
se.=20
> E.g. in khash.h file of =E2=80=9Cattractivechaos/klib/khash.h=E2=80=9D [2=
]. There's an implementation for `KHASH_MAP_INIT_INT64` which isn=E2=80=99t=
 defined in =E2=80=9Cgit/git/khash.h=E2=80=9D[3]. So, there=E2=80=99s a pos=
sibility that the khash.h in a different repository might move forward and =
end up being different from out implementation, so writing tests for =E2=80=
=9Cgit/git/khash.h=E2=80=9D would ensure that our tests are relevant to the=
 actual usage of the library.
> While my colleagues are currently investigating whether C Tap harness is =
the best way to test libified code, this RFC is intended to discuss the con=
tent of unit tests and what other tests would be useful for khash.h. I am u=
nsure of what tests will be valuable in the future, so I would appreciate y=
our thoughts on the matter. Many test cases are easier to construct in C TA=
P harness than in test-tool. For example, In C TAP harness, non-string valu=
es can be used directly in hash maps. However, in test-tool, non-string val=
ues must be passed as an argument to a shell executable, parsed into the co=
rrect type, and then operated on.
> I'm also very new to writing unit tests in C and git codebase in general,=
 so I'll appreciate constructive feedback and discussion..

Do rewrap the line to 80 characters, otherwise it is quite hard to read
on most text-based clients. You can preview your patches with "git
send-email --annotate" and see if they are a reasonable column width.

> diff --git a/Makefile b/Makefile
> index 660c72d72e..d3ad2fa23c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3847,11 +3847,13 @@ $(UNIT_TEST_RUNNER): t/runtests.c
> =20
>  UNIT_TEST_PROGS +=3D t/unit-tests/unit-test-t
>  UNIT_TEST_PROGS +=3D t/unit-tests/strbuf-t
> +UNIT_TEST_PROGS +=3D t/unit-tests/khash-t
> =20
>  $(UNIT_TEST_PROGS): $(CTAP_OBJS) $(LIBS)
>  	$(QUIET)mkdir -p t/unit-tests
>  	$(QUIET_CC)$(CC) -It -o t/unit-tests/unit-test-t t/unit-test.c $(CTAP_O=
BJS)
>  	$(QUIET_CC)$(CC) -It -o t/unit-tests/strbuf-t t/strbuf-test.c -DSKIP_CO=
MMON_MAIN common-main.c $(CTAP_OBJS) $(LIBS)

Many reviewers like to apply the patches for review. It's typically
assumed that patches are based on 'master', but this looks like it is
not. That's okay, though you should call it out. If it is based on
something not in Junio's tree (and thus a reviewer can't apply your
patch), it would be appreciated if you share this commit via a Git fork,
e.g. GitHub.

> +/*
> +  These tests are for base assumptions; if they fails, library is broken

Missing *.

> +int hash_string_succeeds() {
> +  const char *str =3D "test_string";

We use tabs, not spaces. I think "make style" catches this.

> +int initialized_hashmap_pointer_not_null() {
> +  kh_str_t *hashmap =3D kh_init_str();
> +
> +  if(hashmap !=3D NULL){

"if ", not "if". "make style" will catch this.

> +int update_value_after_deletion_succeeds() {
> +  int ret, value1 =3D 14, value2 =3D 15;
> +  khint_t pos1, pos2;
> +  kh_str_t *hashmap =3D kh_init_str();
> +  // adding the kv to the hashmap

Comments use /* */, not //.
