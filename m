Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6575AC04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4354F613F4
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhEUWqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhEUWqU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:46:20 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC56C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:44:55 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id v13-20020a4ac00d0000b029020b43b918eeso4922249oop.9
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W/5eNlwJ7YkcBCY2tUxqxjGSOOlL0FwIIvCmNF/BCSU=;
        b=DEXa1hMDbFAd3v+ageEPzpfQYWFvTZYXsdNDodOkjC/tx8ThUsI+LeOX6khk4gaTcn
         9wY7qDA05QcvbtOf2uHHjUM3NBfoh9IHK8Bur/M6yVEIhawNEkENBa2ik7yO6jc8iw6r
         Ydw5oens2oJ/Jj2vd+SoUdQ4KM7UfKL23ovSp5QFMl5o+Fwc2rmAS/V+jcMLvxq+R8qE
         cQ6LcgbigpG8tutnKgwDa5SPhIEsnutFgjLKvDjq85D+/re8MY5egcydMx4h/FL2hMwo
         Mw+TlZUNjC8rySuLOkiZGjVYvZfQlaxnCFIJ6q2uY+rc45Gw/C2a5Cj9yO5UGIypYJUe
         NjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W/5eNlwJ7YkcBCY2tUxqxjGSOOlL0FwIIvCmNF/BCSU=;
        b=E3TIc8ZvJtEW+AQx6FdMJMYTPXMqAP3JzcBApQ9B4vXglqblCgUp9wdcpOeGYvqxdV
         NaSBoTbDKFFG94FFaDv1ipSENRQI/N92hF252ZWQ3vp081BUvpuF29LGavka6mIswWss
         wxnVLPnjjqG9fGA4D9D2/yA52ClhuS2au+gZ4FnzhMdgD08L7Aot4Si2QZ4SQqMw4Y6S
         OGJqtO4+QwYM1IdqzcO4X1wVPWZyYv6k3XofZyx0WoOQJrhbMhlhjH2RYOuSQ5uTpC/J
         TRE+2y9ZKEv3rJds84OVfcNFisZ74wf6vJhkIssUFKm6h7pp7LpM/pXOdVGbmSyzYKDc
         WEKg==
X-Gm-Message-State: AOAM531wfvHtbcAFCPlrEecqN9nmWxOUIpsY8It4iShekGjrlZKmhW7U
        Ddh6Jf3A/3rpk5y/ulCphhsnpiHoKZAWUg==
X-Google-Smtp-Source: ABdhPJyHGHPTOcVOkzy81EcQxJW5HhYkr+1NPjUsgHbtKMIrIdHL9Ru1peCfLiPyFUdE6aCfh7f8LQ==
X-Received: by 2002:a4a:3e0c:: with SMTP id t12mr9975135oot.24.1621637094434;
        Fri, 21 May 2021 15:44:54 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id y13sm1441052oon.32.2021.05.21.15.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:44:53 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 00/11] doc: asciidoctor: direct man page creation and fixes
Date:   Fri, 21 May 2021 17:44:41 -0500
Message-Id: <20210521224452.530852-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series enables direct man page creation with asciidoctor, but in addition tries to
minimize the difference with asciidoc+docbook.

I fixed as many issues as I could, and now the doc-diff looks very sensible. I could not find any
major issues, however, some minor ones still remain.

On the other hand the asciidoc method has issues as well, so it's not clear which method is superior
at this point; both have advantages and disadvantages.

At the very least the man pages with pure asciidoctor should be quite usable now.

This series builds on top of my previous cleanups [1].

[1] https://lore.kernel.org/git/20210521223701.526547-1-felipe.contreras@gmail.com/

Felipe Contreras (9):
  doc: doc-diff: set docdate manually
  doc: use asciidoctor to build man pages directly
  doc: asciidoctor: add linkgit macros in man pages
  doc: add man pages workaround for asciidoctor
  doc: asciidoctor: add hack for xrefs
  doc: asciidoctor: add hack to improve links
  doc: asciidoctor: add support for baseurl
  doc: asciidoctor: cleanup man page hack
  doc: asciidoctor: add hack for old versions

Jeff King (1):
  doc-diff: support asciidoctor man pages

Martin Ågren (1):
  doc-diff: drop --cut-footer switch

 Documentation/Makefile                  | 15 ++++++--
 Documentation/asciidoctor-extensions.rb | 51 +++++++++++++++++++++++++
 Documentation/doc-diff                  | 35 +++++++++--------
 3 files changed, 82 insertions(+), 19 deletions(-)

Range-diff against v1:
 1:  de0ecf9c0e <  -:  ---------- doc: allow the user to provide ASCIIDOC_EXTRA
 2:  22a35efa3f <  -:  ---------- doc: doc-diff: allow more than one flag
 3:  a8ad5c703a <  -:  ---------- doc: doc-diff: set docdate manually
 4:  4d0266a3a1 <  -:  ---------- doc: use asciidoctor to build man pages directly
 5:  5efb19348b <  -:  ---------- doc: asciidoctor: add linkgit macros in man pages
 6:  d5d006298e <  -:  ---------- doc: join mansource and manversion
 7:  7c8b502df9 <  -:  ---------- doc: add man pages workaround for asciidoctor
 -:  ---------- >  1:  a2f85f4b05 doc: doc-diff: set docdate manually
 -:  ---------- >  2:  13085a13b6 doc-diff: drop --cut-footer switch
 -:  ---------- >  3:  f0b3576d77 doc: use asciidoctor to build man pages directly
 -:  ---------- >  4:  8b3bb9e9f4 doc-diff: support asciidoctor man pages
 -:  ---------- >  5:  3f9859b223 doc: asciidoctor: add linkgit macros in man pages
 -:  ---------- >  6:  df27fcb9a2 doc: add man pages workaround for asciidoctor
 8:  5d5e9d99ac !  7:  5f0ae41e3e doc: asciidoctor: add hack for xrefs
    @@ Commit message
     
      ## Documentation/asciidoctor-extensions.rb ##
     @@
    - require 'asciidoctor'
      require 'asciidoctor/extensions'
     +require 'asciidoctor/converter/manpage'
     +
    @@ Documentation/asciidoctor-extensions.rb
     +        orig_convert_inline_anchor(node)
     +      end
     +    end
    ++    alias inline_anchor convert_inline_anchor # For old versions of asciidoctor
     +  end
     +end
      
    - module Git
    -   module Documentation
    + Asciidoctor::Extensions.register :git do
    + 
 9:  f4a4f1394e =  8:  a8fb29d893 doc: asciidoctor: add hack to improve links
10:  894802bfbb !  9:  272e6e8551 doc: asciidoctor: add support for baseurl
    @@ Commit message
     
      ## Documentation/Makefile ##
     @@ Documentation/Makefile: ASCIIDOC_DOCBOOK = docbook5
    - override ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
    - override ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
    - override ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
    -+override ASCIIDOC_EXTRA += -abaseurl='$(MAN_BASE_URL)'
    + ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
    + ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
    + ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
    ++ASCIIDOC_EXTRA += -abaseurl='$(MAN_BASE_URL)'
      ASCIIDOC_DEPS = asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
      DBLATEX_COMMON =
      XMLTO_EXTRA += --skip-validation
11:  d3b6899ed8 ! 10:  928a632038 doc: asciidoctor: cleanup man page hack
    @@ Documentation/asciidoctor-extensions.rb: module Asciidoctor
     +        nil
            end
          end
    -   end
    +     alias inline_anchor convert_inline_anchor # For old versions of asciidoctor
 -:  ---------- > 11:  758e5be3b7 doc: asciidoctor: add hack for old versions
-- 
2.32.0.rc0

