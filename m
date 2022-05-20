Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B96C433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353093AbiETSmY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353021AbiETSlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:41:09 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C3D26AC7
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:41:06 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h5so11495702wrb.11
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NDpWaLFNa+l/P0h1AWvMZEuGkyVsE5uejaZdfaC//Lk=;
        b=nJ85PHpKhVpUP6bNouD5vbTggSJbe6kvSYopmtHw0C1sXxzigLxD6NwaFzn3Wtp7A/
         jWzHILlAMnW0j6eaClpqr0leXPBPsTCggeMr9v3kLK7aOTvGmVMndFNUK9rwemr0zhbX
         MvTOlgCaEHGZN58b4rd49V6ZzzWrhEvyvjJnrjyHZ4ciwtKBncd3ogsjRa12IwvPDC9g
         TyqVP0s2tgjxNY97dhN5wjEnhXAnucMDc2+ED4JYuszuRmU+qrVQpRHOaO71JZ4dMRk3
         5a9Ejd1i3GVTYr6QFRxLGP0nv4HCBrRUOaKCseQzTIqg9WeAnAaS5Nqj9i1/QbE+xl6+
         5GPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NDpWaLFNa+l/P0h1AWvMZEuGkyVsE5uejaZdfaC//Lk=;
        b=mDon3ZqG1ZG3jSi9rXQOXTdUHa7THVvsNDqcBvcBByX3odeFf6KU3hm+z9Wsyo9wxd
         AxVxi8JsOT/xlEkBY+TAByWWIBehSmE5fBJ2BARN5zsgk7qscht/xf5e8oYIdzVSEMyr
         EPL4NXVTZPjsY5l2nmseqNhyCEwDstR/LqJ6EFxw4z3Xz0YQeeIfvPSlTriKKAgJpdAu
         tVYKikMH5CaIGJfSxUj3q4BIGL2q+n28TyYz5lOZJqkByWjSU9e/gars3dms9iT5071h
         l+XL/d+S/vvseNwQopTmldn+nl2ms7tG+hOf7YIA5nCTthF/C2AvGW3q0zo8/A0oElY4
         Aa7g==
X-Gm-Message-State: AOAM531ZVNIlKAvz5ctXbKBjxHCgBidCFAbriHPf1wnn5k4y/lxHKAUc
        8rIVSTMrFFaqH7f5TJLhjDwFCUCt43c=
X-Google-Smtp-Source: ABdhPJz/CBHhPL2i3HvXv9FDycfbj0X+8lx27/kpPwCgpyJ/nd31HAlp7FUm4Y5fMDNgFUxHIbZVug==
X-Received: by 2002:a5d:6386:0:b0:20d:8315:f9c7 with SMTP id p6-20020a5d6386000000b0020d8315f9c7mr9503134wru.494.1653072066095;
        Fri, 20 May 2022 11:41:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h22-20020a05600c351600b003971fc23185sm2923956wmq.20.2022.05.20.11.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:41:05 -0700 (PDT)
Message-Id: <5d78566f30c69d594fa5169079f3ae1781fc986a.1653072042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
References: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 May 2022 18:40:37 +0000
Subject: [PATCH 19/24] bundle-uri: serve URI advertisement from bundle.*
 config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Teng Long <dyroneteng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

TODO: fill in details

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index fed508cd51a..70be53aa38d 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -579,6 +579,16 @@ cached:
 	return advertise_bundle_uri;
 }
 
+static int config_to_packet_line(const char *key, const char *value, void *data)
+{
+	struct packet_reader *writer = data;
+
+	if (!strncmp(key, "bundle.", 7))
+		packet_write_fmt(writer->fd, "%s=%s", key, value);
+
+	return 0;
+}
+
 int bundle_uri_command(struct repository *r,
 		       struct packet_reader *request)
 {
@@ -590,7 +600,11 @@ int bundle_uri_command(struct repository *r,
 	if (request->status != PACKET_READ_FLUSH)
 		die(_("bundle-uri: expected flush after arguments"));
 
-	/* TODO: Implement the communication */
+	/*
+	 * Read all "bundle.*" config lines to the client as key=value
+	 * packet lines.
+	 */
+	git_config(config_to_packet_line, &writer);
 
 	packet_writer_flush(&writer);
 
-- 
gitgitgadget

