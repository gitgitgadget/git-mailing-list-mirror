Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5058D20D0C
	for <e@80x24.org>; Tue, 20 Jun 2017 07:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751126AbdFTHzx (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:55:53 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33801 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbdFTHzw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:55:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id f134so3642958wme.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z/Dor0lJxAVsE8QzQYzI0GDXXm2ssP3X7jRuMewnmD4=;
        b=cyB9Z830yXRAYZo/Xy1zbtNasQXX5qH8LPlLVnGejx1ORzqTINQMY3hQ9Ks40n7Ajv
         S8yWeUdZ1s24ByNRlVPyQ9jFUBA53EirFrEDAEjtJUy9eWQz+vYPnTcyPTi4sP7xhSnw
         aYE1JJymzWH8yuGPDd4zmYI9jISsty9Z9dzXg2muoNDG4TtseMUSiUztRpH0CB183DBr
         GuOLG+5KE+rvzsh8zeBox4Wc2P+yo2mny3gfxAZv9vdIi6BwSbolLpM3TpP+qZjzyFKx
         zXO+vXQ5fV2rThdHwA82AAlU18z+VjyoV/mN+UBdA2qZxPCi5gHFGcUOOU5IUXouIP9P
         SpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z/Dor0lJxAVsE8QzQYzI0GDXXm2ssP3X7jRuMewnmD4=;
        b=Rm8hy2o0nAfDJRqNhVGQb4ABNlb3T80J1J+nfpPDMNmFGc0lRh3Q6LSm+dmX8lFQtp
         bnWGE4YKZq8BXqgd9A7BU1J7gsrn2pvuCtFEIqlLQ3Ya8JU56Gbigsv1csBLvW671Qeb
         /ty2/B3KZIYgKvhuqixSPBPL66k77y8aB8d/cZVbqzZ2UPbtvdNDIZjMChF5JPVo3ohl
         SCXhubdVPyzED4BO2LyfsM03RS7EEUIZV43llmnIdoUC5LF53Q2s2x9L+Hf5r1oEPfio
         qEerKBiJphlJO5iqLZxU8gSxVNGcA9Gp02j6tQX+wytHnjI+OMRqyDnk7fy+3BIfAX+k
         0O1A==
X-Gm-Message-State: AKS2vOzIqIs+zibkU0rpkJRRo1mFp+sFlbvPtRpBru4Qta0NXSykp1qj
        F+NE96/TMoPIg4+v
X-Received: by 10.28.54.154 with SMTP id y26mr1838770wmh.53.1497945350363;
        Tue, 20 Jun 2017 00:55:50 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:55:49 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v4 01/49] builtin/clone: get rid of 'value' strbuf
Date:   Tue, 20 Jun 2017 09:54:35 +0200
Message-Id: <20170620075523.26961-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes the code simpler by removing a few lines, and getting
rid of one variable.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/clone.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index a2ea019c59..370a233d22 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -870,7 +870,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	const struct ref *our_head_points_at;
 	struct ref *mapped_refs;
 	const struct ref *ref;
-	struct strbuf key = STRBUF_INIT, value = STRBUF_INIT;
+	struct strbuf key = STRBUF_INIT;
 	struct strbuf branch_top = STRBUF_INIT, reflog_msg = STRBUF_INIT;
 	struct transport *transport = NULL;
 	const char *src_ref_prefix = "refs/heads/";
@@ -1035,7 +1035,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&branch_top, "refs/remotes/%s/", option_origin);
 	}
 
-	strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
 	strbuf_addf(&key, "remote.%s.url", option_origin);
 	git_config_set(key.buf, repo);
 	strbuf_reset(&key);
@@ -1049,10 +1048,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_required_reference.nr || option_optional_reference.nr)
 		setup_reference();
 
-	fetch_pattern = value.buf;
+	fetch_pattern = xstrfmt("+%s*:%s*", src_ref_prefix, branch_top.buf);
 	refspec = parse_fetch_refspec(1, &fetch_pattern);
-
-	strbuf_reset(&value);
+	free((char *)fetch_pattern);
 
 	remote = remote_get(option_origin);
 	transport = transport_get(remote, remote->url[0]);
@@ -1191,7 +1189,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_release(&reflog_msg);
 	strbuf_release(&branch_top);
 	strbuf_release(&key);
-	strbuf_release(&value);
 	junk_mode = JUNK_LEAVE_ALL;
 
 	free(refspec);
-- 
2.13.1.565.gbfcd7a9048

