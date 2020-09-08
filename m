Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51003C433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 17:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AFC520738
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 17:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M+DStaBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731776AbgIHR1A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731737AbgIHQQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 12:16:58 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CD5C061757
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 09:16:53 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id k25so8224909ljk.0
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 09:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=pGpgu94TWBDHmoUgsvwdpQL6Vj4is4gUlN1l1kom1UE=;
        b=M+DStaBVBotWDGfvwYNTv7Z90+/PkZCWkx5qdY3gowEmtdkIoaWkX/MMuCXFT+1d9w
         Qow7El5HkjAg37YcqcFEC6LFkJ9nMT2X7PEZBAY7RRDgQBwv3AFebXWGvaDYlmdtQ+2a
         JEr9c4V6Ag5yE91/Y8cSEWtgA83k2Lp8DHHX3ufxhOwFd5jsjCSKK4JGHqZdF2ZZy77Y
         elNCmB5xKNmWtTq4zfuEUH7UDQj0u6EUBE2EMxRHJkSdcnj+37CIqV4DqTA+aE8tKJmS
         0d7MKpdPEQNyuhlwfBTuaJsNzZWJpCwGSF7Y7ZA88eleF1zLNtBI+dWzH2bWfeufvgsq
         VH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pGpgu94TWBDHmoUgsvwdpQL6Vj4is4gUlN1l1kom1UE=;
        b=Zj0Xk6SFgrOuRUb4onFuKSYC32D/jJjzY6+8S8wpkr3kGGbVv22Sb/U+pjeZKKJW9z
         0WaNkqTxAPYepZlK8GPCEtK8E3r89qdL0DwIXi58qREJT8NQBYnFV7WtqJGnj41qxcpk
         kZfMynZzdz9oLg+K5+IcWioIS/tuRj/Er+Wr8lZKStVDAPg7VJbuuT0dn7ImlB/fBSqY
         Nnik8gB1chEtFyy0cpArnlKZT6h14jblHGfzTexxI4ZkwPHOLFrwYCof3fXKpKLNj2sp
         OwCbfHagN4jJD7GKCOXwWfddGa4NMEIUbnvqGiX1JwqEElD+rVSrjmZVHqRykXtIXJHF
         SYiw==
X-Gm-Message-State: AOAM532OUjVEDIFOYfNfTS63O4unDQHRhv4rcSsp/I+Ybt+5LcE6pnTU
        2/h785aKZr4EsbkDmC4eDhSPZldKiLU5NNy7HEA66+9vMwAIqQ==
X-Google-Smtp-Source: ABdhPJxuXa3OMHzQTaED9K2AmLhpx7bpyOBVS6cRGKNMVlDmh2LlRjMe6PUXYHfXdYWP36l/9ACFmXnhwag0NoztgWg=
X-Received: by 2002:a2e:9c8d:: with SMTP id x13mr6882749lji.392.1599581806362;
 Tue, 08 Sep 2020 09:16:46 -0700 (PDT)
MIME-Version: 1.0
From:   Yuchen Ying <ych@google.com>
Date:   Tue, 8 Sep 2020 09:16:37 -0700
Message-ID: <CAF6j4hcSEhNvS-DYgNLNn3TdH1vkhgHZRC0fqWer_XM0PQxgYA@mail.gmail.com>
Subject: No edit option when "git add --patch" a new file
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi list,

I was attempting to "add --patch" a newly created file but the "edit"
option is not provided.

Steps to reproduce this problem:

$ echo "test\ntest" > test
$ git add -N test
$ git add -p test

Expected: e is an option
Got:

$ git add -p
diff --git a/terraform/test b/terraform/test
index 0000000..992533b
--- /dev/null
+++ b/terraform/test
new file mode 100644
@@ -0,0 +1,2 @@
+asdf
+asdf
(1/1) Stage addition [y,n,q,a,d,?]? e
Sorry, cannot edit this hunk
