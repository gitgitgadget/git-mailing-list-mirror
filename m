Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 611BE20954
	for <e@80x24.org>; Fri,  1 Dec 2017 22:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751403AbdLAWuT (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 17:50:19 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:33230 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbdLAWuS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 17:50:18 -0500
Received: by mail-io0-f194.google.com with SMTP id t196so12938475iof.0
        for <git@vger.kernel.org>; Fri, 01 Dec 2017 14:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3JAFS3ndDEYji3x93ptKsFvvArTyahzyDpTfY2ITJvY=;
        b=O1XHjzisOUGz1n4L5XKQjQ0IuRkP55DQNeqd+o5BWKSkeHMdrVvPH2dd1oj3aqfUip
         2xMG8VFTg9S1N2f8mOplKe6OmwriU+oZkKYTTE43WFbv6ImN0Mql5vGsAmQGEwU8jwf2
         G6STyEe3XPX2/5LWfpTZ868+8rx/8SHHQQabUv1wuZ3akJP5/Cyo4ecczHb+ExQkcPve
         rHIrS0r4yccwwJo7KgpV687xzLJETICcKWRkCn5Cwv7LqZhQZPh4Qr7ySLwJ3gWRhBoT
         751tjyYD6gBfAaGP2wW/IGgfrpALPsKDIerGzZ0ieictezzRMFcc3OTlcSffQnIHEa3L
         hG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3JAFS3ndDEYji3x93ptKsFvvArTyahzyDpTfY2ITJvY=;
        b=fF7PjMZ/293zpjSZd2Jjbpd+czaDh7a092KwZgpx8dtsxtKqmFWW7p7+ryf0B8L4H9
         UObNGzvT2xorlxXRudhAG/wjdBPRbO2EuHP6lcoKQjlAm+1hbXxQf/ZkUKZgd3o6O/HP
         BO5tuFJwEwGcXyOElaWFaQdSeFvKn8Kbi6Oe7QBPEL66XyRlyWzuxyxaFC/CLcLFG/S2
         I9bcyfqsEJz7Z8WdDtG2zp5m3YnB5BmRFwDqzAp0c2h94h3KibWYKKmiYMBadRtnrQdK
         2swwc8ARDLIHAu9rF1R2muI2BLA5gFcuxJQfT6YCRrnqFC20eC81msKtciL0nSyJbMI7
         /8YQ==
X-Gm-Message-State: AJaThX4fW1ybX20noAN/zvXw5RqraK/NVGe5sdMIFZqg2giiS2AxNuCH
        HiNyivksyd5f94n/wxnR2zwhDZXtuU8=
X-Google-Smtp-Source: AGs4zMacsqf6hAgeSBVrrernwwIOMmG7za4yroWvr8bx6l7I+C6SeCkb4eHR1+vjUg3VA35TUjbxlQ==
X-Received: by 10.107.39.207 with SMTP id n198mr13748549ion.180.1512168617281;
        Fri, 01 Dec 2017 14:50:17 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id p17sm3420475iod.15.2017.12.01.14.50.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Dec 2017 14:50:16 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jacob.keller@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [WIP 0/2] Submodule ref backend that mirrors superproject
Date:   Fri,  1 Dec 2017 14:50:05 -0800
Message-Id: <cover.1512168087.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.15.1.273.g588edb5b8.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I sent out an earlier email [1] that discusses the idea of a submodule
ref backend that mirrors the superproject. Basically, if this backend is
used (for example, through a configuration option), the submodule itself
will not store any "refs/..." refs, but will check the gitlink of the
commit of the ref of the same name in the superproject. For example, if
the superproject has at refs/heads/foo:

    superproject/
      sub [gitlink -> 1234...]

and at refs/heads/bar:

    superproject/
      sub [gitlink -> 5678...]

Inside sub, "git rev-parse foo" will output "1234...", and "git rev-parse
bar" will output "5678...", even though "foo" and "bar" are not defined
anywhere inside sub.

(The submodule handles refs that do not start with "refs/" - for
example, HEAD and FETCH_HEAD - like usual.)

[1] also describes what happens when the submodule attempts to write to
any "refs/..." ref.

For those interested, here's what such an implementation might look
like, and a test to demonstrate such functionality. I have partial
read-only functionality - a lot of it still remains to be done.

[1] https://public-inbox.org/git/20171108172945.33c42a0e91b4ac494217b788@google.com/

Jonathan Tan (2):
  submodule: refactor acquisition of superproject info
  submodule: read-only super-backed ref backend

 Makefile                       |   1 +
 refs.c                         |  11 +-
 refs/refs-internal.h           |   1 +
 refs/sp-backend.c              | 261 +++++++++++++++++++++++++++++++++++++++++
 submodule.c                    | 107 +++++++++++------
 submodule.h                    |   5 +
 t/t1406-submodule-ref-store.sh |  26 ++++
 7 files changed, 374 insertions(+), 38 deletions(-)
 create mode 100644 refs/sp-backend.c

-- 
2.15.0.531.g2ccb3012c9-goog

