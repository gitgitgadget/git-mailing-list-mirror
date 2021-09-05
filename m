Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B15C43217
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 23:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF4A260EBA
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 23:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbhIEXwu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 19:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbhIEXws (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 19:52:48 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE10C061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 16:51:44 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id z9-20020a7bc149000000b002e8861aff59so3742272wmi.0
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 16:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EKbwJxXY1lIIETVYLLHHtfH4gsX5lwzIvam74mdf87s=;
        b=YINCKMq3QoOiyWSKWzswSprau4lDDgH6CvYZiKNLne3kfws92iChPqOesee7/JzEC0
         DK66x1A4q7tfHLhNFWXZji8phOREqSRg9ISyxs98GaooOBcPtK1jmMYwohudn63VEMJw
         xNdJHWoW2sesKTN8w2dpOk7l1U41of7PCZScWqldJbZhk5Oq2yW25/jWw+lfAMGGSFXU
         R1gHkbMCed+EAzIArZL/eUm+Yj4PkKjG/yUSUSyXSwR61e0BQVQkwtHZwerfe0egXIkV
         mYkX/exASMphcghZLXJhrUvCk7oDyyosySZ+zSnSZoT+YRb+pKgPSvFJ3kQpW/daWaC9
         L75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EKbwJxXY1lIIETVYLLHHtfH4gsX5lwzIvam74mdf87s=;
        b=rX7jXT0EwR0FeTCSl6zsoJ3Hiie4kIWwQRyaLE6VXErfM7cartDwmM932V2MwEe75G
         BmdQmIqFIt4rsziNIpIGnHgdzmqQdxnolTm+M1w6DCFr/bJP1/ZYlrwhhYGLL9t/2KRu
         1ZAIlH5fxEthlCKeNjTk4OtwGnSV8YHtmt6ExXHoRi+aBa7pHBOU7MCGZz1QX1q4ijBT
         jmyEW8NIbLogpuvkiSMRu9qZw74uEk9GrzvCOdQncTR3guyszcLY1RbbW47Fvx7nJ+8Y
         08vKdBF3Z1oBUGd8zf/a2elHN+we3pMWBsnARG+sO1Q5SJZQMbRRhpJH6+K1MvKMclSF
         aJ2g==
X-Gm-Message-State: AOAM531nmvOQrpuWzooy5xcMz35Ho5EV0S1WpTLXEgEjvvInHbQcohpe
        xc0BENZJqmkE9axAUNPJYDovtXSk2HQ=
X-Google-Smtp-Source: ABdhPJw0uWF18Dz2IlSuaN7Ylyt4rfdOXskLG1AbhdSkkmG6eWIuc9bBhyQeyEL9IjYGiW6aAPQOoA==
X-Received: by 2002:a1c:1d84:: with SMTP id d126mr8540229wmd.160.1630885903221;
        Sun, 05 Sep 2021 16:51:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l124sm5705264wml.8.2021.09.05.16.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 16:51:42 -0700 (PDT)
Message-Id: <22475475cae2d32dfa664709f283e4c6e8f60e83.1630885899.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1031.git.1630885899.gitgitgadget@gmail.com>
References: <pull.1031.git.1630885899.gitgitgadget@gmail.com>
From:   "Andrew Olsen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 05 Sep 2021 23:51:39 +0000
Subject: [PATCH 4/4] Documentation for list-object-filter extensions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrew Olsen <andrew232@gmail.com>,
        Andrew Olsen <andrew.olsen@koordinates.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrew Olsen <andrew.olsen@koordinates.com>

Explains how to develop a custom extension for list-objects-filter
behavior, and how to compile it into a custom build of Git using the
FILTER_EXTENSIONS Makefile argument.

Signed-off-by: Andrew Olsen <andrew.olsen@koordinates.com>
---
 Documentation/config/uploadpack.txt  |   7 +-
 Documentation/rev-list-options.txt   |   4 +
 contrib/filter-extensions/README.txt | 153 +++++++++++++++++++++++++++
 3 files changed, 161 insertions(+), 3 deletions(-)
 create mode 100644 contrib/filter-extensions/README.txt

diff --git a/Documentation/config/uploadpack.txt b/Documentation/config/uploadpack.txt
index 32fad5bbe81..b2ef2421a6d 100644
--- a/Documentation/config/uploadpack.txt
+++ b/Documentation/config/uploadpack.txt
@@ -66,9 +66,10 @@ uploadpackfilter.allow::
 uploadpackfilter.<filter>.allow::
 	Explicitly allow or ban the object filter corresponding to
 	`<filter>`, where `<filter>` may be one of: `blob:none`,
-	`blob:limit`, `object:type`, `tree`, `sparse:oid`, or `combine`.
-	If using combined filters, both `combine` and all of the nested
-	filter kinds must be allowed. Defaults to `uploadpackfilter.allow`.
+	`blob:limit`, `tree`, `sparse:oid`, `combine`, or a named filter extension
+	`extension:<name>`. If using combined filters, both `combine` and all of
+	the nested filter kinds must be allowed. Defaults to
+	`uploadpackfilter.allow`.
 
 uploadpackfilter.tree.maxDepth::
 	Only allow `--filter=tree:<n>` when `<n>` is no more than the value of
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index b7bd27e1713..d7a317f0aa1 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -914,6 +914,10 @@ Note that the form '--filter=sparse:path=<path>' that wants to read
 from an arbitrary path on the filesystem has been dropped for security
 reasons.
 +
+The form '--filter=extension:<name>[=<arg>]' uses a compile-time extension
+to implement a named filter. Filter extensions may take an argument string
+which is passed via `<arg>`.
++
 Multiple '--filter=' flags can be specified to combine filters. Only
 objects which are accepted by every filter are included.
 +
diff --git a/contrib/filter-extensions/README.txt b/contrib/filter-extensions/README.txt
new file mode 100644
index 00000000000..3d5921cda9b
--- /dev/null
+++ b/contrib/filter-extensions/README.txt
@@ -0,0 +1,153 @@
+= List-Objects-Filter Extensions API
+:pp: {plus}{plus}
+
+This API can be used to develop filter extensions used for custom filtering
+behaviour with `git-upload-pack` and `git-rev-list`. The API is defined in
+link:../../list-objects-filter-extensions.h[list-objects-filter-extensions.h]
+and defines three functions to implement a filter operation.
+
+NOTE: Each filter implementing this API must compiled into Git as a
+static library. There is some plumbing in the Makefile to help with this
+via `FILTER_EXTENSIONS`.
+
+== Overview
+
+. You write a filter and compile it into your custom build of git.
+. A filter request is received that specifically names the filter extension
+that you have written, ie: `--filter=extension:<name>[=<arg>]`
+. The `init_fn` function of your filter is called.
+. The `filter_object_fn` function of your filter is called for each object
+at least once.
+. The `free_fn` function of your filter is called.
+
+== Examples
+
+*link:./rand/[`rand`]* is a filter that matches all trees and a random
+percentage of blobs, where the percentage is parsed from the filter arg. It
+imports and uses the `oid_to_hex()` and `trace_key_printf()` functions from the
+Git API.
+
+Build via:
+
+[,console]
+----
+$ make FILTER_EXTENSIONS=contrib/filter-extensions/rand/rand.a
+    ...
+    SUBDIR contrib/filter-extensions/rand
+    ...
+----
+
+We can run against git's own repo:
+
+[,console]
+----
+$ ./git rev-list refs/heads/master --objects --max-count 1 --filter=extension:rand=3 --filter-print-omitted | grep -c '^~'
+filter-rand: matching 3%
+filter-rand: done: count=4068 (blob=3866 tree=202) matched=117 elapsed=0.005017s rate=810843.1/s average=1.2us
+3749  # number of omitted blobs = 3866 - 117
+----
+
+== Development
+
+See the examples for a basic implementation. The comments in
+link:../../list-objects-filter.h[`list-objects-filter.h`] and the built-in
+filter implementations in
+link:../../list-objects-filter.c[`list-objects-filter.c`] are important to
+understand how filters are implemented - `filter_blobs_limit()` provides a
+simple example, and `filter_sparse()` is more complex.
+
+The API differences between the built-in filters and the filter extensions:
+
+. Filter extensions don't handle ``omitset``s directly, instead setting `omit`.
+. Filter extensions receive a void pointer they can use for context.
+
+== Building
+
+There is some plumbing in the Git Makefile to help with this via
+`FILTER_EXTENSIONS`, setting it to space-separated paths of the filter extension
+static libraries indicates that these filters should be compiled into git.
+For example:
+
+[,console]
+----
+make FILTER_EXTENSIONS=contrib/filter-extensions/rand/rand.a
+----
+
+Filter extensions don't need to be within the Git source tree. A filter
+extension static library should either exist at the given path - ie, `rand.a`
+should exist - or there should be a Makefile in that directory which will create
+it when `make rand.a` is run. (Such a Makefile should also have a `clean` target
+which deletes all object files and brings the directory back to its initial
+state).
+
+The static library should define a struct of type `filter_extension` called
+`filter_extension_NAME` where `NAME` is the name of your extension (ie `rand`
+for `rand.a`). See
+link:../../list-objects-filter-extensions.h[list-objects-filter-extensions.h]
+
+This definition should follow the following pattern:
+
+[,C]
+----
+#include "list-objects-filter-extensions.h"
+
+/* Definitions of rand_init, rand_filter_object, rand_free ... */
+
+const struct filter_extension filter_extension_rand = {
+    "rand",
+    &rand_init,
+    &rand_filter_object,
+    &rand_free,
+};
+----
+
+(The names of your `init_fn`, `filter_object_fn` and `free_fn` are not
+important, but the string literal should again be the the name of your extension
+- `"rand"` for the filter extension in `rand.a`.)
+
+You may use library functions from Git if you include the relevant Git headers,
+since the filter extensions and Git itself will be linked together into a single
+binary.
+
+You may depend on other libraries if you indicate that they are to be linked
+into the Git binary using `LDFLAGS`. See the C{pp} example below.
+
+== Developing in C{pp} (and other languages)
+
+You can develop filter extensions with C{pp}, but many Git header files are not
+compatible with modern C{pp}, so you won't be able to directly use Git library
+functions. However, you can use them if you create wrapper functions in C that
+delegates to the Git library functions you need, but which are also C{pp}
+compatible. See link:./rand_cpp/[`rand_cpp`] for a simple example. A similar
+solution would be to implement the extension itself in C, and have the
+extension do any operations that require Git library functions, but have it
+delegate to a C wrapper API that you add to a C{pp} library that already
+contains the domain-specific operations that you need. In either case, remember
+to wrap any functions that must be C-compatible with `extern C` when declaring
+or defining them from within C{pp}.
+
+To build the C{pp} example:
+
+[,console]
+----
+make FILTER_EXTENSIONS=contrib/filter-extensions/rand_cpp/rand_cpp.a \
+     LDFLAGS=-lstdc++
+----
+
+For other languages you'll either need to port definitions of some internal Git
+structs (at a minimum, `object`, `object_id`, `repository`, and `hash_algo`) -
+or again, you could write the extension in C but have it delegate to a domain
+specific library in the language of your choice that has a C-compatible API.
+Extra libraries can be required using `LDFLAGS`.
+
+== Linking more than one filter extension
+
+To link in more than one extension, set `FILTER_EXTENSIONS` to the
+space-separated paths of all the extensions you want linked. For example, to
+link in both example filters at once:
+
+[,console]
+----
+make FILTER_EXTENSIONS="contrib/filter-extensions/rand/rand.a contrib/filter-extensions/rand_cpp/rand_cpp.a" \
+     LDFLAGS=-lstdc++
+----
-- 
gitgitgadget
