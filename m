Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF90C433FE
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243968AbiBWScc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243920AbiBWScK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:32:10 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D494BFE8
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:29 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u1so41051242wrg.11
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=VcEgWbt3lO6ugJXNLWN/Cdal2JKkBE560E2IRHc6CQU=;
        b=ZwwIVaZ8joSRWsWsyMOtiYCz1stj/DsJa3EkKbD5ETJJ9egB3JtUjANBvD1neDcJkU
         Gmtltuu8UvURDKB9uQYBmZYYUl3rmNlToklLyo0Nl4vqwyhtxBpNE8Ii7Evsnsqmxb0E
         Qfgmzqxe6ihklI6DVrHBb4tyT5wLwC36Vq3Ei48rM8Tyg0hc+fH9msOVhIYIz2ZKhltJ
         xJ9l0/lHTpdYyAPPVKyuil3B0Xqa1fUxn0NoMHhUOcSjbrX9a3kOIRMVG2IP56wBkbU+
         RKmnwqJe+0v8nD2yywHUqnGRxRYZxHhPJKK5IqdeK2SVKS8J2Y45PKORa8rjS1Cnep8S
         cCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=VcEgWbt3lO6ugJXNLWN/Cdal2JKkBE560E2IRHc6CQU=;
        b=oq1lIZliutGlB7TUeT5pycv7ft6evFPrzAmKS+4xdyAwlQERZkLQkg8yWWYq7xrvEr
         tC51wubEe9DQqEE8Dcnj2bmGw05Y42fIM+jUH+7fDc9x2mvJtDK4I5OzOYxfRZxBliAO
         B2Q9QHc5oEQ8uAPVc4+hyaLJGJ3Tcg8pcTkcJLKx4+tDdkMiKKRCdH2pVuBchQq+0/un
         l2Ll7ukc3Nqd+R8ugVhwTIQq6YOhFMOwe3NuALrlCTPrtsTLPYzdjzLIUGAHuFaSO6qf
         CasUP3n+P1rFJZVIZpm5hKnorq8eUhVOOpDZqMjQ3QPYF0nFXx0Z2VEZiWjmgufp/yr4
         owaA==
X-Gm-Message-State: AOAM533S4wX8XYsSMWpdF67pMosvo5mgvWBIL7ccSWwJwjooReckCQ45
        dThdZUrOmUFPTic8JZx1V/eklaA88dU=
X-Google-Smtp-Source: ABdhPJysZAlYdjBD4DHwA+c9AuANnix3hdqmy7xvhG79NbB/VXtrdwS2xlWuToomfVLGdRxrJLxFXg==
X-Received: by 2002:a05:6000:508:b0:1e4:a027:d147 with SMTP id a8-20020a056000050800b001e4a027d147mr678436wrf.315.1645641087903;
        Wed, 23 Feb 2022 10:31:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w18sm286188wrl.62.2022.02.23.10.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:31:27 -0800 (PST)
Message-Id: <7a8b13c308c1e54e4f51429805fc309384a93120.1645641063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:31:00 +0000
Subject: [PATCH 22/25] connect: implement get_recommended_features()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, aevar@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
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
index 9d78d681e95..e1e6f4770dd 100644
--- a/connect.c
+++ b/connect.c
@@ -491,6 +491,42 @@ static void send_capabilities(int fd_out, struct packet_reader *reader)
 	}
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
 struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     struct ref **list, int for_push,
 			     struct transport_ls_refs_options *transport_options,
diff --git a/remote.h b/remote.h
index 438152ef562..268e8134f5e 100644
--- a/remote.h
+++ b/remote.h
@@ -236,6 +236,10 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     const struct string_list *server_options,
 			     int stateless_rpc);
 
+/* Used for protocol v2 in order to retrieve recommended features */
+int get_recommended_features(int fd_out, struct packet_reader *reader,
+			     struct string_list *list, int stateless_rpc);
+
 int resolve_remote_symref(struct ref *ref, struct ref *list);
 
 /*
-- 
gitgitgadget

