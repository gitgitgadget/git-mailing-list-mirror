Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39280C33CB2
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 01:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A532070E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 01:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="ieJp/Fv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgA3BAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 20:00:30 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:44317 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgA3BAa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 20:00:30 -0500
Received: by mail-io1-f45.google.com with SMTP id e7so1992280iof.11
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 17:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=4R/Vj912bDahBRgl7wiDkmj7qReUFFiXv/8hsLrZhSw=;
        b=ieJp/Fv0wd6RKcv0+RCahriLky0I5Mypou9PbG9zs5Mjl2gZ3xAjkxY0NwggeMCeci
         QMMZCsRKVH/+f99xW6XjOqx2BO2CcMxd9OEIJxwaRb4oZkm1wQXvot2sEprs03DJWg08
         du3xrr/oLi+FDPyyNlpRsU2DuCMCc8lYflfDsZSFj5TgZF4d7UoapjvSlspUdjzkfWDY
         IsKACul2zLD1Uzh21z95/nChWne5wiGs6QqyTB7ZAm1luOlFGSn/L2WPh6RkYIGaMQjR
         GyUFtZ7Ye8jqxkQ2NR1jAS7dELCuihGUSdnYaXXrNhsd6GZdlA5KK23ucOVOedAxhF2A
         xahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4R/Vj912bDahBRgl7wiDkmj7qReUFFiXv/8hsLrZhSw=;
        b=Z/6ZESep3m3zCObumr+9OlqvorD2O6ek5Azz9lD9euVQ1JJWzHLwfs9xOA/1CFi654
         1l+oZG6RRYLlkU6f3iRoOfvDSk5hQUJed2J//yklVAbC+RPumDffxRe2znWH81eEZHv3
         +7/L/lxZOPgIP5IM9KSHigvuJF1OuxXjskbFGV7xmF/giwZGa0jW7PXw7eCgKHjoNZjK
         4GyulRHoModlpAy9vt95B/rCjRztDddDSeHBchp4Risj7IHWH2Z3mkkWNkPGWk5hJVVc
         Q5u8ssuYlzRRE7ho2aBcwrRktSbMmF3sZiENXv1Bc4XBjWI30MWNszjWSQy2oskvYgdV
         rudQ==
X-Gm-Message-State: APjAAAXuR56C+zYfkwADtlfyPB1RaOU/vDieQ+HHueyNXEQJvYU123I0
        im/MFF5HE6IfMvU42Hs4JGvuRzssXpOOOsmZRGrZVLtz
X-Google-Smtp-Source: APXvYqyzBBmnJYeMz7YdADk0xKFaBowz+CcD/o8WNHcDcVHYmCprVhPH78h273P3GuAVsS5rz/0u2Ng+8vBEKhhqMYE=
X-Received: by 2002:a02:b602:: with SMTP id h2mr1755425jam.20.1580346029551;
 Wed, 29 Jan 2020 17:00:29 -0800 (PST)
MIME-Version: 1.0
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 29 Jan 2020 17:00:18 -0800
Message-ID: <CAGyf7-E==gzsvP-ckK0kwHD+f9pMmLBVpL4y2rC9tqk7ZiuW1g@mail.gmail.com>
Subject: packObjectsHook and the git executable
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In upload-pack.c, when Git invokes the packObjectsHook, it's
hard-coded to pass "git". Unless it modifies the PATH environment
variable, though, if the script were to invoke the provided command
line as-is, it may end up running a different version of Git than the
version being used to run upload-pack (or http-backend).

Is there any way the packObjectsHook could be passed the "right" git
executable? Or am I missing some surrounding context that means
executing "git" is somehow guaranteed to invoke the "right" binary?
(Perhaps this same PATH-related caveat applies to other places where
Git invokes itself recursively?)

Grateful for any insight!
Bryan
