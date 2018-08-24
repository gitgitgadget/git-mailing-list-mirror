Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75E261F404
	for <e@80x24.org>; Fri, 24 Aug 2018 15:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeHXTM5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 15:12:57 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:44898 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeHXTM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 15:12:57 -0400
Received: by mail-io0-f195.google.com with SMTP id 75-v6so7443942iou.11
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 08:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PIuRV/gY3XB8T6BBwvEVlZpEs/W8W01u3dg48dGqoGU=;
        b=A45wkYgeDZjNJm6l3npRuaU7ykZkEqsnyds1iR5staa/WmDIV4POihvEKlmOX2iK4H
         5Op7OhhvPXIls5skMIoqtY/KgxeOyeYdKsTdhstuI/5V0PCSYu2AyseuNr28B0d/H5AM
         OzdSy8gn+irvZGi7tgF2Q3X3K1z9otLs4dnDm3wNhzb18ZVVzpFg/z30zx5Z65cZoNnV
         ky0zWfiXpHAOfzphPOU59RmZcKLmJzl/5iKzbZKqHvwqKKuJtBZt40tgawkg7reE90NY
         GXK8K+OOX44X4UsECWSujbzPWZUzVqGPuT/kSQfy0SzfpMeYo1pY68sEkCl7IKGE2n07
         n5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PIuRV/gY3XB8T6BBwvEVlZpEs/W8W01u3dg48dGqoGU=;
        b=JNZb2Zy9765u9QxF2mufquIKNagvxbVnuGZqPTtMV/0Q912R46V/omKRxMyR4ermaH
         D1i/WzPUs/ZTn07M0pTfWbEgzBoD2mtc0j85GLODx7luZMKygwMRqsBhCnsHnO1pAo3h
         ZVu+bGpL6rJsPxzy6V2dLwKqXR2qRF1+gKKMJ71etrIMWYyNsF9FDMbHuzXQWbA3V22T
         uvpm7yKmL/3uXanIErvAST20QhEWEiXuQyNgX8ztLNrU2ykY0rG5lDE9e51/azdl6w+M
         NjphWoq/mVvnJC2U4GrE9QfWXYIK+kuqDwFps3N7UL3D+mcVBmwkKu2IdXoIVsiQ7gg4
         9MHQ==
X-Gm-Message-State: APzg51DNeon+R2kkm1KUrnmYAIO8ndBYGIH56h6OxwX0tmBeb4ZDvS9S
        H5fAAw+nam57IddIIqWad+JHWJMt50prkw8x4M4=
X-Google-Smtp-Source: ANB0VdZXe2kBviKn6sy03OY3KSGsC6zEuXmie/47xVlC42/XOB2kcsTisQhZkDM593DrsvX5SVTXcf5kmkcfxotrhBA=
X-Received: by 2002:a6b:9dc8:: with SMTP id g191-v6mr1535283ioe.282.1535125066331;
 Fri, 24 Aug 2018 08:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <xmqqin41hs8x.fsf@gitster-ct.c.googlers.com> <4c70ea50-5b43-8696-3c46-cf3d658a0ef8@gmail.com>
In-Reply-To: <4c70ea50-5b43-8696-3c46-cf3d658a0ef8@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 24 Aug 2018 17:37:20 +0200
Message-ID: <CACsJy8CUPGUhR3girstdqD6YVxOQ6_xE+gacT98KXgqOSPz0dw@mail.gmail.com>
Subject: Re: [PATCH v1] read-cache: speed up index load through parallelization
To:     Ben Peart <peartben@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since we're cutting corners to speed things up, could you try
something like this?

I notice that reading v4 is significantly slower than v2 and
apparently strlen() (at least from glibc) is much cleverer and at
least gives me a few percentage time saving.

diff --git a/read-cache.c b/read-cache.c
index 7b1354d759..d10cccaed0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1755,8 +1755,7 @@ static unsigned long expand_name_field(struct
strbuf *name, const char *cp_)
        if (name->len < len)
                die("malformed name field in the index");
        strbuf_remove(name, name->len - len, len);
-       for (ep = cp; *ep; ep++)
-               ; /* find the end */
+       ep = cp + strlen(cp);
        strbuf_add(name, cp, ep - cp);
        return (const char *)ep + 1 - cp_;
 }

On Thu, Aug 23, 2018 at 10:36 PM Ben Peart <peartben@gmail.com> wrote:
> > Nice to see this done without a new index extension that records
> > offsets, so that we can load existing index files in parallel.
> >
>
> Yes, I prefer this simpler model as well.  I wasn't sure it would
> produce a significant improvement given the primary thread still has to
> run through the variable length cache entries but was pleasantly surprised.

Out of curiosity, how much time saving could we gain by recording
offsets as an extension (I assume we need, like 4 offsets if the
system has 4 cores)? Much much more than this simpler model (which may
justify the complexity) or just "meh" compared to this?
-- 
Duy
