Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA1BC54EAA
	for <git@archiver.kernel.org>; Fri, 27 Jan 2023 17:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjA0RLj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Jan 2023 12:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbjA0RLg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2023 12:11:36 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63B57B7A3
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 09:11:08 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ud5so15501375ejc.4
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 09:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=h1sTqto0qrZgGfpbbupvCGdtpknGXaF+43N9dtgmsnI=;
        b=NF2VUqDTF8y28anM45y+pmB+de61ixrd8qo3Sni8ayMcyd2nUsZC8fTYzlI9dy+04E
         mkvhc7iEWPECd+a1H+XKYHhJk8Bpbde6jdE/Vtx92oVAHoCRIXIN2ngsxqN1+uOjd297
         sVAfdHXsF6FHr9XqOy2s4VmvmPpDhlu2yRRn+ZaY8/fmYG0BFhyJP0Brp8Odw8G8Xa2T
         V1v1kHOKlTB03UYltneb4rRRQ4cLD/Vr7CVETGo/df616hUdjqFu9EDsXyx5ugPlg/Br
         fisQrp2iovO7KdXpkbLYVyrhaGNY298UhBa+m3BGDPjTWqgRSjWSDf8tkVIXRVQ1tGMY
         6X7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1sTqto0qrZgGfpbbupvCGdtpknGXaF+43N9dtgmsnI=;
        b=0UiUoYW5vRGFtv+DuMpzLvaOsRjU+6iAOMAOdhfY5xJNZfQyD7Cldd7nNvyWu5rxrb
         VSvYvRMe+9mv/AwRW7vqMnGFa3a+gOA7/fq+Sbn9D3RE51xNpTNaDu2rzagPyh1MDHL4
         +fZrc0oXHPy8eJIzZwr3Hrbl+ctfXmALgV+IoQ76u/7SPzzk5kVdU3nJz9gj832qgQvN
         qM6mdxepkboKmj6tt0MAqs0Hk4+IqTalUtUtpv8+niDVeB/SdTxWYiLVJkZ8ydzHIbGD
         5Kr5OLPyt3Owk0ba8wHdUXDdgL+OU7L/zIZ+nrVXEUA4qtmKK6bxTG0vDFTdQTBgpGgh
         FsYg==
X-Gm-Message-State: AO0yUKXn/QI3AxDtiLdt2PHUNkfO9P09Ckicqqc5WhlXheuf09WPcW4+
        UmwmHEl9xa2DXUJTKHPKsraG2nHExFvgmt6Salw=
X-Google-Smtp-Source: AK7set8djgaqmdcHS8p3JM4HAPyXph3zDzquqpvXLeMcwCfI9rIB/9GLXQlExkKLU5/USFhxF6fQbQ==
X-Received: by 2002:a17:906:4950:b0:87b:d409:f087 with SMTP id f16-20020a170906495000b0087bd409f087mr2738255ejt.21.1674839432458;
        Fri, 27 Jan 2023 09:10:32 -0800 (PST)
Received: from smtpclient.apple (132-216-166-62.ftth.glasoperator.nl. [62.166.216.132])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090658c600b00878621bd86bsm2555249ejs.164.2023.01.27.09.10.31
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jan 2023 09:10:31 -0800 (PST)
From:   Ilya Kantor <iliakan@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: How experimental are git switch/restore?
Message-Id: <BD4D4AEB-C73C-463B-9118-9687E0267B3E@gmail.com>
Date:   Fri, 27 Jan 2023 18:10:21 +0100
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3731.400.51.1.1)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

How experimental are the "recent" git switch and restore commands?

Are there any plans to change the current behavior or remove the =
"experimental" warning from the manual?

Kind regards,
Ilya Kantor=
