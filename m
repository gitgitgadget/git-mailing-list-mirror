Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EC5C48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 16:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E268613AC
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 16:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbhFIQOV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 12:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbhFIQOS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 12:14:18 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F86BC061574
        for <git@vger.kernel.org>; Wed,  9 Jun 2021 09:12:07 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q5so26149664wrm.1
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 09:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eI6n0aN9YiJyRAa4tsEarH9OJdBt7KV8llRaZUeK+/Q=;
        b=L7xSvJ/n0SIzC7gOyIQchAyGmJUtlljOvYPglElrvB460b5WA7iC6iGXkbQILxgLrH
         zGd9t+HJLXuDPS5dWchnHQrfQU8tZVVlnPnjrE7BDYv52Dya1eqvZ3hG7/HogO41kM47
         uW4uiyfNm+zkE5OhCJG5BbzYASmk1S5bqKUZ0xc4DmxR0dkOFp9BiDe5yGhsHOXcUyjC
         st0cn+LgczHcWRNC4KlkJ5434VmcImF0hhyBwJoW7bp6UQLF1uwx8yG1uA1EciR+84t3
         drI2FVnaW+BsgJsisS08ssJndmWUdnsCA8IPqH3806Hf/JeQffcHTxJZ6uVBtsSWBZJv
         TOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eI6n0aN9YiJyRAa4tsEarH9OJdBt7KV8llRaZUeK+/Q=;
        b=qPsZ4xDMHpTBGmgtYPsk2BhNdBbuZMh8MFu0eWwUHTmhC1YieosPLL/GqyYvW7PVJd
         WITrzCcqqyd1f3iLGZZwBD5V0E2jJjzj2dGflrOYnFBRnb9ZD6IKZq0iSxny37l9O2Qn
         TcQrMGUkt0TC7dJYFUV/GSttDS6UI6xWRXI5xv2sVCtlJSpGcqQWocXfnEZx/VFIBBQF
         JzXLchvhUxmBKo15q5fCAEEDIc+bVB3SJoc3tGPgF2JBjUQBLao6sH7m85bOcT1DDRW8
         8VqndIpU6I4hZIixZWoPquQhoYRtf8WZHsjV0qtkjgplZwHDdgXeASSOrM4Wxf4Q8eFW
         fyKg==
X-Gm-Message-State: AOAM532aQaR5QzURiY0lZwiiWJuu3mgU5pM6S3tnTkZINPLI0VinaSK1
        GikUwUg1e4Eb4yXUlEV/sqQVqQvkHNw=
X-Google-Smtp-Source: ABdhPJwXMRm8O8Q/Anhj55sqIpmdDytuYgcczID0tWr+sqW/WuHk6YqhgYd9pd31XnhSWaDdoGbTTQ==
X-Received: by 2002:a5d:6747:: with SMTP id l7mr629275wrw.220.1623255123009;
        Wed, 09 Jun 2021 09:12:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 89sm350689wri.94.2021.06.09.09.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 09:12:02 -0700 (PDT)
Message-Id: <pull.976.v2.git.1623255121.gitgitgadget@gmail.com>
In-Reply-To: <pull.976.git.1623163082.gitgitgadget@gmail.com>
References: <pull.976.git.1623163082.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Jun 2021 16:11:57 +0000
Subject: [PATCH v2 0/4] [GSOC][RFC] ref-filter: add %(rest) atom
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to let git cat-file --batch reuse ref-filter logic, the atom
%(rest) and %(raw) are added to ref-filter.

Change from last version: Use printf "xxx" instead of printf "%b" "xxx" in
test, ensure that strings containing NUL will not be truncated, to avoid the
breakage of the test.

ZheNing Hu (4):
  [GSOC] ref-filter: add obj-type check in grab contents
  [GSOC] ref-filter: add %(raw) atom
  [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
  [GSOC] ref-filter: add %(rest) atom

 Documentation/git-for-each-ref.txt |   9 ++
 builtin/tag.c                      |   2 +-
 ref-filter.c                       | 226 +++++++++++++++++++++--------
 ref-filter.h                       |   9 +-
 t/t3203-branch-output.sh           |   4 +
 t/t6300-for-each-ref.sh            | 211 +++++++++++++++++++++++++++
 t/t7004-tag.sh                     |   4 +
 t/t7030-verify-tag.sh              |   4 +
 8 files changed, 408 insertions(+), 61 deletions(-)


base-commit: 1197f1a46360d3ae96bd9c15908a3a6f8e562207
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-976%2Fadlternative%2Fref-filter-texconv-filters-v2-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-976/adlternative/ref-filter-texconv-filters-v2-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/976

Range-diff vs v1:

 1:  48d256db5c34 = 1:  48d256db5c34 [GSOC] ref-filter: add obj-type check in grab contents
 2:  428d105ebbad ! 2:  abee6a03becb [GSOC] ref-filter: add %(raw) atom
     @@ t/t6300-for-each-ref.sh: test_atom refs/myblobs/first contents:body ""
      +'
      +
      +test_expect_success 'set up refs pointing to binary blob' '
     -+	printf "%b" "a\0b\0c" >blob1 &&
     -+	printf "%b" "a\0c\0b" >blob2 &&
     -+	printf "%b" "\0a\0b\0c" >blob3 &&
     -+	printf "%b" "abc" >blob4 &&
     -+	printf "%b" "\0 \0 \0 " >blob5 &&
     -+	printf "%b" "\0 \0a\0 " >blob6 &&
     -+	printf "%b" "  " >blob7 &&
     ++	printf "a\0b\0c" >blob1 &&
     ++	printf "a\0c\0b" >blob2 &&
     ++	printf "\0a\0b\0c" >blob3 &&
     ++	printf "abc" >blob4 &&
     ++	printf "\0 \0 \0 " >blob5 &&
     ++	printf "\0 \0a\0 " >blob6 &&
     ++	printf "  " >blob7 &&
      +	>blob8 &&
      +	git hash-object blob1 -w | xargs git update-ref refs/myblobs/blob1 &&
      +	git hash-object blob2 -w | xargs git update-ref refs/myblobs/blob2 &&
 3:  e4a5aeec0409 = 3:  c99d1d070a18 [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
 4:  5e95292e3de2 = 4:  5a5b5f78aeea [GSOC] ref-filter: add %(rest) atom

-- 
gitgitgadget
