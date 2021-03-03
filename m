Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25BCC433DB
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E31A64ED0
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448810AbhCCGgE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 01:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238091AbhCCCFj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Mar 2021 21:05:39 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5467AC061793
        for <git@vger.kernel.org>; Tue,  2 Mar 2021 18:04:15 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id f124so4364752qkj.5
        for <git@vger.kernel.org>; Tue, 02 Mar 2021 18:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ritter.vg; s=vg;
        h=mime-version:from:date:message-id:subject:to;
        bh=aEDkBsuDHlprB8l/LSrHdI5fEkCNiXASJwVqE2C+KPE=;
        b=lEyulrO3wbjzcU9L3SVv9QcCzOlYdRj/Z29sfKi7ctH1Tndvu8P832hdN3a/Gp8NuI
         LZQLgqbbnSI9HqVBkiQ5BFyQUT1WXBfbhJViEgLVZI4eOIpou1bpe626U7hQMbH3J9Jd
         wz5HGvCJFeUvTILVTMKJDlqQFQVxNWdmXuScg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=aEDkBsuDHlprB8l/LSrHdI5fEkCNiXASJwVqE2C+KPE=;
        b=F78pKwzgv7L6cN+YwLJ/dPLfznen6NfQGyBAnzxvmWslJEYPjwrF5Nj6YBKZIpst/Z
         /pjjJljl7j1a2cbyBbFw3XYOJEuKKtQSA5vG3cM+5u/r8L9QY1wnCs0W9LCSfsz59lKT
         p8q7oy3l5I+bc2TkR0XbqNKNZ6WMQaaCWRWLY4S+2wuavHQaIb3ZQRoA5gpwTyfG+Lwo
         G0I0o+m8Z9iiJksXH33yQTHekTQytHBZtQTR0lwkGowKhAh7ubq8bPeCr0pJYqSa02+G
         iAxg3PtPhU/nVF/04l+yVGbRCchbH7U1tm9bZydiv0ofONwNbgoWNJASI1VFMk9NKTl1
         X3gw==
X-Gm-Message-State: AOAM533VHlQK5BcbkZblfs2NFScGFZ+Hl95RpRP3boA1KJo8yAcWknHK
        9v8ySjGTU/EIKG+v/LrPdWE0vYruvB0k4JdWN6ddvu2X1frJAGOH
X-Google-Smtp-Source: ABdhPJwsy5UEWr7EXlU/3nUb9ZzcKNWXQG8hDvwFVF8zGeyY8ieCboQJb4aiVMH8qtFt2r2llGXoOxNyBhLW33wZAUI=
X-Received: by 2002:a05:620a:4549:: with SMTP id u9mr22024670qkp.113.1614737054183;
 Tue, 02 Mar 2021 18:04:14 -0800 (PST)
MIME-Version: 1.0
From:   Tom Ritter <tom@ritter.vg>
Date:   Wed, 3 Mar 2021 02:03:59 +0000
Message-ID: <CA+cU71=FfReSG411Feo=vmkw4MdK4KDgokP1jH6uwOkC_0AbYA@mail.gmail.com>
Subject: Can I convince the diff algorithm to behave better?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(For a specific, nuanced, and personal definition of better...)

I have a frequent behavior that arises when I am copy/pasting chunks
of code, typically in tests.  Here is an example:

My Original code:

def function():
   line 1
   line 2
   line 3
   line 4
   line 5
   line 6

--------------------------------
I add, after it:

def function2():
   line 1
   line 2
   line 3
   line 4
   line 5
   line 6

--------------------------------
My diff is:

+   line 3
+   line 4
+   line 5
+   line 6
+
+def function2():
+   line 1
+   line 2

--------------------------------
I'd like my diff to be

+
+def function2():
+   line 1
+   line 2
+   line 3
+   line 4
+   line 5
+   line 6


Obviously there's nothing incorrect about the former diff, I just wish
it was the latter rather than the former.

I know that git includes four diff algorithms; in my testing patience
or histogram exacerbated the problem; and none of them improved upon
it.  If anyone has suggestions I'd be curious to know if there's
anything that could be done...

Thanks,
-tom
