Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90A481F404
	for <e@80x24.org>; Wed, 28 Mar 2018 20:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753079AbeC1Udc (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 16:33:32 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41827 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753072AbeC1Udb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 16:33:31 -0400
Received: by mail-pg0-f66.google.com with SMTP id t10so1538511pgv.8
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 13:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ivXqWojENe2XGFrojq/MNgCbKWheCYWfHec+tkgn81Q=;
        b=PnwGAEq22Cj0aU9EVV8sIOUtG1KHJWjy1NyWmP3Fmmt4i9I+gsQjyHUAqAR0MMR2Ol
         jcgElNTbA9b0QEgQiznmSy2Y14mlvcIoZbpNWz//SCkE7L02y141VYpAzs5i767GZa+J
         HYNsqHGoLUBq5ko2wKvCXanAn4sNJej81gzAW8I2eh+GUmOXgquXpg7sscpLwgMG7D/G
         YMUoHm2S0P6obPFbwWKtY1Bzf/QoSa8rAE+6/9Mfv41Qo+X+u6FyWbVXXU5j/n2g+0FA
         xUek7w/uPwIAwj+v2nm6wU8rHKNmo/P7YttKat8VFcioi27xGyN3/CWO8S2crzpuHkq3
         aF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ivXqWojENe2XGFrojq/MNgCbKWheCYWfHec+tkgn81Q=;
        b=sJ2EZdztpfW7dtKVKNqMMTiclzTeBWb0Q/MaeW0qQhiN7Gkxlvp739oua+kmU7TrTy
         StlWMSAFzc2y+StG9Rz+oLXbah2nX7diKwVTEZtCeRE7GX0V3PV4DA9lmk8/C7keY0Iz
         ZDMW6qFD22bOxPo6/M19skzRUZXaTY7uNXi7VeMxrr7r21vpzP17H9D8uUSUt8lRXPlI
         j22ZmLvL5vBm4merTJviuwyENtda24gvdrTzRxsPEqXPO7FY/y7ZbdaEYtfKKPrqwdCg
         WIW2egZhiEANKyE3iy+c6RL4FWByXanMp1aR7aA2RA5NwJovxX8T+1vYIOFSJ1bPMR8i
         HUPQ==
X-Gm-Message-State: AElRT7EOnboamVxp5bCDpgggMl9ifki4yUIgO+lVOZ9mDDUmT9BXH1HD
        xwy9fm4Jvp1IIfVE1zbBh4NgKdmN
X-Google-Smtp-Source: AIpwx48tC1sORXMBbYshMGeaTb8GN4bh1hcPF9wvEkuaLXbmzpqSm1WdTnxm3/uKj7YqHkyYpdvM8Q==
X-Received: by 10.99.62.193 with SMTP id l184mr3456356pga.87.1522269210148;
        Wed, 28 Mar 2018 13:33:30 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id p71sm10650403pfl.89.2018.03.28.13.33.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Mar 2018 13:33:29 -0700 (PDT)
Date:   Wed, 28 Mar 2018 13:33:03 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [RFC/PATCH] upload-pack: disable object filtering when disabled by
 config
Message-ID: <20180328203303.GA260688@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When upload-pack gained partial clone support (v2.17.0-rc0~132^2~12,
2017-12-08), it was guarded by the uploadpack.allowFilter config item
to allow server operators to control when they start supporting it.

That config item didn't go far enough, though: it controls whether the
'filter' capability is advertised, but if a (custom) client ignores
the capability advertisement and passes a filter specification anyway,
the server would handle that despite allowFilter being false.

This is particularly significant if a security bug is discovered in
this new experimental partial clone code.  Installations without
uploadpack.allowFilter ought not to be affected since they don't
intend to support partial clone, but they would be swept up into being
vulnerable.

Simplify and limit the attack surface by making uploadpack.allowFilter
disable the feature, not just the advertisement of it.

NEEDSWORK: tests

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Noticed while reviewing the corresponding JGit code.

If this change seems like a good idea, I can add tests and re-send it
for real.

Thanks,
Jonathan

 Documentation/config.txt | 2 +-
 upload-pack.c            | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ce9102cea8..4e0cff87f6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3364,7 +3364,7 @@ uploadpack.packObjectsHook::
 	stdout.
 
 uploadpack.allowFilter::
-	If this option is set, `upload-pack` will advertise partial
+	If this option is set, `upload-pack` will support partial
 	clone and partial fetch object filtering.
 +
 Note that this configuration variable is ignored if it is seen in the
diff --git a/upload-pack.c b/upload-pack.c
index f51b6cfca9..4a82602be5 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -69,7 +69,7 @@ static int stateless_rpc;
 static const char *pack_objects_hook;
 
 static int filter_capability_requested;
-static int filter_advertise;
+static int allow_filter;
 static struct list_objects_filter_options filter_options;
 
 static void reset_timeout(void)
@@ -846,7 +846,7 @@ static void receive_needs(void)
 			no_progress = 1;
 		if (parse_feature_request(features, "include-tag"))
 			use_include_tag = 1;
-		if (parse_feature_request(features, "filter"))
+		if (allow_filter && parse_feature_request(features, "filter"))
 			filter_capability_requested = 1;
 
 		o = parse_object(&oid_buf);
@@ -976,7 +976,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 				     " allow-reachable-sha1-in-want" : "",
 			     stateless_rpc ? " no-done" : "",
 			     symref_info.buf,
-			     filter_advertise ? " filter" : "",
+			     allow_filter ? " filter" : "",
 			     git_user_agent_sanitized());
 		strbuf_release(&symref_info);
 	} else {
@@ -1056,7 +1056,7 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 		if (!strcmp("uploadpack.packobjectshook", var))
 			return git_config_string(&pack_objects_hook, var, value);
 	} else if (!strcmp("uploadpack.allowfilter", var)) {
-		filter_advertise = git_config_bool(var, value);
+		allow_filter = git_config_bool(var, value);
 	}
 	return parse_hide_refs_config(var, value, "uploadpack");
 }
-- 
2.17.0.rc1.321.gba9d0f2565

