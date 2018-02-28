Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 844DD1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 00:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbeB1AvI (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 19:51:08 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:37164 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeB1AvH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 19:51:07 -0500
Received: by mail-pf0-f169.google.com with SMTP id s24so315693pfm.4
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 16:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Bm4XSJuldxC2Ng/L1z+pETw/6xZxv6ZOMK0i9nN60EM=;
        b=dPz5GcddxW/YYkIR0vD8lCEWVRGhDRDCjWKYgiPJLHq9uADk/C6P6+P9RZKuCerzZQ
         gGWmRbqjYHa1yx9Jf5VLyhIFnUg/re+a7lP5Z59u6eJ+H8teS4uM2VRt5v8IXVumIxN3
         BpY4W93xtBqmQJWWag1B8qZ+yf2XZPZ90tmjQF35IV9Z94kLcUt5dLgeoCIlhFC7Udtz
         FKGdGFYDYA41xEyOjjFzIrEaZrUb8BteKC/2cZgD5+3q/x8psjhAMBe1Q7PFoFNwvBzK
         WHlwMq2+bmCwsxrx/FjlTJDyTk17dRS2k8b6Qw5wx7uSjOYk0SS5R6EtM946oC3NxHvN
         aR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Bm4XSJuldxC2Ng/L1z+pETw/6xZxv6ZOMK0i9nN60EM=;
        b=qbvET7/06mqCEL7bq8DjylPNpZwMdqjkT7yfqB0yhh+PV4hmTDdiIGubvUvv8/+vCu
         WMb/x9bTKbXbBnMXXsMMun809wADOzNRtPkkRIg/deLJu90nyG23nZHR1VYbPSpXQQ3u
         8qbLVxD0Z5Ij1lCbbvlKpIhOgkFamDhEZyJKNpPgtVYftqv+P8N8qh3WDeREmw4mm/mH
         fBfjV7PrEbdM4sJYfxOqeLKFYH9eIhGtao+HjBvjPp2uU7KeA5kPo+Ekt/mrB2poBIcE
         5POSfJsDz0gBg1A1fpmCg+V8PHxekVgBzsoZxFJMP/iXNj1XILDY8JnTXlOplD3aX3KX
         6QPQ==
X-Gm-Message-State: APf1xPAkz32vDGWo9ouxjlIbKYCBdLOJdxhY0m83x3YnnZNke5n84qTN
        z+luacwcz5oeizOtfb2RQiabNgHv
X-Google-Smtp-Source: AH8x226vueJo4K7lXhwY11DyKGsEFwECLW3GXM4qkMAYgUQq4msu1S1FvaF1qjoElxiSvb3gks64qg==
X-Received: by 10.98.86.151 with SMTP id h23mr15716249pfj.79.1519779066131;
        Tue, 27 Feb 2018 16:51:06 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id n67sm453008pfh.150.2018.02.27.16.51.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 16:51:05 -0800 (PST)
Date:   Tue, 27 Feb 2018 16:50:59 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, Jeff King <peff@peff.net>
Subject: [PATCH] protocol: treat unrecognized protocol.version setting as 0
Message-ID: <20180228005059.GA251290@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If I share my .gitconfig or .git/config file between multiple machines
(or between multiple Git versions on a single machine) and set

	[protocol]
		version = 2

then running "git fetch" with a Git version that does not support
protocol v2 errors out with

	fatal: unknown value for config 'protocol.version': 2

In the spirit of v1.7.6-rc0~77^2~1 (Improve error handling when
parsing dirstat parameters, 2011-04-29), it is better to (perhaps
after warning the user) ignore the unrecognized protocol version.
After all, future Git versions might add even more protocol versions,
and using two different Git versions with the same Git repo, machine,
or home directory should not cripple the older Git version just
because of a parameter that is only understood by a more recent Git
version.

So ignore the unrecognized value.  It may be useful for spell checking
(for instance, if I put "version = v1" intending "version = 1") to
warn about such settings, but this patch does not, since at least in
these early days for protocol v2 it is expected for configurations
that want to opportunistically use protocol v2 if available not to be
unusual.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Google has been running with a patch like this internally for a while,
since we have been changing the protocol.version number to a new value
like 20180226 each time a minor tweak to the protocolv2 RFC occured.

The bit I have doubts about is whether to warn.  What do you think?

Thanks,
Jonathan

 protocol.c             |  8 ++------
 t/t5700-protocol-v1.sh | 12 ++++++++++++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/protocol.c b/protocol.c
index 43012b7eb6..ce9c634a3a 100644
--- a/protocol.c
+++ b/protocol.c
@@ -17,12 +17,8 @@ enum protocol_version get_protocol_version_config(void)
 	const char *value;
 	if (!git_config_get_string_const("protocol.version", &value)) {
 		enum protocol_version version = parse_protocol_version(value);
-
-		if (version == protocol_unknown_version)
-			die("unknown value for config 'protocol.version': %s",
-			    value);
-
-		return version;
+		if (version != protocol_unknown_version)
+			return version;
 	}
 
 	return protocol_v0;
diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
index ba86a44eb1..c35767ab01 100755
--- a/t/t5700-protocol-v1.sh
+++ b/t/t5700-protocol-v1.sh
@@ -31,6 +31,18 @@ test_expect_success 'clone with git:// using protocol v1' '
 	grep "clone< version 1" log
 '
 
+test_expect_success 'unrecognized protocol versions fall back to v0' '
+	GIT_TRACE_PACKET=1 git -c protocol.version=9999 \
+		clone "$GIT_DAEMON_URL/parent" v9999 2>log &&
+
+	git -C daemon_child log -1 --format=%s >actual &&
+	git -C "$daemon_parent" log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+
+	# Client requested and server responded using protocol v0
+	! grep version log
+'
+
 test_expect_success 'fetch with git:// using protocol v1' '
 	test_commit -C "$daemon_parent" two &&
 
-- 
2.16.2.395.g2e18187dfd

