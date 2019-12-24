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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE4CC2D0C0
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 01:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2575206D3
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 01:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVGmYzUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfLXBES (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 20:04:18 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39703 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfLXBES (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 20:04:18 -0500
Received: by mail-pg1-f193.google.com with SMTP id b137so9624557pga.6
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 17:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a7MNuE//RoXYPqcP2Z6if9LKbiq1IhHPYdUXMJq+060=;
        b=XVGmYzUdw4zLpBmYyTP+xZB0VvwNrKaJszE+Y9j8KMi9KeftMB9Nmz9csaoSNcsxQp
         coZ8fMSLWcxQh7cJwujXyhlHwIdbhog2tuAhbxnstw6A9B0eXWe39J8aHy14a/EUaC27
         e0jaM6oR5/F7N+dKi48K6ul+KFYI0zf4oLhDRNQPr5YqlPMeBd7Gj729dmXNNTJRqFwm
         jk/+ay27JpC/GFGvq6/W+qYlJ8GFW8zLispyFTSmJmHWjbH1AyCx2UiVeQH9KhiKFHrA
         k9MBL5lB/LGXP3WC5JW4mSVP6cfEZ0wQAdQH9xwxqohWy7yBle6AT4wvMXyoziMEoIUX
         IRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a7MNuE//RoXYPqcP2Z6if9LKbiq1IhHPYdUXMJq+060=;
        b=Ia90TsaZw6l7LtqVqEb0N8L45HCWzSk4GCU23CzZBi+7AjYaf4KnqQj9h+hL3wgZxt
         m/UmtyaO4ao6LCShrSpU8r++xYjJRISWdDOLsaoDXZB0Vd8jqYfR4Dwv+4z0ZjuhWxpE
         /DPj+uBp45SaaITt6pdBGSrIx7st89ScZRHxO+H6yskUeA6YyXTsC4bqGnIhlgx31dQu
         paJyFvaMcZxudNawneE1VcbUE35leDXxfrIuZ7GwHtMdJm/jvKL9NsUIe02gfvwzRTQ2
         J9mNVxVwAbyth7o0JSOK3u6mKW060eaeAnXaAfSt6xNXxJ1mdGRQT4bWyDE0Z/xN0GQp
         z1Ow==
X-Gm-Message-State: APjAAAX4C3i19uMrNqkfK00+HM0n5tVhQmH00W4we9PmBxuAjxFkPZav
        VI9+gTgiAD1j1TWxA8aL0gXHlnfZ
X-Google-Smtp-Source: APXvYqzlObBrvuKaezSdobFziK3zyCVMcQ/E0a595IL7UuPbXu/rZ0KtAKMccpnWd+4ZuxXE7yRg/w==
X-Received: by 2002:a63:184d:: with SMTP id 13mr34226967pgy.132.1577149457579;
        Mon, 23 Dec 2019 17:04:17 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id w123sm7453846pfb.167.2019.12.23.17.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 17:04:17 -0800 (PST)
Date:   Mon, 23 Dec 2019 17:04:15 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 5/5] fetch: default to protocol version 2
Message-ID: <20191224010415.GH38316@google.com>
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

The Git users at $DAYJOB have been using protocol v2 as a default for
~1.5 years now and others have been also reporting good experiences
with it, so it seems like a good time to bump the default version.  It
produces a significant performance improvement when fetching from
repositories with many refs, such as
https://chromium.googlesource.com/chromium/src.

This only affects the client, not the server.  (The server already
defaults to supporting protocol v2.)  The protocol change is backward
compatible, so this should produce no significant effect when
contacting servers that only speak protocol v0.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That's the end of the series.  Thanks for reading.

Thoughts?

 Documentation/config/protocol.txt | 2 +-
 protocol.c                        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/protocol.txt b/Documentation/config/protocol.txt
index 0b40141613..756591d77b 100644
--- a/Documentation/config/protocol.txt
+++ b/Documentation/config/protocol.txt
@@ -48,7 +48,7 @@ protocol.version::
 	If set, clients will attempt to communicate with a server
 	using the specified protocol version.  If the server does
 	not support it, communication falls back to version 0.
-	If unset, the default is `0`.
+	If unset, the default is `2`.
 	Supported versions:
 +
 --
diff --git a/protocol.c b/protocol.c
index d390391eba..803bef5c87 100644
--- a/protocol.c
+++ b/protocol.c
@@ -39,7 +39,7 @@ enum protocol_version get_protocol_version_config(void)
 		return env;
 	}
 
-	return protocol_v0;
+	return protocol_v2;
 }
 
 enum protocol_version determine_protocol_version_server(void)
-- 
2.24.1.735.g03f4e72817

