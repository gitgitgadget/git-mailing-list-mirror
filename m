Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67220C433FE
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 16:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350310AbiCKQ0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350289AbiCKQZt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 11:25:49 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361DD10856D
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 08:24:45 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r6so13292605wrr.2
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 08:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VAs+mWqtC+XGazAdtOhiLst/VRu/6iJH7vVOH+Wsg4E=;
        b=CJIjSaSSPNsLIKCPEH+gWjiwV4OgmkoVlUZHjhl+EW45FJ2ggcB7AEfode42m1m0Jd
         cG8ynJi1KMOxqZt/nkBCslJpLBRt8HBxzeuuYp5/DGwGxj5Eyzj/n+QFxmR2oc4ZM4y+
         7BE7p+7UIIY/LaH5vJM0K0bgKyxAlo3GwK7ROmRFYWuOGRhIEXXHMJ/K9dptb25xP7sn
         24aG5M+I0IZb6RCme6ISQUd5xpuTHT6Mh8W1RViJIIlDCwqbZg9Pcn9Rs0Zu+9bUt/ug
         PEn4YnBQz/3DiC2D+uiLNiVyrptwJDMcs2mxtQdrDtK4qj28R3enj87Yr7B7wk2nhJ/A
         Ynuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VAs+mWqtC+XGazAdtOhiLst/VRu/6iJH7vVOH+Wsg4E=;
        b=MNgFDu3hvp0HyGYAGPslDdnih2vGXKmNlD6Lr38NjKv4+lUtZpvG76/xy3rg13YRip
         3Ldjhe0mDr/rXK1z06XXjQEsh6PsawTGp0eCTOIEvlYc2bxRckznm/zikK33yWnu+iTS
         geSV3caYFrIygH3vcLIq5zAgbg5eyZc3fHWw13XDcoUqbGpPDhYO5gC3TVMIrWmkjkYE
         2S5Ais4vBPobnLydeIY+qGruvwvrRLImt5nCteuBU/2yizOAA06keHqJwtWJMrVL+qus
         h+qBNLukD4NLirkVgFalQvSPwBIWKae3CaEoX11/z1GLe5G1MrfPgrCx3qHyPnjXMeR0
         rwSw==
X-Gm-Message-State: AOAM530CUbZZvL8zm8Y1PCR24k0sTWvtkqGRbN+SoKyuLutNRHIJrea6
        mZ5ArQZMfRa9V6c8aMZuJccE1SImAVOVKg==
X-Google-Smtp-Source: ABdhPJx//34woua+FCKsYK78pTb3MPYPt/14OvSQAw2K+zsarhjbbDrWszeEYEJNzHcePWQR8vterg==
X-Received: by 2002:a5d:69c7:0:b0:1f0:61f3:642b with SMTP id s7-20020a5d69c7000000b001f061f3642bmr8051310wrw.632.1647015883349;
        Fri, 11 Mar 2022 08:24:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f22-20020a1cc916000000b00380d3e49e89sm7318667wmb.22.2022.03.11.08.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:24:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 13/13] bundle-uri: make the download program configurable
Date:   Fri, 11 Mar 2022 17:24:25 +0100
Message-Id: <RFC-patch-v2-13.13-40f37c8b9d5-20220311T155841Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1337.g7e32d794afe
In-Reply-To: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com> <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in a preceding commit we really should be using libcurl's C
API by default in get_bundle_uri(), but testing with a command-line
program can be very handy, and useful e.g. to implement custom or
ad-hoc caching.

E.g. using part of the recipe noted in a preceding commit to create
the "git-master-only.bdl" and "git-master-to-next.bdl" files, we can
implement a trivial caching shellscript as:

	cat >get-bundle.sh <<-\EOF &&
	#!/bin/sh
	set -xe

	uri="$1"

	bundle_cache_key () {
		echo "Computing cache key for URI '$1' (only getting the header)" >&2

		curl --silent --output - -- "$1" |
		sed -n -e '/^$/q' -e 'p' |
		git hash-object --stdin
	}

	get_cached_bundle_uri() {
		cache_key=$(bundle_cache_key "$1")

		path="/tmp/bundle-cache-$cache_key.bdl"

		if test -e "$path"
		then
			echo "Using cache '$path' for URI '$1'" >&2
			cat "$path"
		else
			echo "Downloading bundle URI $1" >&2
			curl --silent --output - -- "$uri" | tee "$path"
		fi
	}

	get_cached_bundle_uri "$1"
	EOF
	chmod +x get-bundle.sh &&
	rm -rf /tmp/git.git &&
	./git \
		-c protocol.version=2 \
		-c fetch.uriProtocols=file \
		-c transfer.bundleURI.downloader=./get-bundle.sh \
		-c transfer.injectBundleURI="file:///tmp/git-master-only.bdl" \
		-c transfer.injectBundleURI="file:///tmp/git-master-to-next.bdl" \
		clone --bare --no-tags --single-branch --branch next --template= \
		--verbose --verbose \
		https://github.com/git/git.git /tmp/git.git

Now, clearly that specific example is rather pointless. We're getting
a local file anyway, so "cat"-ing another local file doesn't make any
difference, it's even slightly slower & more redundant as we're having
to get it twice with "curl".

But the point is that this can be trivially improved for use in any
arbitrary custom caching strategy. E.g.:

 * A less dumber implementation that would stream the remote URL,
   check the header as we go, and disconnect if we've got that content
   locally.
 * Ditto, but using an ETag or other strategy.
 * N boxes could share a cache an NFS with a shared mount, or N
   disconnected git processes could use a common cache without the
   need for a front-line HTTP proxy server.

 * It would be trivial to extend this to guard against a "thundering
   herd" (e.g. concurrent CI) downloading the same bundle N times. As
   soon as we'd get the header we'd create a $cache_key.lock as we
   download the rest, and other concurrent clients spotting that would
   wait, then eventually cache "$cache_key".

   Still racy as N clients could download the header in parallel, but
   way less so (the header will be a tiny part of the payload).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/transfer.txt | 7 +++++++
 fetch-pack.c                      | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/config/transfer.txt b/Documentation/config/transfer.txt
index ae85ca5760b..5310cd96cb9 100644
--- a/Documentation/config/transfer.txt
+++ b/Documentation/config/transfer.txt
@@ -84,6 +84,13 @@ transfer.bundleURI::
 	using bundles to bootstap is possible. Defaults to `true`,
 	i.e. bundle-uri is tried whenever a server offers it.
 
+transfer.bundleURI.downloader::
+	When set to `<program>` will be invoked when
+	`transfer.bundleURI` is in effect to download URIs containing
+	bundles. Expected to take one `URI` as an argument, and to
+	emit the bundle on STDOUT. Defaults to "curl --silent --output
+	- --". I.e. we'll invoke "curl --silent --output - -- <URI>".
+
 transfer.injectBundleURI::
 	Allows for the injection of `bundle-uri` lines into the
 	protocol v2 transport dialog (see `protocol.version` in
diff --git a/fetch-pack.c b/fetch-pack.c
index 4f1a7acb20d..6e22605f06c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1116,12 +1116,18 @@ static int get_bundle_uri(struct string_list_item *item, unsigned int nth,
 	const char *uri = item->string;
 	FILE *out;
 	int out_fd;
+	const char *tmp;
 
 	strvec_push(&cmd.args, "curl");
 	strvec_push(&cmd.args, "--silent");
 	strvec_push(&cmd.args, "--output");
 	strvec_push(&cmd.args, "-");
 	strvec_push(&cmd.args, "--");
+	if (!git_config_get_string_tmp("transfer.bundleURI.downloader", &tmp)) {
+		strvec_clear(&cmd.args);
+		strvec_push(&cmd.args, tmp);
+		cmd.use_shell = 1;
+	}
 	strvec_push(&cmd.args, item->string);
 	cmd.git_cmd = 0;
 	cmd.no_stdin = 1;
-- 
2.35.1.1337.g7e32d794afe

