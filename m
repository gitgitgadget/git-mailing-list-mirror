Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C123C433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 17:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbiBRRND (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 12:13:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238185AbiBRRNB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 12:13:01 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3641547545
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 09:12:45 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id j9-20020a05600c190900b0037bff8a24ebso9050785wmq.4
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 09:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V0rgFhFumRJ8xLgY7FBzMqanBoGWuWtgz33otHKqQ+8=;
        b=BpS4iRv/WO/AabaZNjyZpl7G7GbfJZyxDnn3MrcNBYp60eG0bYh5hBdNp4gf0C68lE
         g3t96Y3RBhzWcH2OODjX8fdMigdVNnP+TZeOtR8Fn5hC9u7xHx1FwihwX+RVwTt0rUJh
         gYCjl2bKrYs6jI5Gi+76ACj3WS6Z2Auh2cHJ4GSR3n7xEU1p5n6hzJ1jE3aJ1WWSyCAT
         1jhK//r/1DaJOHvLYOkdGzpYIC0C2WL71aGPAXkZW/J7qANTEj6qlFhL808dDGhs9ma0
         iEHm7bAK0VFt4Q4URncYRcn0RGR+Zgw9R7F5Q/tg6wa456SSJFea5ba4I+YQ0EN+vyQQ
         TbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V0rgFhFumRJ8xLgY7FBzMqanBoGWuWtgz33otHKqQ+8=;
        b=WnNmhhPolOEYwA8ZDY+BbjQEyTRVbV4KUe15AJWZOqoc9YtHJwdezljEoGkCJ8fYOb
         UVOjGxKbnALk9x+KoATcEV/DpjWndkqg5BWUZjUSu9aknoGA368eh7keOqddMd9sQsa2
         4/N/6npYqVH24RJ38fnFLPtFSf2c3Cn8QVw62IJvAo0pWPLB2MZ3P66Omf76PtDxdHcD
         dQ3HxYCkQEtas6bW9lWCHf6A0aVaKlQeVRgeL4ULFLK/MRgZGSpX0P7G+QoOWVqMLR4D
         N6Vqb5UH/NvxPyO/wDb/BSyWhu5qkbrJyBUVYX0eKTl0DFeFE807DMPYx9IA8wReA/2k
         WooQ==
X-Gm-Message-State: AOAM530DfC4xo5q/Na1XTw3bBADI3xDpbl03VTl1821pCxD3tI6G0uys
        SkF7Yab7+hbNZjJAvcBEEFYh4zkDHDFie4x0
X-Google-Smtp-Source: ABdhPJxu2F/f+gnMI27wblONadiaBZ7EOPkLJfdcXmFEkpwXtNu8eeBNi0678Zd3eApC/EMbuvbzAQ==
X-Received: by 2002:a05:600c:2158:b0:37b:f39b:d4bf with SMTP id v24-20020a05600c215800b0037bf39bd4bfmr8158711wml.129.1645204363751;
        Fri, 18 Feb 2022 09:12:43 -0800 (PST)
Received: from localhost.localdomain (176.248.7.93.rev.sfr.net. [93.7.248.176])
        by smtp.gmail.com with ESMTPSA id h6sm14332wmq.8.2022.02.18.09.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 09:12:43 -0800 (PST)
From:   COGONI Guillaume <cogoni.guillaume@gmail.com>
To:     avarab@gmail.com
Cc:     cogoni.guillaume@gmail.com, git.jonathan.bressat@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, guillaume.cogoni@gmail.com,
        matthieu.moy@univ-lyon1.fr
Subject: [PATCH v2 1/2] t/t3903-stash.sh: replace test [-d|-f] with test_path_is_*
Date:   Fri, 18 Feb 2022 18:12:23 +0100
Message-Id: <20220218171224.262698-2-cogoni.guillaume@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218171224.262698-1-cogoni.guillaume@gmail.com>
References: <220215.86a6erwzee.gmgdl@evledraar.gmail.com>
 <20220218171224.262698-1-cogoni.guillaume@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use test_path_is_* to replace test [-d|-f] because that give more
explicit debugging information. And it doesn't change the semantics.

Signed-off-by: COGONI Guillaume <cogoni.guillaume@gmail.com>
Co-authored-by: BRESSAT Jonathan <git.jonathan.bressat@gmail.com>
---
 t/t3903-stash.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index b149e2af44..11a0856873 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -487,7 +487,7 @@ test_expect_failure 'stash directory to file' '
 	rm -fr dir &&
 	echo bar >dir &&
 	git stash save "directory to file" &&
-	test -d dir &&
+	test_path_is_dir dir &&
 	test foo = "$(cat dir/file)" &&
 	test_must_fail git stash apply &&
 	test bar = "$(cat dir)" &&
@@ -500,10 +500,10 @@ test_expect_failure 'stash file to directory' '
 	mkdir file &&
 	echo foo >file/file &&
 	git stash save "file to directory" &&
-	test -f file &&
+	test_path_is_file file &&
 	test bar = "$(cat file)" &&
 	git stash apply &&
-	test -f file/file &&
+	test_path_is_file file/file &&
 	test foo = "$(cat file/file)"
 '
 
-- 
2.25.1

