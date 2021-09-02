Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F38C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 12:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68C4F610CD
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 12:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344305AbhIBMST (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 08:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbhIBMSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 08:18:16 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A07BC061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 05:17:18 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id s11so1693046pgr.11
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 05:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DnYIIH6UeYgFuzLY4hvh5a0Ppg3hU4eqjM0zCc9Kwe0=;
        b=JcQpU1rfSKMeQtTWIQQ8gE2bsEVFis3TjFSWbp8DUXS3LPtMnJkj7r7rdwBSPIaqTt
         kaytsRsL/PnWQdAqiF1D+wwCPiEgJZ7EBdWsOOAc7LOglELwjzJ8hw7k4kO3GdbNTCCu
         9M0Sf/w4tqU1xE0BzvQcEW5NgiI5TvuRMzGDXr9BFUsfa3lSFUlMi0ujaasKsZUQE4Ma
         /WSsy+d+B9jiBhMammPdN83+Z1+sd9J5HTZ5CmYFBZJUwb/5cGHRElBPF6MoXMvdKMVn
         CEt7etAQmqcruzBhvst+P3L4Yad0w7qXrsjegezuFILDvGai23vt2paXHLCTHaA7xA1D
         lU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DnYIIH6UeYgFuzLY4hvh5a0Ppg3hU4eqjM0zCc9Kwe0=;
        b=OklJKP7YXIpJprIVuBwFdVlrIX5p+FudL/KCocL6hMU4TSFCC+82A5FmYKYQYYO0ZP
         18aCYfxv03tXOZXmgtB5hSyjs82qmvgrTGxQEz1g7OYiiZkfdUD/IJEKuyUkiRLJY46/
         MgQCoiBdAmHhqowrj1M9wkiMGT+mPhzyyl815RoQnoEqPrNg83KQ8sXtCrQdCWN2EeNX
         8xZzlMjqYIiXS8ZP8UGmD5xUeoAZKGdobNgKP6bdoQ4B6uIIlj4+6z0Z5Gka7wVpY1jJ
         yvw7RKAo3Tko2IiBYtmLUm9QE0U5EM6x5J27Efpr4fl/CYd/3mU0q2HFicSm3a/Twkzz
         YL8g==
X-Gm-Message-State: AOAM530z7Z94VJX5l7VWz8x4LqXtI3SvU47rL1bjb1UF6rqQ76pqeuvt
        rsAwTdOIubYQI2Nwa77Kus3YBHXHEZn3cXHn
X-Google-Smtp-Source: ABdhPJynhlFT+BksIeIAHSLfeDLEiEkRN5TxsD+UdDQgTC3bLGmO1zaem0C+cUDw4IAfcUq0bmryGQ==
X-Received: by 2002:a65:6554:: with SMTP id a20mr2895317pgw.107.1630585037555;
        Thu, 02 Sep 2021 05:17:17 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.145])
        by smtp.gmail.com with ESMTPSA id v23sm2161081pff.155.2021.09.02.05.17.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Sep 2021 05:17:17 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     avarab@gmail.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v5 09/14] commit.h: add wrapped tags in commit struct
Date:   Thu,  2 Sep 2021 20:17:09 +0800
Message-Id: <20210902121709.77198-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.456.g1a7c4c5894.dirty
In-Reply-To: <87wno9axfs.fsf@evledraar.gmail.com>
References: <87wno9axfs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Ævar Arnfjörð Bjarmason wrote:

> Can't we store this info on the side between these two static functions
> somehow, instead of adding this "wraps" to all commit structs?
>	      

Thanks very much and I have some doubts.

> ... instead of adding this "wraps" to all commit structs?
I think "adding this "wraps" to all commit struct" is an easy but a little
rough indeed. I didn't know if this is okay at the time. So I pushed the patch,
hoping to ask some different opinions.

> Can't we store this info on the side between these two static functions...

Do you mean to use static storage to share the "wraps", or other way? I want to make
sure that I understand your opinion accurately.

Thank you.
