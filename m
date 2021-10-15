Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5F5C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0032B611C1
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241113AbhJOQHF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 12:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236035AbhJOQHF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 12:07:05 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18EEC061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 09:04:58 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id x1so7678414ilv.4
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 09:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=qfw2oBJ/vXMZl35EKz1n669sX/umIKJOTk+c/AvngCI=;
        b=CgnFcXC4DlCKp550oIOUwmaLjH8y/dgkRFDDPmJ7CQVPi+iz2PcjKrUDuYIEf/Jg4l
         7zMsb4ArDCR1BkqUahO+x0NNQkL3uV5rEJ3KoTUgDeEO86dY9SxVShCmAfVK+fyXpjIt
         e1809dQ6VjQ7Brg3yvmY8zusRrdCIiaEXxy9AWj/DbqzleDkSzf6ilVjkvsjYtj7kaYQ
         OHNusJHcOtO9la/1bvMIxfS8jtZlL3KsPycatV87d7Ga4N7T9I55fvh22qHFyvvHTbDl
         rIZR5zm/KO751GLbz+xsmgoXc5g6wzdLR9HTRPFsZXVJuazyXGU5F9wqRAsTB3pIK/Tp
         YyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qfw2oBJ/vXMZl35EKz1n669sX/umIKJOTk+c/AvngCI=;
        b=K+N+/NC9VTZjX42jVcfUgFW7W4ooLLlq8JJVXvSb5v75vtO9GW96nWgzNEZ8b62exr
         2XU4qEfpm6zhtu+Oe7dVnm4o8mBdpKlo1j1GPaTB9JvqvOlt8FqnJ5+2RulupDT1IajG
         omdPSifwhh79XTBplkf2aAFEWxOXdxqzQ/hnpfOnNLtmLxY1fvTILMx1xx+NTicZdEsO
         Foux0ZGah6O8OPjmvyr6e75IqbAHr3Emv1GfgmNvDI7okkuIyPOxUeLfUKFf4NqvEfO7
         O+PyrEfA/wkCLhK95Vdv9PULV2KGTZlfMWm8W5Yk0eXATxmOtsyJnl70iMG2Rya5QD3h
         YsLw==
X-Gm-Message-State: AOAM5327ly7yZ+MhgcnbRaaXfdmcGzpS1t23VkPbgZ8pFLajOioEqjt5
        MdAM7+PFOLCqTDYdkUHO/2mCyZzHzorBe3pDKx3YpOJavd0=
X-Google-Smtp-Source: ABdhPJxynKv+8uQuSbgudRbS9HK9uugnfU0A60FKR24Mtbit2NR/IFkgni0ZwOahri6/bCS7sMTLh1A25q+nWFZll2w=
X-Received: by 2002:a05:6e02:17c6:: with SMTP id z6mr4343362ilu.185.1634313897630;
 Fri, 15 Oct 2021 09:04:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:c949:0:0:0:0:0 with HTTP; Fri, 15 Oct 2021 09:04:57
 -0700 (PDT)
From:   milan hauth <milahu@gmail.com>
Date:   Fri, 15 Oct 2021 18:04:57 +0200
Message-ID: <CAGiEHCtdjA+cVXjN43NPbSZfrDtr-kDtPMN4x_VTGSJuPZ8bcg@mail.gmail.com>
Subject: force deterministic trees on git push - exact sort-order of filenames
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fact: the sort-order of filenames in a tree is not strictly regulated

proposal: enforce the exact sort-order of tree-items,
to make trees deterministic and reproducible.
the git server could refuse a 'git push',
when the tree is invalid

use case: reconstruct a git tree only from files.

current situation:
blobs are deterministic, trees are non-deterministic

backward compatibility:
rewriting git history is usually not desired.
so this new rule would apply only to new commits
after a certain 'deadline', set by the git server



sample trees from [1] and [2]:

git cat-file -p 2b75a7dbb76138587dbe50a5a6af8a6eedbaf66b | grep id_ed25519
100644 blob f914b3f712fc56ab212b53cb9055e1291b5c77a2    id_ed25519
100644 blob 40de4a8ac6027f64ac85f687bea7049467b428a2    id_ed25519.pub

git cat-file -p c8a72e628d0ca0a174a1a4241e6c7314a4660f0f | grep example
100644 blob fde6f3cbd19addb8ce84ffe32ab4d040e8b09c18    example.pem
040000 tree 6b0ee97865059ac965590e0ff5272fb76b6fd2c8    example



the first tree is sorted as expected

printf 'id_ed25519\nid_ed25519.pub\n' | sort
id_ed25519
id_ed25519.pub



the expected sort-order for the second tree:

printf 'example.pem\nexample\n' | sort
example
example.pem

the "unexpected" sort-order can be produced with [3]:

```py
import functools
def cmp(s, t):
  """
  Alter lexicographic sort order
  to make longer keys go *before* any of their prefixes
  """
  for p, q in zip(s, t):
    if p < q: return -1
    if q < p: return 1
  if len(s) > len(t): return -1
  elif len(t) > len(s): return 1
  return 0

arr = [ 'example', 'example.pem' ]
print("\n".join(sorted(arr, key=functools.cmp_to_key(cmp))))
```

result:

example.pem
example



[1] sample tree 1
https://api.github.com/repos/NixOS/nixpkgs/git/trees/2b75a7dbb76138587dbe50a5a6af8a6eedbaf66b

[2] sample tree 2
https://api.github.com/repos/NixOS/nixpkgs/git/trees/c8a72e628d0ca0a174a1a4241e6c7314a4660f0f

[3] python impl of unexpected sort
https://stackoverflow.com/questions/42899405/sort-a-list-with-longest-items-first

[4] related issue (wontfix)
https://github.com/dulwich/dulwich/issues/905
