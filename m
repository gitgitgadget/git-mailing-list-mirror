Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC972C433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 14:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiJDOl7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 10:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJDOlz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 10:41:55 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2884961D62
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 07:41:53 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id q83so10654013iod.7
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 07:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:date:subject:to:from:user-agent:from:to:cc
         :subject:date;
        bh=lca3rTGyu099MYePtvk47IY078sgceCFFkh5dVfnuKY=;
        b=ZwT3PqXhqh9ihl+8jMxCOJHJLGAoNXmxZXs9GSouXt2QJo4i9iHsAYujuDLY2DpU9q
         XjqusKCaLwpN2bKhg/p7VVoIicHLY+FTm2G9jtWPtJB6fxjGyRfbM6iMeauwiX+2MJfg
         6Zjjj4kdINCry27Gh9U9XBn+J0Sq3QsFB24zveGeLSJh1QBNGUyTpy72ca06mIoLAmej
         KEUDeLLfseIuiNF80nY2YBoJ7QoYqoLOqh7TsHV/BifhqsdJY4Jxn3tYhEpzztJnCgq3
         t86gwKMMhxxHAtwqQ9+YmO4HB0MNEjpUvYmW+0PHfQkSvc9CdJEXHsZUoZ1C8It1ARQl
         gRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:subject:to:from:user-agent
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lca3rTGyu099MYePtvk47IY078sgceCFFkh5dVfnuKY=;
        b=5eaZVF9vvXzqxX6GSozMEY47+aM8UycsYFvFs71m9RsHg+hFCSRLa7pyet4pabLMgq
         RqCJ1oKOwJhR7HZTxMcn1nAfWs195r+SnVoHPg6g1fzdpsBxSpQ/V00zCYhhjiwBGjxD
         HKI+dSv9ZDxU7MAAPxfG/566SN56Vm930/jMjgAyZHHDi4IzT43dIBZyOggWVsdx6qAi
         c9jM+/zSvtagfV7UVfRknFm+v2+9KpKAZz1zo4srbHzw4BbgfumxFdr2QNXVKHV3+nig
         dX/OHMJirXKsLmLULSm2ipfSR8k6wbFmCbDg1XOhhPMQKY0rSBcF8V3kZPJLPUpmrezs
         PEGA==
X-Gm-Message-State: ACrzQf2XKz0znWQmQkuxyYwSf7EargiVv6NYvGmFvkOSKv3h0lfRd4pH
        krADFwnhnJX+ilTbXYb4Ijtohu9vJ78=
X-Google-Smtp-Source: AMsMyM6IlbEq0tNUxucO1UEcdujydmT73HvvZwz7R32QaFYGEetmiC5LYvs4OBgG9INMSVEoWolQ/A==
X-Received: by 2002:a5d:8913:0:b0:6a4:71b5:8036 with SMTP id b19-20020a5d8913000000b006a471b58036mr10764712ion.171.1664894511698;
        Tue, 04 Oct 2022 07:41:51 -0700 (PDT)
Received: from stargate ([2620:72:0:a40:e4f1:6517:1ef1:ff28])
        by smtp.gmail.com with ESMTPSA id t6-20020a02b186000000b0035aab2f1ab1sm5178022jah.134.2022.10.04.07.41.50
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 07:41:51 -0700 (PDT)
User-agent: mu4e 1.9.0; emacs 28.1
From:   Sean Allred <allred.sean@gmail.com>
To:     git <git@vger.kernel.org>
Subject: Using git-update-index to add existing tree objects at other paths
Date:   Tue, 04 Oct 2022 08:44:43 -0500
Message-ID: <87o7ur1wi9.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

We're looking to create a tool that can duplicate a specific subtree
elsewhere in the repository. (This is part of a rag-tag replacement for
svn:external that will continue to work with our existing build
infrastructure while we adjust everything to be organized better in the
actual repository.) The basic idea is as follows:

1. At the repository root, there is a manifest that defines groups of
   paths that should be copies of one another.

2. Server hook logic will enforce that for each new commit, the paths in
   the manifest at that commit are TREESAME to each other. This
   guarantee is important for our build processes.

3. Client-side tooling will help produce this TREESAME-ness in the
   context of sparse-checkouts. Support for sparse-index may not be so
   large a concern as this entire approach is more of a stopgap measure.

It's this last step, the client-side tooling, that is proving tricky.

### Solution based on git-fast-import

A working solution using git-fast-import was recently submitted for
review:

    $ cat | git fast-import
    feature done
    commit refs/heads/<current-branch>
    committer (...)
    data <<ENDDATA
    (...commit message...)
    ENDDATA
    from refs/heads/<current-branch>
    M 040000 TREEID1 PATH1
    M 040000 TREEID1 PATH2
    M 040000 TREEID1 PATH3
    M 040000 TREEID2 PATH1
    M 040000 TREEID2 PATH2
    M 040000 TREEID2 PATH3
    (...)
    done

but using fast-import for this purpose seems like an abuse. It's
especially suboptimal because it creates a *new* commit that brings
everything into sync, so the two commits (the one the developer makes
and the one created by this tooling) must be squashed together.

### Something better?

This feels like a job for git-update-index. From the docs,

> USING --INDEX-INFO
> ------------------
>
> `--index-info` is a more powerful mechanism that lets you feed
> multiple entry definitions from the standard input, and designed
> specifically for scripts.  It can take inputs of three formats:
>
>     . mode SP type SP sha1          TAB path
> +
> This format is to stuff `git ls-tree` output into the index.

but the following does not work:

    $ cat | git update-index --index-info
    040000 tree TREEID1	PATH1

(using the appropriate delimiters, of course). This command succeeds,
but checking git-status (and confirming with other tools like `git
ls-files -s`) reveal that this invocation did not have the desired
effect:

> (mode) (oid) (stage)	(path)
> (...)
> 100755 (oid1) 0       PATH1FILENAME
> 100755 (oid2) 0       PATH1FILENAME
> 100755 (oid3) 0       PATH1FILENAME

with `PATH1` simply prepended to each file in TREEID1. In contrast, the
desired state is

> 100755 (oid1) 0       PATH1/FILENAME
> 100755 (oid2) 0       PATH1/FILENAME
> 100755 (oid3) 0       PATH1/FILENAME

I also tried appending a / at the end of PATH1 (this isn't ls-tree
output, but it's 'reasonable'), but git-update-index simply ignores the
line with the message

> Ignoring path PATH1/

Is there a better, recommended way to do this? Given the language in
git-update-index.txt, is this a bug / functionality gap in update-index?
The documentation reads as if I could

    $ git ls-tree <args> | git update-index --index-info

but it seems that is not the case.

Thanks,
-Sean

--
Sean Allred
