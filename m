Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA2DE7C4D0
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 15:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243145AbjJDPVw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 11:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbjJDPVv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 11:21:51 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C41093
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 08:21:47 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c364fb8a4cso19123655ad.1
        for <git@vger.kernel.org>; Wed, 04 Oct 2023 08:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696432907; x=1697037707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fe8eoXKLU3LhGZ9QnmBBML4avfnlZn90OV2icmcRWY=;
        b=di/eGwp4tlXz1p5R5TRWP4+Skj1ydmOlB4z40zJFC9wAzrv4uusxEdEsFs21F7EE8F
         NkyUf02MoYdM5sKwLjqwmnf52Bqdfeh2VrLZZy/2ESIJyOrmfJpuyOVc+ZPRMl2P2dKz
         2HQqqGF0VSg1nOJTwqr0T7rUP9856C+uDBdCPcoEagl3MisiHIzcCu6MPaQ510kK00h0
         9tMjxqVp08I1RupruHrBfw1QrDCAWpgDqBUQmboE4bJCndnni8F+tUJvyOplId9EJfQM
         I0mrK2B/iPb7rGqHd3oqtUZYm11pIMMCNDUP3mmtioS3yx/yqWz6mUGK8GLa3Uxe0SHW
         rbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696432907; x=1697037707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fe8eoXKLU3LhGZ9QnmBBML4avfnlZn90OV2icmcRWY=;
        b=s+W1mwbhNpGFEE07+N4hivzBuRHozEZQ1p0E9Ul7zik362t9e8auwEdd8f7dgAZRoV
         Pyckw0rRXi7tkR6G2j+JuyMEIs30e6RpwvbSyIQk4Q2cH/VPWCSmhLt1zNOLmuDyN+3w
         hWEEDyWcdQhmfiYZdStjgH9S1ZG1xxBUJ65HOkyKFuS19G9eOGRg+0NpPSaeiIRqvc50
         QTPOopS8svQLbPYB1smJ16RF10WFGKnOBywVvsBPNP3ro7F0bVVCpHL5wYWphID6IGsY
         dMPaTEWNDrRjsQaydpyuu3bCvsiDCdWgnBnLD7M9MXx6SRXNPVCjDytkiUfbxBqBsQCw
         0lXw==
X-Gm-Message-State: AOJu0Yyeq0CV7w/pP27BkaVEHJ96QYLry0320LzjbSABzvLCBZgJFlKT
        sOU4PEOfxridudmFU8QcQEilW+H9bEA=
X-Google-Smtp-Source: AGHT+IF5FsBB+u46ixukTlBAZKb3n/uRQ8+iuVseKPXJ3J+IRiQrXOq+XurTjTamBQwWSd/6obRL8w==
X-Received: by 2002:a17:903:1208:b0:1c3:92de:1b23 with SMTP id l8-20020a170903120800b001c392de1b23mr3314683plh.59.1696432906627;
        Wed, 04 Oct 2023 08:21:46 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id c11-20020a170903234b00b001c5f0fe64c2sm3838199plh.56.2023.10.04.08.21.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2023 08:21:46 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 0/4] support remote archive from stateless transport
Date:   Wed,  4 Oct 2023 23:21:39 +0800
Message-Id: <cover.1696432593.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <xmqqil7yq6ms.fsf@gitster.g>
References: <xmqqil7yq6ms.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

"git archive --remote=<remote>" learned to talk over the smart
http (aka stateless) transport.

range-diff v2...v3

1:  4497404900 = 1:  e660fc79b6 transport-helper: no connection restriction in connect_helper
-:  ---------- > 2:  e3dc18caa9 transport-helper: call do_take_over() in process_connect
2:  9bfaa1a904 ! 3:  01699822c3 transport-helper: run do_take_over in connect_helper
    @@ Metadata
     Author: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## Commit message ##
    -    transport-helper: run do_take_over in connect_helper
    +    transport-helper: call do_take_over() in connect_helper
     
         After successfully connecting to the smart transport by calling
    -    "process_connect_service()" in "connect_helper()", run "do_take_over()"
    -    to replace the old vtable with a new one which has methods ready for
    -    the smart transport connection.
    +    process_connect_service() in connect_helper(), run do_take_over() to
    +    replace the old vtable with a new one which has methods ready for the
    +    smart transport connection.
     
    -    The subsequent commit introduces remote archive for a stateless-rpc
    -    connection. But without running "do_take_over()", it may fail to call
    -    "transport_disconnect()" in "run_remote_archiver()" of
    -    "builtin/archive.c". This is because for a stateless connection or a
    -    service like "git-upload-pack-archive", the remote helper may receive a
    -    SIGPIPE signal and exit early. To have a graceful disconnect method by
    -    calling "do_take_over()" will solve this issue.
    +    The connect_helper() function is used as the connect method of the
    +    vtable in "transport-helper.c", and it is called by transport_connect()
    +    in "transport.c" to setup a connection. The only place that we call
    +    transport_connect() so far is in "builtin/archive.c". Without running
    +    do_take_over(), it may fail to call transport_disconnect() in
    +    run_remote_archiver() of "builtin/archive.c". This is because for a
    +    stateless connection or a service like "git-upload-pack-archive", the
    +    remote helper may receive a SIGPIPE signal and exit early. To have a
    +    graceful disconnect method by calling do_take_over() will solve this
    +    issue.
    +
    +    The subsequent commit will introduce remote archive over a stateless-rpc
    +    connection.
     
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
3:  1e305394ee ! 4:  a38ac182d6 archive: support remote archive from stateless transport
    @@ Commit message
             capabilities when connecting to remote-helper, so do not send them
             in "remote-curl.c" for the "git-upload-archive" service.
     
    +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## http-backend.c ##
    @@ http-backend.c: static void check_content_type(struct strbuf *hdr, const char *a
      static void service_rpc(struct strbuf *hdr, char *service_name)
      {
     -	const char *argv[] = {NULL, "--stateless-rpc", ".", NULL};
    -+	const char *argv[4];
    ++	struct strvec argv = STRVEC_INIT;
      	struct rpc_service *svc = select_service(hdr, service_name);
      	struct strbuf buf = STRBUF_INIT;
      
    -+	if (!strcmp(service_name, "git-upload-archive")) {
    -+		argv[1] = ".";
    -+		argv[2] = NULL;
    -+	} else {
    -+		argv[1] = "--stateless-rpc";
    -+		argv[2] = ".";
    -+		argv[3] = NULL;
    -+	}
    ++	strvec_push(&argv, svc->name);
    ++	if (strcmp(service_name, "git-upload-archive"))
    ++		strvec_push(&argv, "--stateless-rpc");
    ++	strvec_push(&argv, ".");
     +
      	strbuf_reset(&buf);
      	strbuf_addf(&buf, "application/x-git-%s-request", svc->name);
      	check_content_type(hdr, buf.buf);
    +@@ http-backend.c: static void service_rpc(struct strbuf *hdr, char *service_name)
    + 
    + 	end_headers(hdr);
    + 
    +-	argv[0] = svc->name;
    +-	run_service(argv, svc->buffer_input);
    ++	run_service(argv.v, svc->buffer_input);
    + 	strbuf_release(&buf);
    ++	strvec_clear(&argv);
    + }
    + 
    + static int dead;
     @@ http-backend.c: static struct service_cmd {
      	{"GET", "/objects/pack/pack-[0-9a-f]{64}\\.idx$", get_idx_file},
      
---

Jiang Xin (4):
  transport-helper: no connection restriction in connect_helper
  transport-helper: call do_take_over() in process_connect
  transport-helper: call do_take_over() in connect_helper
  archive: support remote archive from stateless transport

 http-backend.c         | 15 +++++++++++----
 remote-curl.c          | 14 +++++++++++---
 t/t5003-archive-zip.sh | 30 ++++++++++++++++++++++++++++++
 transport-helper.c     | 29 +++++++++++++----------------
 4 files changed, 65 insertions(+), 23 deletions(-)

-- 
2.40.1.50.gf560bcc116.dirty

