Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAA8C2D0D2
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 01:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F374B20715
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 01:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlDwW3Fy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfLXBAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 20:00:04 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:42504 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfLXBAE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 20:00:04 -0500
Received: by mail-pl1-f172.google.com with SMTP id p9so7825864plk.9
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 17:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=swXz1l8xqR8M8lYSRTQjF3d5fj3eCMHeDB/Nh/woZHw=;
        b=BlDwW3FyVPgelIjA8FVOrPQYh14YvKIjM+basrueJODHHtEoTDi3vIQUAfrwWB8G4i
         lpSL87oX8g5yUnCZ+ay+hU8slTFmIHZ0Go0qcWoGaRH+K09XNQSfkZ8+1SKG2VUzdOOM
         MPcW6pypkLxwMH3HfmvzblRoO1HZeR/VzqkEsJebCZipv+DrebZiBAc/iLXRNtvksXJ4
         xXrwYziT3PnaOrCudHxyJDfqO/3VDhaIWwz9qKGazl+a5nZ7db14bojoPYUf7bvpsgVo
         G4pBnFlGiQF6qNARrR0P0/eUgmRZwi7z3yAxEQLUOalTyozBl3MuORnhk76YkBfH+1QL
         jjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=swXz1l8xqR8M8lYSRTQjF3d5fj3eCMHeDB/Nh/woZHw=;
        b=oJ32xVsiOxmJ/9O752PnCpnJEk9MudPkhgs6VtqzVW3jhnMw8OcfUqD+N5v09CnUe4
         KxyvRPrtFRuJqHPwO4HFVnIPmIWFQ/8zfAXGj8tqwC4UlFAXmqPuhTvgkrRtUSqe2lSj
         QA2FNgBcS5+J7Pute0oKMHuCdLtb10yfTf9EDWgygAdCYAIQsymrpe9AxuoYxFOIyuNl
         MjXHTyzphaitRv4E4uqX3HLMp1iY4/c1wNTrW3AV1OMGFijN+v2GN0Adkp+9MbGCCtvO
         7hAMullSoXChIV4Dq+7c3IU/0XeSt+qVHex+CwlNusiOuqtqnEzK5qNZEWew2+D+yBvf
         XRMg==
X-Gm-Message-State: APjAAAXls8Qbn5Y7C3Mnjmk5pdvu8OHpTMxAKrCklC2DckwBeHybj1ty
        KYNP8ZOLI0NyB94NdhRDgfI4aRK6
X-Google-Smtp-Source: APXvYqytAuia2fuS077Yxjxc0Rgskv9VXsyTo/5RS3YBCOsUne2HNLuRq3rh9HrDNcRs+A9vrtbBEg==
X-Received: by 2002:a17:902:42c:: with SMTP id 41mr21333121ple.7.1577149202841;
        Mon, 23 Dec 2019 17:00:02 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id u7sm24898980pfh.128.2019.12.23.17.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 17:00:02 -0800 (PST)
Date:   Mon, 23 Dec 2019 17:00:00 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 2/5] config doc: protocol.version is not experimental
Message-ID: <20191224010000.GE38316@google.com>
References: <20191224005816.GC38316@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224005816.GC38316@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git's protocol version 2 has been working well in production for over
a year.  Simplify documentation by no longer referring to it as
experimental.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/config/protocol.txt | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/protocol.txt b/Documentation/config/protocol.txt
index bfccc07491..0b40141613 100644
--- a/Documentation/config/protocol.txt
+++ b/Documentation/config/protocol.txt
@@ -45,11 +45,10 @@ The protocol names currently used by git are:
 --
 
 protocol.version::
-	Experimental. If set, clients will attempt to communicate with a
-	server using the specified protocol version.  If unset, no
-	attempt will be made by the client to communicate using a
-	particular protocol version, this results in protocol version 0
-	being used.
+	If set, clients will attempt to communicate with a server
+	using the specified protocol version.  If the server does
+	not support it, communication falls back to version 0.
+	If unset, the default is `0`.
 	Supported versions:
 +
 --
-- 
2.24.1.735.g03f4e72817

