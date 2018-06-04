Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AA1A1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 17:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751303AbeFDR3t (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 13:29:49 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44731 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbeFDR3s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 13:29:48 -0400
Received: by mail-pg0-f65.google.com with SMTP id p21-v6so14744762pgd.11
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 10:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tu3UNngncnKuZbJo2yjaOtEhAaceIK7aKe6c3HW9mQQ=;
        b=dn1XS63C093XKIeYneQgXLe797CLmjjSJh0lmMPZ6bch2UsMUwfdWfZzbZJ9+kjQ2v
         zVBOPvssk4B660qXgfIH5VgXSCvyNfVBsRQWSq9Wvov98fFepMPs83GTv6pH2Kh2tyhj
         gNl5uiH/mh0dgAuX2c1fupsox8yRPPfD6xJbQEvhP4gbAuWctutbjgDRWH31arHM1NIq
         iz1NDiQqPzXbr6njFTGKKdl7YxNfMT4W9+4gq+YAmAYpkjRPPd07wgd3cR/7aSTL7Udj
         8xqeTi2Ybc9+E3uWHd47PM7ZbNgiiIDbwYpjvtWbyoiT9mE0j8p7+0qMlw2qBwBQURLo
         2G8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tu3UNngncnKuZbJo2yjaOtEhAaceIK7aKe6c3HW9mQQ=;
        b=MF7sqlP9VDEo/He2RIz4tiOXuhW0ZI6sOFMTUKvGckxhuGTJbdnbINWzp59899fhSK
         Is4PGGnDkNHcdQlYPC0i6xiSvaXIdwCxRd3AvfTW5ZuJAwGjNcI9+9IKm2Sihs4e2cm4
         vS2GXk9H9M5rP7l+ciQYtn8nh6AtqFIA0kdOjyX0Ei7Bbmkm7CL84/fbHx1iBkCQSX/L
         RrTXi9ZxdyaVyyvYbpV0FP3hH6jexr5L5EJOlVD6SxmIn1vE44S8sG33hZWJ+uBpX2D9
         8me7Ao38HnDEZgjZ3aEhW+pYFAX6x3VESQv+/iFKDLqV8IOvK/3eoLhpbwiIdctg+quw
         1G5Q==
X-Gm-Message-State: ALKqPwcvE1ZjXFk8jnRwWPuzAqXpzlOmRU17reQeP+Veh//RYu0LJVq2
        bvtr59m5+ij49pQgjKftNkkA4vmdotU=
X-Google-Smtp-Source: ADUXVKJCDSrVnOYiEQR64F4Fhdn3hqZRLQX+zGdb9FwiRuc0GWvnUX85SHMQzl2dsy2oz5pJCWW1wQ==
X-Received: by 2002:a63:ac57:: with SMTP id z23-v6mr17397921pgn.394.1528133386888;
        Mon, 04 Jun 2018 10:29:46 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id x2-v6sm4491994pfn.11.2018.06.04.10.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jun 2018 10:29:45 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        bmwill@google.com
Subject: [PATCH 2/6] fetch-pack: truly stop negotiation upon ACK ready
Date:   Mon,  4 Jun 2018 10:29:32 -0700
Message-Id: <c79a6e6f96e2e453017669fabbed1a9fb4036cce.1527894919.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.768.g1526ddbba1.dirty
In-Reply-To: <cover.1527894919.git.jonathantanmy@google.com>
References: <cover.1527894919.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "ACK %s ready" is received, find_common() clears rev_list in an
attempt to stop further "have" lines from being sent [1]. This appears
to work, despite the invocation to mark_common() in the "while" loop.
Though it is possible for mark_common() to invoke rev_list_push() (thus
making rev_list non-empty once more), it is more likely that the commits
in rev_list that have un-SEEN parents are also unparsed, meaning that
mark_common() is not invoked on them.

To avoid all this uncertainty, it is better to explicitly end the loop
when "ACK %s ready" is received instead of clearing rev_list. Remove the
clearing of rev_list and write "if (got_ready) break;" instead.

The corresponding code for protocol v2 in process_acks() does not have
the same problem, because the invoker of process_acks()
(do_fetch_pack_v2()) proceeds immediately to processing the packfile
upon "ACK %s ready". The clearing of rev_list here is thus redundant,
and this patch also removes it.

[1] The rationale is further described in the originating commit
f2cba9299b ("fetch-pack: Finish negotation if remote replies "ACK %s
ready"", 2011-03-14).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 1358973a4..2d090f612 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -517,10 +517,8 @@ static int find_common(struct fetch_pack_args *args,
 					mark_common(commit, 0, 1);
 					retval = 0;
 					got_continue = 1;
-					if (ack == ACK_ready) {
-						clear_prio_queue(&rev_list);
+					if (ack == ACK_ready)
 						got_ready = 1;
-					}
 					break;
 					}
 				}
@@ -530,6 +528,8 @@ static int find_common(struct fetch_pack_args *args,
 				print_verbose(args, _("giving up"));
 				break; /* give up */
 			}
+			if (got_ready)
+				break;
 		}
 	}
 done:
@@ -1281,7 +1281,6 @@ static int process_acks(struct packet_reader *reader, struct oidset *common)
 		}
 
 		if (!strcmp(reader->line, "ready")) {
-			clear_prio_queue(&rev_list);
 			received_ready = 1;
 			continue;
 		}
-- 
2.17.0.768.g1526ddbba1.dirty

