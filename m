Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3641C636CC
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 18:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjBOSBD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 13:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjBOSBB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 13:01:01 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3BE32CEA
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 10:00:47 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id h4so13174087pll.9
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 10:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RmENZu6DypnwEEmNLvIMK3MNUBGM0+G4jWG2At6e6dg=;
        b=O3NAZuv6t7WFvHwiStrcEArS4zV+PvcHqAfoLjHrmhXXZp+FfzpQyw4O7ZUSMGefKM
         pWq+bnRwpKqKlmDeC0Xb9ZW0beyRO7AjNlq+n3gdRN6BHaY6rfS7Mg0ldu7dSDm1JJLw
         tLmXx5b08iS/2g1u5aRCH+WM3A4y1tDmccxKEm7Hh7W66zqNFFqXN/LvIECiaP0YQKn7
         t4fG5gp636vVmKU5kyldazy9fVWd2raHVaCJEhvLJq4qVgnF8N0CZZyRqwOWcuLyPOEg
         zpGzH7ovEQYmZ0QlqLspOFw6hsAQbEieREHC8GY/7Z8yUbjDzOj2v8ZJKkOurUp8Drn5
         tLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RmENZu6DypnwEEmNLvIMK3MNUBGM0+G4jWG2At6e6dg=;
        b=FG+jScxU6/MFZEcrbBqw6GnaqbumyEQrd7RKuQDfwlVdE7T+3guKNs3YQtFRWpHYXN
         520T73ybWZV63SEv7NdlfdTVf1AbpSUrkO8M31iu72aZlUISjYR84AyfqWmYCoHDGXlO
         VUM+JZZ5sakcGA7LKbws9P2RMj3EuN3mpgUJCHM4brqLkGDjxNVt+wVr1uR7dEPyJFo+
         2lWjj0E0h4E3AAtiTi2VpWHwHnRHOuWTZZ9IRv7YWJfUzu0Tzx8bfnli6SZRbhHZptU5
         Hmj0+naKKol8QaRwATpX9/f/d6oGz6JWE95AtuPE9VCrAXHt0URXU4j0SNSNxtTL+ijF
         VvFw==
X-Gm-Message-State: AO0yUKX4Uyoagv6UZ+pfrG8xfT5ATVV5RqG2fjH0zBnrfvwVMcKWC+kF
        jtJg9OviQ66P2a8jwsqilQU=
X-Google-Smtp-Source: AK7set9c2oCeqBCgQamonzx81Y3VpwQmw32bLqwUaGUzFBxVbuocUpSfq+bVmjsv392C0GBxtBlnzA==
X-Received: by 2002:a17:902:e850:b0:196:44d4:2453 with SMTP id t16-20020a170902e85000b0019644d42453mr3846812plg.7.1676484046477;
        Wed, 15 Feb 2023 10:00:46 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id ij9-20020a170902ab4900b0019a96a6543esm7184682plb.184.2023.02.15.10.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 10:00:45 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] get rid of sscanf() when shortening refs
References: <CAPig+cSTG2_hsv-amhwDwQNcfLSZ2+if6=MJcyDb6PhKBx-WJQ@mail.gmail.com>
        <CAPig+cT5mORvJt_E+uDYEVW+SYbUp_1U8hmjWT8iUkjzOnJm=A@mail.gmail.com>
        <xmqq7cwk955b.fsf@gitster.g>
        <CAPig+cQx24PRUsEjEcnuDtokS02SS3n_dUi8MO=WJbBazget8g@mail.gmail.com>
        <xmqq3578924s.fsf@gitster.g>
        <CAPig+cQLRDJY_9zjEu2DdZug8h9QNSUVCzDC7W65Cm=eQ-3MiQ@mail.gmail.com>
        <Y+uwW0I0k7urZ3do@coredump.intra.peff.net>
        <CAPig+cTH1hUTSN+TRCo9brGMosEW-OWV0JVBATK+moB0EZec3w@mail.gmail.com>
        <Y+u/xUQJoWVWULn6@coredump.intra.peff.net>
        <Y+vVFFCRem6t4IGM@coredump.intra.peff.net>
        <Y+z3MtgayoXsxaHA@coredump.intra.peff.net>
Date:   Wed, 15 Feb 2023 10:00:45 -0800
Message-ID: <xmqqa61ezu42.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>     +      - scanf's matching of "%s" is greedy. So the "refs/remotes/%s/HEAD"
>     +        rule would never pull "origin" out of "refs/remotes/origin/HEAD".
>     +        Instead it always produced "origin/HEAD", which is redundant with
>     +        the "refs/remotes/%s" rule.

Wow, that thing is new.  Fixing it may break expectations by
existing script by end-users, but it may probably be OK.

Everything looks good.

