Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE8FC04A94
	for <git@archiver.kernel.org>; Tue, 15 Aug 2023 22:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238679AbjHOWQj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 18:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239399AbjHOWQc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 18:16:32 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6D5198C
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 15:16:31 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-583b3aa4f41so61621577b3.2
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 15:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692137791; x=1692742591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6rSbVOk19lfgiiy3NU4dIrbLQkMABJ+4ZMgNa0A1z1A=;
        b=eDC+qTmdaEfZ94MKncFLSro4sTyREDI2sx88WM3RHOHt9/g3uvPThSAb8VsF8DvkFi
         t/3smhagCg86hPBy22iG1bpydg/xhSpb5nRqBvWmoDSPz7O47d0GpCwsbFtsBLA1Mfju
         FlJJf0/Z72yTUqkLzUQtphyV8NoNa/QxP5WA81dtNI2FPuObvykFFi6ibX0vur0ACAkw
         CZxHZYTCwVEBTqY9sBsdSsqeKLVqJgV+YDo1Quo379eflQQqspgCd2Un7g2BjAqFCAqL
         RZ6WLjivgsk7ekETVmOmFmwx52AharwIW6pJxz6Jss8s5A3a5QSUhOgMZ9yDGKHrvOJD
         PdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692137791; x=1692742591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rSbVOk19lfgiiy3NU4dIrbLQkMABJ+4ZMgNa0A1z1A=;
        b=Mn3yyplfJwVs4NZMvnIVdCBG8YefiF04K73bNqIC+4UL4zvfeKIt9xSkmOKlAilfzf
         YvamiBEGsmgT2o0Ur0aL4N1dzvTOf8Psr7PRrf0+TuON3O7eg29ag9q6K7jkw8KipIwZ
         tKEPNqOLGQbPMbGXp3PcZ8/CWBA9zlZO3qtP/zQnlpfb3lLXNoKD6Fis9mJdjIIu4vkb
         pvIMcLhhnZ/P+QFJ8SJlE2+eC3+uVpsPhNMvjLWFSnjEfi2WDFANFfw1qJRhGNY+8TLF
         5TYaeYp46Dkc1P2jlU+IUWJ69Oa9MiayI8XEcpIRrXmUuYZkw2edRu462lvCBcPsXyk/
         4JBw==
X-Gm-Message-State: AOJu0YzPKRXXsl3S8Xm0jy/ZU6aMCpibT4bJdDpl/ezqmQCDefc5OzXy
        F17Q/KayDFYeh79zxVJ9M/dwOw==
X-Google-Smtp-Source: AGHT+IGA5fOD6pEvf44l77ZEee4un3YAnBaUxfus+wkiXbzMLy+HVFuakI5doFm6Dk+gcHFCZocv5g==
X-Received: by 2002:a81:4755:0:b0:571:11ea:b2dd with SMTP id u82-20020a814755000000b0057111eab2ddmr13963901ywa.32.1692137790786;
        Tue, 15 Aug 2023 15:16:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s4-20020a0dd004000000b005794a9576f0sm3648906ywd.9.2023.08.15.15.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 15:16:30 -0700 (PDT)
Date:   Tue, 15 Aug 2023 18:16:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Andy Koppe <andy.koppe@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: main != master at github.com/git/git
Message-ID: <ZNv5PQlkn6tbUcH7@nand.local>
References: <20230715103758.3862-1-andy.koppe@gmail.com>
 <20230715160730.4046-1-andy.koppe@gmail.com>
 <kl6l351j22dr.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CAHWeT-ZA8f-TGRwDHixAvi5kddVBbuK8LpVGJ9cjYZMsMk5ODw@mail.gmail.com>
 <xmqq7cpwjhr1.fsf@gitster.g>
 <006574bd-4d53-495e-8cfe-677ede521908@gmail.com>
 <xmqq350kjfk8.fsf@gitster.g>
 <ce5d20db-2220-45dd-8c39-2a52e0f9f816@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ce5d20db-2220-45dd-8c39-2a52e0f9f816@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2023 at 08:29:43PM +0100, Andy Koppe wrote:
> On 15/08/2023 20:01, Junio C Hamano wrote:
> > > See [1], where main currently is at v2.41.0.
> > >
> > > [1] https://github.com/git/git/tree/main
> >
> > Ah, that one.  The CI job is unfortunately attached to that tree and
> > updating 'master' and 'main' with the same commit at the same time
> > wastes CI cycles, so I had to tentatively stop updating it.
> >
> > It used to be that 'main' was set to lag behind 'master' by 24 hours
> > or so to prevent the problem---CI notices that the commit updated
> > 'main' has been already dealt with 24 hours ago at 'master' and
> > refrains from wasting time on it.  But resurrecting it would still
> > make folks confused about how 'main' is different from 'master'.
> > Perhaps it is a good time to remove stale 'main' and keep only
> > 'master' there?
>
> An alternative might be to exclude one of the branches in the workflow file,
> as per [1].

I think that this should be relatively straightforward to do, and would
be preferable to dropping 'main'.

Here's an (untested) patch that should do the trick:

--- >8 ---
diff --git a/.github/workflows/check-whitespace.yml b/.github/workflows/check-whitespace.yml
index a58e2dc8ad..764f46b21f 100644
--- a/.github/workflows/check-whitespace.yml
+++ b/.github/workflows/check-whitespace.yml
@@ -8,6 +8,8 @@ name: check-whitespace
 on:
   pull_request:
     types: [opened, synchronize]
+    branches_ignore:
+      - main

 # Avoid unnecessary builds. Unlike the main CI jobs, these are not
 # ci-configurable (but could be).
diff --git a/.github/workflows/l10n.yml b/.github/workflows/l10n.yml
index 6c3849658a..f6767a73d2 100644
--- a/.github/workflows/l10n.yml
+++ b/.github/workflows/l10n.yml
@@ -1,6 +1,12 @@
 name: git-l10n

-on: [push, pull_request_target]
+on:
+  push:
+    branches_ignore:
+      - main
+  pull_request_target:
+    branches_ignore:
+      - main

 # Avoid unnecessary builds. Unlike the main CI jobs, these are not
 # ci-configurable (but could be).
diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 079645b776..eaaf6a9151 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -1,6 +1,12 @@
 name: CI

-on: [push, pull_request]
+on:
+  push:
+    branches-ignore:
+      - main
+  pull_request:
+    branches-ignore:
+      - main

 env:
   DEVELOPER: 1
--- 8< ---

> [1] https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#example-excluding-branches

Thanks,
Taylor
