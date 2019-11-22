Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA6DC432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 23:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7E820704
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 23:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CniM/dcb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfKVXKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 18:10:37 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]:35976 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKVXKh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 18:10:37 -0500
Received: by mail-qk1-f180.google.com with SMTP id d13so7804610qko.3
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 15:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=EKl5OqkTn+WnP19wdgMwpa0yWfSCQtkH8K34bK5wLBs=;
        b=CniM/dcbjFHjG0kkE0ZJ+L/rpeBB2P0D7YW2KG+Ke50NDdG9DqWJcfZANRWVVFtlr1
         Zj0IrQ4TvkxkikPNJsjs9dMHxoaJ+QDgQa3nDHsKiZMtHYLYd1e2omTJ1wItzRNfQB/+
         PLcFZ1MC0ALPkURc7NxNyRHhd79F0u2K7fbjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=EKl5OqkTn+WnP19wdgMwpa0yWfSCQtkH8K34bK5wLBs=;
        b=E768aQubsnBoBrIJ5ahPfhjj09UCy237/5INfYMoVcO4EXBSgp5GS3V1vIfgbdG5lN
         JHFqp50e5WBs6fO1B7l4j47wWY/97RHdarzhWa54kLZYy7l+Ot4NWOF3ok3D6OrChcXE
         p94raIunSkf1eDjVhqikJBvplCRzLOZADgz34F4wkTEMDzQWhE3NScjct+3SPC62VeCx
         JWsw/efNnMbxQZVyfrJ3+woEqPyCpqY9mnPGjkiHcKzAAlQpiw8B/e5LWKWknETJWh9A
         +y2ykaaOOvKH0xi9gnnkKklowq050B3odI/3tasqqfajQc0ZMmXpCGj2VwwByITze/9z
         o24w==
X-Gm-Message-State: APjAAAWjOHpiHBC0qXn26M5nV0o/35B4WrwsC5IJOVmvReK/rnKVxKdO
        cKps/sytHKj867tmqVJ58dUl+pla7u0=
X-Google-Smtp-Source: APXvYqzBfBhrbX1vfN2G7+ANhJ4EDOddL24xbOQp/rUekwBsONHjxZQpBuyZalv/PmbBkfw8Y4OTuQ==
X-Received: by 2002:a37:650c:: with SMTP id z12mr15843755qkb.130.1574464234576;
        Fri, 22 Nov 2019 15:10:34 -0800 (PST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com. [209.85.222.179])
        by smtp.gmail.com with ESMTPSA id 8sm3690529qkr.29.2019.11.22.15.10.32
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2019 15:10:33 -0800 (PST)
Received: by mail-qk1-f179.google.com with SMTP id c124so3364897qkg.0
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 15:10:32 -0800 (PST)
X-Received: by 2002:a05:620a:2043:: with SMTP id d3mr1370990qka.279.1574464231683;
 Fri, 22 Nov 2019 15:10:31 -0800 (PST)
MIME-Version: 1.0
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 22 Nov 2019 15:10:20 -0800
X-Gmail-Original-Message-ID: <CA+ASDXNQ+9i-6uCNDwN46cnHJeciiqQSX5Z6EaqB9pbseQhVFw@mail.gmail.com>
Message-ID: <CA+ASDXNQ+9i-6uCNDwN46cnHJeciiqQSX5Z6EaqB9pbseQhVFw@mail.gmail.com>
Subject: git 2.24: git revert <commit1> <commit2> requires extra '--continue'?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi! I'm using git 2.24 (or, a variant of that packaged my distro -- I
can try to build my own if this is deemed not reproducible), and I
feel like I've been seeing a regression here:

Previously, when reverting multiple commits (with the default --edit
behavior), as soon as I'm done editing the first revert commit
message, the second revert commit pops up an editor, and I'm on my
way. Now, it seems to require an extra 'git revert --continue' prompt
in between, yet it doesn't actually recommend that. This is highly
confusing, and seemingly unnecessary.

An annotated transcript provided below.

Note that none of this happens with --no-edit; my reverts happen
smoothly, with no extra need for --continue.

Regards,
Brian

$ mkdir tmp
$ cd tmp
/tmp$ git init
Initialized empty Git repository in [...]/tmp/.git/
/tmp$ touch foo
/tmp$ git add foo
/tmp$ echo bar >> foo
/tmp$ git commit -am baz
[master (root-commit) a388f78d9013] baz
 1 file changed, 1 insertion(+)
 create mode 100644 foo
/tmp$ echo pow >> foo
/tmp$ git commit -am whizzbang
[master 51753222dd9a] whizzbang
 1 file changed, 1 insertion(+)
/tmp$ echo pop >> foo
/tmp$ git commit -am nothing
[master 7153607b11e0] nothing
 1 file changed, 1 insertion(+)
/tmp$ git revert HEAD HEAD^
## EDITOR pops up, as expected
[master 586469974ec2] Revert "nothing"
 1 file changed, 1 deletion(-)
On branch master
Revert currently in progress.

nothing to commit, working tree clean
## Unexpected, confusing pause? No prompt to '--continue'
/tmp$ git log --oneline
586469974ec2 (HEAD -> master) Revert "nothing"
7153607b11e0 nothing
51753222dd9a whizzbang
a388f78d9013 baz
/tmp$ git status
On branch master
Revert currently in progress.
  (run "git revert --continue" to continue)
  (use "git revert --skip" to skip this patch)
  (use "git revert --abort" to cancel the revert operation)

nothing to commit, working tree clean
/tmp$ git revert --continue
## EDITOR pops up, as expected
[master b8dd23f61d07] Revert "whizzbang"
 1 file changed, 1 deletion(-)
On branch master
Revert currently in progress.

nothing to commit, working tree clean
## Unexpected state; both reverts happened, but revert is still in progress?
/tmp$ git log --oneline
b8dd23f61d07 (HEAD -> master) Revert "whizzbang"
586469974ec2 Revert "nothing"
7153607b11e0 nothing
51753222dd9a whizzbang
a388f78d9013 baz
/tmp$ git status
On branch master
Revert currently in progress.
  (run "git revert --continue" to continue)
  (use "git revert --skip" to skip this patch)
  (use "git revert --abort" to cancel the revert operation)

nothing to commit, working tree clean
## OK...I'll run it one more time.
/tmp$ git revert --continue
/tmp$ git status
On branch master
nothing to commit, working tree clean
## *Now* I'm done
/tmp$ git log --oneline
b8dd23f61d07 (HEAD -> master) Revert "whizzbang"
586469974ec2 Revert "nothing"
7153607b11e0 nothing
51753222dd9a whizzbang
a388f78d9013 baz
