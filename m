Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA31DC2BA2B
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 21:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A65221F9
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 21:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkTckXr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgDPVF1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgDPVF0 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 17:05:26 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DB4C061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 14:05:26 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id m21so2217216pff.13
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 14:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bvjd2JHaW8/kIVKUslXU4l15fN4tToM4B+lvjUl0MZM=;
        b=OkTckXr+/DdWErLiicdOChQLloeCrqG1Sh0Wo79jftsO9QPBSFOJ6VMNxx0fwka/Kp
         byzX7xTjxpAqZLSIKyInNfUCIWAsrC2Uqab70bmyTemFAP2BsOQMCCw6hYI6+tFB2X/y
         AZYgMORwYDHHerZTrmnjfZsHibyPZS4LZk2Zs7xxBNW+evZPdTeNZJ5h9OLfR2VipEFr
         2Ja+HVhrDiORRwulBSPj0XilW0QRqDPBN6kBS24SSbNTFoKZuVa+NYAs/q0xetRpc4mr
         9+uPqtMEk5Q1rCwdYNXuzkVUPNJiB9Preuh+1vyp/71wdyb6YlY8rEozhB1DGLRzkVjP
         0Bdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bvjd2JHaW8/kIVKUslXU4l15fN4tToM4B+lvjUl0MZM=;
        b=d/5K+WFLEPqFcW0kjiTIPURcvGnVyKqqaxcZNBcZzlae71BeFmeIH+WbEy4ynpf4bP
         J1jIc0wutEUrmgKFbfsOsovYX3CYGrtm2tbLh7xFVmyeQlBkoG5eSWVANZL99dr2cot1
         4V2tqDJFQhJstbYn0qdaziSVhdSx7vvFkbG3oarXdJ5NvRWrso2jfGro5pWdoFvKay9d
         B5uaBu0rqVJ4NTxNsv8+jfJ6nvF4TXKnoL7tS/Kc43Xql+Rk52zSRELOK3R5X3iG2006
         45ZiCrWyypzEBuF9288SxmDy32LhTgOb9rUwPzkBdbx5NI2BL7ljtUXgR+R5MUeU5Hhy
         WQ+A==
X-Gm-Message-State: AGi0PubIvBF997bgxTMk4VgyH9tjPV+j5W/IebqE2f1hadYzxQysw/aH
        ud2sG9ue+ERxvIhdiCByOcGFeOrD0lQ=
X-Google-Smtp-Source: APiQypLji5cSwryCOpiH34GQX+1stQymNOralLzdrFwBDpp2s9RG8J2PTit6B0sGZDyFW2hNmnVISw==
X-Received: by 2002:a63:d40a:: with SMTP id a10mr32238101pgh.53.1587071125667;
        Thu, 16 Apr 2020 14:05:25 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.171])
        by smtp.gmail.com with ESMTPSA id x18sm10524090pfi.22.2020.04.16.14.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:05:24 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, peff@peff.net, heba.waly@gmail.com,
        Johannes.Schindelin@gmx.de, gitster@pobox.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [RFC][PATCH 0/2] submodule: port 'set-url' from shell to C
Date:   Fri, 17 Apr 2020 02:34:54 +0530
Message-Id: <20200416210456.19122-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

This is my very first attempt at the conversion of subcommand 'set-url' from shell
to C, thus making the subcommand a builtin.

I have based my conversion by looking at the way other subcommands have been implemented
in 'submodule--helper.c' as well as the subcommand 'set-url' in 'remote.c'. The approach
I have taken is as follows:

1. Create a helper function 'update_url_in_gitmodules()' in 'submodule.c'
   to update the URL of an entry in '.gitmodules'.

2. Port the function 'cmd_set_url()' in 'git-submodule.sh' to 'module_set_url()'
   in 'submodule--helper.c'.

The issues I am facing are:

1. The patch fails test #2 in t7420, i.e., the test to verify the working of 'set-url'
   subcommand.

2. Though not an issue affecting the patch, but the 'usage' prompt of 'git submodule'
   does not show the subcommands 'set-url' and 'set-branch'.

Also, I am aware that the patch does not support the '--quiet' option. This is something
I intended to add after ensuring that the patch works in the first place.

I understand that the patch is in a weak condition right now. How can this patch be improved?
Any guidance from the community would be appreciated! :)

Thanks,
Shourya Shukla

Shourya Shukla (2):
  submodule.c: update URL in .gitmodules using update_url_in_gitmodules
  submodule: port subcommand 'set-url' from shell to C

 builtin/submodule--helper.c | 38 +++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 23 ++--------------------
 submodule.c                 | 33 ++++++++++++++++++++++++++++++++
 submodule.h                 |  2 ++
 4 files changed, 75 insertions(+), 21 deletions(-)

-- 
2.20.1

