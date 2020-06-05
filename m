Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27B3C433DF
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 16:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FBAA206DB
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 16:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=forgerock.com header.i=@forgerock.com header.b="ME4QuX1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgFEQvM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgFEQvM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 12:51:12 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8DDC08C5C2
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 09:51:12 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id o8so5404355pgm.7
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 09:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forgerock.com; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=Gyd5nLwu1k1yRiz24wXZ9pavtOeVIiLHVZHq4h6+bS8=;
        b=ME4QuX1KrZ9hr/Ot+hFORmxwoFHDy3FQe1EgTMxpVAhzkSItSJsit8JoBgjOiNcH1L
         ovnvsZIPZr0ca/dStvYqapI1G4tJK0H+6/Y/7DCEz7dbdtguW9LNqJVZCXK8ZqhvSchM
         jsAl80fqNaoCagInwN+d1KBQPvjsKLpSEOnqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=Gyd5nLwu1k1yRiz24wXZ9pavtOeVIiLHVZHq4h6+bS8=;
        b=qNGLILDcgHwUan/GUE4G8DFCAP6EHgs96WcCdusjw5WT/Cr3AbYNFfizCQRS1ogfjA
         Qf516PTAqL0AhM1CoFx5wWirkBdVbwrbfoaEYv32jstil+qqNp+bXv2oZgpldX/cQWTB
         /rkJWS9RGirGzaEympwFTbQZKBWBLwOh6ikpciXGDNwbDsdBEse8OGlhvbH/HuYEI7gv
         DI8uOW04rQTYJkBqvbKQ7a/HVVzAFa3y8+sKnsdAEAMqb7OybUhmeFuq3T9WVd+g+5bu
         fY38lHEPpdy2iK/odZ63dfZIN2MYcOHj6W+4XPv/2nH7Edv/LT2nRyYt2XEc2Ye/Bpaj
         nXIg==
X-Gm-Message-State: AOAM532IcMYnh+8mZMKgpS1B7H/usnkViJj1+cKj/7n6S2FDm+fkLaKr
        jO9YgLHA+3o6gTwDS9sJhonVZMrPYSbC6QjMmxuTvE17PN3lvaQxi7TcGbb8rPXCrvV1jH14SSt
        3r2nQQVUkhYVHi+Bx4z9Q/3XnrOKII6xwLILy0WllkJB8CinPCfmdmZbxTVXDq22oEplgSg==
X-Google-Smtp-Source: ABdhPJyDuwfRaH8DTm5FvIBdSRMha+agDW/H/ZiGvpnJpbh4bKudwDfHRAiQDNY3VfpKA1IvsktPxw==
X-Received: by 2002:a62:4e8a:: with SMTP id c132mr9984016pfb.22.1591375871270;
        Fri, 05 Jun 2020 09:51:11 -0700 (PDT)
Received: from localhost ([75.164.48.18])
        by smtp.gmail.com with ESMTPSA id m15sm105941pgv.45.2020.06.05.09.51.10
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 09:51:10 -0700 (PDT)
Date:   Fri, 5 Jun 2020 09:51:09 -0700
From:   Max Resnick <max.resnick@forgerock.com>
To:     git@vger.kernel.org
Subject: name-ref on annotated-tags is null terminated, but lightweight tags
 arent
Message-ID: <20200605165109.jr6mjl6xz7upofdy@forgemax.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
I was using name-rev to resolve a commits tag name. Annotated tags seem
to have a null termination and lightweight tags dont.
```
/tmp
❯ git clone https://github.com/maxres-fr/null-termination-issue.git
Cloning into 'null-termination-issue'...
remote: Enumerating objects: 10, done.
remote: Counting objects: 100% (10/10), done.
remote: Compressing objects: 100% (4/4), done.
remote: Total 10 (delta 0), reused 10 (delta 0), pack-reused 0
Unpacking objects: 100% (10/10), 757 bytes | 189.00 KiB/s, done.

/tmp
❯ cd null-termination-issue

/tmp/null-termination-issue on  master
❯ git pull --tags
Already up to date.

/tmp/null-termination-issue on  master
❯ git tag --list

/tmp/null-termination-issue on  master
❯ git name-rev --tag --name-only
38bdebc9107cab4ab3718d0581632702e74d9209
annotated-tag^0

/tmp/null-termination-issue on  master
❯ git name-rev --tag --name-only
a340894d3ee655ae6c336a85b42d2215d52609e3
lightweight-tag
```

What did you expect to happen? (Expected behavior)

`git name-rev --tag --name-only ANNOTATED-COMMIT-ID` to return the name
without null termination

What happened instead? (Actual behavior)

`git name-rev --tag --name-only ANNOTATED-COMMIT-ID` returns the name
but it's null terminated

What's different between what you expected and what actually happened?

a null control character exists.

Anything else you want to add:

I tried this with the following git versions:

2.11, 2.23, 2.26, 2.27. I've also been able to reproduce on MacOS.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.27.0.rc0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
uname: Linux 5.6.0-1-amd64 #1 SMP Debian 5.6.7-1 (2020-04-29) x86_64
compiler info: gnuc: 9.3
libc info: glibc: 2.30


[Enabled Hooks]

