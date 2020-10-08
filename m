Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219C5C433E7
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 19:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCB522184D
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 19:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9zZBKrf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbgJHTMz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 15:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgJHTMz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 15:12:55 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505A4C061755
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 12:12:55 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p15so7547305wmi.4
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 12:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FfRaG/pRbAEXezZrb2QHPfUsVGu4WjVwJR3upN/P+tA=;
        b=i9zZBKrfnm/NH1viCFtioeugXzhvASpqk2iQRdVdkLx9FUJMvGWsvzex3UQtk857e3
         YkRnzu9TODRzmGohMG0EFDXCIJjEMVIqSJ1GN81piGZ06RYACGU4JmNq1A0G/vKbz948
         nSad0+qz8dWqkAusEr0AlvYMi8lToG2s30iIdU7AYAgsEx2efcJfT7HZM0LbNm3GGGeW
         2meCY1+3Akuim2WEXisyTIxw84eHhlY057nhmuMGJUaqC9B4UzCgRCPf2BMJ2l9XK1sg
         ciV0qk3UCdfwBJ+SgjquQeKOBsoAg+qEYEuG0GtvmPIOX2ZJgHlJkGYt8+NItJLAhZKj
         jIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FfRaG/pRbAEXezZrb2QHPfUsVGu4WjVwJR3upN/P+tA=;
        b=j2GnqfqaitcmTGzgwwjH22YDHMSL1cMnM34geT8aNXNJXTe2foCsifpnN/WG+b4JFy
         PQH86lLnMEWopDlJ0dR6j7ki54PlbLPaAGrJp8sQQovnMGQaN7wtephGmFVE21j3M/Yu
         Mr6ZBDREn4b5uYHBLCkYjxHY8dLaDAI/27vdSYPksz4N8Zf8ZZlthsAiAa3L2CBD+PIl
         xE/cG94b19dilc3YI3+SEzbg+PgH55gS0NeScnarovaxft0diVGOrv/1altb/uhIt/Ww
         4qnsjljjkHkDdQ3cCj6ZlFmk1LwKgUzi8mljI+WR0SngKjHKSLuEFtXJjGR4aYdC8GDp
         WaCA==
X-Gm-Message-State: AOAM532pcqCLZBBNwgiln03jf7BJNKm20QEi0Z5QBONEKbPYPTetYqUt
        2Ke7gA0a4XGhQCWRvq7jnOld65gX1iKc5l+muYLriBqyIlk1Thzi
X-Google-Smtp-Source: ABdhPJzKvJgwSbgoSsoZR1ws53whozzl+tU9CSg4un/NRAJHA95VjyawmIg487OHfck4UZF1LuR9bBGezRHIGghwKf0=
X-Received: by 2002:a1c:e089:: with SMTP id x131mr10311463wmg.78.1602184373797;
 Thu, 08 Oct 2020 12:12:53 -0700 (PDT)
MIME-Version: 1.0
From:   Amanda Shafack <shafack.likhene@gmail.com>
Date:   Thu, 8 Oct 2020 20:11:18 +0100
Message-ID: <CAGxm6oXSaKoTR3btKRV4bMYUsc3-oKeWSfzrWKkCXgrRorAEAQ@mail.gmail.com>
Subject: Introduction - An Outreachy 2020 Applicant
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good day.

I am Amanda Shafack, an Outreachy 2020 applicant who wishes to
contribute to the "Add Git protocol support to Wireshark" project.

In addition, I have some experience coding in C and I hope to enhance
my skill set by contributing to this project.

I am currently going through the project description and contribution
guidelines.

Thanks.

-- 

Cheers!

Amanda  Shafack
