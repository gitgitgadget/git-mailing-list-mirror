Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CC8C433E1
	for <git@archiver.kernel.org>; Mon, 18 May 2020 10:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22C0D2081A
	for <git@archiver.kernel.org>; Mon, 18 May 2020 10:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dtucker-net.20150623.gappssmtp.com header.i=@dtucker-net.20150623.gappssmtp.com header.b="J/Bdm1ik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgERKER (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 06:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbgERKEO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 06:04:14 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF26FC061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 03:04:13 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f23so4592263pgj.4
        for <git@vger.kernel.org>; Mon, 18 May 2020 03:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dtucker-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vWrjir7K2/mpy1WZhJAKGYkUh9E1XAV66xmDJoBNslg=;
        b=J/Bdm1ikrYi8DDWAf8cerx4Icw4hLAiPn1gH3uNDp1vqdm02You5I7rV7G50OYFzm6
         Gec8CgcmGNvHQq5vyzdUkRyDArMHxP+CBMu+iXPwdPj9cKNs93P6+Zlzi0GIimnKmTyX
         X0AcUTMhfA+ML4IjZJP8YkREZgdbNjcqVYzR1Z3cWJXw6til0DvFtMoAh0edUM9K/vsw
         spswiaeJbyPv+zABiFiUBvKXSAlXzSc9Zu8HnpFmcosGv//1B384rZMznZ34AytVr4Nh
         c+jhkXI7wGycJ0nOkHVUO5fQoEv8PMU1AsuubyO6z1OObA8Gc5nDGKNdJR9fiVpuKR6j
         f4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vWrjir7K2/mpy1WZhJAKGYkUh9E1XAV66xmDJoBNslg=;
        b=FcYGDqJHr4X2+dLLntv9lHmYCjy8wSTBl0InUEiN+htiz9GMiZlkXY+h1+tvJFiL7n
         XzCwQO+dsYZGejXYWsN0OkWIYy/fj5+uvvWVXYAXdsrR8moHVATaLzB0wc9UsplPxCC6
         zR4ZDx3Pqdmime+w1I5vUT1HohbLWpwC7dBU2HzRVkPuJnfisCfBwjyud+pnGyTOcoNJ
         qWMZH2P3zIkV7e4m1WnsRd60Me5aSdlKzeJ85FYoZlC9m9VdzwaNLEwB32QOoUBTOicC
         zIcxanCdkbYK6Gnu8RZ+Ipyuashr5fekDw/GGU+1llBUSO+xiZc6kMTiaSis3Zj/MunQ
         m+KA==
X-Gm-Message-State: AOAM532modB049YyIUdJJUVrCpLXnl50ZvoiQmw3rvj/f3JHnrD/eFUF
        7CFONmge1v9W+TMJRdPL0hIfDy4HS1tLHu/mzNumiNpvt+b8taSQ866AOHjLns+v7Y4tyzS4Tyk
        j5pVaqJp+LoqISFAccJd1uqr49o1yjYlAbya0Hnbiz7fLZcx1LKbYIEDa8WBa2bM=
X-Google-Smtp-Source: ABdhPJwbrmhMSuZvP6+NzmN1awOTnveDZWHG63d7Y6SFx2vj2mqv5vJPVthfXXzoPXkO9qU3s8CI+Q==
X-Received: by 2002:a63:c04a:: with SMTP id z10mr13998443pgi.430.1589796252861;
        Mon, 18 May 2020 03:04:12 -0700 (PDT)
Received: from fw.dtucker.net (ppp59-167-129-32.static.internode.on.net. [59.167.129.32])
        by smtp.gmail.com with ESMTPSA id cc8sm8094167pjb.11.2020.05.18.03.04.11
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 May 2020 03:04:12 -0700 (PDT)
Received: from gate.dtucker.net (2001-44b8-3110-fb01-0000-0000-0000-0001.static.ipv6.internode.on.net [2001:44b8:3110:fb01::1])
        by fw.dtucker.net (OpenSMTPD) with ESMTP id 877fce63
        for <git@vger.kernel.org>;
        Mon, 18 May 2020 20:04:02 +1000 (AEST)
Received: from gate.dtucker.net (localhost.localdomain [127.0.0.1])
        by gate.dtucker.net (8.15.2/8.15.2) with ESMTP id 04IA413e029463;
        Mon, 18 May 2020 20:04:01 +1000
Received: (from dtucker@localhost)
        by gate.dtucker.net (8.15.2/8.15.2/Submit) id 04IA41Rh029457;
        Mon, 18 May 2020 20:04:01 +1000
From:   Darren Tucker <dtucker@dtucker.net>
To:     git@vger.kernel.org
Cc:     Darren Tucker <dtucker@dtucker.net>
Subject: [PATCH 3/7] Test for strtoull in configure.
Date:   Mon, 18 May 2020 20:03:52 +1000
Message-Id: <20200518100356.29292-3-dtucker@dtucker.net>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200518100356.29292-1-dtucker@dtucker.net>
References: <20200518100356.29292-1-dtucker@dtucker.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's already used in compat/strtoimax.c

Signed-off-by: Darren Tucker <dtucker@dtucker.net>
---
 configure.ac | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configure.ac b/configure.ac
index 4effc82b76..14e09b04b6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1158,6 +1158,12 @@ AC_CHECK_TYPE(uintmax_t,
 ])
 GIT_CONF_SUBST([NO_UINTMAX_T])
 #
+# Define NO_STRTOULL if you don't have strtoull in the C library.
+GIT_CHECK_FUNC(strtoull,
+[NO_STRTOULL=],
+[NO_STRTOULL=YesPlease])
+GIT_CONF_SUBST([NO_STRTOULL])
+#
 # Define NO_STRTOUMAX if you don't have strtoumax in the C library.
 GIT_CHECK_FUNC(strtoumax,
 [NO_STRTOUMAX=],
-- 
2.21.3

