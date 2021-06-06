Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB79AC4743D
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 18:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E395613EF
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 18:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhFFSuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 14:50:25 -0400
Received: from mail-oo1-f43.google.com ([209.85.161.43]:42501 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhFFSuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jun 2021 14:50:25 -0400
Received: by mail-oo1-f43.google.com with SMTP id y18-20020a4ae7120000b02902496b7708cfso1059884oou.9
        for <git@vger.kernel.org>; Sun, 06 Jun 2021 11:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/eOQe2TIljC7Ib6cSz/4+mVQl7A2KTZknYWI0FuCoTc=;
        b=YXB+E5dbJSEk/+eZenCh45fa1+3+C9cG9is4yCiNgU9jmIrpz+JAUV72mtjhslUHTt
         TTS4maYOzCSZJ8vAADmVCJpHWXoSX0epHDjUSbuVS1DbN6v6m2kKn9+jhhMSmMUGeTVx
         P5fXySBDGZLNuC+ZKXSS5hG0M/HnQ+P/DakkZqtaIItcjnnULsU1YLlpTUel8/eK9AyC
         O1OqS9zJs3WPFX8RsyD0KJ329WxJISSxEBc4Pj5xSS1Z/6IDdWbeVf0c1zsY3gUYylNZ
         0cTQuqfVYXpDiK2hjkilguJ+KjG4q5EI/b835gY2xmCt+PLbR+vGS0PQNQU6iiucv7GH
         uCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/eOQe2TIljC7Ib6cSz/4+mVQl7A2KTZknYWI0FuCoTc=;
        b=EPZeHfAp8NboeieR5qcjcv25tzujajwZyvueCQ77V/kTESrRVKIFHyXEHmB1/FdxEh
         vXNZx7C+J1ieh6Dlr8zyyuStID+qvS1ls7tQreTceskgZdd0iCiu2vSaaZ5ue3ySrMhH
         /Z6kFciYFLx8P3U2gf7TCEj1jf/Q6pYKUC91XhArPS1EKjGM59f3ks0awEfsPfUqntRk
         /POqec0r6pHxFn/JvgvJFGoLptSY6tbc7CXBhRbz9VWYi9+2HLLwJrBK6a2UoIvfx9Kp
         HPhAIA+FasRwGGnzduJ7JkcytBqye0B1DucUb2Qo9JRRzJjG9K8xtoC0AVA/7wCq5jAE
         affg==
X-Gm-Message-State: AOAM530iQq91P0GrofdkqpNVf4y8mvowXspIYV/w2Ihn8KGgyyPVhrMO
        aP7Vh3tKQXBf2kgo0lSYM4eRFEgDynbN0w==
X-Google-Smtp-Source: ABdhPJykF7WH/no6D8s8+lNYSqiwdUjFtzQV32ekGFWyXA1cKV1AB0RYhTwRfAYuXddE/k/oiUYmgg==
X-Received: by 2002:a4a:b202:: with SMTP id d2mr10929435ooo.13.1623005254753;
        Sun, 06 Jun 2021 11:47:34 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 7sm54959oor.30.2021.06.06.11.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 11:47:34 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 try2 0/4] completion: bash: a bunch of fixes
Date:   Sun,  6 Jun 2021 13:47:22 -0500
Message-Id: <20210606184726.1018460-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1.2.g0532ba4bf6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These should be pretty obvious and straightforward.

This is the second time I'm sending this exact series, and the seventh time in almost
exactly the same form.

The previous version was still applying without conflicts to master, and so does this one.

 * https://lore.kernel.org/git/xmqqv9cavcc5.fsf@gitster.c.googlers.com/
 * https://lore.kernel.org/git/6094a335c22dc_8ee520860@natae.notmuch/

Felipe Contreras (4):
  completion: bash: fix prefix detection in branch.*
  completion: bash: fix for suboptions with value
  completion: bash: fix for multiple dash commands
  completion: bash: add correct suffix in variables

 contrib/completion/git-completion.bash | 14 +++++++-------
 t/t9902-completion.sh                  | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 7 deletions(-)

Range-diff:
1:  dd49b0e680 ! 1:  52de92cb06 completion: bash: fix prefix detection in branch.*
    @@ Commit message
     
           git clone --config=branch.<tab>
     
    +    Reviewed-by: SZEDER Gábor <szeder.dev@gmail.com>
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## contrib/completion/git-completion.bash ##
2:  6ac184b9a4 = 2:  af2f17364d completion: bash: fix for suboptions with value
3:  960a692fda = 3:  a3bcb70594 completion: bash: fix for multiple dash commands
4:  a95c3edaf9 = 4:  6b3ef41c92 completion: bash: add correct suffix in variables
-- 
2.31.1.2.g0532ba4bf6

