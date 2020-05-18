Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B4DC433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 09:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 943FE2067D
	for <git@archiver.kernel.org>; Mon, 18 May 2020 09:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFYlaMC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgERJkw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 05:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERJkv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 05:40:51 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFD2C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 02:40:50 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id u35so4563157pgk.6
        for <git@vger.kernel.org>; Mon, 18 May 2020 02:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j/jZLnynn4UPdPpkYdxZX7CU+vRXBHWymcoUoY55wv4=;
        b=oFYlaMC00d7hOWnG3NNA/TsLUu/yO0i8SD67kz2W9gHrRC81LxUdORHTVcRFqh2TcQ
         Wh1/kBdHKKvSZr4ats5plKO1m8gOcRSkkF2O3ZSHN7mX9qtGIJ95lKLi2gbZ+4B5m4xX
         ltGaYecEt7QmykJDOgZJrJxNHmsMrbmG8djubyVPg355sv4P9qU1bV6BbEiHTac9Vbgd
         d9NVQPU9sfDvd9vDDWH/CyR26KhUMuYqFotel5kbWiCiHrJ1E7P+XBzo4KI5ird/q+Cf
         MRdnjjomUArJqJdgk/78lwp5N2fXRVBx5g3UseUqLBQkfi14FQL1Qf17H+jeMJL2D7Wi
         UsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j/jZLnynn4UPdPpkYdxZX7CU+vRXBHWymcoUoY55wv4=;
        b=CUrSnj6P8NotVMGkkK7peibRzjY03Eo7Qbcol4JZTwy2t9zP7vp4IywE1oM+sI1246
         MRpXv7uptO7xaLKcL2FSHm6cHDTb9BhkTg2WuqOT1JS63NTioyTeybEUSxzqqSOBpR3n
         KCE/MYyIdytGcLFK+zb0H9eb3R/My3Ua8OKPUuMQUTIM5LEJ10VLDqvZZd1y1rxKjkjf
         UxJtY7r3/tft7Is16L5OrpdDFU5ZS03hAwCP4B2+AI7+Vzcgt0qFCimXXfrYj81fDc9e
         SCkYzphaQ9AIcArocHmG85PUklP2R1y3PPxtr89c7VBJIVF9ZvhT9xJOPtClsLjEFmHb
         ZBaA==
X-Gm-Message-State: AOAM530P/6AmsHey8kz6JFxI4J5UacK62hClA/1k0XADScD5mDsw75zQ
        i3XE16M3Hxc+WQn3xgsvHZQ=
X-Google-Smtp-Source: ABdhPJwwGc5iyXgJe3MvagEzdLw9CbxMJiK4X5/LBqGFoNw4MUhAfZuVZ00aySNaLhtWwEYSKqdk9Q==
X-Received: by 2002:a62:7cd1:: with SMTP id x200mr16471285pfc.232.1589794849539;
        Mon, 18 May 2020 02:40:49 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id e1sm8119867pjv.54.2020.05.18.02.40.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 02:40:48 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v16 00/11] New proc-receive hook for centralized workflow
Date:   Mon, 18 May 2020 05:40:28 -0400
Message-Id: <20200518094039.757-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200507161057.12690-1-worldhello.net@gmail.com>
References: <20200507161057.12690-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

This topic introduces a new hook named "proc-receive" for
"receive-pack".  We can use this hook to implement a Gerrit-like
centralized workflow.

## Changes since v15

1. Parse report options in function `transport_update_tracking_ref()`
   in order to update remote-tracking branches properly.

   See patch 9/11 and 10/11.

2. Add docs for 'report-status-v2' in 'Documentation/technical/
   pack-protocol.txt', and other files.

   See patch 5/11.

3. Remove unnecessary headers:

    --- a/remote.c
    +++ b/remote.c
    @@ -1,6 +1,5 @@
     #include "cache.h"
     #include "config.h"
    -#include "connect.h"
     #include "remote.h"
     #include "refs.h"
     #include "refspec.h"
    
    --- a/t/helper/test-proc-receive.c
    +++ b/t/helper/test-proc-receive.c
    @@ -3,7 +3,6 @@
     #include "parse-options.h"
     #include "pkt-line.h"
     #include "sigchain.h"
    -#include "string-list.h"
     #include "test-tool.h"
     
     static const char *proc_receive_usage[] = {


4. Fix format issues:

    --- a/builtin/receive-pack.c
    +++ b/builtin/receive-pack.c
    @@ -2262,7 +2262,7 @@ static void report(struct command *commands, const char *unpack_status)
     	for (cmd = commands; cmd; cmd = cmd->next) {
     		if (!cmd->report.error_message)
     			packet_buf_write(&buf, "ok %s\n",
    -						 cmd->ref_name);
    +					 cmd->ref_name);
     		else
     			packet_buf_write(&buf, "ng %s %s\n",
     					 cmd->ref_name, cmd->report.error_message);

    --- a/builtin/send-pack.c
    +++ b/builtin/send-pack.c
    @@ -101,13 +101,13 @@ static void print_helper_status(struct ref *ref)
     				strbuf_addf(&buf, "ok %s\n", ref->name);
     			if (options->ref_name)
     				strbuf_addf(&buf, "option refname %s\n",
    -						  options->ref_name);
    +					    options->ref_name);
     			if (options->old_oid)
     				strbuf_addf(&buf, "option old-oid %s\n",
    -						  oid_to_hex(options->old_oid));
    +					    oid_to_hex(options->old_oid));
     			if (options->new_oid)
     				strbuf_addf(&buf, "option new-oid %s\n",
    -						  oid_to_hex(options->new_oid));
    +					    oid_to_hex(options->new_oid));
     			if (options->forced_update)
     				strbuf_addstr(&buf, "option forced-update\n");
     		}

5. Other minor changes:

    --- a/builtin/receive-pack.c
    +++ b/builtin/receive-pack.c
    @@ -806,7 +806,7 @@ static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
     	if (options) {
     		struct object_id *old_oid;
     		struct object_id *new_oid;
    -		char *ref_name;
    +		const char *ref_name;
     
     		old_oid = options->old_oid ? options->old_oid : &cmd->old_oid;
     		new_oid = options->new_oid ? options->new_oid : &cmd->new_oid;
    
    
    --- a/remote.h
    +++ b/remote.h
    @@ -94,7 +94,7 @@ int for_each_remote(each_remote_fn fn, void *priv);
     int remote_has_url(struct remote *remote, const char *url);
     
     struct ref_push_report_options {
    -	char *ref_name;
    +	const char *ref_name;
     	struct object_id *old_oid;
     	struct object_id *new_oid;
     	unsigned int forced_update:1;
    
----

Jiang Xin (11):
  transport: not report a non-head push as a branch
  t5411: add basic test cases for proc-receive hook
  receive-pack: add new proc-receive hook
  New capability "report-status-v2" for git-push
  doc: add document for capability report-status-v2
  receive-pack: feed report options to post-receive
  refs.c: refactor to reuse ref_is_hidden()
  receive-pack: new config receive.procReceiveRefs
  t5411: test updates of remote-tracking branches
  transport: parse report options for tracking refs
  doc: add documentation for the proc-receive hook

 Documentation/config/receive.txt              |  14 +
 Documentation/githooks.txt                    |  62 +++
 Documentation/technical/pack-protocol.txt     |  43 +-
 .../technical/protocol-capabilities.txt       |  17 +-
 Makefile                                      |   1 +
 builtin/receive-pack.c                        | 461 ++++++++++++++++--
 builtin/send-pack.c                           |  21 +-
 refs.c                                        |  13 +-
 refs.h                                        |   1 +
 remote.c                                      |   4 +-
 remote.h                                      |  16 +-
 send-pack.c                                   |  99 +++-
 t/helper/test-proc-receive.c                  | 174 +++++++
 t/helper/test-tool.c                          |   1 +
 t/helper/test-tool.h                          |   1 +
 t/t5411-proc-receive-hook.sh                  | 117 +++++
 t/t5411/common-functions.sh                   |  56 +++
 t/t5411/once-0010-report-status-v1.sh         |  88 ++++
 t/t5411/test-0000-standard-git-push.sh        | 143 ++++++
 .../test-0001-standard-git-push--porcelain.sh | 147 ++++++
 t/t5411/test-0002-pre-receive-declined.sh     |  33 ++
 ...st-0003-pre-receive-declined--porcelain.sh |  34 ++
 t/t5411/test-0010-proc-receive-settings.sh    |   7 +
 t/t5411/test-0011-no-hook-error.sh            |  64 +++
 t/t5411/test-0012-no-hook-error--porcelain.sh |  66 +++
 t/t5411/test-0013-bad-protocol.sh             | 217 +++++++++
 t/t5411/test-0014-bad-protocol--porcelain.sh  | 160 ++++++
 t/t5411/test-0020-report-ng.sh                |  67 +++
 t/t5411/test-0021-report-ng--porcelain.sh     |  69 +++
 t/t5411/test-0022-report-unexpect-ref.sh      |  45 ++
 ...est-0023-report-unexpect-ref--porcelain.sh |  46 ++
 t/t5411/test-0024-report-unknown-ref.sh       |  34 ++
 ...test-0025-report-unknown-ref--porcelain.sh |  35 ++
 t/t5411/test-0026-push-options.sh             |  79 +++
 t/t5411/test-0027-push-options--porcelain.sh  |  82 ++++
 t/t5411/test-0030-report-ok.sh                |  35 ++
 t/t5411/test-0031-report-ok--porcelain.sh     |  36 ++
 t/t5411/test-0032-report-with-options.sh      | 256 ++++++++++
 ...est-0033-report-with-options--porcelain.sh | 265 ++++++++++
 t/t5411/test-0034-report-ft.sh                |  44 ++
 t/t5411/test-0035-report-ft--porcelain.sh     |  45 ++
 ...t-0036-report-multi-rewrite-for-one-ref.sh | 227 +++++++++
 ...rt-multi-rewrite-for-one-ref--porcelain.sh | 172 +++++++
 t/t5411/test-0038-report-mixed-refs.sh        |  89 ++++
 .../test-0039-report-mixed-refs--porcelain.sh |  91 ++++
 t/t5411/test-0040-process-all-refs.sh         | 113 +++++
 .../test-0041-process-all-refs--porcelain.sh  | 114 +++++
 t/t5516-fetch-push.sh                         |   2 +-
 transport-helper.c                            |  53 +-
 transport.c                                   | 161 ++++--
 50 files changed, 4109 insertions(+), 111 deletions(-)
 create mode 100644 t/helper/test-proc-receive.c
 create mode 100755 t/t5411-proc-receive-hook.sh
 create mode 100644 t/t5411/common-functions.sh
 create mode 100644 t/t5411/once-0010-report-status-v1.sh
 create mode 100644 t/t5411/test-0000-standard-git-push.sh
 create mode 100644 t/t5411/test-0001-standard-git-push--porcelain.sh
 create mode 100644 t/t5411/test-0002-pre-receive-declined.sh
 create mode 100644 t/t5411/test-0003-pre-receive-declined--porcelain.sh
 create mode 100644 t/t5411/test-0010-proc-receive-settings.sh
 create mode 100644 t/t5411/test-0011-no-hook-error.sh
 create mode 100644 t/t5411/test-0012-no-hook-error--porcelain.sh
 create mode 100644 t/t5411/test-0013-bad-protocol.sh
 create mode 100644 t/t5411/test-0014-bad-protocol--porcelain.sh
 create mode 100644 t/t5411/test-0020-report-ng.sh
 create mode 100644 t/t5411/test-0021-report-ng--porcelain.sh
 create mode 100644 t/t5411/test-0022-report-unexpect-ref.sh
 create mode 100644 t/t5411/test-0023-report-unexpect-ref--porcelain.sh
 create mode 100644 t/t5411/test-0024-report-unknown-ref.sh
 create mode 100644 t/t5411/test-0025-report-unknown-ref--porcelain.sh
 create mode 100644 t/t5411/test-0026-push-options.sh
 create mode 100644 t/t5411/test-0027-push-options--porcelain.sh
 create mode 100644 t/t5411/test-0030-report-ok.sh
 create mode 100644 t/t5411/test-0031-report-ok--porcelain.sh
 create mode 100644 t/t5411/test-0032-report-with-options.sh
 create mode 100644 t/t5411/test-0033-report-with-options--porcelain.sh
 create mode 100644 t/t5411/test-0034-report-ft.sh
 create mode 100644 t/t5411/test-0035-report-ft--porcelain.sh
 create mode 100644 t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
 create mode 100644 t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
 create mode 100644 t/t5411/test-0038-report-mixed-refs.sh
 create mode 100644 t/t5411/test-0039-report-mixed-refs--porcelain.sh
 create mode 100644 t/t5411/test-0040-process-all-refs.sh
 create mode 100644 t/t5411/test-0041-process-all-refs--porcelain.sh

-- 
2.26.1.120.g98702cf3e9

