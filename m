Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1136C4332D
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 14:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2CCC23A54
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 14:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbhAVOW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 09:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbhAVOWo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 09:22:44 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C0BC061788
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 06:22:03 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id c6so6775610ede.0
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 06:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vterG4vKjjM2wPvo6g0UtgDct5S8JxEnKImgKc2N9lM=;
        b=InBVdvbYdvtSYkpu4A1/HIJWNErE3HOhRqu9z2v6xAmFRq0og4NX+X5BcY4es5EDek
         Z7LeQUtFPOB0NncjHD7lKLOAUeSIMn/yp9D+FHzSiQZ6wgRXwpl/TPpMXH0mHe1LECVk
         HkGCGuADqKLaq+VGmD6cTwcARW8HQ3Y5ni7HY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vterG4vKjjM2wPvo6g0UtgDct5S8JxEnKImgKc2N9lM=;
        b=RavJh4g8NnPBGnvTOMCViXa1rEYmnWEZlolDNGfLS51ShpGWk1FX8GFbJuzJQVi1aB
         9qNI06K7kvm0HYw4hMFQl/2rXzCAL3melUroNFK9Zz0VvbV+l3btpJrrbaXpZ3QfhA86
         2zeIw7MJoV6mLTC3biYXRR5onH6lC4YNsK9Dm5LV3wdUbK5L9gkkxkbijC0zaWDtigBK
         //jyYZpPNDEFzNruwAuD6aafFzaQrmC5GA9mY7r96JthlQlP9J9zjopZ3pCNMJDv+iwx
         U1A55qnlu5ZefA9kBukjSHRgYuAdHWR0Mm0EGve3EzTer/YEzrkT7TZUve+yFx4naYu8
         FiZQ==
X-Gm-Message-State: AOAM533OQHRiV7MXaVvwDtJjcgy4/zAkuOjWIon+umvAwxEg7V/ZBUJJ
        YRO+UVz6g0Js45qNtL1T1cPPAjkZBwDTR1a0
X-Google-Smtp-Source: ABdhPJxiyIn0ovZ6t/3gVwZvCFqKTu8RIGpGxXRLS169XS2CY/UShXQ0vULx8HXdsrhz3p0ixXaGCQ==
X-Received: by 2002:aa7:d98a:: with SMTP id u10mr3353628eds.275.1611325321925;
        Fri, 22 Jan 2021 06:22:01 -0800 (PST)
Received: from localhost.localdomain (e93008.upc-e.chello.nl. [213.93.93.8])
        by smtp.gmail.com with ESMTPSA id zk10sm4576650ejb.10.2021.01.22.06.22.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 06:22:01 -0800 (PST)
From:   Jacob Vosmaer <jacob@gitlab.com>
To:     git@vger.kernel.org
Cc:     Jacob Vosmaer <jacob@gitlab.com>
Subject: [PATCH 1/1] upload-pack.c: fix filter spec quoting bug
Date:   Fri, 22 Jan 2021 15:21:37 +0100
Message-Id: <20210122142137.21161-2-jacob@gitlab.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210122142137.21161-1-jacob@gitlab.com>
References: <20210122142137.21161-1-jacob@gitlab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes a bug that occurs when you combine partial clone and
uploadpack.packobjectshook. You can reproduce it as follows:

git clone -u 'git -c uploadpack.allowfilter '\
'-c uploadpack.packobjectshook=" exec" '\
'upload-pack' --filter=blob:none --no-local \
src.git dst.git

Be careful with the line endings because this has a long quoted string
as the -u argument. Note that there is an intentional space before
'exec'. Without that space, run-command.c tries to be smart and the
command fails for the wrong reason.

The error I get when I run this is:

Cloning into '/tmp/broken'...
remote: fatal: invalid filter-spec ''blob:none''
error: git upload-pack: git-pack-objects died with error.
fatal: git upload-pack: aborting due to possible repository corruption on the remote side.
remote: aborting due to possible repository corruption on the remote side.
fatal: early EOF
fatal: index-pack failed

The problem is an unnecessary and harmful layer of quoting. I tried
digging through the history of this function and I think this quoting
was there from the start. My best guess is that it stems from a
misunderstanding of what use_shell=1 means. The code seems to assume
it means "arguments get joined into one big string, then fed to
/bin/sh". But that is not what it means: use_shell=1 means that the
first argument in the arguments array may be a shell script and if so
should be passed to /bin/sh. All other arguments are passed as normal
arguments.

The solution is simple: never quote the filter spec.
---
 upload-pack.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 3b66bf92ba..eae1fdbc55 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -305,14 +305,7 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 	if (pack_data->filter_options.choice) {
 		const char *spec =
 			expand_list_objects_filter_spec(&pack_data->filter_options);
-		if (pack_objects.use_shell) {
-			struct strbuf buf = STRBUF_INIT;
-			sq_quote_buf(&buf, spec);
-			strvec_pushf(&pack_objects.args, "--filter=%s", buf.buf);
-			strbuf_release(&buf);
-		} else {
-			strvec_pushf(&pack_objects.args, "--filter=%s", spec);
-		}
+		strvec_pushf(&pack_objects.args, "--filter=%s", spec);
 	}
 	if (uri_protocols) {
 		for (i = 0; i < uri_protocols->nr; i++)
-- 
2.30.0

