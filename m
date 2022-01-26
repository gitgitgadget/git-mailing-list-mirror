Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E9AC28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 08:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiAZIl4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 03:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238548AbiAZIlz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 03:41:55 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2852C061744
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 00:41:54 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e2so8990154wra.2
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 00:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7ewypPI1Z9cMHCUUQ1HrSlBl1OW939EsBTHhSNw3s78=;
        b=D7TcTHWhUkUO57M7B0YrOTd4AgivXQcySDvDVCYewn5mms++TuqUxovv6p7Ou8sOOL
         Zo8tyvRcLEHD1+d0oiK849bGaL+NBfdo8EkiWChsm4gBMl519NRLH05LYEAc5/nOKOgp
         ObFejqQNejin/HD3siUwnpUNntt9A2ywnsU0BzUN3ScMD45Tv0hWcE2GbCOivjY7sH3u
         swOFT9+iZbrYGt2BZ5QZ0Wqz88jpMqltJIi7rqeoUDbDcITHhr221k94I4wI+6CNtzhF
         1dve6sN7O4bacHpOiYj9cOVqf/hGqQo3Duq/PjcDyd4iOB/IweTSCDXcFcS4TsvAvYIf
         wHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7ewypPI1Z9cMHCUUQ1HrSlBl1OW939EsBTHhSNw3s78=;
        b=f2mzOzY6Qjkyfe5WP7nxfMuivdYFaHzS0eXc5NcCxTTR0rxDKxzLxoeH2XgfaIUCzQ
         cdqHiwvJsEpk/vMP+youFXO6hZtfUCIgcpoVnbTdBktQYUIGL4cSZfCo69AejnxdkNpg
         aJw0lfSzm5Jal2gEDwn6USj7oXwtU3OdbAmOYB4FDHrnawy5c8HwaLGSiFouASWaxrwn
         KVJUmwnOGpdWrd9/WbBQiI4IF+by52b5ZiAuNY52q34XqbJdXBEOwoyXv0QVbhsO+ksA
         /2+EL2uw8C3JWKLYAPe6xkWZVsDnnseLsge2XHZu+Ym5T3y9jkbwLGTFV+bekBahQ7tn
         1ZpA==
X-Gm-Message-State: AOAM5328pytDCwpgK8ooywi9V9pFpZq5EXxp4d2aC3k5yypCS0Vmjwug
        SqbQG/co63BNk6KNBIhiwZm2T0fnqfY=
X-Google-Smtp-Source: ABdhPJy0GubvuKvqfHMN1pVBqFFUtKydH4L5WK0UHiAqhAuGVgSeF7Nv4N0RJI82yj8rqhpkB6OgBA==
X-Received: by 2002:a5d:5846:: with SMTP id i6mr13064418wrf.4.1643186513149;
        Wed, 26 Jan 2022 00:41:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8sm3138831wmg.44.2022.01.26.00.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 00:41:51 -0800 (PST)
Message-Id: <f8885b27502408984f687e28b0a6fc9531287276.1643186507.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Jan 2022 08:41:44 +0000
Subject: [PATCH 2/5] scalar diagnose: include disk space information
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When analyzing problems with large worktrees/repositories, it is useful
to know how close to a "full disk" situation Scalar/Git operates. Let's
include this information.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c | 53 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 13f2b0f4d5a..e26fb2fc018 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -361,6 +361,58 @@ static int index_to_zip(const char *git_dir)
 	return run_command(&cp);
 }
 
+#ifndef WIN32
+#include <sys/statvfs.h>
+#endif
+
+static int get_disk_info(struct strbuf *out)
+{
+#ifdef WIN32
+	struct strbuf buf = STRBUF_INIT;
+	char volume_name[MAX_PATH], fs_name[MAX_PATH];
+	DWORD serial_number, component_length, flags;
+	ULARGE_INTEGER avail2caller, total, avail;
+
+	strbuf_realpath(&buf, ".", 1);
+	if (!GetDiskFreeSpaceExA(buf.buf, &avail2caller, &total, &avail)) {
+		error(_("could not determine free disk size for '%s'"),
+		      buf.buf);
+		strbuf_release(&buf);
+		return -1;
+	}
+
+	strbuf_setlen(&buf, offset_1st_component(buf.buf));
+	if (!GetVolumeInformationA(buf.buf, volume_name, sizeof(volume_name),
+				   &serial_number, &component_length, &flags,
+				   fs_name, sizeof(fs_name))) {
+		error(_("could not get info for '%s'"), buf.buf);
+		strbuf_release(&buf);
+		return -1;
+	}
+	strbuf_addf(out, "Available space on '%s': ", buf.buf);
+	strbuf_humanise_bytes(out, avail2caller.QuadPart);
+	strbuf_addch(out, '\n');
+	strbuf_release(&buf);
+#else
+	struct strbuf buf = STRBUF_INIT;
+	struct statvfs stat;
+
+	strbuf_realpath(&buf, ".", 1);
+	if (statvfs(buf.buf, &stat) < 0) {
+		error_errno(_("could not determine free disk size for '%s'"),
+			    buf.buf);
+		strbuf_release(&buf);
+		return -1;
+	}
+
+	strbuf_addf(out, "Available space on '%s': ", buf.buf);
+	strbuf_humanise_bytes(out, st_mult(stat.f_bsize, stat.f_bavail));
+	strbuf_addf(out, " (mount flags 0x%lx)\n", stat.f_flag);
+	strbuf_release(&buf);
+#endif
+	return 0;
+}
+
 /* printf-style interface, expects `<key>=<value>` argument */
 static int set_config(const char *fmt, ...)
 {
@@ -637,6 +689,7 @@ static int cmd_diagnose(int argc, const char **argv)
 	get_version_info(&buf, 1);
 
 	strbuf_addf(&buf, "Enlistment root: %s\n", the_repository->worktree);
+	get_disk_info(&buf);
 	fwrite(buf.buf, buf.len, 1, stdout);
 
 	if ((res = stage(tmp_dir.buf, &buf, "diagnostics.log")))
-- 
gitgitgadget

