Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845B8C433DB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52ADD65296
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbhCHSoA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 13:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhCHSnv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 13:43:51 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03420C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 10:43:51 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id p10so9767330ils.9
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 10:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wrIHsl50SuzzplipbU7ydZHXd0y9cMwEiw4cP5ZNplQ=;
        b=saFPFpMzjVhTSt2+ky6EUbN3WjH+37MQBDMZ0Cy4VUGZIkE6w+8q6hxKmnyt2R1ln+
         ym4AIf0QIMUXOjtJGsBr0/nKPDhExXHJNGbs5ItW1qN6114mzxbdXyJvvqz25Hza1ZY/
         EhWSN9u1yWIUH8nZs7HuK62fC3KvLvanQgQtJUThQqgfxnAthenEmHZ2XHihMuO/XGOX
         W8Mc1ZTqwDgOK9pSswpIsoOlh/D4aurgV+ScMp4vuRrdz6hHPOULCkFibWLqMN5u1Q11
         MHa9KLwgYYF9uFQbRLz5zDgKi5XDTzrq1pLB4onBH45qcwFEtta1c+rGsWAwBNHBzW4p
         HXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wrIHsl50SuzzplipbU7ydZHXd0y9cMwEiw4cP5ZNplQ=;
        b=R5tIupCPlKE1qFT2Kcneyz3FKc+xFWvMyX9sgybR5M7uDsTjUTaMGlFpVFhBVCrRkY
         XJUiMPVEUP9jPyAOv4rXZlCFHd7aUBseUJN35YIP1jHuYiUrFKs4c7s4K/zxGBwktNcW
         MG0FHBaHGzszoqcp+sePanML7yk/JmOxDfVOLo2oTRPA1mftVLrwRhavvgJKAb6JrKU/
         9c9nd3u3lyn0JqQ2ZcQ027UJmZB86PYPHES8RCcbNSk3RHSc5JB17uSvaP9GD4YdHaYl
         Sa153s94PCW8x8B1ej8GQcie/pxIjsTEhcnMheZXyVUmiFizmQzzRjLcQyiewKujbzfw
         yf2g==
X-Gm-Message-State: AOAM5333DUZE423/QKGTJDxDFCLAvb8fuxQFVEes+SuQ77OPlDDKQ6l+
        81k5H7V+cWbziKwGjf4UAiTg/avtcC57gHUV
X-Google-Smtp-Source: ABdhPJxJcbGtqcD7EV3xF/nI2y2nVaaxFmmCWiruByQKMmgIWBP15ooPENCo+eCD/MknYN/9fZFhOw==
X-Received: by 2002:a92:cda1:: with SMTP id g1mr21120332ild.267.1615229030377;
        Mon, 08 Mar 2021 10:43:50 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:d16b:b0bc:c9fc:2720])
        by smtp.gmail.com with ESMTPSA id w9sm6635655ioj.0.2021.03.08.10.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 10:43:49 -0800 (PST)
Date:   Mon, 8 Mar 2021 13:43:47 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Fabien Terrani <terranifabien@gmail.com>, git@vger.kernel.org
Subject: Re: remote.<name>.merge missing from the git-config man page?
Message-ID: <YEZwY0721KvQNkK+@nand.local>
References: <CAOuwed4HJLTgk48Fre5vGYjYanqD6hu8yZM73CpcAmF1ajiTnA@mail.gmail.com>
 <xmqqlfax7dya.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlfax7dya.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 08, 2021 at 09:27:57AM -0800, Junio C Hamano wrote:
> >> git push origin
>
> >>     Without additional configuration, pushes the current branch
> >>     to the configured upstream (remote.origin.merge configuration
> >>     variable) if it has the same name as the current branch, and
> >>     errors out without pushing otherwise.
>
> Hmph, it seems it talks about the branch on the remote side that is
> configured for the current branch to integrate with.  Most likely
> that is misspelt "branch.<name>.merge" where <name> is the name of
> the branch currently checked out.

I agree; this should definitely refer to "branch.<name>.merge", not
"remote.<name>.merge" (which to my knowledge has never existed).

I had to double check that this "without additional configuration" is
right. Indeed:

  - The default value of the 'push.default' variable is "simple", which
    in a non-triangular workflow calls
    "builtin/push.c:setup_push_upstream()".

  - 'setup_push_upstream()' dies on L213 if strcmp(branch->refname,
    branch->merge[0]->src).

  - Othewrise, it sets up the expected refspec (to push the local branch
    to the remote branch 'branch.<name>.merge').

> The text comes from b2ed944a (push: switch default from "matching"
> to "simple", 2013-01-04); I am a bit surprised how such a typo
> survived this long ;-)

Me too :). Here's a patch to rectify the confusion:

--- >8 ---

Subject: [PATCH] Documentation/git-push.txt: correct configuration typo

In the EXAMPLES section, git-push(1) says that 'git push origin' pushes
the current branch to the value of the 'remote.origin.merge'
configuration.

This wording (which dates back to b2ed944af7 (push: switch default from
"matching" to "simple", 2013-01-04)) is incorrect. There is no such
configuration as 'remote.<name>.merge'. This likely was originally
intended to read "branch.<name>.merge" instead.

Indeed, when 'push.default' is 'simple' (which is the default value, and
is applicable in this scenario per "without additional configuration"),
setup_push_upstream() dies if the branch's local name does not match
'branch.<name>.merge'.

Correct this long-standing typo to resolve some recent confusion on the
intended behavior of this example.

Reported-by: Adam Sharafeddine <adam.shrfdn@gmail.com>
Reported-by: Fabien Terrani <terranifabien@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-push.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index ab103c82cf..a953c7c387 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -600,7 +600,7 @@ EXAMPLES

 `git push origin`::
 	Without additional configuration, pushes the current branch to
-	the configured upstream (`remote.origin.merge` configuration
+	the configured upstream (`branch.<name>.merge` configuration
 	variable) if it has the same name as the current branch, and
 	errors out without pushing otherwise.
 +
--
2.30.0.667.g81c0cbc6fd

