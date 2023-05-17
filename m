Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6FEC77B75
	for <git@archiver.kernel.org>; Wed, 17 May 2023 16:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjEQQXZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 12:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjEQQXY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 12:23:24 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44487E76
        for <git@vger.kernel.org>; Wed, 17 May 2023 09:23:23 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-ba71af5f164so1295717276.1
        for <git@vger.kernel.org>; Wed, 17 May 2023 09:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684340602; x=1686932602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4iogzqw7m1AnNKGQiY6ooXCEosORFxMOuyasy4S45fc=;
        b=R7Fguw1fJmv5n/iRsII7J7dl/3FrmWkCIFZ535ferDeWU6ZD58+I4Z9lZGyRBGpDyG
         PsMP1EQ9QJRW0SB0K52PDfVdZWXRvzrTKPIO5TwnBXeV7+aEG7Aud15RGkm4UvMe+rGf
         5yBlWWb8R6lob8c8rR6mb+vdwA40UInZ5M8kVeo50qEpC4Rm6MExQom/0kP/uPzwFhFY
         xd1jrg3NiykbRRAkK+V9ApFeK6/RIJM8L8IW+FYti4E78HiC7SrygQNqFJSSQL494/ZS
         7/ugf2onGaPa4oKql1YRXs5BpraBS7oPar7mMqOMQEz001JaHQQ5+XIFsVBaXWXhNdhm
         0lVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684340602; x=1686932602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iogzqw7m1AnNKGQiY6ooXCEosORFxMOuyasy4S45fc=;
        b=KdEVUIYR5KbL9LzYRTYvltJYGM6+n5TkPx8DebP7PV9CxmO6HpK53BJ+nW0KzZecty
         e2Vgj8cy2+t6k+67nY+9k4Wpac+YdT8dgx7aQvWIcEJ2Nx34JbRlS7+Maa/yGoaxTQ+V
         e4EAKvw7II5uqh1Vfn04GKE2Yv6c0WwVT58cUpI+Uc0VNp4UqRaUTwhpR2ZzFNZ2cv2A
         qEn89/uPDv4pK+4T5S22wlo8um1LdODbKTwjcAOUcfWNzlosgGAo6C8Y31spOSYr1Kzx
         iX0oBPFjyb6f/TKPVGRw4HZ1HY+o2d0A93bipzKr38sUVgtTbz8BamJwwVkKblbpwzX4
         ZzSw==
X-Gm-Message-State: AC+VfDxTb7GVwyBLVH+fD9NX74wV/60JcG94DwICswfdu7a9Ccj2uFOq
        4ddA3vsH8vkEJwkhVriziwfO2aiquwePCP7YlM5BmQ==
X-Google-Smtp-Source: ACHHUZ6J7TrnzNDWjndzuu94ocIv/21L3LW3w8bgqQSKpIjXUXQxTbnSurpOYNxkaN6XYv0oy+S3+Q==
X-Received: by 2002:a25:e7c5:0:b0:ba8:63e8:e583 with SMTP id e188-20020a25e7c5000000b00ba863e8e583mr1636833ybh.61.1684340602386;
        Wed, 17 May 2023 09:23:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f133-20020a256a8b000000b00b923b2935d9sm633843ybc.20.2023.05.17.09.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 09:23:22 -0700 (PDT)
Date:   Wed, 17 May 2023 12:23:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Hesse <list@eworm.de>, git@vger.kernel.org,
        Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] imap-send: include strbuf.h
Message-ID: <ZGT/eK6+IKlCM6Sg@nand.local>
References: <20230517070632.71884-1-list@eworm.de>
 <xmqqwn17q7ou.fsf@gitster.g>
 <ZGT6fEZFumAsZnxu@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZGT6fEZFumAsZnxu@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2023 at 12:02:04PM -0400, Taylor Blau wrote:
> > I know there are many header file shuffling patches flying around, and
> > I have seen some of them, but is this a fix for one of these patches?
>
> Similar to [1], this bisects to ba3d1c73da (treewide: remove unnecessary
> cache.h includes, 2023-02-24).

I'm looking through other files to see if we have other uses of the
strbuf API that are hidden behind a #define without a corresponding
#include "strbuf.h".

Here's the (gross) script I wrote up to check:

    git grep -l -e '[^_]xstrdup(' -e 'strbuf_[a-z0-9A-Z_]*(' \*.c |
    while read f
    do
        if ! gcc -I $(pwd) -E $f | grep -q 'struct strbuf {'
        then
            echo "==> $f NOT OK";
        fi
    done

Here's the list:

  ==> compat/fsmonitor/fsm-listen-darwin.c NOT OK
  ==> compat/mingw.c NOT OK
  ==> contrib/credential/osxkeychain/git-credential-osxkeychain.c NOT OK
  ==> pager.c NOT OK
  ==> refs/iterator.c NOT OK
  ==> refs/ref-cache.c NOT OK
  ==> string-list.c NOT OK
  ==> t/helper/test-mktemp.c NOT OK

The ones in compat are OK to ignore since they both fail to compile on
my non-Windows machine (I am missing the `<dispatch/dispatch.h>` and
`<windows.h>` headers, respectively).

The one in contrib is fine to ignore, since it has its own definition of
xstrdup().

pager.c is OK, since it only needs xstrdup(), not any other parts of the
strbuf API. It gets a declaration of xstrdup() from git-compat-util.h
refs/iterator.c, refs/ref-cache.c, string-list.c, and
t/helper/test-mktemp.c are all OK for the same reason.

So I think that this is the only spot we need to worry about.

Thanks,
Taylor
