Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67345C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 11:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A9262068E
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 11:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cl+GQOp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbgHYLaz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 07:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730001AbgHYLan (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 07:30:43 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30418C061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 04:30:43 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kx11so654919pjb.5
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 04:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Sj69wu4aBkruj8jTFTKZnX9Z/3J3W/HXEkQsfXYYMk=;
        b=cl+GQOp28cPGEviGMZuEPIYslzuuwQFrngdpjVJaEL0Eb3CofNRpn7iqP/Et9m8Guk
         sSUokV5nAXxi8Ot19F4SZ68L/842GR9CbRZNdYoy9ImUE3h5BC0VNjkvTS9c2k3SMSXj
         qNMhCULkMMS9j8bY2gr/jCpRwlkjxmQlv3a6UeIPW3jmBgWsTrvVI6pspxC4PPfO10+B
         O0OTAivOoEHsH7bP08yz/wqksJgP2uye0vHmO0LHC+20wy0lVyBKzfaB9CC8uD+O1+89
         JULYZ99ncNL0dgfjpFAgMysj19801sDQgww5fgaVDR4KNIFuRxdgXTyjvbpM3aIkx4Id
         B9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Sj69wu4aBkruj8jTFTKZnX9Z/3J3W/HXEkQsfXYYMk=;
        b=RnOFBKbcz0C4njP8HQSOJhZ/F4AjAyTCv0CcJwLPMzJY0nr47x975cISTuTTnvYkeU
         r2fSEb2x9ju3uJX6yAm/RnYJCQCNCoZS9FHxnBjgDxmcpdxTLsm9uQGPcoXAd8VtsUjL
         pkTFudM24sBNFWz6kmIiM2Ef553vWJ6M3eKAIHhAHzwiYQNFJHOKYV5dcvX5c9ENplcG
         p7qxX43BH7oJxqNLMzSezxwCNIgb5hK4PWfh5HwBWiMg3adChB8+e0jaEIIHUSabTRis
         kFa6oiR/dGK4Ilr7pbRAqGyE/2gmWl/56S0QC6nqElFMQw8mzogy23qJg/nz1d80v/pi
         zraw==
X-Gm-Message-State: AOAM530pGlhhaxUU5WMgb7UpBez/W/1vVypseGo0pzTE/qTgR+3GI9hr
        py9LPvcCorNljGfTtpiwNptDYXo/gDWvRQ==
X-Google-Smtp-Source: ABdhPJzAdfj7p9FMSiO6oQXHLXTA8p8FDDOPCnaN9eoiG+Q5Zt655pVKhda8ZKAZ6lcBuvSp7eW4FA==
X-Received: by 2002:a17:90b:1b12:: with SMTP id nu18mr1233688pjb.126.1598355041874;
        Tue, 25 Aug 2020 04:30:41 -0700 (PDT)
Received: from localhost.localdomain ([115.97.133.243])
        by smtp.gmail.com with ESMTPSA id y3sm2821518pjg.8.2020.08.25.04.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 04:30:41 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, Johannes.Schindelin@gmx.de,
        peff@peff.net, liu.denton@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [GSoC][PATCH 0/3] submodule: fixup to summary-v3
Date:   Tue, 25 Aug 2020 17:00:17 +0530
Message-Id: <20200825113020.71801-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings,

The v3 of 'git submodule summary' port to C is currently in 'next'
branch of git/git. Recently, the patch recieved some comments from
Peff, Dscho and Kaartic:

    1. The definition of 'print_submodule_summary()' contained two
       unused parameters namely 'missing_src' and 'missing_dst'. Hence,
       I had to eliminate them as covered in the commit a22ffa950f
       a22ffa950f (submodule: eliminate unused parameters from
       print_submodule_summary(), 2020-08-21). Reported by Peff.
       Junio also advised to make the output in case of an unexpected
       file mode a bit more user friendly by outputting an octal instead
       of a decimal.

    2. The function definitions of 'verify_submodule_committish()' and
       'print_submodule_summary()' had wrong styling in terms of the
       asterisk placement. Hence it was fixed in 32934998ee (submodule:
       fix style in function definition, 2020-08-22). Reported by
       Kaartic.

    2. The test script 't7421-submodule-summary-add.sh' failed in
       Windows due to failure of t7421.4. Precisely, the 'test_i18ngrep'
       check failed on Windows since the error message which was being
       grepped was different on Windows; it was designed to work on
       Linux. Therefore, we had to eliminate the grep check in t7421.4
       and replace it with a check to see if there is any error message
       or not using 'test_must_be_empty'. Also, to support this change,
       we had to make some small changes in 'print_submodule_summary()'
       function. The call to verify_submodule_committish()' had to be
       guarded using 'p->status !=D' so that it isn't called when the SM
       directory does not exist, therefore, the error message is not
       displayed. This resulted in 82e0956cd2 (t7421: eliminate 'grep'
       check in t7421.4 for mingw compatibility, 2020-08-22). Reported
       by Dscho.

summary-v3: https://lore.kernel.org/git/20200812194404.17028-1-shouryashukla.oo@gmail.com/
Peff's comment: https://lore.kernel.org/git/20200818020838.GA1872632@coredump.intra.peff.net/
Dscho' comment: https://lore.kernel.org/git/nycvar.QRO.7.76.6.2008211708280.56@tvgsbejvaqbjf.bet/
Kaartic's comment: https://lore.kernel.org/git/377b1a2ad60c5ca30864f48c5921ff89b5aca65b.camel@gmail.com/
Junio's comment regarding unexpected file mode: https://lore.kernel.org/git/xmqqo8n053r6.fsf@gitster.c.googlers.com/

Feedback and reviews are appreciated.

Regards,
Shourya Shukla

Shourya Shukla (3):
  submodule: eliminate unused parameters from print_submodule_summary()
  submodule: fix style in function definition
  t7421: eliminate 'grep' check in t7421.4 for mingw compatibility

 builtin/submodule--helper.c      | 17 ++++++++---------
 t/t7421-submodule-summary-add.sh |  2 +-
 2 files changed, 9 insertions(+), 10 deletions(-)

-- 
2.28.0

