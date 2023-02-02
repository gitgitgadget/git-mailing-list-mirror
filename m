Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94CEC64EC3
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 16:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjBBQ0I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 11:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjBBQZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 11:25:59 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10A1902D
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 08:25:53 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id mi9so2381570pjb.4
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 08:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFM76+WLQ4UI6YoMj+iXdJd/ZiyHGxiUQ/in9aDNyNQ=;
        b=TW/XjqUWkLxL/JCJO9TR4GMP+0VkES9+6dMrttsvUhPhOExcEIrwwqgC1g5sduYXSl
         nsreLVij9yBlf7J78i53vO5kpkCj+hmyF0Zakd04hGPcIguSix83M8h1uuTY+lbfTP7P
         zpAL0zzo0sBGJ0sjWWh0QczrR0EthXAQuOwnirWGywJi+v+fbC7nQFZUEz21VNmEWoEe
         g/m//rTjGPfUpw3uPT7cAyD+5sXTfRFmIcKqTi+KMwZ3ql6At0aVm4WKz8+GtZAYHb7f
         QrE9YBj9Uj7Cv0BuP3vbX08qt3zUyipGHcVxA6RhXwbXk9pC1lryNNukIOhpPnPApn6X
         Yv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pFM76+WLQ4UI6YoMj+iXdJd/ZiyHGxiUQ/in9aDNyNQ=;
        b=BpXOD5hCWHgEJl5x4B+PWP3d9h3X2OQo9BRUSoLEijJC86KIAhYBTyC4vIAE3KeLEK
         QMIF5hM63gLeRLRan/UaVvgMDj4P/HjUa8D6RlGSa/pJOXXlngetWpilXTOQlURPim0k
         a9Pr1O4pqrGjebfsieZfRMheM6XaBPv/CIzaO2r7o8xMc+XeX/N2uzydCiYJ1uEBKRRm
         wjf44h+GD+tb+4CUD5sI3p+piL5KGuVage4y60FNf4tDfLkhpVTWC2or55Ts6qhQGs75
         j5h1hKg+qEAM48G9Xf0wafeJHlQ/syO0afzN0G1ZnvFmOCc/NdMBb+7TDwtTOFKsG8Y1
         L7Aw==
X-Gm-Message-State: AO0yUKXEaZs9wpGGvRz63iZ1qnq4Bc5i07n8gaAI9ND2d8W33K2GgNtC
        tPt6Uau/EO9DCDD9d2jUgJk=
X-Google-Smtp-Source: AK7set+m//Brd0d8clIu4d7+mhU9YaQSmjAfWysaTZoxIDowswb82mSF0S5TH/th5iZ16W/jI8GIMg==
X-Received: by 2002:a17:902:ec8a:b0:196:5540:3953 with SMTP id x10-20020a170902ec8a00b0019655403953mr8261287plg.24.1675355153313;
        Thu, 02 Feb 2023 08:25:53 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902da8e00b001928c9d772bsm13908590plx.206.2023.02.02.08.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 08:25:52 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eli Schwartz <eschwartz93@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 0/9] git archive: use gzip again by default, document
 output stabilty
References: <230131.86357rrtsg.gmgdl@evledraar.gmail.com>
        <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
Date:   Thu, 02 Feb 2023 08:25:52 -0800
In-Reply-To: <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 2 Feb
 2023 10:32:20 +0100")
Message-ID: <xmqq5yckvxtb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> As the disruption of changing the default isn't worth it, let's use
> gzip(1) again by default, and only fall back on the new "git archive
> gzip" if it isn't available.

It perhaps is OK, and lets us answer "ugh, the compressed output of
'git archive' is unstable again" with "we didn't change anything,
perhaps you changed your gzip(1)?" when they fix bugs or improve
compression or whatever.  Of course that is not an overall win for
the end users, but in the short term until gzip gets such a change,
we would presumably get the "same" output as before.
