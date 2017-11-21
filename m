Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82AE32036D
	for <e@80x24.org>; Tue, 21 Nov 2017 23:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751429AbdKUXHs (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 18:07:48 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46827 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbdKUXHr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 18:07:47 -0500
Received: by mail-lf0-f67.google.com with SMTP id g35so16024759lfi.13
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 15:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FUiZ/XIXaAc6Ka5GJXeqKBOd8R7VGKy6yylaFzHrJK0=;
        b=JA1GLqldJdljRyUZEY48159SFwc1x0sisd7Z3zgs1/nC/WIBQPecGloryc++2y4EBs
         aQQkY79tzXIWz2tpkb72w3Ky5SJ4xvX0uLkkhUv/wtEWREeKIktB67/hJjNHIQlggyhf
         jlrQ7U/UZ8jLPu0MgNEdVa2ermefjR49sClEndQpN+zH3DtYC3p7NC+12KnNdmV3IhvO
         GPTgWa9gGJ7NtpsfC4ep8iwAfSyx9YxjG5EfCAilOHZRGqGc0wjmprRzyApof2xvXazD
         M0f6T+HM5KBjE8V3mZvOJKK3AC09oOu0LE5gP02Q1jnEuolfvYP4Yo2JCUUUP95EviVy
         uxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FUiZ/XIXaAc6Ka5GJXeqKBOd8R7VGKy6yylaFzHrJK0=;
        b=cIU2fPLzpwv0l0fshfw0GhBtVE2CCBSJKMkGpIeOD7qcnmt6s7nkJFgVVXIqyGu+64
         IE2nrDlYqkhInJYArY47GSjAAhRbz9G7YNs2Wc+hk5X+ux2j5bZh2oM86GtgWumjpIhp
         PqHPN8ShCt9VLBmZ8wsWh0PbTELg0+HZ2kUEi2HcqmF9s8LKT+KyarZ+DisXLm0Mjw5q
         wVeVImwn0q/kls61sUcziuR/5JL8UayTCxe3pTE25EMh2UparEAjGQD6yHiREXCoQAJg
         QDJmrWQeVE83Px7hDDgBsYkmwK5VGSfomLfofg8X+AzOUL6hTAFejl6bVSfITRk0Qyfe
         3e3g==
X-Gm-Message-State: AJaThX5AQm+qxfyu7KadgJCj/AI9VmAmZQBe9EEnEBHd2OrCxV6JA4zK
        2TCl5DViCVDVYn1/ugKkCJj/D/iPeN7Aor6fVN+9mWbg
X-Google-Smtp-Source: AGs4zMbIeDsuBNBLkNzUp8rc+icVU7kYKFWj90WqgA4QoYsrRpZOBb7WIbW0ovS0sfUJ1tTQkuVjvm7qxykYMl/uiKU=
X-Received: by 10.46.66.69 with SMTP id p66mr1521690lja.18.1511305665498; Tue,
 21 Nov 2017 15:07:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.179.22.16 with HTTP; Tue, 21 Nov 2017 15:07:24 -0800 (PST)
From:   Phil Hord <phil.hord@gmail.com>
Date:   Tue, 21 Nov 2017 15:07:24 -0800
Message-ID: <CABURp0qadq2cAwR_Nk76J8RqpQk4DZwtnu6aS5hR=LjVD-dGgA@mail.gmail.com>
Subject: stash: learn to parse -m/--message like commit does
To:     Git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git stash push -m foo` uses "foo" as the message for the stash. But
`git stash push -m"foo"` does not parse successfully.  Similarly
`git stash push --message="My stash message"` also fails.  Nothing
in the documentation suggests this syntax should work, but it does
work for `git commit`, and my fingers have learned this pattern long
ago.

Teach `git stash` to parse -mFoo and --message=Foo the same as
`git commit` would do.

Signed-off-by: Phil Hord <phil.hord@gmail.com>
---
 git-stash.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/git-stash.sh b/git-stash.sh
index 4b7495144..1114005ce 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -76,6 +76,12 @@ create_stash () {
  shift
  stash_msg=${1?"BUG: create_stash () -m requires an argument"}
  ;;
+ -m*)
+ stash_msg=${1#-m}
+ ;;
+ --message=*)
+ stash_msg=${1#--message=}
+ ;;
  -u|--include-untracked)
  shift
  untracked=${1?"BUG: create_stash () -u requires an argument"}
@@ -193,6 +199,12 @@ store_stash () {
  shift
  stash_msg="$1"
  ;;
+ -m*)
+ stash_msg=${1#-m}
+ ;;
+ --message=*)
+ stash_msg=${1#--message=}
+ ;;
  -q|--quiet)
  quiet=t
  ;;
@@ -251,6 +263,12 @@ push_stash () {
  test -z ${1+x} && usage
  stash_msg=$1
  ;;
+ -m*)
+ stash_msg=${1#-m}
+ ;;
+ --message=*)
+ stash_msg=${1#--message=}
+ ;;
  --help)
  show_help
  ;;
-- 
2.15.0.471.g17a719cfe.dirty
