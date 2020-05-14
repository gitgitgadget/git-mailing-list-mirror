Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADB1C433DF
	for <git@archiver.kernel.org>; Thu, 14 May 2020 20:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9570720675
	for <git@archiver.kernel.org>; Thu, 14 May 2020 20:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfcy050+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgENUZX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 16:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725975AbgENUZX (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 May 2020 16:25:23 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCEBC061A0C
        for <git@vger.kernel.org>; Thu, 14 May 2020 13:25:22 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id a9so3752954lfb.8
        for <git@vger.kernel.org>; Thu, 14 May 2020 13:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=L9C7Pl4p10kjq+UzHlyT0KwBNUAB4tSM9yDdUK3nLuk=;
        b=jfcy050+nt72VS3AW0RSDZjqiCSUvwshlLn5K2KNDx+CjUdVYjJyDqYViRwgE+Sh1D
         bIamZVEJqyqU0Sp1Fbdz2A5cIzbHzN3m21u6JOudjCaCGgwxkCbEc6eho9hyE8GcWOVw
         FykOMFmQ6OmLLk0VMYV986UWinCIUoeN6WWvakB6faUZW0tBTJ3WVoMVPiSJuIP2o1aG
         9JhGma18JHD6Bmp6GyP3v44eR9WXBpqfir2wMiU9fcRXmrHWngQ3yl5uwtsYcM3mEi6s
         XCAsl2aFxQ7kYjhw+0GRKxUb6H6V5C/anKPlKCJlivztlG7B9Ig+lIUhJ0xpmt2zuYm2
         rwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=L9C7Pl4p10kjq+UzHlyT0KwBNUAB4tSM9yDdUK3nLuk=;
        b=bGsaYygp1xrS+aCS9etKtFU+JbSZ4K2O9g9UFWNlUpc+RYiFnMtKoPwfcEi5vge/Ji
         zKHHbhhOlm9XFx6XSoFPsZCe601ZjLF8amnoaoC/j2Eae+xfnvt5C7CdBadZ43JZSaiH
         SitH2F+zK5EKxpofWF8Pn10MqWfzL9RXWm044/qexXlRGNJSSRAEXMrrj8Q4jugiQuVT
         xx4xVKWi+BhZ9AIq6zddl3+asHRI64Yy3pu1jFjrh113mF1Bg0trbzp68hzsSejJ4BBN
         1L5jmOj8oID2qs8/5Wv375ZA0VO16JrwUvN8cx9bbIF6eE3OOyVYu8Zv1LFUB2uD1GHU
         8Nog==
X-Gm-Message-State: AOAM533vmYVGPR7V5f1MQ5BgG6lLXbPw44cl+UvtfkOeRTeM9wQPBCd4
        bxzDL/tCBvUuvuX7RTZoizmEf3g7R7RXd//oEjhJPeBw
X-Google-Smtp-Source: ABdhPJz1ch3VpG/U7FVFBtHyhlQzXkhgRVn277tvMgSFvIjpk+yf88EGaIW/A61Ow7Mgd/dr4EohKOGhCwy/lzMPUP8=
X-Received: by 2002:ac2:51b4:: with SMTP id f20mr4447783lfk.45.1589487921049;
 Thu, 14 May 2020 13:25:21 -0700 (PDT)
MIME-Version: 1.0
From:   John Carlissi <johncarlissi@gmail.com>
Date:   Thu, 14 May 2020 16:25:10 -0400
Message-ID: <CAGa9yXqOY0onB4cg4rjCY+RCL7qqxtYDBT+B9DoJ3nwpKh5_Hg@mail.gmail.com>
Subject: Git stable releases
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed that with 2.16.6 development stopped whereas with the latest
security update, everything 2.17 and newer got the fix. Is there any
formal definition as to when a minor version is EOL and no longer gets
security updates?
Thanks!
