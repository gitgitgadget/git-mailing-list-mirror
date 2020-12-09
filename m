Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDCDC4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 00:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EC02224B0
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 00:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732013AbgLIA1H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 19:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730991AbgLIA1C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 19:27:02 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6B8C0613CF
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 16:26:22 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id i6so591308otr.2
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 16:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S4sico8mQnuC7Md9k0O6Sgny/hJXtpWpE4Xl4DbxpJU=;
        b=ToxsxyxRSysqeX7PBB5GmtY/9hbD7tdqupjzkAdyllZTmx9VQfrVG3MvbRHTy55Ee0
         fF9m63TgDcZ4ljSAJXKg2V10TFqbvi7IJHKNN17ssQ85BREPzj3hGTISNNENws0+YZ9B
         i1fMKoWdEQefFIVsNGa807IojAzty4van0G9OCnT8Ry/4JCuj1bAJP3wJft2OQzrG5xF
         JFNNhpZe9/si+00YlsViyCp/kz/mTRq/VhhUkSgcHq7CPBui5mpeWn4Mpni1cazJtUII
         7usiUPUw4Xb8xHsuGpRfXBqI+bhb7vbdyTsPnDF1UMwGPNj5wlvCfdlFk9BNVl5XI5Df
         Rc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S4sico8mQnuC7Md9k0O6Sgny/hJXtpWpE4Xl4DbxpJU=;
        b=CDzTXmv33BcwESbB+8HQs2gWYvY2XzQ6pi+IDuNSEAxFLvB9rTjIN136nX5eVum0FA
         cM9sm/6wOpTnx9EBtA6xsDzQNYgi5BpaPB0XNvFqcPG8LO4Y0ubE4qiFuQy9CJ9MPTmQ
         QaZjGjRnpyF1I0MMYqbw0GlPvyu2Aj3Ydml5RJz6tZAks2nlAfkxt4ONHZsSxQCzsUjA
         c18pM9VYX+wrFvOm3yGwVBj5TMlxW4zsiL3XrTFYzubOHzRcr98W1nvp+5MBoJMEQbYg
         yYXke8wW6J8v2ykJ6CvhezpsyAuN37ir8GDMT/anbyNlnmIx7AbzZzGTZ0GAWUmxcJp6
         GSIg==
X-Gm-Message-State: AOAM530TShzQkOfcAwWhhwfkpTlJdfnZ1cuBkHWR/wI2t1vZzr29dJZK
        H1NKugFHibjtO4d65DYh4bFNG9jruqF4Yk0j
X-Google-Smtp-Source: ABdhPJzS9jJIID5CSSg5Uq7Q3FR0dLBW8e5M+EgxNyVy6vcJe/SI1EXOlvG/pu7obE0rJWRu3cZd5w==
X-Received: by 2002:a9d:2ab:: with SMTP id 40mr606240otl.280.1607473581230;
        Tue, 08 Dec 2020 16:26:21 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id l1sm137833ooi.48.2020.12.08.16.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 16:26:20 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] Add project-wide .vimrc configuration
Date:   Tue,  8 Dec 2020 18:26:19 -0600
Message-Id: <20201209002619.25468-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's not efficient that everyone must set specific configurations in all
their ~/.vimrc files; we can have a project-wide .vimrc that everyone
can use.

By default it's ignored, you need the following in your ~/.vimrc

  set exrc
  set secure

Then the project-wide configuration is loaded, which sets the correct
filetype for the documentation and tests, and also the default
indentation of c, sh, and asciidoc files.

If you have the shareness syntax file it will be used for the tests, but
if not the sh syntax will still be used.

These default configurations can be overriden in the typical way (by
adding the corresponding file in ~/.vim/after/ftplugin).

We could add the vim modelines at the bottom of every file, like other
projects do, but this seems more sensible.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 .vimrc | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 .vimrc

diff --git a/.vimrc b/.vimrc
new file mode 100644
index 0000000000..d250ab26e0
--- /dev/null
+++ b/.vimrc
@@ -0,0 +1,9 @@
+augroup git
+  au!
+  au BufRead,BufNewFile */t/*.sh set ft=sharness.sh
+  au BufRead,BufNewFile */Documentation/*.txt set ft=asciidoc
+
+  au FileType c setl noet ts=8 sw=0 cino=(s,:0,l1,t0
+  au FileType sh setl noet ts=8 sw=0
+  au FileType asciidoc setl noet ts=8 sw=0 autoindent
+augroup END
-- 
2.29.2

