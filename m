Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE27FC4167B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 06:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFCAB23B87
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 06:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgLIG4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 01:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbgLIG4V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 01:56:21 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9009C0613D6
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 22:55:41 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id x13so379880oto.8
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 22:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GfYHWyRvIh2oUB6/eVHCclMi+/CNBRGdLL5osas3gIE=;
        b=txt9jzbBXJmdBwor26fPXbRDUUGosQHbPF7ebDTZ3Y6jsEbKn4+WgCyoYyx5UFAi7H
         WAsok5TJC+T+Zl9tcJ7PCY8wYZ8jbJKeztanbw6t5+3Rp8yJd1VnpW5Izl4sJ1LIsi1b
         I1RIFfGaz3bjFRwXzZtIQeLI7c+q5JuUTM0rLlqWl+BXKR4AR20HFprN+H5062FSC+Fb
         DABHq7Vwzz95zhV9MoTN4YrpjW7FQzU0FFoq6KOQdnBF5czFwi1grK3ONsag9PbQRdIV
         hIlX4TlzXAKnPU8wXSWw0PPp/yy9pGPF76T3GX+qH4W70DRa4wn/ZsVTXoliNiNiUZz9
         +Gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GfYHWyRvIh2oUB6/eVHCclMi+/CNBRGdLL5osas3gIE=;
        b=rUMDz46f2Pe/iJZQRcVBOTPCW8QagOdVWBWVl2w/CR/jjcP2RzdYwcPg8mOfJC+GWx
         sKTnvazyGzCs4xI7RJPjE8Xa8u+49Gt7n8vLPiq22lDUX+kNL/QLfwttS7SeH3TYSvpg
         qa5GCAMJNELrzDjh3wgk4MJoZdBnTP6fdhUvI5qe4Job6XymX7l3tDNzwVWNPv6sqfNT
         qm9DQzlwunF+rz/U7PMMOw8/AucJ43U3QefG0M7RTLhSnMXkkaLMx3OtdsIryGtyXH5l
         IN8BgcmoLTz51f8c3f+AceM+7+vUf8PzZ44R94U36OP7U/ydCPuXi9AwngNiDnMKw2iz
         L+AQ==
X-Gm-Message-State: AOAM53241weDg1s6fjL/wX6N+ZY1MU/x4nadO3LwY5NweawVvCvEWUkY
        f3OtEMJj4c8ns7b8yPyzu/JUiGOGIvlVrw==
X-Google-Smtp-Source: ABdhPJwzYyHjj427ulR8eGMTX78gQ1xltTj25fjzh2Ugu0iyzmCIzqgBJnHnFuCw8GS9JCpjaWjj2w==
X-Received: by 2002:a9d:802:: with SMTP id 2mr636279oty.62.1607496940973;
        Tue, 08 Dec 2020 22:55:40 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id f10sm215959oti.11.2020.12.08.22.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 22:55:40 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Aaron Schrab <aaron@schrab.com>,
        Denton Liu <liu.denton@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/2] Add project-wide .vimrc configuration
Date:   Wed,  9 Dec 2020 00:55:36 -0600
Message-Id: <20201209065537.48802-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209065537.48802-1-felipe.contreras@gmail.com>
References: <20201209065537.48802-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's not efficient that everyone must set specific configurations in all
their ~/.vimrc files; we can have a project-wide .vimrc that everyone
can use.

There's different ways to load this configuration, for example with
vim-addon-local-vimrc [1], but we don't need much of the complexity of
these solutions.

Instead I created a simple loader that is in the contrib area, which can
be installed with:

  cp -aT contrib/vim ~/.vim/pack/plugins/start/git

Then, add the location of the Git repository to your ~/.vimrc:

  let g:gitvimrc_whitelist = [ expand('$HOME') . '/dev/git' ]

Then the project-wide configuration will be loaded, which sets the
correct filetype for the documentation, and also the default indentation
of c, sh, perl, and asciidoc files.

These default configurations can be overridden in the typical way (by
adding the corresponding file in ~/.vim/after/ftplugin).

We could add the vim modelines at the bottom of every file, like other
projects do, but this seems more sensible.

[1] https://github.com/MarcWeber/vim-addon-local-vimrc

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 .vimrc                          | 22 ++++++++++++++++++++++
 contrib/vim/plugin/gitvimrc.vim | 21 +++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 .vimrc
 create mode 100644 contrib/vim/plugin/gitvimrc.vim

diff --git a/.vimrc b/.vimrc
new file mode 100644
index 0000000000..602c746477
--- /dev/null
+++ b/.vimrc
@@ -0,0 +1,22 @@
+" To make use of these configurations install the git plugin provided in
+" the contrib section:
+"
+"   cp -aT contrib/vim ~/.vim/pack/plugins/start/git
+"
+" Then whitelist the location of this directory to your ~/.vimrc:
+"
+"   let g:gitvimrc_whitelist = [ expand('$HOME') . '/dev/git' ]
+"
+" You can add multiple locations, or specify a regexp pattern.
+"
+
+augroup git
+	au BufRead,BufNewFile */Documentation/*.txt set filetype=asciidoc
+
+	au FileType c setl noexpandtab tabstop=8 shiftwidth=0 cino=(s,:0,l1,t0
+	au FileType sh setl noexpandtab tabstop=8 shiftwidth=0
+	au FileType perl setl noexpandtab tabstop=8 shiftwidth=0
+	au FileType asciidoc setl noexpandtab tabstop=8 shiftwidth=0 autoindent
+augroup END
+
+" vim: noexpandtab tabstop=8 shiftwidth=0
diff --git a/contrib/vim/plugin/gitvimrc.vim b/contrib/vim/plugin/gitvimrc.vim
new file mode 100644
index 0000000000..c3946e5410
--- /dev/null
+++ b/contrib/vim/plugin/gitvimrc.vim
@@ -0,0 +1,21 @@
+let s:gitvimrc_whitelist = get(g:, 'gitvimrc_whitelist', [])
+
+function LoadGitVimrc()
+  let l:top = trim(system('git rev-parse --show-toplevel'))
+  if l:top == '' | return | endif
+  let l:file = l:top . '/.vimrc'
+  if !filereadable(l:file) | return | endif
+
+  let l:found = 0
+  for l:pattern in s:gitvimrc_whitelist
+    if (match(l:top, l:pattern) != -1)
+      let l:found = 1
+      break
+    endif
+  endfor
+  if !l:found | return | endif
+
+  exec 'source ' . fnameescape(l:file)
+endf
+
+call LoadGitVimrc()
-- 
2.29.2

