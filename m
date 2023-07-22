Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3774C001B0
	for <git@archiver.kernel.org>; Sat, 22 Jul 2023 21:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjGVV3N (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jul 2023 17:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGVV3N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jul 2023 17:29:13 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084D310D8
        for <git@vger.kernel.org>; Sat, 22 Jul 2023 14:29:12 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6687466137bso1826271b3a.0
        for <git@vger.kernel.org>; Sat, 22 Jul 2023 14:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690061351; x=1690666151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kO0WXKOnN63KWkFgTGjXoMHnPkGIbAD0vzJsUIJW8+Q=;
        b=nFUosdRI9FvCHtDaBT/lLNXwL0hkCs2/nsT/v8iOR1iDSm2f3khR+MQW7PwL2HbRxs
         SooXzA0a67Lyp5rEYYt/eRNHkuLQlR9NiI1uwGj/uAosT2X1w4CcKm2LgSITD0R5N7PF
         EcWxvr6Jzwn88cL/0u2NdX8udeFRECvRJ55hwQydKVBrHpfRzbGzRzLmfBvBeoq6v908
         SzHWGwTwaLvKkih9cR/FEXI4GkpkIJEgNs5WR/B9d6c3oTRq/KY2R23w7C0RwyI0AqoS
         VOqUFc1fsMEPh/x3nENkpQO9zCI+ZGrnExj9WxWJDJocV+YDvb3fwzZ8LSAhWtD1+ilf
         S6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690061351; x=1690666151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kO0WXKOnN63KWkFgTGjXoMHnPkGIbAD0vzJsUIJW8+Q=;
        b=KiZAZodYOLpGn0GHI1MOKJnbyVIBSMpzGsuiTWzX1Q1CwRip66GNWxwemmAe8tuFYL
         GvXTSsyZmvAqOsvEuja7OR7re7wIKWOpNN6WDkavf17KmXlzy9iT7Q4TA7XFLGhpXJhQ
         3moqSR247urMy6U6zUUjdW4RHXV+7VrGh9LChVrQfBAVAKK5s5rGJp0aEPF2tVfo2sO5
         5w4AJnSZEERTOEWnGNND2vmKWFVk7dHy+sKWfpLMMdcPzYNgqoA/Ke34vgW+67j1xAGM
         C978sElWkv1YnCMn0qwf/6tNBZipkFb9A5gWRFk8n2JV2WHh6fQL4tazNgb8xO26dbk9
         hjmA==
X-Gm-Message-State: ABy/qLaMDNJqrO7N4Dru0Y4QmbmBgefA6SLBMgBUTZh1++Jg3ktKqjQ5
        /bxoCIoHJe960+9fhS+OcicnL6DvufQ=
X-Google-Smtp-Source: APBJJlHGG8DDLJtafw5keqVCUs8Q+rxnHMw9D8StygWa9YHHuUCy4m2NbsEub4bJSwcPh8CDRvL5nQ==
X-Received: by 2002:a05:6a00:c90:b0:64c:c5f9:1533 with SMTP id a16-20020a056a000c9000b0064cc5f91533mr3630033pfv.33.1690061351070;
        Sat, 22 Jul 2023 14:29:11 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id b12-20020aa7810c000000b006833b73c749sm5055224pfi.22.2023.07.22.14.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 14:29:10 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, alban.gruin@gmail.com, gitster@pobox.com,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v5 0/1] sequencer: finish parsing the todo list despite an invalid first line
Date:   Sat, 22 Jul 2023 15:28:24 -0600
Message-ID: <20230722212830.132135-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721060848.35641-1-alexhenrie24@gmail.com>
References: <20230721060848.35641-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from v4:
- Put Phillip's suggested explanation in the commit message
- Check for truncation both after the first `git rebase` and after
  `git rebase --edit-todo`

Thanks to Phillip and Junio for your feedback.

Alex Henrie (1):
  sequencer: finish parsing the todo list despite an invalid first line

 sequencer.c                   |  2 +-
 t/t3404-rebase-interactive.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

Range-diff against v4:
1:  f6fcdcd9a9 ! 1:  6fbe4fd3e6 sequencer: finish parsing the todo list despite an invalid first line
    @@ Metadata
      ## Commit message ##
         sequencer: finish parsing the todo list despite an invalid first line
     
    -    ddb81e5072 (rebase-interactive: use todo_list_write_to_file() in
    -    edit_todo_list(), 2019-03-05) made edit_todo_list more efficient by
    -    replacing transform_todo_file with todo_list_parse_insn_buffer.
    -    Unfortunately, that innocuous change caused a regression because
    -    todo_list_parse_insn_buffer would stop parsing after encountering an
    -    invalid 'fixup' line. If the user accidentally made the first line a
    -    'fixup' and tried to recover from their mistake with `git rebase
    -    --edit-todo`, all of the commands after the first would be lost.
    +    Before the todo list is edited it is rewritten to shorten the OIDs of
    +    the commits being picked and to append advice about editing the list.
    +    The exact advice depends on whether the todo list is being edited for
    +    the first time or not. After the todo list has been edited it is
    +    rewritten to lengthen the OIDs of the commits being picked and to remove
    +    the advice. If the edited list cannot be parsed then this last step is
    +    skipped.
     
    -    To avoid throwing away important parts of the todo list, change
    -    todo_list_parse_insn_buffer to keep going and not return early on error.
    +    Prior to db81e50724 (rebase-interactive: use todo_list_write_to_file()
    +    in edit_todo_list(), 2019-03-05) if the existing todo list could not be
    +    parsed then the initial rewrite was skipped as well. This had the
    +    unfortunate consequence that if the list could not be parsed after the
    +    initial edit the advice given to the user was wrong when they re-edited
    +    the list. This change relied on todo_list_parse_insn_buffer() returning
    +    the whole todo list even when it cannot be parsed. Unfortunately if the
    +    list starts with a "fixup" command then it will be truncated and the
    +    remaining lines are lost. Fix this by continuing to parse after an
    +    initial "fixup" commit as we do when we see any other invalid line.
     
         Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
     
    @@ t/t3404-rebase-interactive.sh: test_expect_success 'static check of bad command'
     +test_expect_success 'the first command cannot be a fixup' '
     +	rebase_setup_and_clean fixup-first &&
     +	(
    -+		set_fake_editor &&
    -+		test_must_fail env FAKE_LINES="fixup 1 2 3 4" \
    -+			       git rebase -i HEAD~4 2>actual &&
    ++		cat >orig <<-EOF &&
    ++		fixup $(git log -1 --format="%h %s" B)
    ++		pick $(git log -1 --format="%h %s" C)
    ++		EOF
    ++
    ++		(
    ++			set_replace_editor orig &&
    ++			test_must_fail git rebase -i A 2>actual
    ++		) &&
     +		grep "cannot .fixup. without a previous commit" actual &&
     +		grep "You can fix this with .git rebase --edit-todo.." actual &&
    -+		grep -v "^#" .git/rebase-merge/git-rebase-todo >orig &&
    ++		# verify that the todo list has not been truncated
    ++		grep -v "^#" .git/rebase-merge/git-rebase-todo >actual &&
    ++		test_cmp orig actual &&
    ++
     +		test_must_fail git rebase --edit-todo 2>actual &&
     +		grep "cannot .fixup. without a previous commit" actual &&
     +		grep "You can fix this with .git rebase --edit-todo.." actual &&
    ++		# verify that the todo list has not been truncated
     +		grep -v "^#" .git/rebase-merge/git-rebase-todo >actual &&
    -+		# check that --edit-todo did not lose any of the todo list
     +		test_cmp orig actual
     +	)
     +'
-- 
2.41.0

