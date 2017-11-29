Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EB9B20C11
	for <e@80x24.org>; Wed, 29 Nov 2017 08:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753243AbdK2IHO (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 03:07:14 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:46314 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbdK2IHM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 03:07:12 -0500
Received: by mail-it0-f42.google.com with SMTP id t1so2991292ite.5
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 00:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sourcegraph.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=BeyzVy6T0pKtuViB77sYNCVt0jh3slB76mX9Rpqtpi8=;
        b=MTUkHO5Q4YwVzi51xZy1DywOEFOUO7rQugusbRcZLobspg8/Mimk5opoT3gJx6GWJD
         C2XSNEWhFgonAwMOLqT6juPtoELIr0c7kqwTdOnGeekavLruZaPm/+Wnl7BmCvI3rUWk
         vHiTce8V5CHW/eGaR8scC/b4HJseov5FpFkoxHw1TlHY7C+75DwHRIueKcy1C3YbM9lp
         752x8sTPrAx9hdMTYjl+z+N06DsDFEARIyQQA5+QZQfhJY3/Nn9iRK8F8OVscnEIMF7c
         NZGDiy9YYRbfgYFglmXywlzL91IP7XhWIAbcICFnGqDjo9UqavRTBNRTAXzvZ4vOPNeV
         2fXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BeyzVy6T0pKtuViB77sYNCVt0jh3slB76mX9Rpqtpi8=;
        b=DNuu7HWVgspbZFsDHTFfb49iJTAxdqVMWIoQhqdhchX3mhOnXRzPGhR/5Y+cYLfSlw
         QmR96DAalN7fBVBybdHsu5q5BSK2WS+JsgqmAH/2eDVw0zfDlDAn/yjFw2WOrym/DMte
         HlgWtY04+pqhm3UwQlZrb/5hA2NAwkb3fEWM8AcX5+MwN5dL1urNlXKYoP3vyGcJceuQ
         j5Fn4pABljuZPEtVbq57SSJpQZZMywEyusqgfdJnl4wbfOSMg/dqaXx52qjsA9/akpQn
         mCYxllUnzASFJm4KJJRRFWz4YLGp9AD+I1ckoCFPljbuWisA2imcg02vR6yEWev/JGHI
         Nunw==
X-Gm-Message-State: AJaThX4DWMz+AwGJ6pvYipYJf6+849Zx4/xwGbco9tyGbHhx68dnP3nC
        UE18bopAkWr2FXA0h1eNikRIQD/M2RAOsFvwazuCsWqm87o=
X-Google-Smtp-Source: AGs4zMbeHahOOL40K4JfNHdCjx1rawW+8jl2/Mhq8jXMIb6HsvG5cuUreb8nTu5/KrtE63aZDFDOcraEkvIbpGrB+rc=
X-Received: by 10.36.181.80 with SMTP id j16mr6637434iti.118.1511942831343;
 Wed, 29 Nov 2017 00:07:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.165.7 with HTTP; Wed, 29 Nov 2017 00:06:51 -0800 (PST)
From:   Nick Snyder <nick@sourcegraph.com>
Date:   Wed, 29 Nov 2017 00:06:51 -0800
Message-ID: <CA+SQVf1W6BhNyB6bGxh7WfCwb6+E3pNjHLeS4xDYPJ6BLT8cng@mail.gmail.com>
Subject: git blame --reverse doesn't find line in HEAD
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a repo that reproduces a behavior with `git blame --reverse`
that surprises me. https://github.com/nicksnyder/git-blame-bug

The readme explains the observed behavior and what I expected to
happen. I will inline the readme at the bottom of this message for
convenience.

Am I misunderstanding --reverse or is this a bug?

Thanks!
Nick

$ git --version
git version 2.15.0

Blame of L465 in Tree.tsx at HEAD (ca0fb5) points to L463 at 199ee7

$ git blame -p -L465,465 Tree.tsx
199ee75d1240ae72cd965f62aceeb301ab64e1bd 463 465 1
filename Tree.tsx
            public shouldComponentUpdate(nextProps: TileProps): boolean {

EXPECTED: Reverse blame of L463 at 199ee7 points to L465 at the
lastest commit in the repo (at least ca0fb5).
ACTUAL: Reverse blame of L463 at 199ee7 points to L463 at 199ee7.

$ git blame -p -L463,463 --reverse 199ee7.. Tree.tsx
199ee75d1240ae72cd965f62aceeb301ab64e1bd 463 463 1
boundary
previous ca0fb5a2d61cb16909bcb06f49dd5448a26f32b1 Tree.tsx
filename Tree.tsx
            public shouldComponentUpdate(nextProps: TileProps): boolean {

The line in question is in the diff (git diff 199ee7..ca0fb5), but
that particular line is neither added nor deleted, so I don't know why
blame would think it is deleted.

Relevant hunk in diff:

@@ -452,28 +462,17 @@ export class LayerTile extends
React.Component<TileProps, {}> {
         }
     }

-    public validTokenRange(props: TileProps): boolean {
-        if (props.selectedPath === '') {
-            return true
-        }
-        const token = props.selectedPath.split('/').pop()!
-        return token >= this.first && token <= this.last
-    }
-
     public shouldComponentUpdate(nextProps: TileProps): boolean {
-        const lastValid = this.validTokenRange(this.props)
-        const nextValid = this.validTokenRange(nextProps)
-        if (!lastValid && !nextValid) {
-            // short circuit
-            return false
+        if (isEqualOrAncestor(this.props.selectedDir,
this.props.currSubpath)) {
+            return true
         }
-        if (isEqualOrAncestor(this.props.selectedDir,
this.props.currSubpath) && lastValid) {
+        if (nextProps.selectedDir === nextProps.currSubpath) {
             return true
         }
-        if (nextProps.selectedDir === nextProps.currSubpath &&
this.validTokenRange(nextProps)) {
+        if (getParentDir(nextProps.selectedDir) === nextProps.currSubpath) {
             return true
         }
-        if (getParentDir(nextProps.selectedDir) ===
nextProps.currSubpath && this.validTokenRange(nextProps)) {
+        if (!isEqual(nextProps.pathSplits, this.props.pathSplits)) {
             return true
         }
         return false
