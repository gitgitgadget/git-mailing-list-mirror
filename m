Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBDDC433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 17:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2082A20721
	for <git@archiver.kernel.org>; Thu, 28 May 2020 17:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mL9gZAnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405444AbgE1RTa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 13:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405353AbgE1RT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 13:19:28 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8960CC08C5C6
        for <git@vger.kernel.org>; Thu, 28 May 2020 10:19:27 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d66so1179965pfd.6
        for <git@vger.kernel.org>; Thu, 28 May 2020 10:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VJi+QLVq8VPKoX1kAEuD5VUaZv+ZQ8+fL4sR9we58ik=;
        b=mL9gZAnEqV9cNtiMddNELmzP8fVP07qTqzNdhmjV3Ey1YY426P2F5yaviZDVIbPFa/
         zGAWGF4I/5hEqKCBZLcLBZMwIe4qma0TeXUhQJSS29DFDq1zh0b2g2MS850rXhboEXED
         4k0mmYouDqked3x6kqUtq12Hx2zh1bhIVsaBHcuMb+f7EjsnJXEo/Qgd+gCABeOvCAzv
         Owrq47CBFgigK9ad9k7uml4+ORsPL2eexIXYhbsyV6cr2NPRa1t0VjUM9XrDqBSuhPvd
         DjAlkNIYRYmsZa84YgweJEhgQhe6myXtcC2KpehKF5VJ5WOQ+/NeiDnYxJOg6+fkef95
         PZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VJi+QLVq8VPKoX1kAEuD5VUaZv+ZQ8+fL4sR9we58ik=;
        b=J7I2ludILBFIgNRH5XatjjUUlNpZqqjLz371g4qEQuqEgiVZhMEmpL8tuw1xwbyLqn
         MIdhBKtZ2l2Kzv/lW6Veb5IYLhIZ6bamX46j1aNZZ6IFFbhY9boo5JXoekpFjYLuxBei
         5edeA025eUYydGaV8K6z5lSuLUy4uqPjYzUkzQI0yJSUrtr5/3Xn59qBOTlfQs+F0ZiS
         8PcyA3PSNqpLeNqnzt/ltm18pOO3LGwrSzJ6dJT8iRvG3mmROxSHEN3R1nG7avyaVwJE
         7G4yS++GYatfd9fDem6Ac1HhCWjfcjO5y+8CnU931BLIiGUOxZ8iJtcXCmXapMfUmYhh
         6Xag==
X-Gm-Message-State: AOAM533KGcpCZt7HFwhMGp15szj36EZyk7rXd/qG9gwD2C6NJ1hlXane
        vCd7loMuTJMKlQCrjKCxiug=
X-Google-Smtp-Source: ABdhPJwBeNLsGyGGq2H4/pTgrBFqchzD/Jw+QIMWyUXBdr/PkI6cngbCcoXF02EkatnuB99hYZxzmA==
X-Received: by 2002:a62:15c7:: with SMTP id 190mr4163525pfv.190.1590686366888;
        Thu, 28 May 2020 10:19:26 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id u1sm4693299pgf.28.2020.05.28.10.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 10:19:26 -0700 (PDT)
Date:   Thu, 28 May 2020 10:19:24 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Xin Li <delphij@google.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 1/1] fetch: allow adding a filter after initial clone.
Message-ID: <20200528171924.GC58643@google.com>
References: <20200528025359.20931-2-delphij@google.com>
 <xmqqsgfk3xtd.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsgfk3xtd.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> It would be safe to upgrade version 0 repository when there is *no*
> existing configuration variable in the "extension" section,

Yes, that makes sense (also for the case Brian mentioned where someone
may try setting extension.objectFormat, see no effect, and then forget
about it).

Thanks,
Jonathan
