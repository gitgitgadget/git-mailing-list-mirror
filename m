Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503D9C2BA19
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 08:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C45E21569
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 08:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVsYcI5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgDWIFM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 04:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgDWIFL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 04:05:11 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E234C03C1AB
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 01:05:10 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id r66so4522598oie.5
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 01:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=g559DidDy9HYMiPNBamcG5z0jvKBbOu3/9lZiiFdPDw=;
        b=cVsYcI5L/7mKCsamylqlIPq8fbQghF6DuBk1/QmH1oNJUbwYNPeMJq/aSiPtnY5tO2
         osCmJaLs8odcrb7FOQdp1QEl5D+scb2EHYkvjDX6oeQ3vIWu/+wf7cQkjkV9bd4wF/ER
         7iyOvPrYj1ydHe3DHsxd0FdQZ1W7xs2I9zf8ojU0X4FCeQYxyYzDZhAd2D3qMUHejtp/
         hO773OuLOrS4ddg9ix1bDMFa9JCPj6e581YCQyFbH3xozW5kcfdfd4Rl1O7FYIUfNW3K
         Q/dQPUXGzPqkWNBsGos5L3VM1QM9q0DlCZXNylGd9UAD/qilFvX1JyBfBILCaLnMAUXR
         aWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=g559DidDy9HYMiPNBamcG5z0jvKBbOu3/9lZiiFdPDw=;
        b=tOfrH5BuzrFkvWApquMP3wcvEvMiAplkJDq7X/9iv9d2ow2dKnsr4MJW4sL17VVbex
         s6zgaxZJ7Ij7+Kuf9ANu+kDuMuQn22iKag88oji0zeOnTGhP7ivxWDD8byV6ERtMDKPM
         Ol598SzvIzgLhNg/OK8FNeUngp/cIYHiTf/fKPQruQyTxC3QvXbCx6ElYAL2Uz7/3Lds
         OFVtbyEiSP6f4iU3ZLSzXyR9MOmg+hi4uB8IgJ5IahVBPNi13I/Rd9I7PGdg34CyC+re
         CkHOm1heHsUpfzmv4jswHvRD+S2Syls3oHN/+UJcj5O37h8zgUXV02EBnsWCFUUKyzj/
         cjaQ==
X-Gm-Message-State: AGi0Pua02IkgHFLA8/E9NvZjeVa3EF25Zqrj/tVkNo2HbBn9oCOvlCO0
        z24OQf/D1Nggqnr4XfK5xm1iy47sHE6I0K4kvhMnnkXVoRc=
X-Google-Smtp-Source: APiQypJUpGw3H/Xjz18D4RlEOHXj+a5SiGmnpfkM25jIj/vldNmu8cx3ChiXTDRL0OOJ+Zl8HdfN+F+QmaRUciyI62E=
X-Received: by 2002:aca:38c6:: with SMTP id f189mr1960375oia.145.1587629108426;
 Thu, 23 Apr 2020 01:05:08 -0700 (PDT)
MIME-Version: 1.0
Reply-To: timothee.cour2@gmail.com
From:   Timothee Cour <thelastmammoth@gmail.com>
Date:   Thu, 23 Apr 2020 01:04:42 -0700
Message-ID: <CANri+Ey2o-P+3S9iu1xj5YQooqBxo5Lvom0HdiQDAkSVTRv86A@mail.gmail.com>
Subject: proposal for improving gitignore syntax
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm facing a common problem with gitignore, see
https://stackoverflow.com/questions/61381438/how-to-gitignore-extension-less-files-without-breaking-a-global-gitignore
It doesn't seem to be possible to gitignore extension-less files (eg
posix binaries) without negative side effects, eg:
```
*
!/**/
!*.*
```
It's more complicated than it should and also doesn't work well, as it
will render a global gitignore useless.

This is just one of the problems with gitignore.

Such a common task should have an easy solution, and I'm wondering
whether gitignore can be improved to make this easy/possible.

Here's a concrete proposal. If 1st line contains `#
gitignore-syntax:v2`, it uses a new syntax, otherwise it uses existing
syntax, to ensure backward compatibility.
With the new syntax, strings enclosed inside parenthesis, eg (\w+)
denote regular expressions matching a single path component, with ^$
implied for each path component to match the entire component.

Regular expressions are forbidden to span across path components.
(\w+\.(md|txt))
Examples:
```
# gitignore-syntax:v2
# the line above enables the new syntax for this file

# this gitignores all extension-less files anywhere (:
([^.]+)
# this un-ignores files called README
!README

# this will gitignore for example /abc/foo.md
/*/((foo|bar)\.md)

# this will gitignore directories (bc trailing /) like ab/cd/foo/123/
**/(\w+)/(\d+)/
```

old tools like grep support regex so I'm assuming git could too, but
if for some reason that can't work (why?), some simplified version
could be supported to at least enable common cases without a full
blown regex engine, for example */([^.]+)
