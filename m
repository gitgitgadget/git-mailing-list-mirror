Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C2FC3526C
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 17:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 364C22388E
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 17:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgLSRw4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 12:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbgLSRw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 12:52:56 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E5CC0617B0
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 09:52:15 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id h4so5275149qkk.4
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 09:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mpIDmXQD6lHcn7qmXP/6BRsgWcsD6TF9uk+4ivyKpC0=;
        b=s0OQzZDOzyPKlAIgMJAXOw+9mZ6Yn22NEtD2iKe6vrzOKXHZDiH///x00CDu9hDZab
         8Bpq4mjdovBFvIDJ0YFvNYQb6RISN1xrmISc/YVU+MPrWaCmRn07AwgeEL1UGqz+P8DV
         jbGD0Gp3J5JkON4KdXLQkbV5QXwrw2bEdYyOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mpIDmXQD6lHcn7qmXP/6BRsgWcsD6TF9uk+4ivyKpC0=;
        b=Cngxmq8J5kDmWDpPMP41r6cm3eBe39f/5t26ujCo73meC3TsoKbpquIWVtD1hGZO8e
         +SHwgWXcV1zGK0ziFYnClFeKXM7cCK2Xs9tmfnvYPtF2NxSRYmj8Ey6eaE2VRMnU4zQy
         AJk5lYy6PwxF15UMFTYaaukVtOTlpEKuy7l/rARO7W1ejV4vyyTQnSPQqD0yWr0YAEGf
         c/gamiw/1KjbsDcdoYmbLOnyAFhNITEN5AmDRce3Il08Zt3WvQhDcLHqBt0gKg+J8HIO
         gkRpQX+oylPyYrTn1UCsO5myH9zT0BFHJK6ODN46IJyCuPh6yeQrHJOrt5/u52MevCz6
         x30A==
X-Gm-Message-State: AOAM5317HhZB0itAfRs6u8jriwcpn/6T2Q4FI/4NNFi2qK+7UxNL4USu
        WrNrN473chE3NMmWUJhWG4ezzFFc9R4imnkuGshGAQovSLhubH74
X-Google-Smtp-Source: ABdhPJyXZv09aqRM+/B/mp/yWADZa2L7uey5riy8q1OLV2NizsiU3NbCoMVsZa7yiduh1CC7YK7MarFrJqYMJ37da3Y=
X-Received: by 2002:a05:620a:4054:: with SMTP id i20mr10816903qko.72.1608400334849;
 Sat, 19 Dec 2020 09:52:14 -0800 (PST)
MIME-Version: 1.0
References: <xmqqpn3tqugm.fsf@gitster.c.googlers.com> <3f0403b84ab06b9deb7c5c189792bebe1db586a7.1606866276.git.matheus.bernardino@usp.br>
In-Reply-To: <3f0403b84ab06b9deb7c5c189792bebe1db586a7.1606866276.git.matheus.bernardino@usp.br>
From:   Adam Dinwoodie <adam@dinwoodie.org>
Date:   Sat, 19 Dec 2020 17:51:39 +0000
Message-ID: <CA+kUOamDD_SDNLk3sPSwNAojrAAP+g38MjkfG4JMPRTGOVAKAQ@mail.gmail.com>
Subject: Re: [PATCH] apply: don't use core.sharedRepository to create working
 tree files
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit =E2=80=93 eb3c027e17 ("apply: don't use core.sharedRepository t=
o
create working tree files", 2020-12-01) =E2=80=93 seems to have introduced =
a
new test failure in the Cygwin builds for v2.30.0-rc0, and which is
still present in rc1. I'm not quite sure I understand what the
expected behaviour here is, but I expect the issue is down to Cygwin's
slightly odd file permission handling.

To my surprise, the test fails if the worktree is under "/cygdrive",
but not if it's under "/home" within the Cygwin filesystem. I expect
this is some complexity with Cygwin's mount handling, but it's not a
failure mode I've seen before. I'm also going to follow up on the
Cygwin mailing list to see if the folk with a better understanding of
Cygwin's filesystem wrangling have a better understanding of what's
going on.

Extract from the relevant section of ./t4129-apply-samemode.sh -x
output, when run with that commit checked out, below:

expecting success of 4129.10 'do not use core.sharedRepository for
working tree files':
        git reset --hard &&
        test_config core.sharedRepository 0666 &&
        (
                # Remove a default ACL if possible.
                (setfacl -k newdir 2>/dev/null || true) &&
                umask 0077 &&

                # Test both files (f1) and leading dirs (d)
                mkdir d &&
                touch f1 d/f2 &&
                git add f1 d/f2 &&
                git diff --staged >patch-f1-and-f2.txt &&

                rm -rf d f1 &&
                git apply patch-f1-and-f2.txt &&

                echo "-rw-------" >f1_mode.expected &&
                echo "drwx------" >d_mode.expected &&
                test_modebits f1 >f1_mode.actual &&
                test_modebits d >d_mode.actual &&
                test_cmp f1_mode.expected f1_mode.actual &&
                test_cmp d_mode.expected d_mode.actual
        )

++ git reset --hard
HEAD is now at e950771 initial
++ test_config core.sharedRepository 0666
++ config_dir=3D
++ test core.sharedRepository =3D -C
++ test_when_finished 'test_unconfig  '\''core.sharedRepository'\'''
++ test 0 =3D 0
++ test_cleanup=3D'{ test_unconfig  '\''core.sharedRepository'\''
                } && (exit "$eval_ret"); eval_ret=3D$?; :'
++ git config core.sharedRepository 0666
++ setfacl -k newdir
++ true
++ umask 0077
++ mkdir d
++ touch f1 d/f2
++ git add f1 d/f2
++ git diff --staged
++ rm -rf d f1
++ git apply patch-f1-and-f2.txt
++ echo -rw-------
++ echo drwx------
++ test_modebits f1
++ ls -ld f1
++ sed -e 's|^\(..........\).*|\1|'
++ test_modebits d
++ ls -ld d
++ sed -e 's|^\(..........\).*|\1|'
++ test_cmp f1_mode.expected f1_mode.actual
++ test 2 -eq 2
++ eval 'diff -u' '"$@"'
+++ diff -u f1_mode.expected f1_mode.actual
--- f1_mode.expected    2020-12-19 16:50:20.169378700 +0000
+++ f1_mode.actual      2020-12-19 16:50:20.249126000 +0000
@@ -1 +1 @@
--rw-------
+-rw-rw-r--
++ test xf1_mode.expected =3D x-
++ test -e f1_mode.expected
++ test xf1_mode.actual =3D x-
++ test -e f1_mode.actual
++ return 1
error: last command exited with $?=3D1
++ test_unconfig core.sharedRepository
++ config_dir=3D
++ test core.sharedRepository =3D -C
++ git config --unset-all core.sharedRepository
++ config_status=3D0
++ case "$config_status" in
++ return 0
++ exit 1
++ eval_ret=3D1
++ :
