Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABFEC433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 17:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348196AbhLBRkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 12:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348094AbhLBRj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 12:39:59 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AC5C06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 09:36:36 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v11so293197wrw.10
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 09:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=o+yzR3v+HICxu0KErUEfDfQZ02iD/O6cIOZQpZWU2Zw=;
        b=AHUIlJMk6YWWnvXHzh7vu5DNuUXJiBH8ilR4YRmfe2AC89niOeum9s9RYWu4jvxg7O
         PuQ/aJR3rRqUIU2LydHZ5sfrkBwiktktasGtl63oY6i6wg7zvZocdGSr6GjF4MHDcm5m
         OEtP1wR0uCbM3HGe61tey/ZWV7TL3FpEx2hN2ogHTMEs8oH33vE6i3m/g0u7IYuoffPD
         mA2YMVLCqV++AyOu5EDXY6sIh6oiXB+4EJHRzYUGdhLrP992FTpqREvLle5EkYo7JGEH
         Ed5s8mBClmozcdm1mDDsfEuqLgvJmqEVXYDoNuZNWp/Z2JQMV5vc7VcQznJ4fen0vYUx
         zCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=o+yzR3v+HICxu0KErUEfDfQZ02iD/O6cIOZQpZWU2Zw=;
        b=Zfc2DQtK0MI6h/ufzxV9mkFPYBm4yi7BWLeusY6yHFKNjSCv2EjKj9Zsf+MZ4BFq0x
         w0K5tIohVuvT9NKGdPlTvL/jokOk5JDjUWs0UQdb5d69IpPeurq6tr3NYgemXOIOCciI
         uhOLWGBlmYt4dAgJHIch64dJZlXwIE0gZANO5dFi9in/0yeYjpqDrx89N9F/w65LupYm
         iRfWXRNd5y5GhduIaB3KBNjZ3pYnHLwAtrZeUdlPN/5KgUPfStoD6Sv92VYOIVq9o4yy
         2l9KVKMpQ6wzbPtzYQUpRFmUzpwaobpjZqn0Mikd+5ai4ohTHYXLf4w/bw2YK6KGpVlK
         hJow==
X-Gm-Message-State: AOAM533RNr1Mbo1nh08kKzI63SqI/tPoLVTn23ZXWpCbYn4bPK4hwvxf
        DkomO7ibSoCT7kghqLjQtJzMFmpPXYs=
X-Google-Smtp-Source: ABdhPJzf6u7tMxEiwNRST/IPyeuEdR+7te47LHy8D9OXAAipMB3eGFxo7fQqr9/4ByOGeVihbgkzdA==
X-Received: by 2002:a05:6000:1a86:: with SMTP id f6mr15835092wry.230.1638466595100;
        Thu, 02 Dec 2021 09:36:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a1sm567347wri.89.2021.12.02.09.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 09:36:34 -0800 (PST)
Message-Id: <pull.1145.v3.git.git.1638466593.gitgitgadget@gmail.com>
In-Reply-To: <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com>
References: <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Dec 2021 17:36:28 +0000
Subject: [PATCH v3 0/5] Inspect reflog data programmatically in more tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This helps for reftable support, and will help if we want to reconsider
under which conditions reflogs get created/updated.

v3: pointer arithmetic for trimming newline.

Han-Wen Nienhuys (5):
  show-branch: show reflog message
  test-ref-store: don't add newline to reflog message
  t1405: check for_each_reflog_ent_reverse() more thoroughly
  test-ref-store: tweaks to for-each-reflog-ent format
  refs/debug: trim trailing LF from reflog message

 builtin/show-branch.c          | 12 +++++++-----
 refs/debug.c                   |  7 +++++--
 t/helper/test-ref-store.c      |  6 +++---
 t/t1400-update-ref.sh          | 13 ++++++++-----
 t/t1405-main-ref-store.sh      |  4 ++--
 t/t1406-submodule-ref-store.sh |  4 ++--
 t/t3202-show-branch.sh         | 15 +++++++++++++++
 7 files changed, 42 insertions(+), 19 deletions(-)


base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1145%2Fhanwen%2Freflog-prelims-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1145/hanwen/reflog-prelims-v3
Pull-Request: https://github.com/git/git/pull/1145

Range-diff vs v2:

 1:  9d8394d8c76 = 1:  6e94a6fbe05 show-branch: show reflog message
 2:  4a86d212589 ! 2:  062481ffece test-ref-store: don't add newline to reflog message
     @@ Metadata
       ## Commit message ##
          test-ref-store: don't add newline to reflog message
      
     -    The files backend produces a newline for messages automatically, so before we
     -    would print blank lines between entries.
     +    By convention, reflog messages always end in '\n', so
     +    before we would print blank lines between entries.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
 3:  0319503045b = 3:  46a8e13a5e6 t1405: check for_each_reflog_ent_reverse() more thoroughly
 4:  62f5cb8a824 ! 4:  40ba92dbf0d test-ref-store: tweaks to for-each-reflog-ent format
     @@ t/t1400-update-ref.sh: $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 11171502
      -	test_when_finished "rm -rf .git/$m .git/logs expect" &&
      -	test_cmp expect .git/logs/$m
      +	test_when_finished "git update-ref -d $m && rm -rf .git/logs actual expect" &&
     -+	test-tool ref-store main for-each-reflog-ent $m > actual &&
     ++	test-tool ref-store main for-each-reflog-ent $m >actual &&
      +	test_cmp actual expect
       '
       
     @@ t/t1400-update-ref.sh: $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 11171503
      -	test_when_finished "rm -f .git/$m .git/logs/$m expect" &&
      -	test_cmp expect .git/logs/$m
      +	test_when_finished "git update-ref -d $m && rm -rf .git/logs actual expect" &&
     -+	test-tool ref-store main for-each-reflog-ent $m > actual &&
     ++	test-tool ref-store main for-each-reflog-ent $m >actual &&
      +	test_cmp actual expect
       '
       
 5:  0288e743eb2 ! 5:  751f713a025 refs/debug: trim trailing LF from reflog message
     @@ refs/debug.c: static int debug_print_reflog_ent(struct object_id *old_oid,
       	int ret;
       	char o[GIT_MAX_HEXSZ + 1] = "null";
       	char n[GIT_MAX_HEXSZ + 1] = "null";
     -+	struct strbuf trimmed = STRBUF_INIT;
     ++	char *msgend = strchrnul(msg, '\n');
       	if (old_oid)
       		oid_to_hex_r(o, old_oid);
       	if (new_oid)
     - 		oid_to_hex_r(n, new_oid);
     +@@ refs/debug.c: static int debug_print_reflog_ent(struct object_id *old_oid,
       
     -+	strbuf_addstr(&trimmed, msg);
       	ret = dbg->fn(old_oid, new_oid, committer, timestamp, tz, msg,
       		      dbg->cb_data);
      -	trace_printf_key(&trace_refs, "reflog_ent %s (ret %d): %s -> %s, %s %ld \"%s\"\n",
      -		dbg->refname, ret, o, n, committer, (long int)timestamp, msg);
     -+	strbuf_trim_trailing_newline(&trimmed);
      +	trace_printf_key(&trace_refs,
     -+			 "reflog_ent %s (ret %d): %s -> %s, %s %ld \"%s\"\n",
     ++			 "reflog_ent %s (ret %d): %s -> %s, %s %ld \"%.*s\"\n",
      +			 dbg->refname, ret, o, n, committer,
     -+			 (long int)timestamp, trimmed.buf);
     -+	strbuf_release(&trimmed);
     ++			 (long int)timestamp, (int)(msgend - msg), msg);
       	return ret;
       }
       

-- 
gitgitgadget
