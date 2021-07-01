Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3698FC11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E8666140C
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbhGAOul (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbhGAOua (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:30 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B8FC061765
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:47:58 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v5so8607380wrt.3
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IdVJWUWBVm2Iwiwmd97pkicNUmd71GC3yTAVdU5z6UM=;
        b=lmZLh49uXuwCwrWK3isnYQxMG9JMltS1Il/GpgHLReRFYbR75dJYv75dY+Xcv2TlFJ
         uJbUfDYPG37K3LdkZuzdE+l6kxlE+VJr8xbcphz5D5rzwkEY9NaWybWzBePJX/8A6zQB
         aPIUbF9ZzixZymLzBhUG3W/JVMCFAairXGr0axd/148ztJZfMJlDCVktrZ+D4QBoM941
         RDqhGD31X2VfOdWhNlnOPCTJRdQ8lrVsHPf/dxaJgtfx/SCYB4uYg/mnriJTxSRTV4SW
         +Hxbth0HoupMUQNGBK3uDLEdP9gAXnUGwvIeqiLQs97PnBrwu7qb/3Yp9TqsRbUr/46z
         gahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IdVJWUWBVm2Iwiwmd97pkicNUmd71GC3yTAVdU5z6UM=;
        b=p/bcJZeu8nLP5nFjlruAJsS/gxeXHtidAz4iE8YYYXDcasJMxUTukxshm+zQSWSYVK
         pRP5WBbPdZbEe2h+GFQwWrWbiotisjBAcKiC7AU+hZovCPPXDsdfLSw7DKwxqls6931P
         feOb2mkd5W0x4tYEwIXQX9P+ux3u/zGGwY6zgsZw6CFKKnJN3uaq//j57FBppLfMwG71
         8wddsVA5PJ6a7nf31Ri5LqEx6ocB1dGiU2Aya4k4R3gsITpeJcJDpbdn/gRGahFuiUGP
         KmGEdEmnWFEBN0kJuBeFzG7VhkRkQgqDA5KQotlF6ORI7xXYmoHyMG2GnQI9auucwyfH
         OP2w==
X-Gm-Message-State: AOAM532JS5SFczfftZM40bFtXJ4Lffig59gM+AI0VHdq0x14YIdPAn8r
        R+4TG+sGKpkhQGO/iFYfsIpxAhV4GXs=
X-Google-Smtp-Source: ABdhPJz07kUGEr/tP5AAjbSCg7vlbLImML1TS9Q0AZrM5RRR4dt7mPNCtpXas8P3mXX/ubiiAKQxWA==
X-Received: by 2002:a5d:59a6:: with SMTP id p6mr11103333wrr.277.1625150877372;
        Thu, 01 Jul 2021 07:47:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10sm201876wmb.40.2021.07.01.07.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:47:57 -0700 (PDT)
Message-Id: <175ae9a757e33fb119b4e01c76f851fa71ff4c9b.1625150864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:30 +0000
Subject: [PATCH v3 20/34] fsmonitor-fs-listen-macos: add macos header files
 for FSEvent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
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
index b91058d1c4f..bec5130d9e1 100644
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

