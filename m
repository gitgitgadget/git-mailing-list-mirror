Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C7AE7C4D5
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 15:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243199AbjJDPVz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 11:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbjJDPVw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 11:21:52 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7C193
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 08:21:49 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c737d61a00so17135025ad.3
        for <git@vger.kernel.org>; Wed, 04 Oct 2023 08:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696432909; x=1697037709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7Dnp/yNHi6Twk4js+gl4yySR843/EtBt3LDNrZEsq0=;
        b=Psvalo71y5ty4tK0cAvcLXa6OIntY/+DyRIn7itr1wnA81hLP7ZzDepoG6EfORpm7l
         Dqx6IW/hcrYWEUSI4oqFvRSQcGFdFy1tpVzm1+6l8YQ9schZiXqGccXlgy7VUOu44ilU
         Ovv7NAIYS6Sy60gce8E8kwLTG8G9g/cf8adW5AyeMukTt8csls9I7gzXbWuuvx9DoA8H
         ucNmNcR62lby/lKdT65wssKy3OKOxYZr4j1zLaKYiEfuhxcVgEni+AzDLuHodW595lqi
         2uR2ULdhOweMwsocpf2wqZ9B8hglVp+L79iokdt6wxpO0OF/Mf+/PFbGRxXVyaY/fssI
         Bc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696432909; x=1697037709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7Dnp/yNHi6Twk4js+gl4yySR843/EtBt3LDNrZEsq0=;
        b=IynDVrJUZrY8vSbjvsd3fnj/+TETpJdDIMLJljakcjXu4pEo8fuszl2KWcZa4B8WvK
         +d1Sd3S0S46R1D0vigOtZ0iRIAWXGs5dzPyYDAP2Z5s8gS3AQv6DeWB5vV2fCn/gpC6f
         DTC3YkreceLm70kg34pgVdjOKrdXAN2L0vQin5b8DdBWMLxZ6LTsUP1O0eYSpDCMtbMY
         G2sIUhq9qTzTfD4HXB5iA2p6sFrLNNDtm0MfONbTL9f2XX1FoNJJypHWXFVwwSbF0M84
         OSfUhXLJ0kKBNY2tF2uvPbbiOnZe+fnGbRAUqWrOaUoEuCzQrOX7pXjAIxQxp7SbIczF
         wl0g==
X-Gm-Message-State: AOJu0YyaCETKggV5DYJfyaTv8qQIofyhfiLg/WcIzFU1GkBClcNc5SOz
        fptjdZAZjicmgGwa3CiHy+X3ejXH310=
X-Google-Smtp-Source: AGHT+IEaTLrWe6iYXaOz1Hy9+DZFOFuXc91ZMJMX9EdyiJs2R7OT1qG5v9q5Foud9s2oDUB1yZIl8w==
X-Received: by 2002:a17:902:e749:b0:1b8:76ce:9d91 with SMTP id p9-20020a170902e74900b001b876ce9d91mr3413979plf.1.1696432909205;
        Wed, 04 Oct 2023 08:21:49 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id c11-20020a170903234b00b001c5f0fe64c2sm3838199plh.56.2023.10.04.08.21.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2023 08:21:48 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 3/4] transport-helper: call do_take_over() in connect_helper
Date:   Wed,  4 Oct 2023 23:21:42 +0800
Message-Id: <01699822c3f8ecda2c25dc2e2922c1f993c8beb2.1696432594.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1696432593.git.zhiyou.jx@alibaba-inc.com>
References: <xmqqil7yq6ms.fsf@gitster.g> <cover.1696432593.git.zhiyou.jx@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

After successfully connecting to the smart transport by calling
process_connect_service() in connect_helper(), run do_take_over() to
replace the old vtable with a new one which has methods ready for the
smart transport connection.

The connect_helper() function is used as the connect method of the
vtable in "transport-helper.c", and it is called by transport_connect()
in "transport.c" to setup a connection. The only place that we call
transport_connect() so far is in "builtin/archive.c". Without running
do_take_over(), it may fail to call transport_disconnect() in
run_remote_archiver() of "builtin/archive.c". This is because for a
stateless connection or a service like "git-upload-pack-archive", the
remote helper may receive a SIGPIPE signal and exit early. To have a
graceful disconnect method by calling do_take_over() will solve this
issue.

The subsequent commit will introduce remote archive over a stateless-rpc
connection.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 transport-helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/transport-helper.c b/transport-helper.c
index 51088cc03a..3b036ae1ca 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -672,6 +672,8 @@ static int connect_helper(struct transport *transport, const char *name,
 
 	fd[0] = data->helper->out;
 	fd[1] = data->helper->in;
+
+	do_take_over(transport);
 	return 0;
 }
 
-- 
2.40.1.50.gf560bcc116.dirty

