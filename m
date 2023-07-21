Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CF5EB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 05:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjGUFwt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 01:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjGUFwR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 01:52:17 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E6C3AB7
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 22:51:42 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-55b22f82ac8so1874225a12.1
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 22:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689918702; x=1690523502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mb1axS95qsch9iWoedBdre/E9lSxP8nZD6puAqBqAtA=;
        b=IPvIgPjnQh4Dq9rxVEUXhXU0b6I6QwwpeMOH46Od+mPPGHWjUPyQ/51ASMW1waad5T
         CclFSkbZE1/71O3C8NwnDw2zRqGpwr5ULf+4/C8hddUbkpdUC/Z1n+U9U85HFK4XItrZ
         YjEjHw+hg286M9YtnfFmUNYfauaTo0XD1Up5GjsidLFy5g1MyFzZRIRe4HEAZbSp2z8E
         jFVoryxMHueCLcnJeIwt8mpF2TqsGB7ZzG6Gs2EBL7lNB5f2BL5T/n5bOq5VZzzHKcNE
         SOLILlfdG70mvZhjotNdrmQHTRGYfI4oVEiZoQ3Wck5XMzqHmzCB8MTcEnDE4WibZVbd
         P0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689918702; x=1690523502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mb1axS95qsch9iWoedBdre/E9lSxP8nZD6puAqBqAtA=;
        b=gYxAURsIJjQ8+2xgE5lbMLwUXHwdhuGMJiUeiZTDljwek2IdPsmWex+4WgGym65WYR
         Viu7qe6KHYMgrXMdTLSdG1iisdSl60nxqdZ5xSydoe5bovEP8aicPxnHUg1ul3Lu5KOU
         XRwi869pKg3Bdjg49TG7zb42jfsHZDw0nygzNejwO2xR8AtWWvFH6FnE6cvNvMGZCx/B
         HxIo1oIdsS1R9OpvLUzk1XOcoWs+nZ3JczQ1/WEbGdYmq7ycAwunv2ERvKCzs0dGMT/G
         rBsuT3Tgn3mvhr0PE6wNcLdKkQbqSAMM+89SVAZt+5dfcYbkijRJsaJDllTKJF2Mtl+h
         pbHw==
X-Gm-Message-State: ABy/qLafq4SFF993z7sn/fOiE/80volxiesP1IFaV4NyYVSLWIW9VdJJ
        69m2jdz5FzBsmXOAu9hf1aWRsAUStdY=
X-Google-Smtp-Source: APBJJlGItsxzS91oAu0BEqBFGynQKgGzM2ZOzKGfSCoETu04tP1izEeUOaRd14ap69NFXW/TgVTNBA==
X-Received: by 2002:a17:90b:1d07:b0:263:3567:f99 with SMTP id on7-20020a17090b1d0700b0026335670f99mr1637694pjb.15.1689918701665;
        Thu, 20 Jul 2023 22:51:41 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id m4-20020a17090a7f8400b00265c742a262sm1803673pjl.4.2023.07.20.22.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 22:51:41 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, alban.gruin@gmail.com, gitster@pobox.com,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2 0/1] sequencer: finish parsing the todo list despite an invalid first line
Date:   Thu, 20 Jul 2023 23:38:56 -0600
Message-ID: <20230721053906.14315-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719144339.447852-1-alexhenrie24@gmail.com>
References: <20230719144339.447852-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from v1:
- Use `grep` instead of `test_i18ngrep`
- Check for an error message from --edit-todo
- Move and rephrase the comment in the test

Thanks to Junio and Phillip for your feedback.

Alex Henrie (1):
  sequencer: finish parsing the todo list despite an invalid first line

 sequencer.c                   |  2 +-
 t/t3404-rebase-interactive.sh | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

Range-diff against v1:
1:  ceb53efb79 ! 1:  8005d81440 sequencer: finish parsing the todo list despite an invalid first line
    @@ t/t3404-rebase-interactive.sh: test_expect_success 'static check of bad command'
      '
      
     +test_expect_success 'the first command cannot be a fixup' '
    -+	# When using `git rebase --edit-todo` to recover from this error, ensure
    -+	# that none of the original todo list is lost
     +	rebase_setup_and_clean fixup-first &&
     +	(
     +		set_fake_editor &&
     +		test_must_fail env FAKE_LINES="fixup 1 2 3 4 5" \
     +			       git rebase -i --root 2>actual &&
    -+		test_i18ngrep "cannot .fixup. without a previous commit" \
    -+				actual &&
    -+		test_i18ngrep "You can fix this with .git rebase --edit-todo.." \
    -+				actual &&
    ++		grep "cannot .fixup. without a previous commit" actual &&
    ++		grep "You can fix this with .git rebase --edit-todo.." actual &&
     +		grep -v "^#" .git/rebase-merge/git-rebase-todo >orig &&
     +		test_must_fail git rebase --edit-todo &&
    ++		grep "cannot .fixup. without a previous commit" actual &&
    ++		grep "You can fix this with .git rebase --edit-todo.." actual &&
     +		grep -v "^#" .git/rebase-merge/git-rebase-todo >actual &&
    ++		# check that --edit-todo did not lose any of the todo list
     +		test_cmp orig actual
     +	)
     +'
-- 
2.41.0

