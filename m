Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 633261F405
	for <e@80x24.org>; Wed, 19 Dec 2018 12:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbeLSMPC (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 07:15:02 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44543 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbeLSMPC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 07:15:02 -0500
Received: by mail-oi1-f196.google.com with SMTP id m6so1392504oig.11
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 04:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yQdaD1tk9+x9J/j1XuGOlb1AlsAUIVGA0sgTk5WjEDw=;
        b=eri7In9GO3NfLHq2NfHx98+XEuDgiTunhegoPRd4hZJf7nsIf9TA+HdLf9uZ0wVdhN
         UfdCisIDvD6UakfufGhQCUjlff8jDtrarC6/3K2KZBXf7fJ7Xag4rQgfgGtbLe+1LxGQ
         VGIXcp6P0+HJcYwJytKyfyYw/9ZMchcBAUxh1hpA8bvf8NEzhhrBy/zxbAHLT7Agyrex
         h2a4/9x71jNtPIooRsWKk3vtBZLoGRQ5NHa+lEk8GSdwkS7OU8r5oIrjMgV/bVPGgPL6
         cUi+lf9+d2DsEyEi1GSvZeBkwWu5G6HxOLZ/HCxosw5tHDIN4ZNTAqkCwDVEijtJDvKX
         Tmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yQdaD1tk9+x9J/j1XuGOlb1AlsAUIVGA0sgTk5WjEDw=;
        b=BGyCB86YVOPLSHSzvQaSk88mIBStlOG7h3Mh5idFcumUYkJCAyXorC+0RHgfEf8+6V
         6NM63vjAdqrnxh270k6AVb2xvV93uO8p042isvuIRhvcIODkw93sqvFfti7SFI3Ujw8A
         qdcacu84MmU/GnifK2fUYiqg3D0IbJvrvsTGl0VXLO2qEMB0Iv/wR3huKO1AFe45olMH
         aUpakvxCLB0aDmNw8yp6AEBUD4yaLFlnTrtnK2Jye1Wfprk28EyygAMvAMCBvxTjARFy
         AE8F4Es7Y4QLpPXS8pYkWKvvbdTP6JylWdHdqVPEnYFFoq+nBidIJQckp43SYYPQoTLk
         yYvw==
X-Gm-Message-State: AA+aEWaWUZ6AlM5N0E9zM4P4fYNvZswbAIKu6yqz7aTMJ1SeHRAn7brn
        DUIvwPQdY/KDpL05aDbUxtXmLfG/oxI=
X-Google-Smtp-Source: AFSGD/Xa5wrnet7IOXu5Rgwd7lnjJ2lD6dxH2VZfylyqfs/OOGzao1YWtLKa/jgLEPV3StqnXRzxGQ==
X-Received: by 2002:aca:a86:: with SMTP id k6mr986027oiy.334.1545221701059;
        Wed, 19 Dec 2018 04:15:01 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.9])
        by smtp.gmail.com with ESMTPSA id e128sm8826357oia.5.2018.12.19.04.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 04:14:59 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Sun Chao <sunchao9@huawei.com>
Subject: [PATCH v2 0/3] pack-redundant: new algorithm to find min packs
Date:   Wed, 19 Dec 2018 20:14:48 +0800
Message-Id: <20181219121451.21697-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.0.3.gc45e608566
In-Reply-To: <20181218095829.20092-2-worldhello.net@gmail.com>
References: <20181218095829.20092-2-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sun Chao is my former colleague at Huawei. He finds a bug of git-pack-redundant.

When I was in Huawei, I develop a program to manage fork tree of repositories,
using alternate repo for forks to save disk spaces. 

Sun Chao finds if there are too many packs and many of them overlap each
other, running `git pack-redundant --all` will exhaust all memories and the
process will be killed by kernel.

There is a script in commit log of commit 2/3, which can be used to create a
repository with lots of redundant packs. Running `git pack-redundant
--all` in it can reproduce this issue.

Updates of reroll v2:

* Add test cases in t5322.
* Fix a bug in patch 2/3.

--

Jiang Xin (1):
  t5322: test cases for git-pack-redundant

Sun Chao (2):
  pack-redundant: new algorithm to find min packs
  pack-redundant: remove unused functions

 builtin/pack-redundant.c  | 181 ++++++++++++++------------------------
 t/t5322-pack-redundant.sh |  69 +++++++++++++++
 2 files changed, 137 insertions(+), 113 deletions(-)
 create mode 100755 t/t5322-pack-redundant.sh

-- 
2.20.0.3.gc45e608566

