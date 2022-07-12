Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1574DC43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 23:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiGLXDA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 19:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiGLXC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 19:02:59 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB91D64E2B
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 16:02:58 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id o26so7502486qkl.6
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 16:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=mjKoXPv8EOiS1ocCRta34FO4HQ988K/7LSJ80W0YaCo=;
        b=Fx1P8bdsqZqkjMP7mPDjdKZhe4Hc1CAe1Xb+wrvAolNsvo4wDmud5n8LKr7BsHpJ76
         dIlNBzjZNZUJ+cAoxITJcp6wY4qk1sOBPAPO6s72D9ePGzretiWqw47XDHJtoIrFAvDl
         dlk74ucfz/flbokHw5/C8QaCkdlwibZXOu6zyk6yX9wlnvmVF01QMRr9rV1b1Qw/0Ba6
         Ul+VCV2i4tsU5+TacMx/mUnPJdrxrmRaUYnCOXO+7/9P32iKoCWxomofoTzMd2UctG/D
         fcce/8qAhzLa2FSNNV0wJ1Afh1XbAGw6u5/vkvUwwj8E5Dnd0ikgurtV4moCLAMv7Bbw
         AXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=mjKoXPv8EOiS1ocCRta34FO4HQ988K/7LSJ80W0YaCo=;
        b=bFI2OkGiEnFBpY/Ukr7n+hg93qTH17nQNMGAUV9SZkxmvGn6/BY7dy9TTj0KAXBXWJ
         Lyc2hm9J83sr2EE3KB6dAYrn28hkz80SIRsxfcy1oKSDEG0fWL6ZZPaY5NZjFE5LLMnr
         O06ocBwNKYsuOTH22edEZ7bzhtsEY4vvJZgMAbKuM2v1EV1sVHQD558mpzsOA/njeGWD
         zUEAAYh/wdrELFBNo20Z2+qZRnLVE65ce0kygNYLgyCpC2v4HpAda/6cyLzTDiqZZy5H
         URnct2wQ6eHxkz72wsPhkVXsJc1T3L3creRjG6zDgUmbOTrYN3s0PAruZyQRAzMWajZZ
         8HOw==
X-Gm-Message-State: AJIora8qNFyetWdPvixWsTw1gxBiUUASLLt1KDzfZg1UYV5dAhyAXt1s
        AMr4u3Mu+dkRWN2+yzU9RduxCZMRMAdmglRMKh3/cygcsoE=
X-Google-Smtp-Source: AGRyM1tzOqH0c15YHKS4DYpV67W2jo4ovCMbpInrP8EKvQDsFL/wAdQHUW+dulW6YzNweikLCoNErKakJLkarHwrRAA=
X-Received: by 2002:a37:b802:0:b0:6b5:8330:55a with SMTP id
 i2-20020a37b802000000b006b58330055amr517477qkf.778.1657666977845; Tue, 12 Jul
 2022 16:02:57 -0700 (PDT)
MIME-Version: 1.0
From:   Britton Kerin <britton.kerin@gmail.com>
Date:   Tue, 12 Jul 2022 15:02:47 -0800
Message-ID: <CAC4O8c9izkV5vbnE6MH8-RwnxRbUONxJxYZO+hb1J0ewuDtX+w@mail.gmail.com>
Subject: BUG: git-check-ignore documentation doesn't come close to describing
 what it really does
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It begins:

       For each pathname given via the command-line or from a file via
--stdin, check whether
       the file is excluded by .gitignore (or other input files to the
exclude mechanism) and output
       the path if it is excluded.

In fact it just reports matches from .gitignore etc:

     $ cat .gitignore
     *.o
     !*.dont_ignore
     $ ls
     bar.o.dont_ignore  foo.o
     $ git check-ignore -v -n *
     .gitignore:2:!*.dont_ignore bar.o.dont_ignore
     .gitignore:1:*.o foo.o
     $ # Even more confusing without -v -n:
     $ git check-ignore *
     bar.o.dont_ignore
     foo.o

The EXIT STATUS section is even more wrong:

     EXIT STATUS
            0
                One or more of the provided paths is ignored.

            1
                None of the provided paths are ignored.

            128
                A fatal error was encountered.

but:

     $ if git check-ignore foo.o.dont_ignore; then echo exited true;
else echo exited false; fi
     foo.o.dont_ignore
     exited true
     $

IMO the behavior of git-check-ignore is the correct and useful
behavior and the documentation should simply be fixed to reflect the
fact that it just lists matching entries rather than wrongly claiming
that it returns the overall result of the ignore calculation.

Britton
