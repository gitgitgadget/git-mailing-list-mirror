Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F0DC35673
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 00:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6E720836
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 00:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKXIUr0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgBXAoz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 19:44:55 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:33838 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgBXAoz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 19:44:55 -0500
Received: by mail-oi1-f182.google.com with SMTP id l136so7422446oig.1
        for <git@vger.kernel.org>; Sun, 23 Feb 2020 16:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=hKDWwUfEQcASrlKRw3vzh5KczLrn3S9SbTYYP0mD5tc=;
        b=sKXIUr0/gZ+FqAdyx3boJVPw1FRzUHKfOv2nrtYmaF8o6nUds7Tewk0u2bBUewFmrO
         Pnylcp/79vi9A+5tri8D/lbRfFsq4M0MF/QwZeo3QTY3jpTKGW+5WvVZo+c3DCtoLjq1
         5IF7RAj7Tp/lh7o6o+cg7OblOAWqWsQwCGzSZuxMenWqGIL0tXNlvbZd1PlAFYxd4tgB
         aQQy8uabbx86WE9mmYlziQZNK0rkThk8VYtOVU6CoxZQJWtgWJf8hcNyNSoMDFq4LgU4
         nuYFhYDR3yCHXi7+7RNU/U6F419PYZ1SLLOBVXtorDRiXgqGbtfd7jWi5n4GD4XdJiXf
         Xlxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=hKDWwUfEQcASrlKRw3vzh5KczLrn3S9SbTYYP0mD5tc=;
        b=BjBryLQSYX5Ced/I7ag3NKidXyx7vlWePDfKFQdnMqyzjKtu2UIQd/4oBaBinPfyXa
         P3AG9Dzo/miftD/8WxMHjxYk7WQ/BFKh8m8ydd5jr308tRXhXXbnPvlyBTmKQlpwgMn/
         c28OIxdV+DnEfwhtYFm+bGq21AwNytuTEYu1RE0HowfhL2OTzWDxdodOYxhl/xqeroLV
         Xl/KeP8GKAeLs7OcinhR+ffHSvVD+oOmuiNb7qWTKsWbmb83Z8wZFP+4Po4qFWaKvh/O
         8QroMmAmVRwHuWUk5YJ/4envH2+o/4yNeqzKsJHIR8CpvWeZKDWSEFIlRj71mrSSRl1j
         N1xQ==
X-Gm-Message-State: APjAAAUEVlwQQi7d0xVuIp6kFVddP0kl0iS8lEQgdIAgoaBrONmyTqgH
        o3BzUmPx/CjqoA9g2U0AJXYKQP7cJxqnKfx9djrO7byA5uQ=
X-Google-Smtp-Source: APXvYqxoXqect82n24iTKMZ57a2H2e2offnTiloN9WikTNe19mTbIfo0pZ9RfX14dHjQi/8KoeAElBq5geZVwcrvxFI=
X-Received: by 2002:aca:ef54:: with SMTP id n81mr11225042oih.86.1582505094160;
 Sun, 23 Feb 2020 16:44:54 -0800 (PST)
MIME-Version: 1.0
Reply-To: timothee.cour2@gmail.com
From:   Timothee Cour <thelastmammoth@gmail.com>
Date:   Sun, 23 Feb 2020 16:44:28 -0800
Message-ID: <CANri+EzQZLg2djKvLxbPWh_8fr8oEqvaFF5BB1eAMCOYuB+4_w@mail.gmail.com>
Subject: `git diff` fails to detect large re-indented blocks even with --color-moved-ws=allow-indentation-change
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

see https://github.com/timotheecour/Nim/pull/37 for a self-contained
minimal example

the actual diff contains a single large re-indented block (re-indented
by 2 spaces); and a single re-indented line within that large block:
## * getTempDir proc <#getTempDir>_

none of the tools I know of helps viewing the diff in this case:

* problem 1: https://github.com/timotheecour/Nim/pull/37/files?w=1
completely ignores the re-indented single line within the block
* problem 2: https://github.com/timotheecour/Nim/pull/37/files shows a
large complex diff composed of multiple diff blocks, hard to spot
whether code was changed or whether it's just re-indent
* git diff --color-moved-ws=allow-indentation-change --color-moved=blocks HEAD^
this suffers from problem 1 and problem 2: the diff is complex and
shows multiple blocks
* git diff --color-moved-ws=allow-indentation-change --color-moved
HEAD^ does not suffer from problem 1 but suffers from problem 2: the
diff is complex and shows multiple blocks; see comment below

* even without reasoning about moved code (eg `--color-moved`), there
is no `git diff` option I know of that correctly identifies blocks of
text that were merely re-indented UNIFORMLY.

I've show the `git diff` output in that PR.  It makes it really hard
to review diffs that are composed of essentially re-indentation; and
to identify deviations from uniform re-indentation within re-indented
blocks. Uniform re-indentation is important for correctness in
whitespace sensitive languages such as python, nim, where a spurious
re-indentation could introduce a subtle behavior change; this should
be visible, not ignored.

## expected git diff output
perhaps an option `--color-moved-ws=smart-indentation-change` should
be introduced which would group code by uniform re-indentation level,
and would show how much each block was re-indented by (positive or
negative). In example from that PR, it should show a large re-indented
block in 1 color, and show in another color the re-indented single
line


(ref: D20200223T154500)
