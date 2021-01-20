Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AE3C43603
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 23:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C45023619
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 23:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732933AbhATWdA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 17:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731816AbhATV65 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 16:58:57 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6CEC061757
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 13:58:16 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id v126so26876449qkd.11
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 13:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:autocrypt:to:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=pNr4ZhubA8UH0h277cFr2V8SBkLeji6vMDbT5BXfFaE=;
        b=WmL2k13P01QnFPsphaV0IpNu7Mb9S1vfjm+qYDo+BjIp6NT0Mg9hnizIzlA6o0k8rn
         fFYwPNKvcrov2YjUvdh3E3prN7wLPNIhX742GdnB2a1t9u5eVrgllqkTEJq80VFi9OiR
         izmdIP0r24gmgLF4QMXdCMH7iZy1m961L5fXFFS9Hq3yNUJhoPF4TlUD3Ird69knznl3
         LBu+Mva79F+maBksJ+39d5uWjq+WwmyGweP1Z3HnBg7ommr5X99iknnBQtJuF45EfaQt
         jn+/QElXykX2DsSKzNZJlsEvB7zzEcy7D7jcN8jmFiV2wK1NVGDX0PP1r/PkBkMV0PBS
         lsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:autocrypt:to:subject:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=pNr4ZhubA8UH0h277cFr2V8SBkLeji6vMDbT5BXfFaE=;
        b=OWz+VT/d4FEiPnaL4O84AONqWVmkSQSbPGWRh7WKGYgHA/s4Xldpcyq9aZ+DrZxFtD
         O+UEgaHHl8MoJreuIzLL4t1pngLqwXSbW00R/9OvqUAhZdD91DALrwBR9eP48uRJoId+
         9NO2ZBWnAVF5WV9+zzAK/avoYm0K6Y4Hy7UqzZeh5W7FjL9pfypWqrtcfMN42mSsjbmw
         d7KxamNunpDnqCtJUr+cepst+AqouHyzFqPK/4Inh+IlwquDQEO7XKWatH1x1isY1fMM
         1e9YSpEwbKUOqKfmqzCoD0OZx6VrUOxgTwAgqi99g2sYBZgf5vCHtl5CytBC3gI91zha
         McIg==
X-Gm-Message-State: AOAM530nqs+H1JWSKMD9TgtrIl8y4kCtYLF/MI9UtG6WSpS6olqoALA+
        WK9q27MndfvwaBjlpKQoai+AdvQ9FeA=
X-Google-Smtp-Source: ABdhPJwf0GqXeMuvf069ia+4K761t3WoHdQsBcwLoL8W6qMg4wN6aV4vDosxrytaypeeUWe6h4hLwg==
X-Received: by 2002:a37:a707:: with SMTP id q7mr11968144qke.284.1611179895461;
        Wed, 20 Jan 2021 13:58:15 -0800 (PST)
Received: from ?IPv6:2001:470:e04d:10::123? ([2001:470:e04d:10::123])
        by smtp.gmail.com with ESMTPSA id 6sm2254809qko.3.2021.01.20.13.58.14
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 13:58:14 -0800 (PST)
From:   Rich Davis <crashvb@gmail.com>
Autocrypt: addr=crashvb@gmail.com; prefer-encrypt=mutual; keydata=
 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
To:     git@vger.kernel.org
Subject: Unable to push to local bare repository
Message-ID: <8f1df022-0e0e-2451-b32d-2d9918604ea1@gmail.com>
Date:   Wed, 20 Jan 2021 16:58:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello GIT Community,

I have a question concerning initialization of bare repositories on a
local system; what am I overlooking?

I am attempting to init a bare repository locally, then clone the bare
repository to add files, then commit and push the content back:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Start Example =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=


$ git init barerepo
Initialized empty Git repository in /tmp/am_i_crazy/barerepo/.git/
$ git clone --dissociate --no-hardlinks --no-local barerepo clonerepo
Cloning into 'clonerepo'...
warning: You appear to have cloned an empty repository.
Checking connectivity... done.
$ cd clonerepo/
$ echo "This is a test file created on $(date +%Y-%m-%d_%H:%M:%S)" >
test.txt
$ git add test.txt
$ git commit --message "Initial commit."
[master (root-commit) da5f435] Initial commit.
=C2=A01 file changed, 1 insertion(+)
=C2=A0create mode 100644 test.txt
$ git push origin master
Counting objects: 3, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 914 bytes | 0 bytes/s, done.
Total 3 (delta 0), reused 0 (delta 0)
remote: error: refusing to update checked out branch: refs/heads/master
remote: error: By default, updating the current branch in a non-bare
repository
remote: error: is denied, because it will make the index and work tree
inconsistent
remote: error: with what you pushed, and will require 'git reset --hard'
to match
remote: error: the work tree to HEAD.
remote: error:
remote: error: You can set 'receive.denyCurrentBranch' configuration
variable to
remote: error: 'ignore' or 'warn' in the remote repository to allow
pushing into
remote: error: its current branch; however, this is not recommended
unless you
remote: error: arranged to update its work tree to match what you pushed
in some
remote: error: other way.
remote: error:
remote: error: To squelch this message and still keep the default
behaviour, set
remote: error: 'receive.denyCurrentBranch' configuration variable to
'refuse'.
To /tmp/am_i_crazy/barerepo
=C2=A0! [remote rejected] master -> master (branch is currently checked o=
ut)
error: failed to push some refs to '/tmp/am_i_crazy/barerepo'
$ git version
git version 2.7.4
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D End Example =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=


=46rom what I was able to find in the man page, there is an optimization
that takes place locally when the upstream repository is on the same
system / file system; I have attempted to disable that, but I am unsure
if that is what is causing the problem. I am also curious as to why the
error message refers to the upstream repository as "non-bare"?


Thank you for your time,

Rich Davis*
*


