Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02601C48BE8
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 13:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D0F61465
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 13:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhFONbg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 09:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbhFONbP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 09:31:15 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35A1C06124A
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 06:29:09 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id f2so18350730wri.11
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 06:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oePP/ov4SLqwuZlgi7VqblwBKSHM3bfqiwWmNcnSMSo=;
        b=muPLifNMDnVDJ24JhOA+51ss547eu5EimVmwcu8wR5Hn4R0vk6+bVfE8x2faWI8Zk8
         caU422MfmK75O81hIKVEDATVZSchrq+AA5lf/Yy9RYKjKOJL97iRm+aXwZFasjTI7NBW
         cnxRz/iERYYNUoFB8uGv7s+/J+OiRnZ0dEzXhhWtNxOr88DsmSbmREYQm1OfNP/dNfnX
         nP76pZmp2hM3sNN8LZfgUAOvZF5Hlw+NpnwvtloLB5b3PfggK+F90b/VGNNHmDznv2aA
         cyr7TfCtettdHmwLOp3RIO0aSm8I/flGtuZWPnGLEOLM2r1C6bPspnea7gumHYttgUyM
         mduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oePP/ov4SLqwuZlgi7VqblwBKSHM3bfqiwWmNcnSMSo=;
        b=lfBtt2FtHGy656aMBHZw5cRTy7of3HJBC5uUbNNMWukEgazNoBYCpvO1QnXvCtWArh
         rJtjks60lgZ9izMq/jNTOjJhdwUiBh6nF5A2z3ANmjDE0teuXTl3loCVeeASu/x6xNRx
         2e63impqi+9X7WhSuayI7gyCoQB1c9hKrxwOlTqhmu5ZaJxFwHSiP4UhmrFReGztjaIk
         I2XWbR3mFkRvU9Ck9beBwQwPPHNFfVjhq6fpPlGxOjlCQiIokki9PkHCvMCGe3rawsh7
         r15/kU0LLNS3wc7VLmnyRvn14d6/9QciQqTy4QmaY7icWu2zUP6qdnv7XPxKa7MZlv6K
         orRg==
X-Gm-Message-State: AOAM5312u+h097L9cC9zigw8PHIWR+bB1GDLMEwUXmWhBfh7RSbScx5e
        qAcfCX2IUmO/TIPwsr04rsg+XAbxLfY=
X-Google-Smtp-Source: ABdhPJxxn16kr4kf48UKUof7MQTB6ZcQyQOu2v3OQnYvJRb/qVY9AHBFaW/zpHzeu0TgtIktnnfg7w==
X-Received: by 2002:adf:cc8d:: with SMTP id p13mr2838774wrj.239.1623763748533;
        Tue, 15 Jun 2021 06:29:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u12sm19425852wrr.40.2021.06.15.06.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 06:29:07 -0700 (PDT)
Message-Id: <pull.980.v2.git.1623763746.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.git.1623496458.gitgitgadget@gmail.com>
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Jun 2021 13:28:56 +0000
Subject: [PATCH v2 0/9] [GSOC][RFC] cat-file: reuse ref-filter logic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series make cat-file reuse ref-filter logic, which based on
5a5b5f78 ([GSOC] ref-filter: add %(rest) atom)

Change from last version:

 1. Use free_array_item_internal() to solve the memory leak problem.
 2. Change commit message of ([GSOC] ref-filter: teach get_object() return
    useful value).

ZheNing Hu (9):
  [GSOC] ref-filter: add obj-type check in grab contents
  [GSOC] ref-filter: add %(raw) atom
  [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
  [GSOC] ref-filter: add %(rest) atom
  [GSOC] ref-filter: teach get_object() return useful value
  [GSOC] ref-filter: introduce free_array_item_internal() function
  [GSOC] cat-file: reuse ref-filter logic
  [GSOC] cat-file: reuse err buf in batch_objet_write()
  [GSOC] cat-file: re-implement --textconv, --filters options

 Documentation/git-cat-file.txt     |   6 +
 Documentation/git-for-each-ref.txt |   9 +
 builtin/cat-file.c                 | 267 ++++++-----------------
 builtin/tag.c                      |   2 +-
 ref-filter.c                       | 331 ++++++++++++++++++++++-------
 ref-filter.h                       |  14 +-
 t/t1006-cat-file.sh                | 252 ++++++++++++++++++++++
 t/t3203-branch-output.sh           |   4 +
 t/t6300-for-each-ref.sh            | 211 ++++++++++++++++++
 t/t6301-for-each-ref-errors.sh     |   2 +-
 t/t7004-tag.sh                     |   4 +
 t/t7030-verify-tag.sh              |   4 +
 12 files changed, 829 insertions(+), 277 deletions(-)


base-commit: 1197f1a46360d3ae96bd9c15908a3a6f8e562207
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-980%2Fadlternative%2Fcat-file-batch-refactor-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-980/adlternative/cat-file-batch-refactor-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/980

Range-diff vs v1:

  1:  48d256db5c34 =  1:  48d256db5c34 [GSOC] ref-filter: add obj-type check in grab contents
  2:  abee6a03becb =  2:  abee6a03becb [GSOC] ref-filter: add %(raw) atom
  3:  c99d1d070a18 =  3:  c99d1d070a18 [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
  4:  5a5b5f78aeea =  4:  5a5b5f78aeea [GSOC] ref-filter: add %(rest) atom
  5:  c208b8a45d66 !  5:  49063372e003 [GSOC] ref-filter: teach get_object() return useful value
     @@ Commit message
          [GSOC] ref-filter: teach get_object() return useful value
      
          Let `populate_value()`, `get_ref_atom_value()` and
     -    `format_ref_array_item()` get the return value of `get_value()`
     +    `format_ref_array_item()` get the return value of `get_object()`
          correctly. This can help us later let `cat-file --batch` get the
     -    correct error message and return value of `get_value()`.
     +    correct error message and return value of `get_object()`.
      
          Mentored-by: Christian Couder <christian.couder@gmail.com>
          Mentored-by: Hariom Verma <hariom18599@gmail.com>
  -:  ------------ >  6:  d2f2563eb76a [GSOC] ref-filter: introduce free_array_item_internal() function
  6:  44ebf75e2e93 !  7:  765337a46ab0 [GSOC] cat-file: reuse ref-filter logic
     @@ builtin/cat-file.c: static void batch_write(struct batch_options *opt, const voi
      +	if (!ret) {
      +		strbuf_addch(scratch, '\n');
      +		batch_write(opt, scratch->buf, scratch->len);
     -+		strbuf_release(&err);
      +	} else if (ret < 0) {
      +		die("%s\n", err.buf);
     -+		strbuf_release(&err);
      +	} else {
      +		/* when ret > 0 , don't call die and print the err to stdout*/
      +		printf("%s\n", err.buf);
      +		fflush(stdout);
     -+		strbuf_release(&err);
       	}
     ++	free_array_item_internal(&item);
     ++	strbuf_release(&err);
       }
       
     + static void batch_one_object(const char *obj_name,
      @@ builtin/cat-file.c: static void batch_one_object(const char *obj_name,
       		return;
       	}
     @@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt)
       		return 0;
       	}
      @@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt)
     - 
       		batch_one_object(input.buf, &output, opt, &data);
       	}
     --
     + 
      +	strbuf_release(&format);
       	strbuf_release(&input);
       	strbuf_release(&output);
  7:  d31059c391d0 !  8:  058b304686fd [GSOC] cat-file: reuse err buf in batch_objet_write()
     @@ builtin/cat-file.c: static void batch_write(struct batch_options *opt, const voi
       	if (!ret) {
       		strbuf_addch(scratch, '\n');
       		batch_write(opt, scratch->buf, scratch->len);
     --		strbuf_release(&err);
       	} else if (ret < 0) {
      -		die("%s\n", err.buf);
     --		strbuf_release(&err);
      +		die("%s\n", err->buf);
       	} else {
       		/* when ret > 0 , don't call die and print the err to stdout*/
      -		printf("%s\n", err.buf);
      +		printf("%s\n", err->buf);
       		fflush(stdout);
     --		strbuf_release(&err);
       	}
     + 	free_array_item_internal(&item);
     +-	strbuf_release(&err);
       }
       
       static void batch_one_object(const char *obj_name,
     @@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt, const st
      -		batch_one_object(input.buf, &output, opt, &data);
      +		batch_one_object(input.buf, &output, &err, opt, &data);
       	}
     + 
       	strbuf_release(&format);
       	strbuf_release(&input);
       	strbuf_release(&output);
  8:  0004d5b24a0f !  9:  cbf7d51933ea [GSOC] cat-file: re-implement --textconv, --filters options
     @@ ref-filter.h: struct ref_format {
      +	int use_filters;
       	int use_rest;
       	int use_color;
     --
     - 	/* Internal state to ref-filter */
     + 
     +@@ ref-filter.h: struct ref_format {
       	int need_color_reset_at_eol;
       };
       

-- 
gitgitgadget
