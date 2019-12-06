Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D67C43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 20:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1502075C
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 20:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfQ/u+pv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfLFUP4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 15:15:56 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:42895 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfLFUPz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 15:15:55 -0500
Received: by mail-pg1-f180.google.com with SMTP id i5so3838106pgj.9
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 12:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=eMcaRjNYwh6EKPj9VvohbXS3J/Gaa91EwhDGdKRNvdg=;
        b=rfQ/u+pvBXmeSBKKUJ+fWQmcA3lxvJ6nm+AtN8i8PqnTWusqsXcbfUeIb+r6jj1D3x
         Nacw9wDbCAud1gC2ePAOfykYorMdVM1XgGz3RG1IY/IdU3xXKwN2F3pZw2pi/9ehvmvk
         OpLbY/hkdp/C6jmnOha6JJuu86dSvAIbCO430p93ZUdPM/xZpiK91ISwCy20R3BBd1JI
         GwMnPHgiKaGtXcGLUaETWoy4upbDmDi5IA7S8XQUcQ8GpeLWNKY6rJnO+4rRFQ6S/6WF
         gOB9pgyRUWA3apksK4F8hqYAt8TWfKWdrgHup/5jrbPD6ztGxuYMGzXvi76qhGAjRa0i
         EB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eMcaRjNYwh6EKPj9VvohbXS3J/Gaa91EwhDGdKRNvdg=;
        b=KF7gBRKsfRTFMfEuw7BJkkyfnE2aRpW6maY8gXj4ErgVfrYtvXAemal9Coxu86MHK5
         xvNwiC3dUCNRqIzNceN3qalgtBDI59OnrS5Rj3apvKVkg5UkG3rZXgBmzPZnvSJCKlS5
         H70dKP0rVBB1h1fxIY+i6he3vpWBYsfHooNTxUzcqLI7Zkc25sJcklEY0bDZHh72jl67
         aZIjJAQfG27NDwI+M7wFLUJl8WtLIf/N4WqeHkTFB4IXXAyrQqx+I74BfSSrUTk7qT9q
         oCDAaYT8KXgjK8JjbUSidoJRWcEiZ94l6n2iUiLHMQmZya1u63WKnyatmNQeTHErSaom
         x6MA==
X-Gm-Message-State: APjAAAVTJ4gYMfhsujCvTYoCzFKG08bRli2Y2bH06QqdIejWF6E912dz
        e/3kyfP9XdggSYyQDjwRysesrn9k
X-Google-Smtp-Source: APXvYqyDtbdM1PlhVRYWyIivqEPongDWyz9+0M/zyVXIcFlMK5BQih/JUDSCvowHZcnRSC5du9HUKQ==
X-Received: by 2002:a63:101:: with SMTP id 1mr5435565pgb.336.1575663354708;
        Fri, 06 Dec 2019 12:15:54 -0800 (PST)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id 73sm16081070pgc.13.2019.12.06.12.15.52
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 12:15:53 -0800 (PST)
Date:   Fri, 6 Dec 2019 12:16:17 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/3] cleanup for 'dl/range-diff-with-notes'
Message-ID: <cover.1575663345.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series performs some small polishing touches for the
'dl/range-diff-with-notes' topic. Notably, we fix an incorrect test case
name but we also perform some nit-picky cleanup for the range-diff code.

Denton Liu (3):
  t3206: fix incorrect test name
  range-diff: mark pointers as const
  range-diff: clear `other_arg` at end of function

 builtin/range-diff.c  | 1 +
 range-diff.c          | 6 +++---
 range-diff.h          | 4 ++--
 t/t3206-range-diff.sh | 2 +-
 4 files changed, 7 insertions(+), 6 deletions(-)

-- 
2.24.0.612.g9b7bad38f5

