Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B62EC77B7D
	for <git@archiver.kernel.org>; Sat, 13 May 2023 20:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjEMUuj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 May 2023 16:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjEMUui (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2023 16:50:38 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EDD40E0
        for <git@vger.kernel.org>; Sat, 13 May 2023 13:50:26 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-55cc8aadc97so170415707b3.3
        for <git@vger.kernel.org>; Sat, 13 May 2023 13:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684010996; x=1686602996;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7J27VL8uKaKCPqNpUDRv8T+iST9v5Sg55fqjVCMYCQ=;
        b=5Hk4IpPySLEXTKth+k959WB9caYeTBqnNU/WXxDgFYiMAoRn3RZwB4Xq2IO0KaWG95
         SNBmI/ViZb4PZZCktZmK5iU74xF+XrD9R7Au83oGu9VFcS/jJgAuWUxKHUsLM+fMLseS
         oD6dn/FxNpT4iDPwD1uWc7LVMnpqm6MsjR4mcZQYrf0fvET+h2wuy8IKYgBiQj+oY3oO
         z/R5yM3eaVpKBn7frukEaVdUhyncW4QQgO01RvrmPoYlqOrj0xdL3ywJZiUid6XUiIxM
         iJ5ZJ7daMbBdaDN3rogNpS4SzdGFO0/gn70oCJdDzMSOrzzZBgNjftdkFb5Mmg1fLK1H
         kQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684010996; x=1686602996;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7J27VL8uKaKCPqNpUDRv8T+iST9v5Sg55fqjVCMYCQ=;
        b=VzmTN6O9+di9ifIZ4vnhk2JxhPtQ1FNO2i5s9y3Y8TGPUpLV8gSEEjnpAXXKgOmhLl
         7tK3ctKIVeupU5zWv8YTAYKaNFT0MS6YFZxc4cZfN5z0qBMBnGF8/qblHZlHjAAaPK/Z
         t7AmoXP2GQEuWRMRYXbGBlgQs/IKXUx0bCU+ftQ4IcQDsGxU+uz2u1ieoGdfgT+PGyb1
         iRxMxYRXWusR/OI8/LDPi57iGn2KvHV1wz6sJYUcrIhjr8PYxpvu8Uc4tIXqDOJqg4U6
         PIDp+f/S16ECiokDmiFmLy5NXMgmnwH40fQguNVqOHz3ThPY0zeLUmGeiQKd26TQppbQ
         i8eQ==
X-Gm-Message-State: AC+VfDwOeoRVqEa5rJZsWLA9XycLwlvAVSOxfkh1RWeh2wy1UMyrSYmv
        wvXKaehefkxG6nNgNpUZnS6KLMMw2xqw9pEX26nZag==
X-Google-Smtp-Source: ACHHUZ6H7TfaEelwTn6LFZu5aeTdIIpY4MyUaxaWWIOD7AnHUx8qIjkrNW3wMMJYiRSFpMaTkMHgfQ==
X-Received: by 2002:a81:9202:0:b0:559:e54d:4dde with SMTP id j2-20020a819202000000b00559e54d4ddemr29809932ywg.8.1684010995968;
        Sat, 13 May 2023 13:49:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n1-20020a0dcb01000000b0055a503ca1e8sm6581162ywd.109.2023.05.13.13.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 13:49:54 -0700 (PDT)
Date:   Sat, 13 May 2023 16:49:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Git's Code of Conduct, and community updates
Message-ID: <ZF/38DXNYMsZjvy4@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As you know, the Git Project adopted the Contributor Covenant more
than 3 years ago and uses it as its Code of Conduct [1, 2].

That document outlines the standards of behavior that we expect from
all members of the Git project. Most importantly, it reminds us of the
following:

  We pledge to act and interact in ways that contribute to an open,
  welcoming, diverse, inclusive, and healthy community.

While disagreements and technical debates are part of open-source
work, we should always expect of one another to be treated with
respect, regardless of any individual differences of opinion.
Disrespectful behavior is demoralizing, discourages collaboration, and
obscures the best parts of our community.

Among others, the CoC lists the following examples as unacceptable
behavior:

  * Trolling, insulting or derogatory comments, and personal or
    political attacks
  * Other conduct which could reasonably be considered inappropriate
    in a professional setting

By and large, our expectations of each other are met, as the vast
majority of project participants are collegial and friendly. When our
expectations of each other are not met, the project leadership
committee (PLC) exists in part to investigate and mediate disputes.
When corrective action is required, the CoC outlines four steps:
correction, warning, temporary ban, and permanent ban.

Despite our repeated efforts (including applying corrective action as
laid out in the CoC), Felipe Contreras has continued to violate the
CoC, leading to numerous complaints from community members.

As such, **we had to make the difficult decision to permanently ban
Felipe Contreras from participating in the Git project due to multiple
violations of our Code of Conduct**.

Previous violations and related complaints resulted in the PLC's July,
2021 decision to temporarily ban him from the community for three
months. This ban contained clear warnings that further violation could
result in another temporary or permanent ban.

Despite this, we have recently seen a number of new violations and
received related complaints, resulting in our decision to ban him
permanently.

In accordance with the CoC, Felipe is permanently banned from any sort
of public interaction in our community. The vger.kernel.org
postmaster has configured the Git list to drop emails from him.

We should hold each other to high expectations. The Git project should
be a fun place to contribute to or work on. We should not tolerate
behavior that is rude, disrespectful, and detracts to the community,
no matter what. If you have any questions or concerns about the CoC,
please do not hesitate to reach out to the PLC.

--
Thanks,
The Git Project Leadership Committee

Christian Couder
Junio C Hamano
Taylor Blau
Ævar Arnfjörð Bjarmason

[1]: https://www.contributor-covenant.org/version/2/1/code_of_conduct/
[2]: https://github.com/git/git/commit/5cdf2301d4a8b439f89fd2cdfed13736ccd64a30
