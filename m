Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787DCC5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 09:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbjAIJYJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 04:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237162AbjAIJXp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 04:23:45 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5A813DFD
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 01:22:13 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id v19so2051974ybv.1
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 01:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+8t9ZOSvUoZXDgmqP8o7XQqUfoCi47prDRh8yPsblTo=;
        b=V8SmdvueXVMiU7olDEPjoWCJxy01n+847BFCeBkt+ariX86W2HxMjx7u+D3VMc4cyx
         4/BgeJFE0njCVUJfO7g1IGrkWT0QejrZfYymeZMCuO8ChpMzNhOebrf0VdUClQ1taKaS
         jmlsSWW7DWzMTPJSsJhf4lYNijiHLq7YL6F2ZlSFKYg3ADvWqQAEV8qp03XtC23sLx6x
         NiYVp82QOWfoW/dyRjEdjY5eUd/6Jq5kQnMngZ+2jCggmOMfqxtxteMD6FqAY25PjlB7
         hAK/TRQLJLt74mm/vJjXrqRo/ekrsLU5Rs4hIrHpeq06ZwbfxN9L7EtLeo5T8gJcy8eh
         rBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8t9ZOSvUoZXDgmqP8o7XQqUfoCi47prDRh8yPsblTo=;
        b=TLBXJ7a9/TtK8gRn5w+ZYM60/oVavpIjhUV7w8/RUA8WHfzXVAfPVgZ3D8DwJYIcPS
         7ilPz9nVm+8op10D/eig44SQ1gqoCmDzxMum4aTwee49TkJIOshMeZ3YZJ/0//Uz9Fk/
         1Bv7I+TGzD7oxcy1X1t2bF76jFO/97dISXTFt+xFu3fm7qy+wKNmczq4yqDEuxmUifmY
         deQzJpAGgkfgWPLiMUgQLdbaE8Qv8t9KktvAJ8ZwACBMvu3SzTQFbI0a7u/DOY+FWx9x
         geBVSXiAImF6JFZGkyPHdjUEXfBW0AG7Uj5bMIzYjKJ3P1Ma/llEpP9VQfEjMeuw34oc
         P5ZA==
X-Gm-Message-State: AFqh2kp1OWdopOTaDjkVLDrFqZOY8+N1nwsgC9C8d55yQAgaSg5aTVYA
        3oHupDja2gaGYDHW1GFZVwQxIs03D2dBUorvZY8=
X-Google-Smtp-Source: AMrXdXtG+kbyjxFyASZBSYDIvdTdnbxJIwz2hquNmEOa5X9BNC9BTGhkgSjRIrqIeyAveRctAHpFHfWBOfNG7CTTg58=
X-Received: by 2002:a25:4ec1:0:b0:6f9:9c61:66df with SMTP id
 c184-20020a254ec1000000b006f99c6166dfmr7834122ybb.494.1673256132591; Mon, 09
 Jan 2023 01:22:12 -0800 (PST)
MIME-Version: 1.0
References: <CA+PPyiG=+rs_bOQbaNB311_DVdSc2g44SkLzpaqOER7rfxykrQ@mail.gmail.com>
 <CAP8UFD2huFgTjB1hNGyGnMKPONOG6ZV-wvxWkTaz-iZNfxrhJA@mail.gmail.com> <CA+PPyiHOLUm87eHuxyhbqqML33Q6g-he_DKRxTEb2fu-2p3NSQ@mail.gmail.com>
In-Reply-To: <CA+PPyiHOLUm87eHuxyhbqqML33Q6g-he_DKRxTEb2fu-2p3NSQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 9 Jan 2023 10:22:01 +0100
Message-ID: <CAP8UFD23ObbQaeQi2WsZ3oy0QTKiBxs3wExaHTU2QzJBPwKOmA@mail.gmail.com>
Subject: Re: Github actions failing
To:     NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 9, 2023 at 5:40 AM NSENGIYUMVA WILBERFORCE
<nsengiyumvawilberforce@gmail.com> wrote:

> Thanks, I missed the GPG flag. Now I get the following after forcing
> the push. I have been looking for the problem but I can't figure it
> out. I will be glad for any help
> >
> > git checkout -b signed &&
> > 1840 echo 1 >file && git add file &&
> > 1841 test_tick && git commit -S -m initial &&
> > 1842 git verify-commit signed 2>out &&
> > 1843 head -3 out >expected &&
> > 1844 tail -1 out >>expected &&
> > 1845 echo >>expected &&
> > 1846 git for-each-ref refs/heads/signed --format="%(signature)" >actual &&
> > 1847 test_cmp actual expected
> > 1848
> > 1849 + git checkout -b signed
> > 1850 Switched to a new branch 'signed'
> > 1851 + echo 1
> > 1852 + git add file
> > 1853 + test_tick
> > 1854 + test -z set
> > 1855 + test_tick=1112912113
> > 1856 + GIT_COMMITTER_DATE=1112912113 -0700
> > 1857 + GIT_AUTHOR_DATE=1112912113 -0700
> > 1858 + export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
> > 1859 + git commit -S -m initial
> > 1860 [signed 4dc4b90] initial
> > 1861 Author: A U Thor <author@example.com>
> > 1862 1 file changed, 1 insertion(+)
> > 1863 create mode 100644 file
> > 1864 + git verify-commit signed
> > 1865 + head -3 out
> > 1866 + tail -1 out
> > 1867 + echo
> > 1868 + git for-each-ref refs/heads/signed --format=%(signature)
> > 1869 + test_cmp actual expected

I think in general we prefer "test_cmp expected actual" over "test_cmp
actual expected". I think it's easier to understand what happened with
the former.

Also most of the tests in t6300 are like "test_cmp expected actual":

$ grep -c 'test_cmp expect' t6300-for-each-ref.sh
67
$ grep -c 'test_cmp actual' t6300-for-each-ref.sh
1

> > 1870 + test 2 -ne 2
> > 1871 + eval diff -u "$@"
> > 1872 + diff -u actual expected
> > 1873 --- actual 2023-01-08 19:40:42.169214115 +0000
> > 1874 +++ expected 2023-01-08 19:40:42.121213837 +0000
> > 1875 @@ -1,4 +1,5 @@
> > 1876 gpg: Signature made Sun Jan 8 19:40:42 2023 UTC
> > 1877 gpg: using DSA key 13B6F51ECDDE430D
> > 1878 +gpg: checking the trustdb

The + before "gpg" means that the above line is in what we expect, but
not in what we actually get.

I think the reason might be that gpg's output could have changed
between different versions of gpg and it might just not be possible
and wise to rely on the exact output it emits.

In both t7510-signed-commit.sh t7528-signed-commit-ssh.sh for example,
we don't test the '%GG' format, and that might be the reason why.

So I see the following possibilities to overcome this issue:

  - just drop the test you added for the %(signature) format
  - find a way to require a specific version of gpg for that test
(unfortunately I don't think our test framework allows that, so you
would have to add custom code to the test, and this is likely to
bitrot as time passes and the required gpg version becomes unused)
  - find a way to make the test independent of the gpg version (this
might bitrot too as new gpg versions might further change their
output)

> > 1879 gpg: Good signature from "C O Mitter <committer@example.com>"
> > 1880
> > 1881 error: last command exited with $?=1
> > 1882 not ok 338 - test bare signature atom
