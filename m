Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 660D3208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 08:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732201AbeHGKfO (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 06:35:14 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:47046 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbeHGKfN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 06:35:13 -0400
Received: by mail-io0-f195.google.com with SMTP id i18-v6so13281012ioj.13
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 01:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=So+1Z5VZG3GsjsTwvo6afsDAGhvH7NqbNAGqNlfHzbQ=;
        b=sXl2GUGYtCWjRAcKu1Hv9ASne23/IsfgTZw1ZzqMf9yW+4zvhzdfLpHpAQ5ovFWtwk
         hXw4d6x/xcQrFeWWwr0F3aLmEDPWVLrAxhG3Q+yAe58YRdRHfhO73E07Cfb5g5DKaZ/V
         BCyPiKX1EY+sOeImSK2zucmJEVAtS4pZ/95mdNyXGRJOFrADhSvO/Wob3yCGvHzxDXTk
         sHSK5gbNb/RmjiHYndCiuzQ1Ce8upSja8ITIJVnxG2SxG1XXG6cly1+2tckaWrI8IHyO
         wqFU0bQ/pBrcQKvCGIGQ2cyKx96rRCJYv0wzjLOOhl+vROz01f3jXtW63em7kMAxZ5jd
         JTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=So+1Z5VZG3GsjsTwvo6afsDAGhvH7NqbNAGqNlfHzbQ=;
        b=W5RlrOigeJCYHIYndP7dlgmlz5LYTWmY8D4L8/THgFCz2gP/VDMS1mCmDe+2/fsM9b
         KywEL493KkSV2Vvob2vEYvYc5qifk4zrJEDcBgVPDEHhrnQvap/ZLFyKdjLKgEHzIUOe
         R4nTjZxTuS2C/GMz5QMSH1j0Qhz+AkGNb34vsAlA4+etUN3/EJ57NwOwpaT5PWPDPVdN
         ILXdZuC4d6hTPbCRPcL0xy6eJQhcjLr0/9avxoskjdj2vwSDL0nVJSvC/9S/1VfbsJHK
         9/39a4Dq9IJ4kwkiClgVUPCAF86kjyevR/wVjVPKOLtCw0ZOZzngwA5Sze02mVe7fzzw
         dEiw==
X-Gm-Message-State: AOUpUlH712ywkdhV7Ch9rLFe2+D6J4VrRdA/8sr2TjpCF2iey/mcmyH+
        ECr7Yrm+EJotS3H17nTFkfxBt5mA
X-Google-Smtp-Source: AA+uWPzuOQ9DKE0c9YPCSjrGVgQ/JfDsKXaphmsByXKZ1GmiEUboR1qu8NjP7ZL06B5I53wnHmtq+g==
X-Received: by 2002:a6b:fb11:: with SMTP id h17-v6mr8613894iog.270.1533630120947;
        Tue, 07 Aug 2018 01:22:00 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id e19-v6sm210792ioc.46.2018.08.07.01.21.59
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 07 Aug 2018 01:22:00 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/5] chainlint: improve robustness against "unusual" shell coding
Date:   Tue,  7 Aug 2018 04:21:30 -0400
Message-Id: <20180807082135.60913-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.758.g1932418f46
In-Reply-To: <20180711064642.6933-1-sunshine@sunshineco.com>
References: <20180711064642.6933-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series improves chainlint's robustness when faced with the sort of
unusual shell coding in contrib/subtree/t7900 which triggered a
false-positive, as reported by Jonathan[1]. Jonathan has already
rewritten[2] that code to be cleaner and more easily understood (and,
consequently, to avoid triggering the false-positive), thus the
improvements in this series are not strictly necessary.

Nevertheless, it seems prudent to make chainlint more robust against
such unusual coding as an aid to future less-experienced test writers,
making it less likely for them to trigger a false-positive and waste
time trying to decipher a non-existent problem (in their code).

In [3], I said that 'sed' couldn't "be coerced" into dealing with nested
here-docs with arbitrary tag names (explaining why it recognized only a
"blessed" set of hard-coded names). However, I put a bit of thought into
it and figured out how to do it. Patch 1/5 is the result.

This applies atop 'master'.

[1]: https://public-inbox.org/git/20180730181356.GA156463@aiede.svl.corp.google.com/
[2]: https://public-inbox.org/git/20180730190738.GD156463@aiede.svl.corp.google.com/
[3]: https://public-inbox.org/git/CAPig+cRTgh6DStUdmXqvhbL_7sQY6wu21h27rjq_i=kZ_d+LAw@mail.gmail.com/

Eric Sunshine (5):
  chainlint: match arbitrary here-docs tags rather than hard-coded names
  chainlint: recognize multi-line $(...) when command cuddled with "$("
  chainlint: let here-doc and multi-line string commence on same line
  chainlint: recognize multi-line quoted strings more robustly
  chainlint: add test of pathological case which triggered false
    positive

 t/chainlint.sed                               | 98 ++++++++++++-------
 t/chainlint/here-doc-close-subshell.expect    |  2 +
 t/chainlint/here-doc-close-subshell.test      |  5 +
 .../here-doc-multi-line-command-subst.expect  |  5 +
 .../here-doc-multi-line-command-subst.test    |  9 ++
 t/chainlint/here-doc-multi-line-string.expect |  4 +
 t/chainlint/here-doc-multi-line-string.test   |  8 ++
 t/chainlint/here-doc.expect                   |  2 +
 t/chainlint/here-doc.test                     |  7 ++
 ...ti-line-nested-command-substitution.expect | 11 ++-
 ...ulti-line-nested-command-substitution.test | 11 ++-
 t/chainlint/multi-line-string.expect          | 10 +-
 t/chainlint/multi-line-string.test            | 12 +++
 t/chainlint/nested-here-doc.expect            |  2 +
 t/chainlint/nested-here-doc.test              | 10 ++
 t/chainlint/subshell-here-doc.expect          |  4 +
 t/chainlint/subshell-here-doc.test            |  8 ++
 t/chainlint/t7900-subtree.expect              | 10 ++
 t/chainlint/t7900-subtree.test                | 22 +++++
 19 files changed, 199 insertions(+), 41 deletions(-)
 create mode 100644 t/chainlint/here-doc-close-subshell.expect
 create mode 100644 t/chainlint/here-doc-close-subshell.test
 create mode 100644 t/chainlint/here-doc-multi-line-command-subst.expect
 create mode 100644 t/chainlint/here-doc-multi-line-command-subst.test
 create mode 100644 t/chainlint/here-doc-multi-line-string.expect
 create mode 100644 t/chainlint/here-doc-multi-line-string.test
 create mode 100644 t/chainlint/t7900-subtree.expect
 create mode 100644 t/chainlint/t7900-subtree.test

-- 
2.18.0.758.g1932418f46

