Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2D8C433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1786F2074D
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uekwuh42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgEOKFO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 06:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbgEOKFN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 06:05:13 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95912C05BD09
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:05:13 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f13so1689224wmc.5
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qXZgZM9b5cv0Yd4u1IBpFN8DZ1zdWo1HvQCKYyUGv0M=;
        b=uekwuh42vqPESi+7xDtw91TbMeE/5+4s+0rbLQn+ukKSGAGVz1EAd6uLipJop8DNfq
         JOzBKtPiy5dV46hDbLNDB+tivw7i6U+hJN8XUioTCMa1iS3jIXVa+6yDssKpUd7MNgyf
         vvo52jb5N/nYwMsI7rvytfJpCZX/WiO//q2rXMS9g2FJAbSj0NhSlERs5+OS9uRRJetx
         aKfG15UPnEEj66cWaFPWm3oT9cVlhr72wX1MrK6ufhWwd7p+vPYEMykgnI9XjoER0Dw5
         3NF9bleIOIPe0aZWbjTbkiNhOTaxVZOMC+I0lhGRzsrlaNXJNryX6j2f4GBrZ9naaPK7
         +uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qXZgZM9b5cv0Yd4u1IBpFN8DZ1zdWo1HvQCKYyUGv0M=;
        b=qBvK5ZqASkTdICKwlawZbgCtOpoFOzxwtNgei+yOkR4GcA+aeECrLtTC0kKzaxG5aq
         u0L+8go1hvuJzSA4bQDMxPlf+eI+iV8Rr2DpMYjgQf1eQa7j1d26OtVw8N+o+8HffrX3
         TpGUYWl61yS6m5pkO97g8WKdu8p6wlvLF3JZkMsbkmLYIOgSg7IeFgZ9vuoV9Q4AEyHm
         PoEW9kR71bFhFGCEZ9Fnl9jnq8ZIZJPBndF7kZJlLzs2cC+Gekt159zvwEcMxPmVZEBo
         8B25zbNEqMLosjewVJq61JuJu9PCOehO5QKzb9aRAcqR4KM1bOX8Z3jwdV7FOhx+h4/h
         0zBA==
X-Gm-Message-State: AOAM533dG1ZnZgpbxjMDXTzU2OwbC/Ies3l+K1zawiNVsp6b0DjpmOh1
        fktFME84s9QNlyZ8V+ZA5go9IrW+0Y8=
X-Google-Smtp-Source: ABdhPJwt5Ix2GRI7MLCOLGPS+UFsjiy0L89oy+9Naqfzr5joSQfw36ciJnVWRikqIwR3zQe8bQSXWQ==
X-Received: by 2002:a1c:c3c6:: with SMTP id t189mr3121485wmf.94.1589537108869;
        Fri, 15 May 2020 03:05:08 -0700 (PDT)
Received: from localhost.localdomain ([193.57.121.171])
        by smtp.gmail.com with ESMTPSA id m3sm2792326wrn.96.2020.05.15.03.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:05:08 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 00/13] upload-pack: use 'struct upload_pack_data' thoroughly, part 1
Date:   Fri, 15 May 2020 12:04:41 +0200
Message-Id: <20200515100454.14486-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.26.2.639.gb7dde20fdf
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the thread started by:

https://lore.kernel.org/git/20200507095829.16894-1-chriscool@tuxfamily.org/

which led to the following bug fix commit:

08450ef791 (upload-pack: clear filter_options for each v2 fetch
command, 2020-05-08)

it was agreed that having many static variables in 'upload-pack.c',
while upload_pack_v2() is called more than once per process, is very
bug prone and messy, and that a good way forward would be to use
'struct upload_pack_data' thoroughly, especially in upload_pack()
where it isn't used yet.

This patch series is the first part of an effort in this direction.

While there are still a lot of static variables at the top of
'upload-pack.c' after this patch series, it does a lot of ground work
and a number of cleanups.

This patch series is based on master at 172e8ff696 (The ninth batch,
2020-05-13).

Christian Couder (13):
  upload-pack: remove unused 'wants' from upload_pack_data
  upload-pack: move {want,have}_obj to upload_pack_data
  upload-pack: move 'struct upload_pack_data' around
  upload-pack: use 'struct upload_pack_data' in upload_pack()
  upload-pack: pass upload_pack_data to get_common_commits()
  upload-pack: pass upload_pack_data to receive_needs()
  upload-pack: use upload_pack_data writer in receive_needs()
  upload-pack: move symref to upload_pack_data
  upload-pack: pass upload_pack_data to send_ref()
  upload-pack: pass upload_pack_data to check_non_tip()
  upload-pack: remove static variable 'stateless_rpc'
  upload-pack: pass upload_pack_data to create_pack_file()
  upload-pack: use upload_pack_data fields in receive_needs()

 upload-pack.c | 298 ++++++++++++++++++++++++--------------------------
 1 file changed, 145 insertions(+), 153 deletions(-)

-- 
2.26.2.638.gb2c16ea67b.dirty

