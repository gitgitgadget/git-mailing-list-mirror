Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63288C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 06:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbiLTGB2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 01:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbiLTGBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 01:01:25 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24B6B9C
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 22:01:23 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id fy4so11416146pjb.0
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 22:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApCqAKQLYxUY1HWb8qhUYJDnL3n/onQGe5mPPJapSE0=;
        b=An8iofwm5XFMoZBMhpETLS3IKSXEbX660Nc+yob14pvNiBjZkeuaA88wbz+ge5CM7i
         ZFHmM22yQTigbzWpmwMffFx4ud0T67RfCi+ePbjiexO4afiANbElJeypEwj6GOyFTdpq
         zec2/VfBraLKQ7iCRUCOebzmUSZS/PXPEbgQ63f15qie7nu1ZkZKJSWH+I+HROyYpbBY
         tZwUsZocAeCYztkjATqIfF9aerEVPxk82J6xtdgmgD5/ZYnZpUk9R7kyLxaDRe+M9h1o
         7YpNLF5CUzDgPNPKUE9JpA5rrSoDE7vgMTdMLcQ/nRJCYtRXmUDyutDdPFeEQclkh2Yw
         c8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApCqAKQLYxUY1HWb8qhUYJDnL3n/onQGe5mPPJapSE0=;
        b=gkVuspBn1JryO8sIplFnOydSOTPv7bri0pXhbjfphN5hqGxyxa1XRW93TS89mLS4lw
         J9fibij35n3jTV6R1MPvaknBWJPHkebFvSngaio39d2DFHC7M+WmUgakIMQmyhkD9Rvz
         5RBmVp9dJJ+NjB2QGYeGo7YPuo7743NND3df5zthNphlxg8sidV+ED2of0f9+c/51sEM
         RbGuHRMhQfZZvuJ8x6DZnIYW3EzLkGY8N0Qst/gDlsoL0d+oz8V0q/iz5BcsAW3sEagp
         5k4w9jVg46IB1ueRp8vLgdo+u4lUdAHIgFxoUpTUZMc6IiDmEMyX9nt+r7FLK+naVGu6
         7QQQ==
X-Gm-Message-State: ANoB5pkKgRJgfx8IQe1EAoBtdc/DejvILUOWTOMSUp5DCPThBy3d1Cr3
        9tma5LTLWCGL4/YTuVNgQd55DGHc9uqB3Q==
X-Google-Smtp-Source: AA0mqf7Ch28B7EogvgOgsWniNjb/eJPfPpqT5VduFD1CgOxKsLXTMzq551wAz82WI0nHZNZuiLgEPw==
X-Received: by 2002:a17:90a:3b04:b0:219:7f29:3152 with SMTP id d4-20020a17090a3b0400b002197f293152mr47262420pjc.39.1671516082891;
        Mon, 19 Dec 2022 22:01:22 -0800 (PST)
Received: from HB2.. ([223.177.27.192])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090a0d0f00b0021358bd24b9sm10211041pja.21.2022.12.19.22.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 22:01:22 -0800 (PST)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, johncai86@gmail.com,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, me@ttaylorr.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v7 0/2] Add mailmap mechanism in cat-file options
Date:   Tue, 20 Dec 2022 11:31:11 +0530
Message-Id: <20221220060113.51010-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.39.0.97.g8305148718
In-Reply-To: <20220916205946.178925-1-siddharthasthana31@gmail.com>
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks a ton Christian and Ævar for the review :) I have made the
suggested changes in v7.

= Description

At present, `git-cat-file` command with `--batch-check` and `-s` options
does not complain when `--use-mailmap` option is given. The latter
option is just ignored. Instead, for commit/tag objects, the command
should compute the size of the object after replacing the idents and
report it. So, this patch series makes `-s` and `--batch-check` options
of `git-cat-file` honor mailmap when used with `--use-mailmap` option.

In this patch series we didn't want to change that '%(objectsize)'
always shows the size of the original object even when `--use-mailmap`
is set because first we have the long term plan to unify how the formats
for `git cat-file` and other commands works. And second existing formats
like the "pretty formats" used by `git log` have different options for
fields respecting mailmap or not respecting it (%an is for author name
while %aN for author name respecting mailmap).

I would like to thank my mentors, Christian Couder and John Cai, for all
of their help!
Looking forward to the reviews!

= Patch Organization

- The first patch makes `-s` option to return updated size of the
  <commit/tag> object, when combined with `--use-mailmap` option, after
  replacing the idents using the mailmap mechanism.
- The second patch makes `--batch-check` option to return updated size of
  the <commit/tag> object, when combined with `--use-mailmap` option,
  after replacing the idents using the mailmap mechanism.

= Changes in v5

- The patch series which improves the documentation for `-s`, `--batch`,
  `--batch-check` and `--batch-command` is again part of this patch
  series with patch 3/3 squashed into patches 1/3 and 2/3 as suggested
  by Junio, Taylor and Christian. The doc patch series was perviously
  sent independently for improving the documentation of git cat-file
  options:
  https://lore.kernel.org/git/20221029092513.73982-1-siddharthasthana31@gmail.com/

- Improve the tests according to run under SHA-256 mode.

= Changes in v6

- Improve the tests so it doesn't break under macOS.

= Changes in v7

- Used `repo_read_object_file` instead of `read_object_file` because we
  have been trying to migrate away from these, and new code should use
  the non-macro variants.
- Improve the documentation of patch series.

Siddharth Asthana (2):
  cat-file: add mailmap support to -s option
  cat-file: add mailmap support to --batch-check option

 Documentation/git-cat-file.txt | 53 +++++++++++++++++++--------
 builtin/cat-file.c             | 28 +++++++++++++++
 t/t4203-mailmap.sh             | 65 ++++++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+), 14 deletions(-)

Range-diff against v6:
1:  7f20f45183 = 1:  2097544b2d cat-file: add mailmap support to -s option
2:  971f38e064 ! 2:  8305148718 cat-file: add mailmap support to --batch-check option
    @@ Commit message
     
         2. Make one call to `oid_object_info_extended()` to get the type of the
            object. Then, if the object type is either of commit or tag, make a
    -       call to `read_object_file()` to read the contents of the object.
    +       call to `repo_read_object_file()` to read the contents of the object.
     
         I benchmarked the following command with both the above approaches and
         compared against the current implementation where `--use-mailmap`
    @@ Documentation/git-cat-file.txt: OPTIONS
     -	also need to specify the path, separated by whitespace.  See the
     -	section `BATCH OUTPUT` below for details.
     +	on stdin. May not be combined with any other options or arguments
    -+	except --textconv, --filters, or --use-mailmap.
    ++	except `--textconv`, `--filters`, or `--use-mailmap`.
     +	+
     +	* When used with `--textconv` or `--filters`, the input lines
     +	  must specify the path, separated by whitespace. See the section
    @@ Documentation/git-cat-file.txt: OPTIONS
     -	need to specify the path, separated by whitespace.  See the
     -	section `BATCH OUTPUT` below for details.
     +	Print object information for each object provided on stdin. May not be
    -+	combined with any other options or arguments except --textconv, --filters
    -+	or --use-mailmap.
    ++	combined with any other options or arguments except `--textconv`, `--filters`
    ++	or `--use-mailmap`.
     +	+
     +	* When used with `--textconv` or `--filters`, the input lines must
     +	 specify the path, separated by whitespace. See the section
    @@ builtin/cat-file.c: static void batch_object_write(const char *obj_name,
     +			size_t s = data->size;
     +			char *buf = NULL;
     +
    -+			buf = read_object_file(&data->oid, &data->type, &data->size);
    ++			buf = repo_read_object_file(the_repository, &data->oid, &data->type,
    ++						    &data->size);
     +			buf = replace_idents_using_mailmap(buf, &s);
     +			data->size = cast_size_t_to_ulong(s);
     +
-- 
2.39.0.97.g8305148718

