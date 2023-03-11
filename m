Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9245C61DA4
	for <git@archiver.kernel.org>; Sat, 11 Mar 2023 21:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjCKVGy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Mar 2023 16:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCKVGx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2023 16:06:53 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727244DE03
        for <git@vger.kernel.org>; Sat, 11 Mar 2023 13:06:48 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h11so8056470wrm.5
        for <git@vger.kernel.org>; Sat, 11 Mar 2023 13:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678568807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MByL5ZsOKNtpgvm+kWKF61CfVRgzaIztMHnKeQlatQs=;
        b=RM4uMUbfOlivMv8wNtOoLt3kSjRSMahkIorf05OJvniKm8FuiZv9iO36NGCxG4/NBP
         Ozc4boFuj6VwZfdCJOllRCxLWiWX16fyMtcRb3iw2d8ny7AvwZw8s+vP6Wv4sIrl4QyY
         wVT5Bs3o3RjuXvZPBF1/d6fAROLZlm7nLDj7XC2/jfoNp0p/7mHPT1BTSTe+Ft+LX0t9
         fSDDc5nErBhVrC5/l/47GWIyY2lJLNt9KZglmdOeoEPyTEvSjD5BXelCrYsDH6ou5d17
         l47+shllY3HonRmdNU2r6sqpI/6YoWn3AEYMFHUm/Ry49QM72SzrvPBt24TH1t17r+oW
         AEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678568807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MByL5ZsOKNtpgvm+kWKF61CfVRgzaIztMHnKeQlatQs=;
        b=qQmxp/WiQge/mapr3GfVFKaBMqa2Kg4nuTH8feODqjqQC1+bmFeQVxgLsNVdQlW9iQ
         SXQS4H3dryKCpbDX+tnjC2wlSbp45lk+B7TnQ2CqVaCF9vEnLi87QVJZJN1YFmfvIZhH
         t9OsIwZfpfqXCd7BVrU7pnIrca2adz0DUy2nVp34/Z5JoUv2Hrar46Vre0ZcLVi3Hqgz
         lslpyTpiS6vYMw6jAKeI5QsMEcwu5tr2H+0Xmjmfjg8sixf13FWgdyQICBFPWQn1aQl1
         3GSyecNZxVH2WgqLFjOuph5vbzn111uy9+1GH0WAz65KFRy3e+iDtIp/p/Yyc8ETYiQv
         L92w==
X-Gm-Message-State: AO0yUKUlDofejP3pitZAmFQKEQgnsJKfu1099Vxjm1qSOYMftutBeX85
        nxI+j3dOA1MPxV11LPewl01O5+MTwaQaqw==
X-Google-Smtp-Source: AK7set9qejvzfAINSbmU6UgH/gotuqUjuG26905WFDu82o3Sw0rrkw5X8W4YNZyO8wFSNSkEJE0hbg==
X-Received: by 2002:a5d:457a:0:b0:2ce:9f0d:df51 with SMTP id a26-20020a5d457a000000b002ce9f0ddf51mr2740020wrc.69.1678568806562;
        Sat, 11 Mar 2023 13:06:46 -0800 (PST)
Received: from wilber4c.. ([197.239.13.29])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d608a000000b002c5493a17efsm3345137wrt.25.2023.03.11.13.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 13:06:46 -0800 (PST)
From:   Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>
To:     git@vger.kernel.org
Cc:     Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>
Subject: [PATCH v5 0/1] ref-filter: add new "signature" atom
Date:   Sat, 11 Mar 2023 16:06:06 -0500
Message-Id: <20230311210607.64927-1-nsengiyumvawilberforce@gmail.com>
X-Mailer: git-send-email 2.39.GIT
In-Reply-To: <20230116173814.11338-2-nsengiyumvawilberforce@gmail.com>
References: <20230116173814.11338-2-nsengiyumvawilberforce@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch addresses Junio's comment
here<https://public-inbox.org/git/xmqqmt65atu1.fsf@gitster.g/>. I
introduced an integer flag called signature_checked to cater
for this.

Also, the fact that "test bare signature atom" test was failing on 
different machines(CI on github) due to trustdb, I introduced a hack
to cater for this.Something like this,
`grep -v "checking the trustdb" out_orig >out &&`

Nsengiyumva Wilberforce (1):
  ref-filter: add new "signature" atom

 Documentation/git-for-each-ref.txt |  27 ++++++
 ref-filter.c                       | 106 ++++++++++++++++++++++++
 t/t6300-for-each-ref.sh            | 128 +++++++++++++++++++++++++++++
 3 files changed, 261 insertions(+)

Range-diff against v4:
1:  d9ce65f411 = 1:  d9ce65f411 ref-filter: add new "signature" atom
-- 
2.39.GIT

