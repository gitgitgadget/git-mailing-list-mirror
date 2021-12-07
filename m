Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33E8C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 08:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbhLGIf2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 03:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbhLGIf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 03:35:27 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C98BC061354
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 00:31:57 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id u1so27739092wru.13
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 00:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=L6McFVKidntjTRJgeRckrxaOo5wa4JA7cy7O95l/ZPU=;
        b=WfhmqLsFlrf/Qr+9XoJFt9skfE6VLUeb4qqf7vH7DgKfaM3i7nN6tF/6XLpXZeXpXD
         BX7iPUtaVVD7+/d6Ccq3YDCJc7bFWpJ8GcXZX83cM2hj3w8ka/Lx+2bgyXW1f1MPIGNH
         vMeQyntoXhBmaBUnaVALGjsJDMsDuC3F6wEEND+FraYdX2d1QFX3QCBe3yqMs92K2ysI
         cuwwcCePbSHAjhMRN9YkzNGKZ3nLkaikTkhEcZgY1yHQtSHbvAYN6Pob9O6qNC4hkpSX
         k+Oi4sxzp0dhAPcf6V7VBza2BoMXuwAldGKR9ROlKLpmBYuIHF73pQruqS5gxddcMfKw
         1pAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=L6McFVKidntjTRJgeRckrxaOo5wa4JA7cy7O95l/ZPU=;
        b=ZHr8ALHU2POhGY9qy5tnqjefmXMmtdgLapToBZKlT7UTOdCtyOirg2RE+39jDVLGOV
         lF27c7SvJHf+w/9I/+27GFbSMBNwyaAzLaSpu0T/msunCJ1EMz4ZJH8HEm/1cgvx1Imr
         ZUJzXvusm/bYiDDMpcPSkuZC06xd0elBURewSYyYkh3WYSUtNvId7F00dlyy81cM1N2f
         uMNk1r/sFInxx7K75HGx3QzdpbOBDz1IvVU/pEE8XzOGDDhscOjBO1cYolYE8Gs/d1Ff
         GAeS/MqA24XIwyP4lgKNne0TmYpjnjeum9U6i3RAZyIC8Q4cuiMcVEwAKlqj2G0f1O3W
         0rTw==
X-Gm-Message-State: AOAM532bKXDGU7PtTIWzokQ2NB2E+Q1y5CNUpikuPC33TSqLXuLx9TqT
        1nCs6QmlZpjQUUctRGAsGUekX4Et9x0=
X-Google-Smtp-Source: ABdhPJztTIIkz4p77M1cQFtFW6Nr/9Eh4ECUjtWi8NUXDxqaWg69GZGq2JJPy749SmXJ7dyLSZcFbA==
X-Received: by 2002:a05:6000:1548:: with SMTP id 8mr49347890wry.279.1638865914598;
        Tue, 07 Dec 2021 00:31:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r17sm2098258wmq.11.2021.12.07.00.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 00:31:54 -0800 (PST)
Message-Id: <pull.1076.v17.git.1638865913.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v16.git.1638853295.gitgitgadget@gmail.com>
References: <pull.1076.v16.git.1638853295.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 08:31:50 +0000
Subject: [PATCH v17 0/3] am: support --empty=(die|drop|keep) option and --allow-empty option to
 handle empty patches
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since that git has supported the --always option for the git-format-patch
command to create a patch with an empty commit message, git-am should
support applying and committing with empty patches.

----------------------------------------------------------------------------

Changes since v1:

 1. add a case when not passing the --always option.
 2. rename the --always option to --allow-empty.

----------------------------------------------------------------------------

Changes since v2:

 1. rename the --allow-empty option to --empty-commit.
 2. introduce three different strategies (die|skip|asis) when trying to
    record empty patches as empty commits.

----------------------------------------------------------------------------

Changes since v3:

 1. generate the missed file for test cases.
 2. grep -f cannot be used under Mac OS.

----------------------------------------------------------------------------

Changes since v4:

 1. rename the --empty-commit option to --empty.
 2. rename three different strategies (die|skip|asis) to die, drop and keep
    correspondingly.

----------------------------------------------------------------------------

Changes since v5:

 1. throw an error when passing --empty option without value.

----------------------------------------------------------------------------

Changes since v6:

 1. add i18n resources.

----------------------------------------------------------------------------

Changes since v7:

 1. update code according to the seen branch.
 2. fix the wrong document of git-am.
 3. sign off commits by a real name.

----------------------------------------------------------------------------

Changes since v8:

 1. update the committer's name with my real name to fix DCO of GGG.

----------------------------------------------------------------------------

Changes since v9:

 1. imitate the signed name format of
    https://lore.kernel.org/git/pull.1143.git.git.1637347813367.gitgitgadget@gmail.com
    .

----------------------------------------------------------------------------

Changes since v11:

 1. introduce an interactive option --allow-empty for git-am to record empty
    patches in the middle of an am session.

----------------------------------------------------------------------------

Changes since v12:

 1. record the empty patch as an empty commit only when there are no
    changes.
 2. fix indentation problems.
 3. simplify "to keep recording" to "to record".
 4. add a test case for skipping empty patches via the --skip option.

----------------------------------------------------------------------------

Changes since v13:

 1. add an additional description about the 'die' value.

----------------------------------------------------------------------------

Changes since v14:

 1. reimplement the 'die' value and stop the whole session. (Expected a
    reroll)
 2. the --allow-empty option is a valid resume value only when: (Expected a
    reroll)
    * index has not changed
    * lacking a patch

----------------------------------------------------------------------------

Changes since v15:

 1. rename "die" to "stop".

----------------------------------------------------------------------------

Changes since v16:

 1. fix typo from "had" to "has" in the comment.

徐沛文 (Aleen) (3):
  doc: git-format-patch: describe the option --always
  am: support --empty=<option> to handle empty patches
  am: support --allow-empty to record specific empty patches

 Documentation/git-am.txt           |  16 ++++-
 Documentation/git-format-patch.txt |   6 +-
 builtin/am.c                       |  90 +++++++++++++++++++++----
 t/t4150-am.sh                      | 102 +++++++++++++++++++++++++++++
 t/t7512-status-help.sh             |   1 +
 wt-status.c                        |   3 +
 6 files changed, 203 insertions(+), 15 deletions(-)


base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1076%2Faleen42%2Fnext-v17
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1076/aleen42/next-v17
Pull-Request: https://github.com/gitgitgadget/git/pull/1076

Range-diff vs v16:

 1:  a524ca6adfa = 1:  a524ca6adfa doc: git-format-patch: describe the option --always
 2:  b9e03f2342b = 2:  b9e03f2342b am: support --empty=<option> to handle empty patches
 3:  abcdfa1b375 ! 3:  ea2dc088b37 am: support --allow-empty to record specific empty patches
     @@ builtin/am.c: next:
        * all the hard work, and we do not have to do any patch application. Just
      - * trust and commit what the user has in the index and working tree.
      + * trust and commit what the user has in the index and working tree. If `allow_empty`
     -+ * is true, commit as an empty commit when index had not changed and lacking a patch.
     ++ * is true, commit as an empty commit when index has not changed and lacking a patch.
        */
      -static void am_resolve(struct am_state *state)
      +static void am_resolve(struct am_state *state, int allow_empty)

-- 
gitgitgadget
