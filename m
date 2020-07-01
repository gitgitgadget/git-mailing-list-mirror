Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D46C433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1064020780
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbcTeTDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730985AbgGANRK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbgGANRK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 09:17:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD38BC03E979
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 06:17:09 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j4so21334639wrp.10
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 06:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:date:subject:message-id
         :to;
        bh=lGva9epjzFm7gQW9J8L2HpMvm32rlzzR49f6fAWBAiE=;
        b=QbcTeTDf4+zwLC2ulZiYHkXrk/UUHyA4WMAcYRNGqvheAJ2titGTmJQAiWcxpgj0pv
         bIf30ewm6nXy3mZRjhnY534MHuGbUZo8HtPoOcgNGftnplkSBLmvjYPsweE/Hmh4Q6KS
         oZ7MtyzE0t4ZS8pkCnqf22QvBDQnNkF2OrYbe4j43iVxTk1geerVWz/ZRPDZtYoJT9KJ
         JX3GMvrCBRL5blN9wGQpxmzTCGK+W9Ap+1h7KQ/KKAMofiLpqIrFBBPHpac/sXe8hybI
         YJRxK6hBamZCzQRseSggoEjFjZ4GaOxgQHjGHSCuswxpd7aIBDpkkp8mdx6pN7VCbOze
         yiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version:date
         :subject:message-id:to;
        bh=lGva9epjzFm7gQW9J8L2HpMvm32rlzzR49f6fAWBAiE=;
        b=oXMbqKV1VZPoOm1RVKRx6NpzW4PjQB+//qnxHisvPaXnKYUteY/rWienlhyXMK/3fz
         vBLJzaeS773LXziInjphExiMh/GeOoPE0qhVFVUOP77SanvyRFpTIgWydLeDKuRrAPWn
         U0N4wTsu1Sjwl+eCrV3Z505C0yi0I99uTQP6yXLB/c9a7KmDpiuan5Yg0zzzEtxk7hL3
         yx+jqBV0+ZMaapzhy2FcJwLEez7oNhoMQVBOPJppPa9xzeBMs4QW7hwjgGrSMyaUoFJ2
         TkhIlYoxhCf7wKOKgdUaakTVmCHkXtAbR2FIwNzAr1oWF9tfjf6kGZ6Zcq+mVQnKyPuZ
         2IwA==
X-Gm-Message-State: AOAM532CqfPUrRM9PESpE4XpcmIzvZ1apHW1cJCP9f8XB838igdlo1aK
        eWCk/2EYhDNgcHnmFcDxI5DPeWhxCds=
X-Google-Smtp-Source: ABdhPJwGCXHlgtMD5NyzdRDU7R0x7M5JZPSsMoOjge+hV4W6gVFMcUuymiRjxF1+naxujKkzkfGvQw==
X-Received: by 2002:adf:c551:: with SMTP id s17mr25757231wrf.330.1593609427679;
        Wed, 01 Jul 2020 06:17:07 -0700 (PDT)
Received: from [192.168.1.116] (2-229-250-51.ip199.fastwebnet.it. [2.229.250.51])
        by smtp.gmail.com with ESMTPSA id 92sm7848849wrr.96.2020.07.01.06.17.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 06:17:06 -0700 (PDT)
From:   Fabio Frumento <frumento.fabio@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Date:   Wed, 1 Jul 2020 15:17:05 +0200
Subject: Built Git 2.27.0 from sources on macOS Catalina fails on "make
 profile"
Message-Id: <618374D7-60E1-4942-B29F-4F2EA261996F@gmail.com>
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm trying to build Git 2.27.0 from sources on MACOS

I've got to get the build works solving missing autoconf app and gcov =
issues (clang does not need it)

now I'm struggling during the ```make profile``` step

some tests fail on ```t0410-partial-clone.sh```

```
not ok 15 - missing tree objects with --missing=3Dallow-promisor and =
--exclude-promisor-objects
#
#		rm -rf repo &&
#		test_create_repo repo &&
#		test_commit -C repo foo &&
#		test_commit -C repo bar &&
#		test_commit -C repo baz &&
#
#		promise_and_delete $(git -C repo rev-parse bar^{tree}) =
&&
#		promise_and_delete $(git -C repo rev-parse foo^{tree}) =
&&
#
#		git -C repo config core.repositoryformatversion 1 &&
#		git -C repo config extensions.partialclone "arbitrary =
string" &&
#
#		git -C repo rev-list --missing=3Dallow-promisor =
--objects HEAD >objs 2>rev_list_err &&
#		test_must_be_empty rev_list_err &&
#		# 3 commits, 3 blobs, and 1 tree
#		test_line_count =3D 7 objs &&
#
#		# Do the same for --exclude-promisor-objects, but with =
all trees gone.
#		promise_and_delete $(git -C repo rev-parse baz^{tree}) =
&&
#		git -C repo rev-list --exclude-promisor-objects =
--objects HEAD >objs 2>rev_list_err &&
#		test_must_be_empty rev_list_err &&
#		# 3 commits, no blobs or trees
#		test_line_count =3D 3 objs
#
not ok 16 - missing non-root tree object and rev-list
#
#		rm -rf repo &&
#		test_create_repo repo &&
#		mkdir repo/dir &&
#		echo foo >repo/dir/foo &&
#		git -C repo add dir/foo &&
#		git -C repo commit -m "commit dir/foo" &&
#
#		promise_and_delete $(git -C repo rev-parse HEAD:dir) &&
#
#		git -C repo config core.repositoryformatversion 1 &&
#		git -C repo config extensions.partialclone "arbitrary =
string" &&
#
#		git -C repo rev-list --missing=3Dallow-any --objects =
HEAD >objs 2>rev_list_err &&
#		test_must_be_empty rev_list_err &&
#		# 1 commit and 1 tree
#		test_line_count =3D 2 objs
#
```

I'm a little surprised as presumed, since 2.27.0 is an official release, =
all the tests should pass without any issue.

I'm not interested to get latest version using home-brew so please leave =
it out of the answers

Any idea?

How to file a bug to the Git developers?

