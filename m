Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63B571F453
	for <e@80x24.org>; Thu, 27 Sep 2018 01:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbeI0HlU (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 03:41:20 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:45573 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbeI0HlU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 03:41:20 -0400
Received: by mail-ot1-f73.google.com with SMTP id c46-v6so1278351otd.12
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 18:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=G5qgRp129EspzskcFzeY0PL7JE8nJck0Ql5xq8kxcbU=;
        b=SDOL5JQ/TO/YbPlXHMG8cYAZ/iXnEoVTFkmcp8Pr+7qHZ+s3y5E0An8jVFxW4dzKLD
         9iJlkBMsQXku76lZy6U0ScVEVwdZ/Q1YpxQEOGP8i8m9p7h26BAU7bQouNZK085+LS2B
         ohFRx8e9PFmSIfCXanJ8t40hIxwpZKYqC+2soKCow4TYI7VCuGkdCQgNFqJdOzrYPKrr
         cb4wFhqcuNPSEYq3GI35hLEgee33LntRKZOZLI7QDhheLhStiGf3UhaAkkU+ZOEU1Ise
         NfIu2DV7yNSqCSmCQ1eRm5TEmOppaAks/q1MLl5fHc4MJvfw0iSrHbVZRJBGVo8JaB3e
         ugvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G5qgRp129EspzskcFzeY0PL7JE8nJck0Ql5xq8kxcbU=;
        b=OK3Za3fYgj9uRiHhvY3HGgPKh0oDvsd12K2GJUG0APmbxNCcuGosBprX0+UL/Yen6U
         wKZ+8F7GpGKXk2VQu7VdnWjvfNWiKcU3zy/yDeGA0nusYPaah/GFRpZ9PPAqNgl8bYXa
         bPWZpG0Zi9nmz9jBkMuctj5EYLUJyUsyu97Q71GbSlfMp3I1WaCck85oFOs7BvD5ZaSR
         EV6PimV6gxf9AL9D3LnJPhE6Smxi9u1owoZdTENXuXB3WTUD2MuagXmBINMRftOpeUpZ
         j65+0gJZNxn44KdVxTV1EbUPB1p7IbDpDqoc5/wjA1OR29Readw/8QMrbKI7Lj/6GAa/
         WAfQ==
X-Gm-Message-State: ABuFfogN2fjJLq3QlFu8qAcwXvTyVZTNoYLMcG8wIjHN954+T+y3VaGe
        lVMkxyBL46LvPrbJ1RwVjpujPfshm5jXe+j1oU6BrbtXCYIYsO44zbuoYtG3rbpfSRanXLPFmiV
        ymZ5cOI5uCn4xTlC+AW2KHcJVGnm6hWau2zeridyXeFHPAUp7uzlNqjQmLzN3EZk=
X-Google-Smtp-Source: ACcGV61wfQs/f/gtqIz0XMyCADtRkaSNdhlt0KosC8HJvdbXWED9GrSgwpu4vjstUWcXFZSq17y++rPQs9NHEg==
X-Received: by 2002:a9d:4b17:: with SMTP id q23-v6mr1875368otf.82.1538011537608;
 Wed, 26 Sep 2018 18:25:37 -0700 (PDT)
Date:   Wed, 26 Sep 2018 18:24:53 -0700
In-Reply-To: <20180927012455.234876-1-steadmon@google.com>
Message-Id: <20180927012455.234876-3-steadmon@google.com>
Mime-Version: 1.0
References: <20180912053519.31085-1-steadmon@google.com> <20180927012455.234876-1-steadmon@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v2 2/4] archive: use packet_reader for communications
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using packet_reader will simplify version detection and capability
handling, which will make implementation of protocol v2 support in
git-archive easier.

This refactoring does not change the behavior of "git archive".

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 builtin/archive.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index e74f675390..4eb547c5b7 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -27,10 +27,11 @@ static int run_remote_archiver(int argc, const char **argv,
 			       const char *remote, const char *exec,
 			       const char *name_hint)
 {
-	char *buf;
 	int fd[2], i, rv;
 	struct transport *transport;
 	struct remote *_remote;
+	struct packet_reader reader;
+	enum packet_read_status status;
 
 	_remote = remote_get(remote);
 	if (!_remote->url[0])
@@ -38,6 +39,8 @@ static int run_remote_archiver(int argc, const char **argv,
 	transport = transport_get(_remote, _remote->url[0]);
 	transport_connect(transport, "git-upload-archive", exec, fd);
 
+	packet_reader_init(&reader, fd[0], NULL, 0, PACKET_READ_CHOMP_NEWLINE);
+
 	/*
 	 * Inject a fake --format field at the beginning of the
 	 * arguments, with the format inferred from our output
@@ -53,18 +56,20 @@ static int run_remote_archiver(int argc, const char **argv,
 		packet_write_fmt(fd[1], "argument %s\n", argv[i]);
 	packet_flush(fd[1]);
 
-	buf = packet_read_line(fd[0], NULL);
-	if (!buf)
+	status = packet_reader_read(&reader);
+
+	if (status != PACKET_READ_NORMAL || reader.pktlen <= 0)
 		die(_("git archive: expected ACK/NAK, got a flush packet"));
-	if (strcmp(buf, "ACK")) {
-		if (starts_with(buf, "NACK "))
-			die(_("git archive: NACK %s"), buf + 5);
-		if (starts_with(buf, "ERR "))
-			die(_("remote error: %s"), buf + 4);
+	if (strcmp(reader.line, "ACK")) {
+		if (starts_with(reader.line, "NACK "))
+			die(_("git archive: NACK %s"), reader.line + 5);
+		if (starts_with(reader.line, "ERR "))
+			die(_("remote error: %s"), reader.line + 4);
 		die(_("git archive: protocol error"));
 	}
 
-	if (packet_read_line(fd[0], NULL))
+	status = packet_reader_read(&reader);
+	if (status == PACKET_READ_NORMAL && reader.pktlen > 0)
 		die(_("git archive: expected a flush"));
 
 	/* Now, start reading from fd[0] and spit it out to stdout */
-- 
2.19.0.605.g01d371f741-goog

