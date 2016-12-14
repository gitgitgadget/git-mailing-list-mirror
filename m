Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB57820451
	for <e@80x24.org>; Wed, 14 Dec 2016 01:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754649AbcLNBmV (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 20:42:21 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35755 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752738AbcLNBmU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 20:42:20 -0500
Received: by mail-pg0-f48.google.com with SMTP id p66so2000161pga.2
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 17:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qfmUSKNPEiIXElXl2RS2W4Mth3gxLmjS4SGxOOc4OtA=;
        b=HpxnR6ZEijKm/kU3PLB+hDLVz4PAbd8aKAt78W+kahPOQ0O2yMYiulkXe1SvhBMMP/
         02Dkv1TTY4ZaEkm5N3aufqaT6ob4ajoIwGw+Vjm3wle4VNwJuvxUuqRlRa3MYDJf1Bln
         E3uJkWVzjQvo7KTt3jN2Ajfrsl8WpD0tiEIK+1FtVcz3lm365NTxPy1YSqD0f8D/RLvm
         WgFaomOSJV+ID+WeFpbkdnh12AInoUzlHiKYiTXdmYXqzI6E69o5VWolWnHOeX03vi7+
         Svy7u5ZEMuIGlE52GJqliduvRj8N20zKVt/4QMEGXRo7IH+UuZHBnmtXWwVgonuEvDd7
         VwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qfmUSKNPEiIXElXl2RS2W4Mth3gxLmjS4SGxOOc4OtA=;
        b=GRKkii5fn6sfw2KMyxxJUL/OfIftctS459TnkyxZXsbjbVSVL/paYWg3oigfYyHKJP
         hp3TDPYdHYuko12qBFX2itkvbYNnMYKspVjvv1pUblfyzZDTxn+Hb70e5fsZfhYDyodt
         wDgO+N7r/iO3Gc7VlQVeiMikcOZInIcGTSR9v+bOVMeiSMrAdwItPFauhoTJhd7lWbTS
         uKaNcgx2o1ITBFdBN4YCrXWF/8ScsHNFYcVnFfCM91bOm8LK3CGYnPTj0e6xV2A05lEi
         c76HTGQADOdjnOLCxF3kYfPu7vTAV17jrSRK+nOO8q58+i/c9ZOejsLUHgIuCJ6WP9SE
         srZg==
X-Gm-Message-State: AKaTC00vfhydiHh5a8jBErU//mTIlFuuSs1/PDyafAW8sE5dg8H4ANJK+5EgSLrR3wDDNS/o
X-Received: by 10.99.151.1 with SMTP id n1mr181598244pge.122.1481679698165;
        Tue, 13 Dec 2016 17:41:38 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id b12sm82462599pfb.78.2016.12.13.17.41.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 17:41:36 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, peff@peff.net,
        sbeller@google.com, bburky@bburky.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: [PATCH v9 0/5] transport protocol policy configuration
Date:   Tue, 13 Dec 2016 17:40:32 -0800
Message-Id: <1481679637-133137-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1480636862-40489-1-git-send-email-bmwill@google.com>
References: <1480636862-40489-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Only difference between v8 and v9 is that v9 has been rebased ontop of Jeff's
http-walker-limit-redirect series 'jk/http-walker-limit-redirect'.

Brandon Williams (5):
  lib-proto-disable: variable name fix
  transport: add protocol policy config option
  http: always warn if libcurl version is too old
  http: create function to get curl allowed protocols
  transport: add from_user parameter to is_transport_allowed

 Documentation/config.txt         |  46 +++++++++++++
 Documentation/git.txt            |  38 ++++-------
 git-submodule.sh                 |  12 ++--
 http.c                           |  36 ++++++----
 t/lib-proto-disable.sh           | 142 ++++++++++++++++++++++++++++++++++++---
 t/t5509-fetch-push-namespaces.sh |   1 +
 t/t5802-connect-helper.sh        |   1 +
 transport.c                      |  84 ++++++++++++++++++++---
 transport.h                      |  19 +++---
 9 files changed, 305 insertions(+), 74 deletions(-)

-- 
2.8.0.rc3.226.g39d4020

