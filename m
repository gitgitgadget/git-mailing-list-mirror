Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D018EC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 06:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0C28610CB
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 06:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239112AbhHZGyb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 02:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbhHZGyb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 02:54:31 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1597EC061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 23:53:44 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i28so4632975lfl.2
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 23:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=WMUsriBZT4M91ahPnTrj/ducYdct4VY9kbMaxTvy3AQ=;
        b=LSJREv3dYkY2vtNKAb3jTMWO7iVxe4voWueCWi3p8/Tl9GvrKMOWyYfnYVWt8+rIfc
         JLzuv2/J0yhnvdCyo5LwfqhXgWceBSXonbxVQ6Pzpy0yH5S/PUx3c9/z6FN8AVoSUKg0
         ltgL0UfVmqFkJolhFhqNQoUIwf8rbdjcapm3Csf2j7b8j8x9/jX8oImM519mTgnCbEKq
         RvfomA/w13KvMx9igakbr/0KdaA8MHumooD+bGyMiz6zEpQXNBOFidHuOVTzJRsmdL0s
         Kjfb7MozLz25A7dCfpf+Lh7JhQtxnchSE2iuC8p6IdjKD0zjHKHDiGAjOnNcn76da23M
         rVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WMUsriBZT4M91ahPnTrj/ducYdct4VY9kbMaxTvy3AQ=;
        b=BtLELD698Aiwjl5Hf5u71A7uvljcpptvVzQuzrzJCmcSIC7cYi+jGdTMN1Ae37wWCk
         df0cElN8p8UuOttVQvzY7RropVGV7Dr9JIc2kVqegmZLT9quJtTgFUs0pOtUbW+BUVhb
         stUX2D+EKZ+19pkMTjOELnUUqj9tG54ERTQSXyQlF+CEni1SOaHeP+C+yC1mr37Po8A5
         n70BT3yc9wC6FsdtzGYxAz3AQRXwF2vIyKrldiN1O53LT1UZGwQs/GTzpDpa6bvnLTen
         9KDm0Ewld9NCGI85NiRpC0N/BmM4grlUsHlhPYOxPSL2kWYrW/08XIR97ryPG2+9mwgR
         7yPA==
X-Gm-Message-State: AOAM531lZEf929aytYY1U4ht8pWF3PxlGRuOV98s6NvNe8bCTNbbMHTc
        s6/CDm8LZp8CEjT8C/MYbo3Sh7Ao12qm4hf59Hblhj7i26EWrg==
X-Google-Smtp-Source: ABdhPJyOgJNpUjs78J1vRlLSbadEpR8vGLKifnW6o6WhkVHNdQRPpPeuei+DuBM7YMjtLhp+/w7Czt7H4JACChOQUHo=
X-Received: by 2002:a05:6512:314b:: with SMTP id s11mr1683394lfi.442.1629960822058;
 Wed, 25 Aug 2021 23:53:42 -0700 (PDT)
MIME-Version: 1.0
From:   Stefan Hoffmeister <stefan.hoffmeister@gmail.com>
Date:   Thu, 26 Aug 2021 08:53:31 +0200
Message-ID: <CALhB_QNZJtUoSEE==xBoX3cTxE4duB+QqsSzuyeY7JFMh7sKhQ@mail.gmail.com>
Subject: BUG: git diff --name-only ignores --ignore-*
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using the --name-only option on git diff (git 2.33.0),
command-line parameters such as  --ignore-blank-lines are not
respected.

Instead, git diff behaves as if these options were not specified at all.

This is either an implementation defect, or a documentation defect,
because that (IMHO surprising) behaviour is not spelled out in
https://git-scm.com/docs/git-diff.

IMHO, this is an implementation defect, as --ignore-* is orthogonal to
--name-only. I would like to use --name-only to identify the set of
files which have only(!) --ignore-* changes (by intersecting the set
of files returned by git diff with, and without --ignore-*).

The bash script below reproduces this for --ignore-blank-lines; the
same would extend to the other --ignore-* options as well.

****************************
#!/usr/bin/env bash

set -e

GIT_REPO=repo
TEST_FILE=the_file.txt

rm -rf ./${GIT_REPO}
mkdir ${GIT_REPO}
pushd ${GIT_REPO}

git init --initial-branch=main
git config user.name "myuser"
git config user.email "myuser@example.com"

cat << EOF > ${TEST_FILE}
Hello world.
EOF

git add -A
git commit -m"Initial commit"

# add empty lines
cat << EOF >> ${TEST_FILE}


EOF

without_name_only=$(git diff --ignore-blank-lines)
echo "----
Without --name-only:
${without_name_only}"

with_name_only=$(git diff --ignore-blank-lines --name-only)
echo "----
With --name-only:
${with_name_only}"

if [[ ${without_name_only} != ${with_name_only} ]] ; then
    echo "
fail: expected same data returned
"
    exit 1
else
    echo "
pass: all good
"
    exit 0
fi
