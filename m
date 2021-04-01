Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7191EC43611
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1192B613B5
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbhDARnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbhDARkT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 13:40:19 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E674C02D544
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 08:41:18 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so1136055wmj.1
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 08:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=edBI/UfAdUANph40tPYHwXApM7BGoIz/01tZ6bP76xw=;
        b=DhIhqghFlINC+pvk7RCv09N6IYN/hdZNh2FSs5VmvuwHxSb/1SMJ1bw96J5W3GGEOC
         UMPyCw4vycKrXVLSgJ4J/HhGmaMegoZb6eQnZIlUBs2ZMZdCIEB8DiiBUu79I0/5CzhH
         8vyL71ZMy8ctHNmLTCKQx7jwDWsgab7FpkAMyBYImj331gceB7Vjd1NgjBICFnJfOiyg
         T7OuZIlYfiODgYjqNx7Ry/3hbLGcQBL0m3mSCTTUZ4j699j+zNOV6BqMRgBbJ4YvGrvA
         1EoaKnPIW8SROe+DKS1fd5fWCgbK/lFB9HIQjtMAo3W8HXh1XVJaUSr7lhz9CipQMcxV
         a8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=edBI/UfAdUANph40tPYHwXApM7BGoIz/01tZ6bP76xw=;
        b=ofgt4HsC9Y5R5xk1r3PRdMqUN/qP1xIxgR3BrRZJrWVD+XsJUkXoUqPJaQZl3TXU/L
         9CtzacL5X9cFVEx4sbnYFJF6PJIkb4b65YiV+IzHbwcuRJj3KhlItglRXL1lD4QJ7/oR
         SlP1HSMBzowH/QMWlhevo/i0lmiZKCd3Sl+MChyvUkz26Y1rRsyALiHkehOjWeUdyc/k
         PjA0rPDZOAiEzBc5+MUy70MnboLNRbtnbPppsHXdKQMvPgu+r9eAeVh9639R0Ue42w4m
         DBLcSN7DDD+Yloh/1+skqbv9PebEvxKweyrRzG1LzA70E1+fRi3NzpJzB0zc+69sK93H
         Jfug==
X-Gm-Message-State: AOAM5339gmt543B90O3q/q4xp0adCnpEkTv6pt7XybjUMI5/5mI97d20
        LwL99+f0eEYMAeULHPSzOh0tZrehl1s=
X-Google-Smtp-Source: ABdhPJyaewqJJospHN4hgv187lTdMBHa9KbqBVbIldPPomDmWXrJ9RjkYPQ7P5dq+ShkbfdtKw6svg==
X-Received: by 2002:a7b:cb05:: with SMTP id u5mr8737568wmj.21.1617291676795;
        Thu, 01 Apr 2021 08:41:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e17sm12423221wra.65.2021.04.01.08.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:41:16 -0700 (PDT)
Message-Id: <67fa7c7b8ac79b05d0773dc0affbe39b77aa4893.1617291666.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.1617291666.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 15:40:56 +0000
Subject: [PATCH 14/23] fsmonitor-fs-listen-macos: add macos header files for
 FSEvent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Include MacOS system declarations to allow us to use FSEvent and
CoreFoundation APIs.  We need GCC and clang versions because of
compiler and header file conflicts.

While it is quite possible to #include Apple's CoreServices.h when
compiling C source code with clang, trying to build it with GCC
currently fails with this error:

In file included
   from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/Library/Frameworks/Security.framework/Headers/AuthSession.h:32,
   from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/Library/Frameworks/Security.framework/Headers/Security.h:42,
   from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/Library/Frameworks/CoreServices.framework/Frameworks/OSServices.framework/Headers/CSIdentity.h:43,
   from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/Library/Frameworks/CoreServices.framework/Frameworks/OSServices.framework/Headers/OSServices.h:29,
   from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Headers/IconsCore.h:23,
   from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Headers/LaunchServices.h:23,
   from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/Library/Frameworks/CoreServices.framework/Headers/CoreServices.h:45,
     /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/Library/Frameworks/Security.framework/Headers/Authorization.h:193:7: error: variably modified 'bytes' at file scope
       193 | char bytes[kAuthorizationExternalFormLength];
           |      ^~~~~

The underlying reason is that GCC (rightfully) objects that an `enum`
value such as `kAuthorizationExternalFormLength` is not a constant
(because it is not, the preprocessor has no knowledge of it, only the
actual C compiler does) and can therefore not be used to define the size
of a C array.

This is a known problem and tracked in GCC's bug tracker:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=93082

In the meantime, let's not block things and go the slightly ugly route
of declaring/defining the FSEvents constants, data structures and
functions that we need, so that we can avoid above-mentioned issue.

Let's do this _only_ for GCC, though, so that the CI/PR builds (which
build both with clang and with GCC) can guarantee that we _are_ using
the correct data types.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsmonitor-fs-listen-macos.c | 96 ++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/compat/fsmonitor/fsmonitor-fs-listen-macos.c b/compat/fsmonitor/fsmonitor-fs-listen-macos.c
index b91058d1c4f8..bec5130d9e1d 100644
--- a/compat/fsmonitor/fsmonitor-fs-listen-macos.c
+++ b/compat/fsmonitor/fsmonitor-fs-listen-macos.c
@@ -1,3 +1,99 @@
+#if defined(__GNUC__)
+/*
+ * It is possible to #include CoreFoundation/CoreFoundation.h when compiling
+ * with clang, but not with GCC as of time of writing.
+ *
+ * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=93082 for details.
+ */
+typedef unsigned int FSEventStreamCreateFlags;
+#define kFSEventStreamEventFlagNone               0x00000000
+#define kFSEventStreamEventFlagMustScanSubDirs    0x00000001
+#define kFSEventStreamEventFlagUserDropped        0x00000002
+#define kFSEventStreamEventFlagKernelDropped      0x00000004
+#define kFSEventStreamEventFlagEventIdsWrapped    0x00000008
+#define kFSEventStreamEventFlagHistoryDone        0x00000010
+#define kFSEventStreamEventFlagRootChanged        0x00000020
+#define kFSEventStreamEventFlagMount              0x00000040
+#define kFSEventStreamEventFlagUnmount            0x00000080
+#define kFSEventStreamEventFlagItemCreated        0x00000100
+#define kFSEventStreamEventFlagItemRemoved        0x00000200
+#define kFSEventStreamEventFlagItemInodeMetaMod   0x00000400
+#define kFSEventStreamEventFlagItemRenamed        0x00000800
+#define kFSEventStreamEventFlagItemModified       0x00001000
+#define kFSEventStreamEventFlagItemFinderInfoMod  0x00002000
+#define kFSEventStreamEventFlagItemChangeOwner    0x00004000
+#define kFSEventStreamEventFlagItemXattrMod       0x00008000
+#define kFSEventStreamEventFlagItemIsFile         0x00010000
+#define kFSEventStreamEventFlagItemIsDir          0x00020000
+#define kFSEventStreamEventFlagItemIsSymlink      0x00040000
+#define kFSEventStreamEventFlagOwnEvent           0x00080000
+#define kFSEventStreamEventFlagItemIsHardlink     0x00100000
+#define kFSEventStreamEventFlagItemIsLastHardlink 0x00200000
+#define kFSEventStreamEventFlagItemCloned         0x00400000
+
+typedef struct __FSEventStream *FSEventStreamRef;
+typedef const FSEventStreamRef ConstFSEventStreamRef;
+
+typedef unsigned int CFStringEncoding;
+#define kCFStringEncodingUTF8 0x08000100
+
+typedef const struct __CFString *CFStringRef;
+typedef const struct __CFArray *CFArrayRef;
+typedef const struct __CFRunLoop *CFRunLoopRef;
+
+struct FSEventStreamContext {
+    long long version;
+    void *cb_data, *retain, *release, *copy_description;
+};
+
+typedef struct FSEventStreamContext FSEventStreamContext;
+typedef unsigned int FSEventStreamEventFlags;
+#define kFSEventStreamCreateFlagNoDefer 0x02
+#define kFSEventStreamCreateFlagWatchRoot 0x04
+#define kFSEventStreamCreateFlagFileEvents 0x10
+
+typedef unsigned long long FSEventStreamEventId;
+#define kFSEventStreamEventIdSinceNow 0xFFFFFFFFFFFFFFFFULL
+
+typedef void (*FSEventStreamCallback)(ConstFSEventStreamRef streamRef,
+				      void *context,
+				      __SIZE_TYPE__ num_of_events,
+				      void *event_paths,
+				      const FSEventStreamEventFlags event_flags[],
+				      const FSEventStreamEventId event_ids[]);
+typedef double CFTimeInterval;
+FSEventStreamRef FSEventStreamCreate(void *allocator,
+				     FSEventStreamCallback callback,
+				     FSEventStreamContext *context,
+				     CFArrayRef paths_to_watch,
+				     FSEventStreamEventId since_when,
+				     CFTimeInterval latency,
+				     FSEventStreamCreateFlags flags);
+CFStringRef CFStringCreateWithCString(void *allocator, const char *string,
+				      CFStringEncoding encoding);
+CFArrayRef CFArrayCreate(void *allocator, const void **items, long long count,
+			 void *callbacks);
+void CFRunLoopRun(void);
+void CFRunLoopStop(CFRunLoopRef run_loop);
+CFRunLoopRef CFRunLoopGetCurrent(void);
+extern CFStringRef kCFRunLoopDefaultMode;
+void FSEventStreamScheduleWithRunLoop(FSEventStreamRef stream,
+				      CFRunLoopRef run_loop,
+				      CFStringRef run_loop_mode);
+unsigned char FSEventStreamStart(FSEventStreamRef stream);
+void FSEventStreamStop(FSEventStreamRef stream);
+void FSEventStreamInvalidate(FSEventStreamRef stream);
+void FSEventStreamRelease(FSEventStreamRef stream);
+#else
+/*
+ * Let Apple's headers declare `isalnum()` first, before
+ * Git's headers override it via a constant
+ */
+#include <string.h>
+#include <CoreFoundation/CoreFoundation.h>
+#include <CoreServices/CoreServices.h>
+#endif
+
 #include "cache.h"
 #include "fsmonitor.h"
 #include "fsmonitor-fs-listen.h"
-- 
gitgitgadget

