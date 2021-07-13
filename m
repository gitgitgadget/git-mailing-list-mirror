Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B460DC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 19:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94D0B61353
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 19:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbhGMTg4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 15:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbhGMTgz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 15:36:55 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F228BC0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 12:34:03 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id w2so8604979qvh.13
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 12:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=CXeFMFJSm0JooFVxu3dKf3oLxfvzcw1tznMZDCpPkdo=;
        b=SK7IO/tzaMjZOgOFfSRc3SzJ0/Dxps0z0rT1m/zrocTrA6lwWC0VFM483NXcufMbEk
         BOFTSMGUZaF+3K5ycaisPQw3sU3yqvbRrahiyy7y5WNeJ9uS9qrxNJxjaJ6aCox/HfL4
         +4ojuWsGB+v/xG4q45sPaKAOxvnvzWTKy5JQEWCD9ZSbXC03wzBOnDSPuqa3glBmAdk5
         D5SzCkH6kYMDlp8LW/Fx6I3/LvrHqY1hs/mww7Ch2/U1LeSzW4rBn2U6H7mGC4l5SSYJ
         JJWV0KtJQYZjF5AJK4MpoJyJ7tn3sNM+vi5uDTO7AGXbhIliMFWQp5n5XcOKaXfx0XfB
         08BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=CXeFMFJSm0JooFVxu3dKf3oLxfvzcw1tznMZDCpPkdo=;
        b=ABH3izJg3bDkHzP6IS8qNCbjTwoEe5y2MEbXF8ZSPNEag6K4CS1H4tJ95fGF4AuOLx
         2DnjfuWaVRFNOvhLXIbq0Pqjssx4ksucUgtp7+npNGrYMr1c9Qxs0RKSEEuqsrUfS4MJ
         GUWV3veNCYPm4mw/1puSorN+nVV3S/M3jy2197WSzWoGQOPikR/W9wfBikV0m0HtmKTr
         0AkVU60yoLOtE/i7U9JIkEVvKN40gdmsCCeKJRoRkMoySKwnVvkApX6XKjY2auXD938u
         tY3mQ022xHlFiVIQ5d7nT9I7UnGBR6UZJv+wKKGmsFXdeQYSvb9qBApliwaDpm7AiEwn
         oA1w==
X-Gm-Message-State: AOAM530SdPdoStSn3+9GJ33COqZBQySrQc+YNtMtD8zZAWQ1Kyr4tLrl
        Sa+4hvp1C0MSAI0S8f9OjUxcJ2xzDlpgjw==
X-Google-Smtp-Source: ABdhPJzyl4d+vqN0YyvMM5/cDKn1p/SsZ7KQgz9zzxQycXsWbLkKjStrnMLqvbzJrI1LCnMmQn03wQ==
X-Received: by 2002:a0c:d805:: with SMTP id h5mr6425618qvj.53.1626204842922;
        Tue, 13 Jul 2021 12:34:02 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id u4sm8843910qkb.99.2021.07.13.12.34.02
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 12:34:02 -0700 (PDT)
To:     Git mailing list <git@vger.kernel.org>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Confusing interaction between 'rebase -i' and 'commit.verbose' when
 squashing commits
Message-ID: <9515534e-705a-ad1c-a1ac-704b2d565f37@gmail.com>
Date:   Tue, 13 Jul 2021 15:34:01 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I encountered a situation when I did an interactive rebase and
changed two 'picks' to 'squash', without re-ordering anything.
I have 'commit.verbose' set in my config.

When I then saved the todo list to start the rebase, it opened my
editor to edit the message for the squashed commit. The message shown
in the editor is as expected (the messages from the three commits are shown),
but the diff below the scissors line, due to commit.verbose,
corresponds to the squashed changes only from the
*first two commits* (the 'pick' and the first 'squash'); the changes
from the second 'squash' are missing.

Running 'git diff --cached'
in a second shell shows that those changes (the ones from the second 'squash')
are correctly staged. HEAD points to a commit that has the changes from
the 'pick' and the first 'squash', and as commit message the message I'm
seeing in my editor.

This is rather confusing.

I do not have a quick reproducer unfortunately and I'm in a bit of a rush,
but I thought I'd just send this in case anyone notices quickly why this
happens just by reading the code (I would think somewhere in 'sequencer.c').

Cheers,

Philippe.
