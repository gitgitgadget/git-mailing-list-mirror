Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49DCC433E0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 11:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B011065228
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 11:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhCILkN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 06:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhCILkF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 06:40:05 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD1CC06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 03:40:05 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id kx1so752982pjb.3
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 03:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=LIMZJLqyaSjDR0akXPvim+aBJdz/dyGM3o4ITc2VW8Q=;
        b=jRk2Q3O3SyIrdO/PKVeELJhpZBbJiuYxRzcQ0CTs97zz9TzyXaO/bPTdLoOXFa335/
         wQj9L44f9WyYEiJ71oEO/7UN8xwPjJZapXTlkHXq7SWESukBU1S8xWzWRs+9MYMZTh5z
         goYEurKt2DpL8uxQ6VTn6fx+/ZZxL/WSW2hXyShOlMpHPaGKDNxjP+DKy2kYhW4u1lDW
         ol/cdLvDiooit0IuYB96doyANesJo4B+B4MPHK/+2sGroKkYSIASh9bwh2DNbkrzhbFc
         U7jogXfsga1HTL55hdgj5LSA9DQc3cdse8wMnUYcsy8Ez/VGUcCf850uaB/sbIY7URWO
         74xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=LIMZJLqyaSjDR0akXPvim+aBJdz/dyGM3o4ITc2VW8Q=;
        b=f0769IVIKswV/sde6dUglzPYvxXlbV1t13gviU2xe+9H07pnwEGk+6rc9EbyGcVv7F
         ZX+JJbyc2+2rlym+jTPkrVr+8mlOR0Yp4bdfmS23P+zN+DMrXkb8OJtTS9L0eQo8NvsO
         rGT4Ig4Spx44UQh1aKU70PIcsYSJU6sTHt58wy8SEOaMsGY0f4/SdHpTU/Zo+/mwvJdL
         x4cAvuPQ6ULuu83D86dterrOUo5EI0FDa5lge6LrGooGcEeT442eW9v79q9BtMXsSLq1
         RbgGqW5dm0TTM9mIJBtCgy6rhz9DU0ur2+IA5GoLrNyll8UzFXT38zD9dpv1YrEHWeYs
         +qZg==
X-Gm-Message-State: AOAM532OBlfburv2GaZMhJ2CnucLlaxVnb8MJtgsxrxjnFRc0ct5HdBZ
        cGhquN/vTb0HrBcD0pEtcjE=
X-Google-Smtp-Source: ABdhPJx8IUU8QLTAHtLWV6eSAvoESD50lPCcwremboO+NZcKhsk+7Fv1FLaxeAplLhfIicWw6qvE6w==
X-Received: by 2002:a17:903:304e:b029:e5:d43:9415 with SMTP id u14-20020a170903304eb02900e50d439415mr25557330pla.42.1615290005221;
        Tue, 09 Mar 2021 03:40:05 -0800 (PST)
Received: from [192.168.43.80] (subs28-116-206-12-54.three.co.id. [116.206.12.54])
        by smtp.gmail.com with ESMTPSA id c16sm6572131pfc.112.2021.03.09.03.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 03:40:04 -0800 (PST)
To:     git@vger.kernel.org
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Core translation should be documented on po/README
Cc:     worldhello.net@gmail.com
Message-ID: <d536f4fe-a857-0307-db3b-139ff4ff25b2@gmail.com>
Date:   Tue, 9 Mar 2021 18:40:02 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I had learned the following when I submitted Indonesian translation [1].

The documentation at po/README missed mentioning about "core translation",
which IMO is minimum translated messages needed to complete the translation.
So the l10n coordinator had to instructed me to complete it.

To translate core messages, I ran `po-helper.sh check id.po` first and
do the translation work on the generated po/core-id.po. Next, I merged
po/core-id.po to id.po by `msgcat`, however he didn't tell me the order of
PO files to be passed to `msgcat`, so AFAIK I `ran msgcat core-id.po id.po`
and fixed "fuzzy" errors (such as misplaced translated messages).

I think these above should be mentioned in po/README.

NOTE: po-helper.sh can be found on po-helper branch of l10n coordinator
repo. [2]

[1]: https://github.com/git-l10n/git-po/pull/500
[2]: https://github.com/git-l10n/git-po/blob/po-helper/utils/po-helper.sh

-- 
An old man doll... just what I always wanted! - Clara
