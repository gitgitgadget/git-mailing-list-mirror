Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A66E1F42D
	for <e@80x24.org>; Sat, 19 May 2018 10:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752202AbeESKA3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 06:00:29 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33604 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752112AbeESKA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 06:00:28 -0400
Received: by mail-wm0-f68.google.com with SMTP id x12-v6so6195907wmc.0
        for <git@vger.kernel.org>; Sat, 19 May 2018 03:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+pAtYAbIug1RQQhsYgAytHquf4+b4QOBmYlX0401dAI=;
        b=SujvgAE4GYSoc11/8ZQZNXj3TyoyGNpDTQZxVGPNZ3WhJJ6vje6Uer0HqbNr0o6lCf
         tX8quLb/nPzZyeAWTqObb2WyTjkxZ0n/3dg8Dz4fMTs+wgC6Y0ig7kI1UpL6D9nYbmi7
         x6rQ2TO3Q0X9xKq7x/w9TGb7hcbEtMWcOBsi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+pAtYAbIug1RQQhsYgAytHquf4+b4QOBmYlX0401dAI=;
        b=AmjVxSJciayJarieqUcVFodKtz86Zyb3ctWtpNTfj3hQ/59ur3PoIs8tKYLSPUYDUD
         +keseWEnMixKUce0IY7Dl89+g/G+xILlrjn/eQ7CTCJ4L2Jv5vZi4QHcw477btGTa7Gs
         M3ohSDL3KhgiV0IyKFJN+VwPffl1t3z4WWZUlvJ9x4JMsj0rCMxkjM4puYJv47otQaUk
         dxaDOwJLUo5pwsYx/qHoypYDkrtTgf5cvzJVtHMp+coqcwlS0MSKuS8h7mdP7KvHw5AL
         NKSDPkf0AbnZ6ylb332RbYrlBz9drK9oz7GadOMGmEzedCZJaSVwNgwxv+h5/J1pX/HE
         mw+w==
X-Gm-Message-State: ALKqPwc1OpMuCuCMGPhXy3buBYAwD6TipewJMEKs3IQQXa4upmb9gWNS
        tnIwnXtPXsLZ2xykvFSm3OB0n84T
X-Google-Smtp-Source: AB8JxZpT3uR2qtEWe7sUEZs+PjlH/2d8/OHqAcR7smeX/plUcKtjWeKKtvC6UtOCUfDfsqBAMIJjnA==
X-Received: by 2002:a1c:55c9:: with SMTP id j192-v6mr7466762wmb.160.1526724026951;
        Sat, 19 May 2018 03:00:26 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id q194-v6sm15218621wmd.26.2018.05.19.03.00.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 May 2018 03:00:25 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv4 0/1] git-p4: unshelving: fix for python2.6
Date:   Sat, 19 May 2018 11:00:19 +0100
Message-Id: <20180519100020.616-1-luke@diamand.org>
X-Mailer: git-send-email 2.17.0.392.gdeb1a6e9b7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the same as the previous unshelve change, other than fixing
the "{}".format(foo) constructs I introduced to be compatible with
Python2.6.

    https://marc.info/?l=git&m=152637850403462

Python2.6 doesn't understand empty format fields ("{}"), so I have
added element indexes, e.g. "{0}".format(foo).

Luke Diamand (1):
  git-p4: add unshelve command

 Documentation/git-p4.txt |  32 ++++++
 git-p4.py                | 207 ++++++++++++++++++++++++++++++++-------
 t/t9832-unshelve.sh      | 153 +++++++++++++++++++++++++++++
 3 files changed, 356 insertions(+), 36 deletions(-)
 create mode 100755 t/t9832-unshelve.sh

-- 
2.17.0.392.gdeb1a6e9b7

