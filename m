Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC7EC7EE22
	for <git@archiver.kernel.org>; Mon,  8 May 2023 22:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjEHW0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 18:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjEHW0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 18:26:16 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361C05BB4
        for <git@vger.kernel.org>; Mon,  8 May 2023 15:26:15 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-b9a7e639656so7936495276.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 15:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683584774; x=1686176774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X2h4jf+zyyUcV+kja2JasfJ4qkEeqWoEfynyVKdsWZw=;
        b=1JS5eNLCcz1+/sW9rJMulMDb11+gZC+E8jOvTgZYrB6z8TJioDWup7vh9P0AExwQIG
         G/aJlT6jBPgjkoBmU1MwWl+N+HiMrvZRAWm6zq5R7wbTJtmjQ32nSuMRwV5I01UfMzri
         rVTdJiLq4DaOlW62aa86JFB2FbB6GYFcc3KJDneA+gIq60JmfjGB6pB4PdvtiGEbLIOe
         Wo6xAGJW6zWX4SMOp4VsEL8QTkvsDtTweYLmj3Wm8wSv9xuBuXBw5mCh0451HpVtgOjV
         v7xuyz2F95+FqNCbWbY2xHV7DeddPGCsVa/ZlUpdyQ5y6CQnC0kbplPWUYE/0shrJcsK
         C7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683584774; x=1686176774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2h4jf+zyyUcV+kja2JasfJ4qkEeqWoEfynyVKdsWZw=;
        b=akLht62HLXY8y7cf8G+y7r7mNxm1ejfpg7pT6FbN9EbcEIYZID1XbMsTlpvMHbsoKE
         8PTe6DcA7h9xN/QabZqGhIBqiNXXrSJjGg6LHgzNWCYVYbu29JtVgjKjcZTX9V03YTPq
         TIVAKswY+XKa9B/ejFgw5EjqtdEJ/1NwQrYE0UBOgCJBnt34X9BeuV+rb5VvSzTkLsXs
         7/PlKe+Bnn7nr600H8yKu7tpjjZzHlD0+gWrMAMLhP8Cyz9twNSqs+63zxQ6wU/YJ/IM
         uA/jSceZDOCpgMoZKbASXrlYwqYDLIkld1cHmrWUjqmPkc7Wsn/DaPUldUwCHdmx+oPj
         B2SA==
X-Gm-Message-State: AC+VfDwydK2HShsZ2lonR6mmEtt6N3gJPiVzEVh8Bpg3Dg/tCuJCGZ1R
        BIQBXG7ii3TkMZM4RBMocDkE0azM8bpRO6+g8mTRpg==
X-Google-Smtp-Source: ACHHUZ7bYu1V0jxAw5boiH5FXR3lZncynIhUIlnSa+LAb+IUS+Dn9J/jaN61Mc0kduXKw7XtG+qgDg==
X-Received: by 2002:a25:7454:0:b0:b92:3d81:cc6 with SMTP id p81-20020a257454000000b00b923d810cc6mr11885380ybc.25.1683584774386;
        Mon, 08 May 2023 15:26:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c203-20020a251cd4000000b00b99768e3b83sm2687045ybc.25.2023.05.08.15.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 15:26:13 -0700 (PDT)
Date:   Mon, 8 May 2023 18:26:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] t: drop "verbose" helper function
Message-ID: <ZFl3BCzDwetyAkyQ@nand.local>
References: <20230508185953.GA2108869@coredump.intra.peff.net>
 <20230508190457.GC2366490@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230508190457.GC2366490@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 08, 2023 at 03:04:57PM -0400, Jeff King wrote:
> Let's consider the "verbose" function a failed experiment and remove the
> last few callers (which are all many years old, and have been dwindling
> as we remove them from scripts we touch for other reasons). It will be
> one less thing for new test writers to see and wonder if they should be
> using themselves.

Well put.

> I think this should be all calls. Most tests will fail after removing
> the function, of course, but it's possible one could be hiding in an
> expect_failure or something. I didn't see any after grepping for
> '[^-]verbose' in t/, which is not too long to look through.
>
>  t/t0020-crlf.sh            | 38 +++++++++++++++++++-------------------
>  t/t1301-shared-repo.sh     |  4 ++--
>  t/t3427-rebase-subtree.sh  | 12 ++++++------
>  t/t4022-diff-rewrite.sh    |  2 +-
>  t/t4062-diff-pickaxe.sh    |  2 +-
>  t/t5304-prune.sh           | 16 ++++++++--------
>  t/t6006-rev-list-format.sh |  2 +-
>  t/t6501-freshen-objects.sh |  2 +-
>  t/t7001-mv.sh              |  2 +-
>  t/t7300-clean.sh           |  4 ++--
>  t/t9902-completion.sh      | 30 +++++++++++++++---------------
>  t/test-lib-functions.sh    |  9 ---------
>  12 files changed, 57 insertions(+), 66 deletions(-)

I applied these myself and grepped around myself, and also could not
find any stragglers. So I'd be happy to drop the implementation of
verbose() in this series, too, to avoid the appearance of it continuing
to be a blessed path.

Thanks,
Taylor
