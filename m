Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2D5C433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346538AbiDRR2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347090AbiDRR1O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:27:14 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0EE340E3
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:32 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x18so11451575wrc.0
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aQSQ3rFgbtx2uK9m2z/GVujlZILQ2CH4ujph93EeIdo=;
        b=OfdUFLy09Qr4NTVH9A1aHIFSmYOqZZxhEjF/NrnA4vxZNhZoVuDGRfTtrfkcCh1mLr
         G6+q18KcSCd/INx7Xyeq6ViSnz1D9i2p72w3dumzKIT2wt0TX6pQx/nExrv62N3aCOJj
         t8df2wHZwbQ4/pj1TqWFiSn1YZad8KFtQo/nI7koXTeNcNOkaIqdVyGFtQtoNZs2CgC9
         2jUER2n/drsQzdB1mKTG2NZsV0B5Ec8wIzTe1dhSbVcDPGi55gYBDV6tnUaeCH6S7iTU
         Uv7sOlSM4RZwSNy21QtCbYebmCexTtgDQLzx6RlsmIq1cPN721v16T/w5qer9Hw6TWzR
         aC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aQSQ3rFgbtx2uK9m2z/GVujlZILQ2CH4ujph93EeIdo=;
        b=8Jhkna0KeqP4EjFyVD7OenesYzivRpPbctHCwuFkIyzIzOBmtZa8XEVPCHsnFseIEg
         cCOugatD/56A593QO503++lTxG9n6RsXJZjvEfo9p+HuwIk1ogz/d6aT90NT19cjuQZP
         3gknVa9HkyFyHXjBtHx+vq4VqUn0JIC4TfIyjhw+GIgcrT+VwZhm/iXh+P6TSadlHyEq
         AsO2kcqBRqWU5RdIpSHq1WLniS61nVGptG+Z9ymhhdXcIw6kLlSILj0GBMu+Dl+AbGML
         uwomJoZ3S2dq3SMBSKucatE/hGMrmNUOjhZFeiLhfY7oO+IhUgDkZuKqWHx/taZ5WUDV
         ZZXg==
X-Gm-Message-State: AOAM533dLiwmAwncHLGObpFKIBWsbTEny4exGhYRPfuFpK4Flkhu7ska
        8qikhFbU5wtq/jPpLavIkjFOEIlGaP6ZwQ==
X-Google-Smtp-Source: ABdhPJwdTKmZRX/0lbGnTY4LbcbPuBDMFgzDt8V0xVvdFGw3NbnBRg8Jv6CQAC14AjwRWW4Ufua1DA==
X-Received: by 2002:adf:ee81:0:b0:206:1b32:d6f2 with SMTP id b1-20020adfee81000000b002061b32d6f2mr8699870wro.144.1650302670869;
        Mon, 18 Apr 2022 10:24:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:30 -0700 (PDT)
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
Subject: [RFC PATCH v2 30/36] connect: implement get_recommended_features()
Date:   Mon, 18 Apr 2022 19:23:47 +0200
Message-Id: <RFC-patch-v2-30.36-e834e633e84-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

This method allows a client to request and parse the 'features' capability
of protocol v2. The response is expected to be a list of 'key=value'
lines, but this implementation does no checking of the lines, expecting
a later parse of the lines to be careful of the existence of that '='
character.

This change is based on an earlier patch [1] written for a similar
capability.

[1] https://lore.kernel.org/git/RFC-patch-04.13-21caf01775-20210805T150534Z-avarab@gmail.com/

Co-authored-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 connect.c | 36 ++++++++++++++++++++++++++++++++++++
 remote.h  |  4 ++++
 2 files changed, 40 insertions(+)

diff --git a/connect.c b/connect.c
index a8fdb5255f7..1739d1f8a5f 100644
--- a/connect.c
+++ b/connect.c
@@ -591,6 +591,42 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 	return list;
 }
 
+int get_recommended_features(int fd_out, struct packet_reader *reader,
+			     struct string_list *list, int stateless_rpc)
+{
+	int line_nr = 1;
+
+	server_supports_v2("features", 1);
+
+	/* (Re-)send capabilities */
+	send_capabilities(fd_out, reader);
+
+	/* Send command */
+	packet_write_fmt(fd_out, "command=features\n");
+	packet_delim(fd_out);
+	packet_flush(fd_out);
+
+	/* Process response from server */
+	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
+		const char *line = reader->line;
+		line_nr++;
+
+		string_list_append(list, line);
+	}
+
+	if (reader->status != PACKET_READ_FLUSH)
+		return error(_("expected flush after features listing"));
+
+	/*
+	 * Might die(), but obscure enough that that's OK, e.g. in
+	 * serve.c, we'll call BUG() on its equivalent (the
+	 * PACKET_READ_RESPONSE_END check).
+	 */
+	check_stateless_delimiter(stateless_rpc, reader,
+		_("expected response end packet after features listing"));
+	return 0;
+}
+
 const char *parse_feature_value(const char *feature_list, const char *feature, int *lenp, int *offset)
 {
 	int len;
diff --git a/remote.h b/remote.h
index 571338510a8..bccb8484dbd 100644
--- a/remote.h
+++ b/remote.h
@@ -242,6 +242,10 @@ int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
 
 int resolve_remote_symref(struct ref *ref, struct ref *list);
 
+/* Used for protocol v2 in order to retrieve recommended features */
+int get_recommended_features(int fd_out, struct packet_reader *reader,
+			     struct string_list *list, int stateless_rpc);
+
 /*
  * Remove and free all but the first of any entries in the input list
  * that map the same remote reference to the same local reference.  If
-- 
2.36.0.rc2.902.g60576bbc845

