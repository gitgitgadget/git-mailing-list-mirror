Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CBCC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 23:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC41620736
	for <git@archiver.kernel.org>; Wed,  6 May 2020 23:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSNi3zA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgEFX2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 19:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgEFX2v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 19:28:51 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A03C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 16:28:51 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 207so1910415pgc.6
        for <git@vger.kernel.org>; Wed, 06 May 2020 16:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5kkAJ4HzRirORvJzWB5TBbp5R44dVYkopcyq1CoMtrM=;
        b=XSNi3zA2IUNggNnm0+fAhggDvP+hAnR0XZXbNUSt6wpnBzUTDiKHbtEGioQi9OOyZ3
         /lsHygGZ1payVcVoeZXjS54IPQwAQc8xWf4/XOT7iQQ3hknUOGOvmaDIuvhfoned6Rls
         Bm50kC4a+c2HzC7wzzYOftoCA+RHhvtkzLJs80vdF0VK9SN+/Uyz8r+6TfY+UdaxDC4g
         NWL973u9iYov5hJkYt08R9pP3a5V3okZydhqSWxRzOT6fsmy2fwUWim/6pWWDeiVVsiZ
         3dXEYVWH8IgI7WBizR5vaotFM2TD3iwpQGa0a0+jjdyBPGCsnXmeB9x/cJB4PWfw2hDs
         rNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5kkAJ4HzRirORvJzWB5TBbp5R44dVYkopcyq1CoMtrM=;
        b=e/PsED2Q3cJGUdWxI7RvIeniBVNEQn7ifaZB0L0LkP+yROpFuWQ2PNtAkJ5rRMbF9V
         iMk0VVV1LvbTHHFKawNX8CEb67ax4ZD4OuMbPbg3I1YwLw8aOL7DGXcmB7UpXhYgGJyS
         ewQLuhtpwRCZWl9X5tbeUAugFpvg7vyDogBCTGsRAzk/y2q7xSx+nLeYa25/4EM2yPGk
         OmJG9k80Iy21H+kq92uUMNaiVUOg5WcQae0a7H3gNK9DS2Z3deWa+Nn7y/uuq4wyFzU1
         M3GbtCAORZj95N9NLuoj8mCYsIMUbnYiXM+3br2clSvnL5kYYXW9oRo4jQzr2QOyrIKt
         sRMQ==
X-Gm-Message-State: AGi0PuYZQb/TNnT+XHocqwOjVN/s+1PXAa/FDf5MrDkgyejeKAj0Vbbe
        H2CSs/+UJurqUoDta08jJjQ=
X-Google-Smtp-Source: APiQypJ40B9S80Hb+9iSWDNV8qd6Aw8lQLUyOILlHN6sYLppzPPX3VSWPxj5QIsMOECsf+KVA9Hecw==
X-Received: by 2002:a62:e80e:: with SMTP id c14mr10406629pfi.83.1588807730680;
        Wed, 06 May 2020 16:28:50 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id 188sm2838669pfg.218.2020.05.06.16.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 16:28:50 -0700 (PDT)
Date:   Wed, 6 May 2020 16:28:48 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 0/4] credential: documentation updates for maint
Message-ID: <20200506232848.GB75901@Carlos-MBP>
References: <20200503063423.83152-1-carenas@gmail.com>
 <20200505013908.4596-1-carenas@gmail.com>
 <20200506162712.GB1275237@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200506162712.GB1275237@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peff,

thanks for the feedback.  as I mentioned in the cover letter for the reroll
(which I am hoping you could Reviewed-by fully), I am including this extra
patch on top that tries to clarify the format of the values, so that helper
developers could adjust their implementations as needed.

Carlo
--- >8 ---
Subject: [RFC PATCH 5/4] credential: document encoding assumptions for values

Because of the similarity on the names of the keys with what is defined
in RFC3986 is easy to assume the same rules would apply here.

Make sure that the format and encoding is well defined to avoid helper
developers assuming incorrectly.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Documentation/git-credential.txt | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 8d990e92fd..d72e85c874 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -113,9 +113,16 @@ separated by an `=` (equals) sign, followed by a newline.
 The key may contain any bytes except `=`, newline, or NUL. The value may
 contain any bytes except newline or NUL.
 
-In both cases, all bytes are treated as-is (i.e., there is no quoting,
-and one cannot transmit a value with newline or NUL in it). The list of
-attributes is terminated by a blank line or end-of-file.
+In both cases, all bytes are treated AS-IS (i.e., there is no quoting,
+and one cannot transmit a value with newline or NUL in it).
+
+Values start inmediately after the '=' separator and could consist of 0
+or more bytes until the required newline delimiter. No assumptions of case
+insensitivity can be made on their contents and if a specific encoding is
+required (e.g. "UTF-8") then the byte contents should be re-encoded before
+use.
+
+The list of attributes is terminated by a blank line or end-of-file.
 
 Git understands the following attributes:
 
-- 
2.26.2.686.gfaf46a9ccd

