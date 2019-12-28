Return-Path: <SRS0=w8S9=2S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC33C2D0C6
	for <git@archiver.kernel.org>; Sat, 28 Dec 2019 07:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51205207E0
	for <git@archiver.kernel.org>; Sat, 28 Dec 2019 07:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfL1HUZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Dec 2019 02:20:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40279 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfL1HUY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Dec 2019 02:20:24 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so27987430wrn.7
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 23:20:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mx5brkCKvfPVtzQcGecqKzgRsazPovpgr4eIGANQLrg=;
        b=j4EIOpylZLbztYzECMwlshDlkGrflJo5F6n0tplaHhjhkAF61N6gjXQ8w7UsKZl0BQ
         B8Gd3WAJ5yvMIz6o0yeT4HmSSdbpw2vOyuS+jUXwJ3LsEIRnH+2aL6ySoRTcPvhRg8q7
         kOPXQ8eu+PsmodwWeWGJZZJILy+0yG9b9N0ZCknIEIjwq1rxMrhFB9r80nigiwdWviTU
         ymGTHLI64Kl6UlGOOnhNcAfNYOXxTBidaphAtOkDNyPkXCBvGqtl+VBbOoc214YDuEy6
         nqnfzrMbCrLt7sGzaa2ySa2V0EF6ADSWG9etRO40j5YNymRREeFbrz3FVrd4QydiYRwP
         q5Ig==
X-Gm-Message-State: APjAAAWp5oQQJThIVHdHDI2JZ7eEF3dAckH3RPboVpT102Be4hIrPhRs
        mMIdOtT31CLRMcnnt4E/Tgw7lIqOq07IUgvCebuIcA==
X-Google-Smtp-Source: APXvYqzklE4a6jOWhz1DiPYrDCEgUrljR6bbe2lqVyNU6pHcIVF80LHa74CXJNoLxP/Aao/KaXi/H37DBaHlHumhc+U=
X-Received: by 2002:a5d:528e:: with SMTP id c14mr56960393wrv.308.1577517622734;
 Fri, 27 Dec 2019 23:20:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577454401.git.liu.denton@gmail.com> <68eb05e10edf1f4b09bc4e02587ac5b15fd2c6e3.1577454401.git.liu.denton@gmail.com>
In-Reply-To: <68eb05e10edf1f4b09bc4e02587ac5b15fd2c6e3.1577454401.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 28 Dec 2019 02:20:11 -0500
Message-ID: <CAPig+cTaph9Mc1cdL6eNPnTF006YCZ14oLX+xKN9VTVYs7X2_A@mail.gmail.com>
Subject: Re: [PATCH 08/16] t3310: extract common no_notes_merge_left()
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 27, 2019 at 8:48 AM Denton Liu <liu.denton@gmail.com> wrote:
> diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
> @@ -32,6 +32,11 @@ verify_notes () {
> +no_notes_merge_left () {
> +       { ls .git/NOTES_MERGE_* >output || :; } &&
> +       test_must_be_empty output
> +}

This function name leaves me thinking that it's talking about
directionality (left vs. right) and gives insufficient clue that it's
talking about a .git/NOTES_MERGE_* file. A name such as
assert_no_notes_merge_files() or notes_merge_files_gone() would make
the intention more obvious.

> -       # No .git/NOTES_MERGE_* files left
> -       test_might_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
> -       test_must_be_empty output &&

On the other hand, the original in-code comment was not confusing,
probably because it was obvious it was talking about an actual file,
due to spelling out .git/NOTES_MERGE_* explicitly and due to actually
using the literal word "file", plus the code following the comment
made it very obvious what was happening.

These observations may not be actionable since someone actually
working on this script will know that it's dealing with
.git/NOTES_MERGES_*, but as a reviewer not familiar with this
particular script, reading the patch from top to bottom, I found the
function name confusing.
