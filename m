Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AF4C433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347019AbiDRR2L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347061AbiDRR1H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:27:07 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B9F344DB
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:18 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r64so9109176wmr.4
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hckDBPAmSUsilYSwPhhuOaLRud2c62uLuwzawMdrIEk=;
        b=aaqeFSpqOrOO/WM2+Z+ITeoMdh10E+4sRnQSF3gqFs5rRH8bTOeVgVyu2u0C54tMET
         85KqaNZ0qPc8r6py2odW3N8nPb3hx65Tgr4cXX5wNNvEVLlDf30h089o+WTZObM1D8Wh
         uvAyX5GZEtCKt2xCTba4Io872s3DeqC0T4dAJB/mMSCokToUUxOwP1VsRdrPLiAjcG8m
         3sGsf/h8qvpmRS4fM47L5vCg9TJM2nBaXvzxbsxvtaCt5YLIwd2ehfuVzmeT8Q3tiZxn
         z07ngN09776mYToo/7+/MUBHnvnZazCn+LC3BLa5+WtMUZMP5cd5C6SQPx/ti5+OcB1p
         Zb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hckDBPAmSUsilYSwPhhuOaLRud2c62uLuwzawMdrIEk=;
        b=grSnJOaVBUmd3McPpubyj982y5cnzk9+0KGuSq0tFpvlkspTZgU39Pxpj9nfwIk6Nt
         w62ykUE/xqPBszO43Up10RQYmte4mWvu8kh/S56PpJN+L9hZWyaFj/IMqgyOzxwBOEro
         5gvwux2/1W0rlxb8gB3lFy5smVZ9/CxIAa6d21EgcSzV8SBZv0uc59YFLKl40YGhI1VX
         1bq+TvUrfukESafKAKVDkXjUAMuxaGxwmgn94cN3QjiErdn1BDs61vJd+XWKj5NYzaHI
         noHlQiV8CgSp6ugL8FsF+f2i1BNGT76nhkQ0F9qWVdG2nZ66RG1DlebmxC8+uwYE67xL
         Kfmg==
X-Gm-Message-State: AOAM531mdVgJRupcNecTfcm5L0z+pkkBSJnb6Dc1PpnbhbBnjYX7MZAn
        YRfsRd3DcPPqQdULLwqZao+aVUc3vK6z9w==
X-Google-Smtp-Source: ABdhPJzOg7ckyzzUtnV2OgGl773p+uN8WEUMEYyj3t8+Gyidu/AGYhWjSZlzV7wpVioYsl7lXYRqJw==
X-Received: by 2002:a7b:c201:0:b0:38f:f7f5:f6db with SMTP id x1-20020a7bc201000000b0038ff7f5f6dbmr16164315wmi.191.1650302657043;
        Mon, 18 Apr 2022 10:24:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:16 -0700 (PDT)
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
Subject: [RFC PATCH v2 16/36] bundle-uri: make the download program configurable
Date:   Mon, 18 Apr 2022 19:23:33 +0200
Message-Id: <RFC-patch-v2-16.36-632c68b224f-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
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
index 316fb2fd65d..7e696142c4d 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1121,12 +1121,18 @@ static int get_bundle_uri(struct string_list_item *item, unsigned int nth,
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
2.36.0.rc2.902.g60576bbc845

