Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B30C35247
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 20:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6C220658
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 20:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2203bNN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgBCUhL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 15:37:11 -0500
Received: from mail-lj1-f169.google.com ([209.85.208.169]:42115 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgBCUhL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 15:37:11 -0500
Received: by mail-lj1-f169.google.com with SMTP id d10so16081336ljl.9
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 12:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mf2a/zE7SODG1sNblkcaSdUcyBAxuDNVQAGgekIpokM=;
        b=X2203bNNglOY+0zuLshrOKYwON8UrOytzczUbDxEir1YywejHDIx9UjeVvc1/rBs23
         UEdBBk0znRniOCZ8vvWwvsf7vmwds1dmsp3+Nb7jjPG5Y1mlGiMA9OVLcxG+RIqMbKb+
         ZDgIG2i/NjLcblH2y0vcYEe7vsrpUdx2SiNPprVJ0De2a3TKhTaz0pGjiLlUsOd+rOIz
         sutKAK1YccuA+q+gyoV71vYP402RHNR3X52YI10HKS7gE5UDBVCff6FKOwAnu1kRy9aH
         EANb40CNRG4RKg4sn+HnBlAzDJjzvIeH/QMgBKrjI8gBnxyx+HvuFkc7Wsch9Cj5rcn8
         ZDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mf2a/zE7SODG1sNblkcaSdUcyBAxuDNVQAGgekIpokM=;
        b=nKJcSAaxB2O4XmbUijTREij5ga6eYHEWE/l7CMZDLLsxFB2pTpPMFnPXug/w8Wqruf
         k9+DRrOmHozAFkTBJOmLHa42diCjFOkc8WwruAUnAaWjPaNRULNlCI50bIK6DNfYQ2le
         JNLuKh7ycT3wClTvHdnaSqn7brs21oygeSt1q6vCNOiZAHuzN767R0sWTHvQ/YTYOLz+
         IhNfitMN1tvEf5GQ+4ZVRkiUBKc4cTHwSjstMYt5MM5j0+qX07bZZrtlAg2SbYm8a3tb
         z9yDwSFop4ZgNqycYn9RGxlL1Oc9NXAdYe8sqyK1L0S3pPqQmuR1Awq+Fv8G6cj8qmFb
         fI8g==
X-Gm-Message-State: APjAAAUpiAe2j3P5+H5HEdVi/Q5FEXZlMIhBowxyN4mrPKhJ580EO7d8
        BVvr6q+HKVp/OSKsnBsr55o=
X-Google-Smtp-Source: APXvYqxM8PEJV+Bxeb/Ouxnance6Nhu7u9D3CMDcY9PfHTItZmvIEwRkycxK/qaLJKc5axUkZL/w0A==
X-Received: by 2002:a2e:9a04:: with SMTP id o4mr15226933lji.214.1580762229309;
        Mon, 03 Feb 2020 12:37:09 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id 3sm5158244lja.65.2020.02.03.12.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:37:08 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: git-filter-branch.txt: wrap "maths" notation in backticks
Date:   Mon,  3 Feb 2020 21:36:50 +0100
Message-Id: <20200203203650.31914-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203114549.GA4157558@coredump.intra.peff.net>
References: <20200203114549.GA4157558@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 3 Feb 2020 at 12:45, Jeff King <peff@peff.net> wrote:
>
> On Sun, Feb 02, 2020 at 08:33:19PM +0100, Martin Ågren wrote:
>
> > In this paragraph, we have a few instances of the '^' character, which
> > we give as "\^". This renders well with AsciiDoc ("^"), but Asciidoctor
> > renders it literally as "\^". Dropping the backslashes renders fine
> > with Asciidoctor, but not AsciiDoc... Let's use "{caret}" instead, to
> > avoid these escaping problems.
>
> Makes sense.
>
> The source is pretty ugly to read both before and after, though. I

Yeah, I was happy to have improved the situation a bit, but didn't quite
feel that it looked great..

> wonder if using a literal like `5*10^5` would be even nicer. That makes
> the source pretty readable, and the output would put it in <tt> or
> similar. Which maybe is a little funny, but kind of makes sense to me
> typographically as a kind of "this is math" style.

Hmm, that somehow makes sense. How about the below? Outside of RelNotes/
and technical/, I only saw one spot where we could do something similar
("O(n^2)" in diff-options.txt; it has an accompanying loose "n"). I had
actually expected more. Most hits for "{caret}" are in revisions.txt
(duh) and the one hit for "\^" that remains after this patch is a shell
snippet.

Going for "1e5" and so on would be one way, I guess, but suffers from
the same problem that it somehow looks like a random pile of characters
in the middle of a sentence (unless it's typeset in, e.g., monospace).

One could of course move in a different direction entirely and talk
about "a thousand", "a million" and so on...

--->8---
Subject: [PATCH v2] git-filter-branch.txt: wrap "maths" notation in backticks

In this paragraph, we have a few instances of the '^' character, which
we give as "\^". This renders well with AsciiDoc ("^"), but Asciidoctor
renders it literally as "\^". Dropping the backslashes renders fine
with Asciidoctor, but not AsciiDoc...

An earlier version of this patch used "{caret}" instead of "^", which
avoided these escaping problems. The rendering was still so-so, though
-- these expressions end up set as normal text, similarly to when one
provides, e.g., computer code in the middle of running text, without
properly marking it with `backticks` to be monospaced.

As noted by Jeff King, this suggests actually wrapping these
expressions in backticks, setting them in monospace.

The lone "5" could be left as is or wrapped as `5`. Spell it out as
"five" instead -- this generally looks better anyway for small numbers
in the middle of text like this.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-filter-branch.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index a530fef7e5..40ba4aa3e6 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -467,9 +467,9 @@ impossible for a backward-compatible implementation to ever be fast:
 
 * In editing files, git-filter-branch by design checks out each and
   every commit as it existed in the original repo.  If your repo has
-  10\^5 files and 10\^5 commits, but each commit only modifies 5
-  files, then git-filter-branch will make you do 10\^10 modifications,
-  despite only having (at most) 5*10^5 unique blobs.
+  `10^5` files and `10^5` commits, but each commit only modifies five
+  files, then git-filter-branch will make you do `10^10` modifications,
+  despite only having (at most) `5*10^5` unique blobs.
 
 * If you try and cheat and try to make git-filter-branch only work on
   files modified in a commit, then two things happen
-- 
2.25.0

