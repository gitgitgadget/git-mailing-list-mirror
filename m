Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6539DC433E0
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 16:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1365A64EF3
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 16:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhBZQb4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 11:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhBZQby (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 11:31:54 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17443C061574
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 08:31:12 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id v3so7042846qtw.4
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 08:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=mOobPkmu9NASA3lCmPF/WzXGOwwOwaZg5+7Gd1MUxIE=;
        b=TfPa0wynUpgH5R0+We/x14heU58tiXCo9ukFuqJ0HvJreX81eHjHEFCVOQBQlFyQTV
         zX22h3xofkPFC1Hspy/voZoZPrNB/DUlISG68crnRc0O/SQkdfs0WdoPynIZw1Cg714U
         loG9KzHwwptpA0tPvQxdH1LKNJP0FGgbD1ap/0bs85gl7hXa8kQtH0kvAexjdqKNTjxx
         VDjRPIW2Ndpco22VXdfHrcKIU0RlDXsn68eec76azctrCv5E7y66i9bvSVkCIXYl63Th
         URpYZX7cikS+SsQnTkRhFnet04yfIrstD+tGUaByEDNMRJHfWIT+MwcyHw8537vnfe1Z
         cNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=mOobPkmu9NASA3lCmPF/WzXGOwwOwaZg5+7Gd1MUxIE=;
        b=AA/dd13EvL+JhDZHOUOToMKrdURiEI2QxDlQinoufrIxS7hEKP5WXSxfppw3gxKZyH
         3Kf4ieCqZ4v7LG+icTdrOPaxnCjKYd7004YSrERslL7CoidPFBxcqXtLyOs5QamLHoTQ
         jP8TzRspSoER8MUdxfUXN/Yo0BvqORH8AT5hAL1TG5Zr9I4Q9zEw6B+Z+DUllRHkbI9t
         AFBewUg+z44i0HTeMNo6n5BaMtdmdsj/BQZjPEj0w1UEyPYohB0oJVxGX30f+7Q+cepy
         mOJfUE/orzxHtwZAb8PlbtCmNZePTmXIUW29DsHLK/LpGSaPRXoDkxCQYvoFCGr06L4M
         aGqA==
X-Gm-Message-State: AOAM530EVrDKTAFvaOb1O/nyw+lvrlpmwwO0b18vyo57Lm5S1e8a4+V2
        mNnwcWYXS1680e0dWIJRWZII3SjjRV9ismcF
X-Google-Smtp-Source: ABdhPJwvG4T+Hm388pP+RlozyVQ97jTtIgtH1nlZqRi1Zv9xxkgv5vZ8OI7JavrgFgBSnoRf+n2eBA==
X-Received: by 2002:ac8:674b:: with SMTP id n11mr3438464qtp.20.1614357070974;
        Fri, 26 Feb 2021 08:31:10 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:8dee:99f0:c019:6a03])
        by smtp.gmail.com with ESMTPSA id g89sm679145qtd.75.2021.02.26.08.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 08:31:10 -0800 (PST)
Date:   Fri, 26 Feb 2021 11:31:02 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com
Subject: [PATCH] pack-revindex.c: don't close unopened file descriptors
Message-ID: <34c017296a7c5fe4a2ea70f8a0b2d8586b34a4dc.1614357030.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When opening a reverse index, load_revindex_from_disk() jumps to the
'cleanup' label in case something goes wrong: the reverse index had the
wrong size, an unrecognized version, or similar.

It also jumps to this label when the reverse index couldn't be opened in
the first place, which will cause an error with the unguarded close()
call in the label.

Guard this call with "if (fd >= 0)" to make sure that we have a valid
file descriptor to close before attempting to close it.

Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
Dscho mentioned this to me privately when reviewing Coverity results for
-rc0. This one is legitimate, and the fix is easy enough, too.

 pack-revindex.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/pack-revindex.c b/pack-revindex.c
index 83fe4de773..4262530449 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -253,7 +253,8 @@ static int load_revindex_from_disk(char *revindex_name,
 		*data_p = (const uint32_t *)data;
 	}

-	close(fd);
+	if (fd >= 0)
+		close(fd);
 	return ret;
 }

--
2.30.0.667.g81c0cbc6fd
