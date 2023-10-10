Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A95CD8CB4
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 19:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343634AbjJJTr3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 15:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343685AbjJJTr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 15:47:28 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62F1C6
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 12:47:25 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-66b024d26e2so2120376d6.0
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 12:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696967245; x=1697572045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Td3SOMnk8v7Zn4cD/Fu4jotDvDofK1xbaQtVj7yjUE=;
        b=j0lbKcyGhahv2LyHvUPR0FjVR6qMRqOb0yvbbN9vSZqcVKXtG+8+921WWnh4iHPCvi
         UdfwBmUxs1GImbUdoAXGgXY1FNCFm5s/4v4tIarEPMBpALo6CL0wXArwh9WIjhgFpY0z
         5iKLx5fYu7W+v4UIBaehH249ZnppNPCBJPd6u6JBvc8hy1rZbz7++f65J8sjCWBHwI1Z
         tSDLrxsU/wJZTeQY22lAovYPijCv4kdn/s7oa5cWmqOXhnBtBKg22JyX1MU8Sped1dG4
         uomSNvmDYcm43MyRSw9T1DALKUyZ119G+ZqRgAh5OZNHZ77deJgYxVW3VEbB/cteBgmn
         Ff8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696967245; x=1697572045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Td3SOMnk8v7Zn4cD/Fu4jotDvDofK1xbaQtVj7yjUE=;
        b=C/vhWQwUaMZcUnZBjE+8AYietspPmzL68J8Mz1LzB01FUzY+8lekThlRzHytwTgngs
         4/Ls+VcxRMu4DbUDKjXKbBQEjbRAmuyJzCYQ7zHZrOYqBSOUA7qWlx7H2R+ytDz7MpuY
         LgydkJxgBCZveC63T8oHj3c2E+SCTjFNQ9Rpow5Lz0n25aYaoKwodvXGaxK8zjw/9jEU
         aHoPj/qXX/ODX5OoFut3FRknnF0W3PhbCUdF0S4z7o6NXm198PcDXFmwcnmAv1ObRjM0
         +Bokl1pgsCYUMG85RjWCE4GyGf4PhbuCTUIkN/dofUd6SJYzAheYaRBp4D/O0sqvhriA
         Vc8Q==
X-Gm-Message-State: AOJu0YyI7ep8tASy0Mvq3PtNWPL8XBQVG7MRjKqAX49cqi+pmETps0pM
        iTijibOmm6tuSgMZ7SCGvrKS+A==
X-Google-Smtp-Source: AGHT+IEalTtBFyaT45Y1uQ1cCkNUsn+6cks3ySuyvsxfZ57sm8TzB/5APIutsUPUpIied0Fw3lpa/g==
X-Received: by 2002:a0c:aa10:0:b0:65b:2cca:4196 with SMTP id d16-20020a0caa10000000b0065b2cca4196mr21659282qvb.29.1696967244643;
        Tue, 10 Oct 2023 12:47:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q9-20020a0c8cc9000000b0064c9f754794sm5077148qvb.86.2023.10.10.12.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 12:47:23 -0700 (PDT)
Date:   Tue, 10 Oct 2023 15:47:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH] Not computing changed path filter for root commits
Message-ID: <ZSWqStEpsFU0SmEm@nand.local>
References: <ZSQ3s3ZiRcvQIKOa@nand.local>
 <20231009205925.1915096-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009205925.1915096-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2023 at 01:59:25PM -0700, Jonathan Tan wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> > This only happens when we return REV_TREE_NEW from a call to
> > `rev_compare_tree(revs, p, commit, nth_parent)`. But we'll only get
> > REV_TREE_NEW back if
> >
> >     repo_get_commit_tree(the_repository, p);
> >
> > returns NULL. But when we call rev_same_tree_as_empty(revs, p) in the
> > REV_TREE_NEW case, we return early as follows:
> >
> >     struct tree *t1 = repo_get_commit_tree(revs, p);
> >     if (!t1)
> >       return 0;
> >
> > So we won't even consult the Bloom filter in that case, since t1 is NULL
> > for the same reason as what caused rev_compare_tree() to return
> > REV_TREE_NEW in the first place.
> >
> > I am still dumbfounded by how we would ever get REV_TREE_NEW in the
> > first place, but if we did, I think we would be OK here.
> >
> > Thanks,
> > Taylor
>
> Ah, good point. Your patch in
> https://lore.kernel.org/git/ZQnmTXUO94%2FQy8mq@nand.local/ looks good to
> me, then.

Oops, I made a mistake in the quoted portion, which is that we could get
REV_TREE_NEW if the tree-diff itself only adds files. This is the
non-trivial case that we get when t1 is non-NULL, and we end up calling
`diff_tree_oid()` which sets the static `tree_difference` variable.

So I think adding an nth_parent field (like you originally
suggested[^1]) makes sense.

Thanks,
Taylor

[^1]: Thanks for being patient with me ;-).
