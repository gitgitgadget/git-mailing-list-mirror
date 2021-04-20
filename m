Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91A7C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 16:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC9F86135F
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 16:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhDTQws (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 12:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbhDTQwq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 12:52:46 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A59C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 09:52:14 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j5so37400864wrn.4
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 09:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=tO58F5rlmeJjLWnaufX44PY28RUq3j+sg1j1Fa0DAgQ=;
        b=fhlNa55RlXYW0GlW6UIV+6pw62Wn4QbFbDZZ+jaUm9FeXg3HxjdJpMP37cMK8qTDxB
         51s+YL4a7N2aORb4DfUQM8PQTGDuJvx0iC6zSoLdnEqZhFg5rhK5JmoyTVSE+CWpoGlN
         c2MOyuU3RgoYxfDYz8/xSaeXVIovLfJq6iB1lrqc+0+hDOEfzop8Pf/arPHFJdjiRCmB
         fCP9srn7+7Fqp1n0ZTCu0zsqD7A//HeyRI30efenBTTs5f9N0LbhX9USCP6pbLX9Eoth
         9GqLe3MxiFTvpQ0BCfX6mc3wOw3Eb1pvgwFAw3eTqIeEu3LUFVn8yWwQidIfu/h6WaUT
         Tksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=tO58F5rlmeJjLWnaufX44PY28RUq3j+sg1j1Fa0DAgQ=;
        b=XRo4tHl0GJwTZiQFyaZtsWwa71Pz4l6kgArXkcp1Iy6jtE9s175bIygV73b50tqGbD
         lYutG9+/TlZuMTthU2nSTyX88qWjpnwFXV1pVrhIuPRkZnh5r/uNHsVHLc+qOFC52D45
         byJn18JGdHbjp+HJZ1Lzj1Y6+7x1uwcZ9jbSchV7mG+T18cZ1uoCtZHXJn5CJ4xvCZFu
         lPzINvDB8ZDisk92EA5ZUZgBbqNUVZwx8LnJcrhNwAFeRu6plBQI4s23FPlaNlcsizLu
         170vayi2WqxQ0c2vYzOuaxOHbSBb1ESxnFc0LXfogcy56CfAhSlQbw2JaoX54DQwRc0k
         EaZg==
X-Gm-Message-State: AOAM530e0y0xJwciU1TVn2QUMT0J3M2SpHohgWbdAo0JtgKk8XdGha66
        Jw93LWIaXGfKOC/9N9MGUXgvcAKpxXY=
X-Google-Smtp-Source: ABdhPJyfvUHqPUtBCx9LE+J69yezdWsmAypfzmUkT1fnnxEkoy5lfiRW4yEXJPvgqgmTMOwBKifAOw==
X-Received: by 2002:a5d:47c1:: with SMTP id o1mr20153026wrc.216.1618937533372;
        Tue, 20 Apr 2021 09:52:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h63sm4052582wmh.13.2021.04.20.09.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 09:52:12 -0700 (PDT)
Message-Id: <pull.935.v2.git.1618937532.gitgitgadget@gmail.com>
In-Reply-To: <pull.935.git.1618831726.gitgitgadget@gmail.com>
References: <pull.935.git.1618831726.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Apr 2021 16:52:09 +0000
Subject: [PATCH v2 0/2] [GSOC] ref-filter: reuse output buffer
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 * Firstly, inlining show_ref_array_item().
 * Secondly, git for-each-ref reuse final buf for all refs output, the
   performance is slightly improved, this optimization is also applied to
   git tag -l and git branch -l.

Changes made in v2: reset err buffer in loop for code cleanness.

Thanks.

ZheNing Hu (2):
  [GSOC] ref-filter: get rid of show_ref_array_item
  [GSOC] ref-filter: reuse output buffer

 builtin/branch.c       | 10 ++++++----
 builtin/for-each-ref.c | 15 +++++++++++++--
 builtin/tag.c          | 15 +++++++++++++--
 ref-filter.c           | 25 ++++++++++---------------
 ref-filter.h           |  2 --
 5 files changed, 42 insertions(+), 25 deletions(-)


base-commit: 2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-935%2Fadlternative%2Fref-filter-opt-reuse-buf-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-935/adlternative/ref-filter-opt-reuse-buf-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/935

Range-diff vs v1:

 1:  ec98f2177d90 ! 1:  7e378eef4b34 [GSOC] ref-filter: get rid of show_ref_array_item
     @@ Metadata
       ## Commit message ##
          [GSOC] ref-filter: get rid of show_ref_array_item
      
     -    Inlining the exported function `show_ref_array_item()`
     +    Inlining the exported function `show_ref_array_item()`,
          which is not providing the right level of abstraction,
          simplifies the API and can unlock improvements at the
          former call sites.
 2:  1c7a69ba072a ! 2:  a17949b9f809 [GSOC] ref-filter: reuse output buffer
     @@ Commit message
          [GSOC] ref-filter: reuse output buffer
      
          When we use `git for-each-ref`, every ref will allocate
     -    its own output strbuf. But we can reuse the final strbuf
     -    for each step ref's output.
     +    its own output strbuf and error strbuf. But we can reuse
     +    the final strbuf for each step ref's output. The error
     +    buffer will also be reused, despite the fact that the git
     +    will exit when `format_ref_array_item()` return a non-zero
     +    value and output the contents of the error buffer.
      
          The performance for `git for-each-ref` on the Git repository
          itself with performance testing tool `hyperfine` changes from
     @@ Commit message
          (cat-file: use a single strbuf for all output, 2018-08-14)
          to speed up the cat-file builtin.
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Helped-by: Jeff King <peff@peff.net>
          Helped-by: René Scharfe <l.s.r@web.de>
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
     @@ builtin/branch.c: static void print_ref_list(struct ref_filter *filter, struct r
       	for (i = 0; i < array.nr; i++) {
      -		struct strbuf out = STRBUF_INIT;
      -		struct strbuf err = STRBUF_INIT;
     ++		strbuf_reset(&err);
      +		strbuf_reset(&out);
       		if (format_ref_array_item(array.items[i], format, &out, &err))
       			die("%s", err.buf);
     @@ builtin/for-each-ref.c: int cmd_for_each_ref(int argc, const char **argv, const
      -		struct strbuf output = STRBUF_INIT;
      -		struct strbuf err = STRBUF_INIT;
      -
     ++		strbuf_reset(&err);
      +		strbuf_reset(&output);
       		if (format_ref_array_item(array.items[i], &format, &output, &err))
       			die("%s", err.buf);
     @@ builtin/tag.c: static int list_tags(struct ref_filter *filter, struct ref_sortin
      -		struct strbuf err = STRBUF_INIT;
      -
      +		strbuf_reset(&output);
     ++		strbuf_reset(&err);
       		if (format_ref_array_item(array.items[i], format, &output, &err))
       			die("%s", err.buf);
       		fwrite(output.buf, 1, output.len, stdout);

-- 
gitgitgadget
