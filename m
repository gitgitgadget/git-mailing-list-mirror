Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363F9EB64DD
	for <git@archiver.kernel.org>; Sat,  5 Aug 2023 08:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjHEI1T (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Aug 2023 04:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHEI1R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2023 04:27:17 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D1C1FE6
        for <git@vger.kernel.org>; Sat,  5 Aug 2023 01:27:15 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d0548cf861aso3032765276.3
        for <git@vger.kernel.org>; Sat, 05 Aug 2023 01:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691224035; x=1691828835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBUpMRSCQY3nHiPWni0gqS3zyR+PfBZqG0QSU7Jfb88=;
        b=r7DTNWX7/mJf6c/LASf5ZH0rDOoHnST6+h/8TNIlsUvnZODDYMKXxL6RCPhMmC/tUO
         daOJ4EcSeM4Wi72uNrR23yLq7OsQLQQT1yJTlxDT9ZJK5Rxu3n5cp2jTZS8O0jA/2fYD
         ljx3DqTE2s1bw08hyI7zre6JnuOSTkfUGwF0k7ngujkRTrW9VF2+c/xBv3ajCaRefqoF
         kBgflM/tH33/U2RgmGWB9V+ctAmHfVRvzq2KU6OiLDf9DPL5Sot+EK3ZTegSY8VVlXyB
         JMsjPwIQiH2DXze+835E51XIMfOOoc+Fuix3MPkAEKwXapEoKpwttig3uWaKut7l9w8U
         B7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691224035; x=1691828835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBUpMRSCQY3nHiPWni0gqS3zyR+PfBZqG0QSU7Jfb88=;
        b=ZCLPwvQwRouaob1wVr7ru1m92GMEcYouPAKI1VF4sduK8KD4854icHufGnXspTS/Xk
         H+bQ7En+cRCeW8u/apZg/kqzSgiCSdbhCsopYp0Pv1UFO6+snFYDKN4Q18Zj9BgTbg42
         ov0OsCbjuvy7Uj9HZBLJN3mIdufg4pTR+ZvqqzmG/pHUQXvozYDzdPbt4TyFjlM8qMEn
         NL2KfIXMWEaWBNgWJrnKq0/3YKhT4zl+fuJhbjU83KemJrdnHUiIm+4t9bWrp2sZPa8N
         5qc6BSQA5dtpLt4BubC8P7MOgIVMFdfIusW50gn/e0Osih51syl8OG1QdOTfxQpyWbi6
         AIAg==
X-Gm-Message-State: AOJu0YzGzdy4cEtmhhojm2jxM0MFGCwKSASnDRnoWvpZ4h/ev75dsA5c
        +K0+xBKOngQjlnlr/YrHObF5TONvhgzHFOkGs6w=
X-Google-Smtp-Source: AGHT+IG6NnidfSVKmBz3WFd/8vuPheEpGh7eCK7BXoa9EciXxHlcQeDt7ltHTHNan2vFccg5KBZ3Dg33z8fpZKkpAek=
X-Received: by 2002:a0d:d84f:0:b0:586:ddc:eabf with SMTP id
 a76-20020a0dd84f000000b005860ddceabfmr4249911ywe.37.1691224034845; Sat, 05
 Aug 2023 01:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8TVGna+C9nYy9nj3h5bT7AdAT0SKtUM3YVz6h=KZhGHHg@mail.gmail.com>
 <xmqqo7k7c1yw.fsf@gitster.g> <CAOLTT8R84Zrtpd=j6o2V=Y_uD54XAS5EA7NWHsdfL+XCkD5cqA@mail.gmail.com>
 <xmqqila6cz0n.fsf@gitster.g> <ZMKtcaN7xYaTtkcI@nand.local>
 <CAOLTT8Ru+3efmUNMOwbhzwRu-FW-SVPYn88-xtrRQiRuweFG+Q@mail.gmail.com>
 <CAOLTT8S=_1Vd2Y4rBqq03JsJ1megRBcx9v-HYAWXe88jDek98Q@mail.gmail.com>
 <ZMvGsYSystLu6oBY@nand.local> <CAOLTT8Tc9NevyUfwiPscEH7BqShSscb=iZP4r+7mjsEwouLeXg@mail.gmail.com>
 <CAP8UFD2GV+1LhZDrSsgQ5=gRgYSTYsS36i2ugoBEHu-Oto-Sow@mail.gmail.com>
 <ZM1EvGVGv2ZYrpuT@nand.local> <xmqqmsz6ljk4.fsf@gitster.g>
In-Reply-To: <xmqqmsz6ljk4.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 5 Aug 2023 16:27:06 +0800
Message-ID: <CAOLTT8SBAb8bAV3uCPJ-q2btNeatMjmtRzDkRASffN5xTS1M0g@mail.gmail.com>
Subject: Re: [QUESTION] how to diff one blob with nothing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=885=E6=97=
=A5=E5=91=A8=E5=85=AD 03:00=E5=86=99=E9=81=93=EF=BC=9A
>
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Fri, Aug 04, 2023 at 10:28:53AM +0200, Christian Couder wrote:
> >> On Fri, Aug 4, 2023 at 6:42=E2=80=AFAM ZheNing Hu <adlternative@gmail.=
com> wrote:
> >>
> >> > Actually, there is no need to support a default empty blob.
> >> > For example, with the command "git diff --no-index <file> /dev/null"=
,
> >> > it can compare a file with /dev/null, but it can only compare <file>
> >> > and not <oid>.
> >> > Therefore, using commands like "git diff <oid> /dev/null",
> >> > "git diff --no-index <oid> /dev/null", or even "git diff <oid> --std=
in"
> >> > could potentially solve this issue.
> >>
> >> Maybe it would be clearer to have a new option, called for example
> >> "--blob-vs-file", for that then. It could support both:
> >>
> >> $ git diff --blob-vs-file <blob> <file>
> >>
> >> and:
> >>
> >> $ git diff --blob-vs-file <file> <blob>
> >
> > Hmm. This feels like a case of trying to teach 'git diff' to do too
> > much.
>
> Worse yet, I do not quite get the original use case in the first
> place.  What is the series of diff output that result in comparing a
> random pair of blob object names going to be used for?
>
> The reply to <ZMKtcaN7xYaTtkcI@nand.local> says that the original
> use case was to express the evolution of a single path since its
> creation until its removal, but the thing is, a diff with an empty
> blob and a creation or a deletion event are expressed differently in
> the patch output, exactly because the patch has to be able to
> express "before this change, a file with zero byte content was
> there" and "before this change, there was nothing at this path"
> (vice versa for contents-removal vs deletion).
>
> For that reason, I have a hard time to find any merit in the earlier
> complaint that said "can be achieved by manually adding them, but it
> is not very compatible with the original logic", whatever the
> "original logic" refers to.  If creation needs to be recorded as
> creation and not as a change from an empty and existing blob, there
> has to be something that needs to be manually done to turn the
> latter (which is the only thing "diff" between two blobs or even a
> blob and a file can give) into the former *anyway*.  Whatever the
> thing that is looping over the history/evoluation of a single path
> needs to have a three-arm switch for each iteration to deal with
> creation, modification, and removal, and iterating over the contents
> of the files and prefixing "+" or "-" on each and every line would
> be the _easiest_ part of such a necessary tweak to turn "diff
> between an empty contents and something else" into "creation or
> deletion of a file."
>

Okay, let me clarify the background for using an empty blob diff.
Essentially, it is a git web diff interface that requires real-time calcula=
tion
of the diff between files across multiple versions and rendering them.
Due to some reasons, the higher-level component did not provide multiple
versions of commits but instead provided blob OIDs (Object IDs).

Therefore, I expected to generate the diff results directly using the
"git diff <oid> <oid>" command. (I only care about the patch part
in the diff and don't really care about the related information of OIDs
in the diff output.) Everything went smoothly except when a blob
is created or deleted, as there is no direct way to obtain
the diff for a blob using the "git diff <oid> <oid>" interface. Initially,
I intended to generate a patch by diffing an empty blob
 (e69de29bb2d1d6434b8b29ae775ad8c2e48c5391) with the blob ID.
However, unlike the empty tree (4b825dc642cb6eb9a060e54bf8d69288fbee4904),
the empty blob does not exist in the git repository by default.

I had to create an additional empty blob for the purpose of performing
the diff, but this goes against the design of the web-based diff interface,
which is intended to be read-only.

So, I might explore methods like "git diff <oid> /dev/null" or
 "git diff <oid> --stdin", they are read only, but it does not
currently exist...

Regardless, I hope that the empty blob diff can simulate the effect of
an empty tree diff:

git diff 4b825dc642cb6eb9a060e54bf8d69288fbee4904

diff --git a/.cirrus.yml b/.cirrus.yml
new file mode 100644
index 0000000000..4860bebd32
--- /dev/null
+++ b/.cirrus.yml
@@ -0,0 +1,22 @@
+env:
+  CIRRUS_CLONE_DEPTH: 1
+
+freebsd_12_task:
+  env:
+    GIT_PROVE_OPTS: "--timer --jobs 10"
+    GIT_TEST_OPTS: "--no-chain-lint --no-bin-wrappers"
+    MAKEFLAGS: "-j4"
+    DEFAULT_TEST_TARGET: prove
+    DEVELOPER: 1
+  freebsd_instance:
+    image_family: freebsd-12-3
+    memory: 2G
+  install_script:
+    pkg install -y gettext gmake perl5
+  create_user_script:
+    - pw useradd git
+    - chown -R git:git .
+  build_script:
+    - su git -c gmake
+  test_script:
+    - su git -c 'gmake test'

Thanks,
ZheNing Hu
