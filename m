Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514D8C46467
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 09:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjANJoZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 04:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjANJoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 04:44:09 -0500
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6187692
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 01:43:12 -0800 (PST)
Received: by mail-pl1-f181.google.com with SMTP id d9so25754352pll.9
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 01:43:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CcnsXTrIMAM7yqYsnDGpA0B7uIfPtutHJ6APVC8XKIM=;
        b=LUDxtnbAOAut62xscTcKEWzaYfgMHdkL3eY55p2BMUqZ3WOQhH3agOvi90vgCOMzAy
         O4CLXp2xHgr3ik5HyV2Hmms1/ZuqtJMk504tMt8DnFmk7O0eou053FSZU7nsdq/zKYQI
         AhubOWqt6bRY6vA+mZ0c4ooP5V/QKOFu/ZGcyJspn2kzcDdQULBKPhwSi2mzSU5MfFD9
         XNgU8BdqYqNlzAdc0x/cXqmnWRw3vW9kIqD2JKUGvxRjmgHHaFFDgXxDQholwbkBdvBx
         SSkNOMFJ97hbuNgzF1Tr8QJJIfH0vZ/NHPtRgqnOwxoLd+zlVRBthoTUaSneNw+bg6Tu
         +9PA==
X-Gm-Message-State: AFqh2kqer5hqTNBFVG7IH6VOEGwEJAy84dnvR6PAx5vqoNwPa5TVYVay
        /QcRIrxXU5WMIpEjVS3Fnvv6oaj7kP9MpJ/QMaU=
X-Google-Smtp-Source: AMrXdXud7QQR7SeisMAIMFRh1QjH/x08styt87DVqmyQx+OjwJnc5PGzvTUeX56YBysjX/4XTEFvH410e0xHjL+4KoY=
X-Received: by 2002:a17:902:cccd:b0:191:2b33:606f with SMTP id
 z13-20020a170902cccd00b001912b33606fmr174199ple.32.1673689391821; Sat, 14 Jan
 2023 01:43:11 -0800 (PST)
MIME-Version: 1.0
References: <20230111233242.16870-1-rybak.a.v@gmail.com> <20230111233242.16870-4-rybak.a.v@gmail.com>
In-Reply-To: <20230111233242.16870-4-rybak.a.v@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 14 Jan 2023 04:43:00 -0500
Message-ID: <CAPig+cQ4k4qTE8JFryvc_DK0CAhwb7XjGhPqzMSTojeSqB4Qpw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] t7527: use test_when_finished in 'case insensitive+preserving'
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 11, 2023 at 7:00 PM Andrei Rybak <rybak.a.v@gmail.com> wrote:
> Most tests in t7527-builtin-fsmonitor.sh that start a daemon, use the
> helper function test_when_finished with stop_daemon_delete_repo.
> Function stop_daemon_delete_repo explicitly stops the daemon.  Calling
> it via test_when_finished is needed for tests that don't check daemon's
> automatic shutdown logic [1] and it is needed to avoid daemons being
> left running in case of breakage of the logic of automatic shutdown of
> the daemon.
>
> Unlike these tests, test 'case insensitive+preserving' added in [2] has
> a call to function test_when_finished commented out.  It was commented
> out in all versions of the patch [2] during development [3].  This seems
> to not be intentional, because neither commit message in [2], nor the
> comment above the test mention this line being commented out.  Compare
> it, for example, to "# unicode_debug=true" which is explicitly described
> by a documentation comment above it.
>
> Uncomment test_when_finished for stop_daemon_delete_repo in test 'case
> insensitive+preserving' to ensure that daemons are not left running in
> cases when automatic shutdown logic of daemon itself is broken.
>
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
> diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
> @@ -910,7 +910,7 @@ test_expect_success "submodule absorbgitdirs implicitly starts daemon" '
>  test_expect_success CASE_INSENSITIVE_FS 'case insensitive+preserving' '
> -#      test_when_finished "stop_daemon_delete_repo test_insensitive" &&
> +       test_when_finished "stop_daemon_delete_repo test_insensitive" &&

Nice. Thanks for working on this (and the series as a whole) in
response to a very tangential comment of mine[1] when replying to an
unrelated patch of yours.

[1]: https://lore.kernel.org/git/CAPig+cTgUPWxMox_nSka52dML6_GHUUoY4HCtcq7+7J0oEyeNw@mail.gmail.com/
