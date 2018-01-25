Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B6341F404
	for <e@80x24.org>; Thu, 25 Jan 2018 12:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751958AbeAYMOa (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 07:14:30 -0500
Received: from mail-ot0-f176.google.com ([74.125.82.176]:43790 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbeAYMO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 07:14:29 -0500
Received: by mail-ot0-f176.google.com with SMTP id p36so6516558otd.10
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 04:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=I0qKULxL84nOusuq9oLqzBcYW1MNwus/S3rl1mqvwDs=;
        b=bKj/Ndbo9kjlx4GEpslWjQxJ9UujvIuDx9aqh9P2Jp4BgJpO8Lto80e4ryyB38fNFU
         G/C/A1vMW10CX0YBOk9UfzWzln2iPb/yA7ORfd1+uLUCbFOESSbfOjM63mF1SkY6gAfK
         e9mHgmoxMP24SV/4ghpSvZPdsP3xngACKJXYT0EozFzMRje3WAhykWdi/wWd61mrFBoY
         sWNBQ5CEjIyWRMYpliAVjPkW7Jo6mP7GkzqcuN6O0A2Wee2EapUcEtQk29tRoWfUJa8v
         yTtQQ0xs4wttays9bwXecth2diftQi8XhxdZl2PiLZeZhI+ro7sRhed2whJ1MCUXdr22
         e7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=I0qKULxL84nOusuq9oLqzBcYW1MNwus/S3rl1mqvwDs=;
        b=bPjU41TdG5X2LwNsaqKGTjxz77TTDPIWA6O3pSD36Uj3cm3Vt4L4HwdiejAOHEMxhy
         /uUQsYR0ACDVqG7wv67RpgTJFZTlr2f8kMXGHUqa63J84pi3g8f+GRhhUdG4r2Gm8O5F
         7O4txJHAFJkyIY0QsouqHRXeG+iz2WQM5le28CznYwXgwRIPryiCCu73bnH7EjL7qH1X
         9bIUZrJJuXzq/xMIACLJX7K6eCiYDAKDyqlnMgUyIBOeWG+/xySMUITD0qg/VTJ6oRrt
         mPuJXzE2YujQKc93wHHwNAouqVvjigEuKoedheBa5oWho67d5QZDshbxg1bw7htjENXW
         vMbg==
X-Gm-Message-State: AKwxytdE/N79att1qcdcyNbvtj4jy+i54IHgkHO6TrjgdTc9XIKbjW4p
        d+czXZokgMXL9hah7PBc+xxtbR91AONmmrsztLM=
X-Google-Smtp-Source: AH8x225mvOcmDWUpRCD231F/0gcUmoX+jZmnQcbV5YkZcV5xJl74/0dPk66biSKAgN0uFpvjITM3d23gZFkA8IOJ3Kc=
X-Received: by 10.157.53.12 with SMTP id o12mr11355410otc.181.1516882468948;
 Thu, 25 Jan 2018 04:14:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.144.218 with HTTP; Thu, 25 Jan 2018 04:13:58 -0800 (PST)
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 25 Jan 2018 19:13:58 +0700
Message-ID: <CACsJy8Dzh5E8JUDkwFmYTwS6KgqGc_1rJBVsDCoC9EpcSShN2Q@mail.gmail.com>
Subject: Bug, git rebase -i does not abort correctly
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rebase scripts are too much for me, so I'll play the user reporting
bugs this time :)

Instead of doing

    $ git rebase -i --onto origin/master @~3

I sometimes accidentally type

    $ git rebase -i origin/master @~3

("rebase -i" is actually an alias, which is why I never forget to type -i)

Usually the todo list in $EDITOR shows noop, I realize my mistake and
try to abort it by clearing the todo list before saving and closing
$EDITOR. The problem is, HEAD is moved away anyway (to origin/master I
think) even if rebase is supposed to abort the operation and leave
HEAD untouched.
-- 
Duy
