Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0690207EB
	for <e@80x24.org>; Wed, 26 Apr 2017 19:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966073AbdDZTPz (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 15:15:55 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34133 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966061AbdDZTPu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 15:15:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id z129so3786868wmb.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 12:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7JB9uAkwIZdKOOg1kUwsHEZMOuQCZSJmHVGmmB83bRc=;
        b=Mh4LeyGlPTlob3Vw9360Xu6KYbyVK9jVbuQR6uTKxqbZhHEwuPQjyI3Abzcddz4uLT
         jVZ64aQyOxxglqfwPtJnLj8OJFZgLsyhcijmGdhYkFRPmLYaGHiNoaElb4TVZlz5R98Y
         ld2keYlVPB0iRhS4G1k2MOFSQSpggJZJ797lifAdK/B+EPpsWthcy9sEjUCbRPewk4U8
         Z+B/vRBgmyioyYFOhyq1uvtBRurTnoqtfsLq7u0rl7mGfJ3ASTUted4UCn9ygtXkmGI8
         75U3aQGq2lgqJ5uyLeiMEtgSgcNcJJP+G9lZnzzkLfA+YswpCX+G9iSn/FHrAnQBdPox
         4OTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7JB9uAkwIZdKOOg1kUwsHEZMOuQCZSJmHVGmmB83bRc=;
        b=HOOphqnLatyoDfc29yuAw925FtOPGKJVrXJaEApe+TqRLzmC1d6opjiQDrl8ZbeVZh
         x7ukS3qZyJXI39qmqjRW2a6WHOFzZ5h5x2YPxgj0XwV+n84VrZP0GhXFUaC/ppSay4Te
         94+5kdCGAs8PhaprnNhBqkrPD63h2ioBBS0fs/uporqE9zv2TFhMnmA+vGNcbtRZ04kJ
         DPHcDZqhvOr3RhOv5Rz7ZWyv7vW3FtB7mgFeCrhqJxqt9CbG5N0gbjoioQmHFafh0y8w
         5jMyi91vf+7llOnwHn79tKxFMRCrumh7jju5HwAWXhd0JUvzhwdopnhHnNQyDMiVXrT/
         GQ0g==
X-Gm-Message-State: AN3rC/407of14Xj4sDzsYXMJ772rUFshDT+7aijskGxIIn53TtSHzROx
        dJRcjJxD7hKFVtXH
X-Received: by 10.80.171.230 with SMTP id u93mr2077743edc.130.1493234149276;
        Wed, 26 Apr 2017 12:15:49 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id n40sm275426edd.12.2017.04.26.12.15.48
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 12:15:48 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, gitster@pobox.com
Subject: [PATCH v2 2/4] travis-ci: parallelize documentation build
Date:   Wed, 26 Apr 2017 21:15:43 +0200
Message-Id: <20170426191545.27552-3-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170426191545.27552-1-larsxschneider@gmail.com>
References: <20170426191545.27552-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation job without parallelization takes ~10min on TravisCI.
With parallelization ("--jobs=2") it takes ~6min.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 ci/test-documentation.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index bf23b2caea..58962d668a 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -9,7 +9,7 @@ make check-builtins
 make check-docs
 
 # Build docs with AsciiDoc
-make doc
+make --jobs=2 doc
 test -s Documentation/git.html
 test -s Documentation/git.xml
 test -s Documentation/git.1
@@ -17,6 +17,6 @@ grep '<meta name="generator" content="AsciiDoc ' Documentation/git.html
 
 # Build docs with AsciiDoctor
 make clean
-make USE_ASCIIDOCTOR=1 doc
+make --jobs=2 USE_ASCIIDOCTOR=1 doc
 test -s Documentation/git.html
 grep '<meta name="generator" content="Asciidoctor ' Documentation/git.html
-- 
2.12.2

