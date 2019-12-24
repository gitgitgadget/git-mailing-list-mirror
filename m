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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE06C2D0C0
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 01:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8CE206D3
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 01:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbPt9tXT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfLXBCb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 20:02:31 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40939 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfLXBCb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 20:02:31 -0500
Received: by mail-pg1-f195.google.com with SMTP id k25so9616227pgt.7
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 17:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=69RjXz5jYMzwILVC1E7OOCuKUAAZHqTlBgG24r2rvRg=;
        b=ZbPt9tXTtAR5MjEDdF8nAd9E37BpTO/rEC1AQutUWoPo3FrIMHDX6enwn5y/CTCrqG
         1XMOcamAL/HrPJq2hjxdAfHTRVhPSsQEtgFsiqaluuhpGbm4JDuc52gumsfA5OIYWqhZ
         RPoQHtP82Cz8mf53NV5WzbHskUJ283zW2FsFBU4OODfSuWTftZknZK2zyyo6MXBT+xnK
         d3zATj6JRvHBuEep5N7fGzfTdu3q4cgfrIPF/HleyhuFNFea0u2QwRAjSDcJUpEOZEub
         Ary2BbfoHeKc1+nrW6hYEKs5XUPYXIHapdxIRWF0Hgipm67WCTU14Y/XxUkKdkTtx5jT
         YpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=69RjXz5jYMzwILVC1E7OOCuKUAAZHqTlBgG24r2rvRg=;
        b=IzVkwfPX/dgUOJ6q3o5hjlr+nfBXSrSRyZ0HkqXZpVzpl3lXIlF86M9phRFjymP9Sg
         FnihgwRH0sPC6kghUDugtPiK+8pb/5rVgv8pA0aH/NUZ9AU5WiBzhhoP9H3CAL6+hWxr
         vJ+QcShcTX8ShAw+vMq/ncjpB+rKW5buT1Bw08EcbsoejEq8SpPQb1veqWVbBpJ49ubx
         pfDcry/9+avBVVc4WfuAe94D7c2CjQguVFkQARyPcozGfM+lOACLHjEBGXLJAat6OqeR
         MfyaMb4UqzjTUaosBwKcCkqDpfwPI1g261dZrxbvkTuNBbuu8HfKxEz8Gvni9STDz8P6
         z2Sw==
X-Gm-Message-State: APjAAAXaG6GeYGP0yM4Uoz075WXFTCqYOp1qvdf96Ry6roJjJItl/LCq
        U967pW5O5Q6YtTQE3dICHv1Wi1v7
X-Google-Smtp-Source: APXvYqzOTjxso6VKj+xGrrz0316SMqrsZmrS5R0lLX47H+orKEVnJ+0qOnqltli61d47Qr2u0NWaew==
X-Received: by 2002:a63:214f:: with SMTP id s15mr36071506pgm.238.1577149350477;
        Mon, 23 Dec 2019 17:02:30 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id q12sm25929297pfh.158.2019.12.23.17.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 17:02:30 -0800 (PST)
Date:   Mon, 23 Dec 2019 17:02:28 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 4/5] protocol test: let protocol.version override
 GIT_TEST_PROTOCOL_VERSION
Message-ID: <20191224010228.GG38316@google.com>
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

The GIT_TEST_PROTOCOL_VERSION environment variable can be used to
upgrade the version of Git protocol used in tests.  If both
GIT_TEST_PROTOCOL_VERSION and 'protocol.version' are set, the higher
value wins.

For usage within tests, these semantics are too complex.  Instead,
always use the value from protocol.version configuration when it is
set, falling back to GIT_TEST_PROTOCOL_VERSION.  This way, the envvar
provides a reliable preview of what will happen if the default
protocol version is changed.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
I'd like to remove the built-in support for GIT_TEST_PROTOCOL_VERSION
altogether and replace it with support in the test harness for setting
protocol.version to the specified value, but that can wait for a
followup another day.

 protocol.c | 11 +++++------
 t/README   |  4 ++--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/protocol.c b/protocol.c
index 9741f05750..d390391eba 100644
--- a/protocol.c
+++ b/protocol.c
@@ -17,9 +17,8 @@ static enum protocol_version parse_protocol_version(const char *value)
 enum protocol_version get_protocol_version_config(void)
 {
 	const char *value;
-	enum protocol_version retval = protocol_v0;
 	const char *git_test_k = "GIT_TEST_PROTOCOL_VERSION";
-	const char *git_test_v = getenv(git_test_k);
+	const char *git_test_v;
 
 	if (!git_config_get_string_const("protocol.version", &value)) {
 		enum protocol_version version = parse_protocol_version(value);
@@ -28,19 +27,19 @@ enum protocol_version get_protocol_version_config(void)
 			die("unknown value for config 'protocol.version': %s",
 			    value);
 
-		retval = version;
+		return version;
 	}
 
+	git_test_v = getenv(git_test_k);
 	if (git_test_v && *git_test_v) {
 		enum protocol_version env = parse_protocol_version(git_test_v);
 
 		if (env == protocol_unknown_version)
 			die("unknown value for %s: %s", git_test_k, git_test_v);
-		if (retval < env)
-			retval = env;
+		return env;
 	}
 
-	return retval;
+	return protocol_v0;
 }
 
 enum protocol_version determine_protocol_version_server(void)
diff --git a/t/README b/t/README
index caa125ba9a..9afd61e3ca 100644
--- a/t/README
+++ b/t/README
@@ -352,8 +352,8 @@ details.
 GIT_TEST_SPLIT_INDEX=<boolean> forces split-index mode on the whole
 test suite. Accept any boolean values that are accepted by git-config.
 
-GIT_TEST_PROTOCOL_VERSION=<n>, when set, overrides the
-'protocol.version' setting to n if it is less than n.
+GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
+default to n.
 
 GIT_TEST_FULL_IN_PACK_ARRAY=<boolean> exercises the uncommon
 pack-objects code path where there are more than 1024 packs even if
-- 
2.24.1.735.g03f4e72817

