Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3A5C64EC7
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 16:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjBVQCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 11:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjBVQCR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 11:02:17 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3703C790
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 08:02:15 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id x6so3661289ilm.11
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 08:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677081734;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=yAdcO+TaX1IctnHW+6QQnvklWfbqqfoO6DVxJ639twA=;
        b=KGz3Q786LeCJfty+sl3snzffOSe8mBro3aARp2SiZ781wAGZBptfDKVpuQwrhHEKVM
         wNv2hoC87ZMzliyn2hwJJGWWZ0wrunajDCFjmgrH6SB9d+SxfgkJ+yqnUdU4eeWoVaFJ
         AZTA9UvocJdo5djBElPOZRJrp5MDmzHxxk6QDgj75DlfMf41xeCtnn8D6DcI4RHFdVbr
         FzrAHqb+75ewJtbZ/CVxJOOAXxM4dbQVG+1PhkwXI01JlKu16CuPoNaq2JHmwxJsmaBd
         JQksQvXQLJUCz9W00gwfGZ7s+TKUojxBI8Isktg8jhmSDxRKSW/TQQFE9uYP6fqK8s7f
         SUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677081734;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAdcO+TaX1IctnHW+6QQnvklWfbqqfoO6DVxJ639twA=;
        b=eZgEfynPeiCM+Bcq3aRuh2coVOVEubEOjggdTLicOWF78LR7snnFh9VE2IKUPTk+Bw
         X1xBZEGUkMT0nVba2FtYfdxNoL7AM47OltDVzx3WtiMhJl1rkfrSPjm/C5md7wc7LSeb
         XohMy6ez0AaDB1MdJDRqDXrN70vND9wL4508Mei3d6yjWwTxiZbTe/mvgCDiahx4/IQo
         cGgrGNkXw1XgetAtL5jAarL07kShIOjc1Yu4RHEOkdfL9jBtRwnshqukMKB7Alh3iaWL
         s3g/CWOL/nmAiN+EijeLW0sp6eqi3IcH+qJbsDOPRnywYow1hMAjvUvtFsZ44mRmtRt9
         mLGw==
X-Gm-Message-State: AO0yUKUPKC/4AvxWcnfzPdgWy48gICILYmj4UzJRdZ3DPIlYxDzU+Ktl
        jn2dwdqyU2JBEteX7a1hq0dEROC1Bj86kw==
X-Google-Smtp-Source: AK7set+4Sm4tIqHdNapGOPiqAFglie/P0Kp7PfqD6U4qzk5q3Cyvzjf8ljhuzjbx1DN2reM/a98hmQ==
X-Received: by 2002:a05:6e02:1a06:b0:315:8bf9:53d8 with SMTP id s6-20020a056e021a0600b003158bf953d8mr5471935ild.2.1677081734463;
        Wed, 22 Feb 2023 08:02:14 -0800 (PST)
Received: from epic96565.epic.com ([2620:72:0:6480::1b0])
        by smtp.gmail.com with ESMTPSA id q7-20020a056e02106700b003153213c586sm1977852ilj.30.2023.02.22.08.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 08:02:13 -0800 (PST)
References: <m0ttze4qzl.fsf@epic96565.epic.com>
 <Y/VNiuI7OZ2YiXx8@tapette.crustytoothpaste.net>
 <7bfb7ecd4a4c78668f97b00d5f06af0c9b2878269476e89c3311eeb8071b1ab3@mu.id>
User-agent: mu4e 1.8.14; emacs 28.2
From:   Sean Allred <allred.sean@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Sean Allred <sallred@epic.com>,
        Kyle VandeWalle <kvandewa@epic.com>, git <git@vger.kernel.org>
Subject: Re: [BUGREPORT] Why is git-push fetching content?
Date:   Wed, 22 Feb 2023 09:48:19 -0600
In-reply-to: <7bfb7ecd4a4c78668f97b00d5f06af0c9b2878269476e89c3311eeb8071b1ab3@mu.id>
Message-ID: <m0lekp4rjv.fsf@epic96565.epic.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Apologies for the double-email; in switching between desktops, I
prematurely sent my last message. Luckily I was very nearly done.

Sean Allred <allred.sean@gmail.com> writes:
> But we can see this blob:none 'mistake' again...
>
>     08:33:51.764098 pkt-line.c:80           packet:        fetch> want 0000063ae70e4385b0527df060daf0a81b306c8d
>     08:33:51.764098 pkt-line.c:80           packet:        fetch> want 00003efd5bd3b3795950588f7d051e8d0b42def3
>
>     ---8<--- many, many thousands of objects removed
>
>     08:33:54.154726 pkt-line.c:80           packet:        fetch> want ffffd8aad00ab11c0672096203f57564b286da08
>     08:33:54.154726 pkt-line.c:80           packet:        fetch> want ffffd967eaed43bf87d40a84f2f9e12c59575abe
>     08:33:54.154726 pkt-line.c:80           packet:        fetch> done
>     08:33:54.154726 pkt-line.c:80           packet:        fetch> 0000
>
> ... with all of those trees

I was verifying my suspicion in the other desktop -- but my suspicion
was incorrect. These aren't all trees; in fact, the objects listed above
are *just* blobs -- no other object types. One could assume that these
are all the blobs in the 8da2fa tree, but I would expect that we'd get
all the subtrees in 8da2fa as well in that case.

I'm not sure how much more information I can extract from this list of
blobs, but I'm open to suggestions if we think there's a pattern here to
be discovered.

--
Sean Allred
