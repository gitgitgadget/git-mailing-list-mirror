Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBE701F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964964AbeB1XYm (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:24:42 -0500
Received: from mail-oi0-f73.google.com ([209.85.218.73]:39006 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965036AbeB1XYj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:24:39 -0500
Received: by mail-oi0-f73.google.com with SMTP id p187so2170345oia.6
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=fdxkw9oojgxuYh3rfhwCjIpuPyLgS4DWRPMeOBYZDnk=;
        b=Z957uJakTYme/ez8ChnuxeztORRA21H4tEqYeh8pT29pg2F8DMqqMXyrvimCOoTuhc
         hmH79DDD1ZNZiK/ufqemYP9Fk3kebclRka2Hn9frSEatDAVAejX6SQtRpGqJrhwTDqJm
         qDZKhJ42DBoTMcMucaHXbnj0nxbKqIHb7kNvZCbuHIESjOzjrb4SGrjhbOEezaWaCbhP
         Xh6WcVusOD5mtvv9M0Bzgz5WwzEbgLC86KLMBvJb+bjSVSzKVyfZ0z+fEAaQZE468XAC
         NfX3INyJwaiHhPg0bhqzOvwSB1j2dXi8phICHsRrJQ3v4MLwSGxNKaOxphZqWnBPU5rU
         c4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=fdxkw9oojgxuYh3rfhwCjIpuPyLgS4DWRPMeOBYZDnk=;
        b=W3GjSrNCX41u5RHOhdvWtDwHjQqGz+XHIcENmi+ki6PkGeKnv/SPl9u+TMLrNx1JKu
         s67S7x0hi0BqBAyWjCI0nvJwPZQG5xIZX2PJ2rRlmEdTb9zirV+Qt5/sssQC57utczVN
         yCH0P+f8YR+BDtbjwCPRKbWr+KS8YJ7hBhsVntprS6/Jh+4oo9OY+h6HIQn5nJBLpnVx
         0PzZZQSp8AjI/NjijwjMmvrda4k2nW/J53QGgqBh/0m5Z9m0BFKaBQQ0DM3n8qRfTZvV
         ofhi03jfqK9PFerejiy1jUpfe+iVb5IHJ3u8mpw+1eVSkqL8ed1CsGImloigQrJ+g8d0
         9osw==
X-Gm-Message-State: APf1xPA4OJBeuPiwTG3GMJV9xkVSJi4pKJgGAM++ahQd94t2zrxEKlAs
        V67z0vINXVlVg81ABCPeY4DIx/5/MNxTT9P6GEVOcoYSX5A1f3Rgukm7ogS7mzZi5BZ2SUDZX6v
        KmS0oJUToZ6HLHZcOpPI1kLv9t5JCUkxX6KyLBpdL+LfDkiMYTzEfWyrGiA==
X-Google-Smtp-Source: AG47ELvXIEsLzD+AT6bw6sax0CHpQS8wb/Y9ix04XtJ5UX9cQbrQpaQAdM+HFqZUR6G3Nt59bCUUl2gtQLY=
MIME-Version: 1.0
X-Received: by 10.202.196.210 with SMTP id u201mr8911175oif.40.1519860278085;
 Wed, 28 Feb 2018 15:24:38 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:47 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-31-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 30/35] remote-curl: store the protocol version the server
 responded with
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Store the protocol version the server responded with when performing
discovery.  This will be used in a future patch to either change the
'Git-Protocol' header sent in subsequent requests or to determine if a
client needs to fallback to using a different protocol version.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 remote-curl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 4086aa733..c54035843 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -171,6 +171,7 @@ struct discovery {
 	size_t len;
 	struct ref *refs;
 	struct oid_array shallow;
+	enum protocol_version version;
 	unsigned proto_git : 1;
 };
 static struct discovery *last_discovery;
@@ -184,7 +185,8 @@ static struct ref *parse_git_refs(struct discovery *heads, int for_push)
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_GENTLE_ON_EOF);
 
-	switch (discover_version(&reader)) {
+	heads->version = discover_version(&reader);
+	switch (heads->version) {
 	case protocol_v2:
 		die("support for protocol v2 not implemented yet");
 		break;
-- 
2.16.2.395.g2e18187dfd-goog

