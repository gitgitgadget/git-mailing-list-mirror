Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 584291F403
	for <e@80x24.org>; Thu, 14 Jun 2018 22:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965088AbeFNWyl (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 18:54:41 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:36138 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964987AbeFNWyj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 18:54:39 -0400
Received: by mail-yb0-f202.google.com with SMTP id r2-v6so5660002ybg.3
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 15:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Wa4brdC2T6qPI+ilB5MxnWd6sY3qhFT66EkXLA+UGV8=;
        b=i3vkJz7Km/gsakxq9UVMkPkxn6VhUXigxmsGwveLQILNOaf+KrPpiZc4LuRQLgLwA3
         LjLL27MhiYsmca1xPpsYQ87bMoa4yqhRqSvuoKleniPtgzekTHetFI7lX6AjaRIVXO/G
         9AVAJzoseDAS5mXb9qVEyp3KnTHw8ppQDLCPdKuIw7fl4F687spQd7DD+c3T1ZacTrqb
         iraJ3dOb5K0x3xaU8QCz5g8miJQV1ka2QRpDw1KFezaWjkInbCediSyPepm09i7YJ5Ow
         turuOYlb8bpiXeGw7544srYk4X2QGTNlB4rR4PFxoj0hGSNRJmri6bYiGI814hfNRpnw
         b4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Wa4brdC2T6qPI+ilB5MxnWd6sY3qhFT66EkXLA+UGV8=;
        b=B942RnRJ+Y6wM7oJj6WiUjF8bVa/y320wK/b6tkpjWJw/S9An6Q2Mgvo+599bFEGH9
         R9Zbis1gSaQkAoxAOK8NPR4C23q+CeLWbfuwXre8jADx7xj9Nnw6OG+fSm/1Xr75f70U
         N/2fA0NiQFZmY8waK6dttwdalpnLW5dO3YNHhXfT+AjFy/PDZ/M6e026xjBPKOGVmhTH
         ob9ZpCY0mEIABvACj6N40A/gHERbSE/YCMm8KpnCwtItXicJZsOKF7XrcOLzBA40xfI9
         Ft/K+t0/nbsYbPnPAi2iNgFcrXvSUOSEHWrYpLOai5IoMMb3r3q2e5W6VMAvMVKIYRgC
         ugAQ==
X-Gm-Message-State: APt69E3GlixwKYql4GWLXHFcoTaA1u9j9ntNRrNtAoXWl5iAfGLb0NCl
        LZHyX7cgs4Hi746MlZ1bZmdfq4q/OdiUVnA7A78r3qFoU87dCysZhO9DeKWMJa3iW3KfnzhXj6K
        DMsrdUGUG/XlPoZK+P8wpdFyBV5/d8CCAWT5fhTWnnQZzp0LTs6bTeAd6ojomvWTi7tL5/SzNup
        5p
X-Google-Smtp-Source: ADUXVKIpKNAqR+JoAF9cvLOLf6+8t1EEXYuud6n0sJj25x8HUgVg88+Nx9biRvkjiuVYuwkMj8brhS/z3kniER+aRYMD
MIME-Version: 1.0
X-Received: by 2002:a81:b3c3:: with SMTP id r186-v6mr1272342ywh.63.1529016879175;
 Thu, 14 Jun 2018 15:54:39 -0700 (PDT)
Date:   Thu, 14 Jun 2018 15:54:24 -0700
In-Reply-To: <cover.1529016350.git.jonathantanmy@google.com>
Message-Id: <fdcd88ba460d1feddb40037ff5b935339a51368b.1529016350.git.jonathantanmy@google.com>
References: <cover.1527894919.git.jonathantanmy@google.com> <cover.1529016350.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c4
Subject: [PATCH v3 3/7] fetch-pack: directly end negotiation if ACK ready
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     bmwill@google.com, gitster@pobox.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "ACK %s ready" is received, find_common() clears rev_list in an
attempt to stop further "have" lines from being sent [1]. It is much
more readable to explicitly break from the loop instead.

So explicitly break from the loop, and make the clearing of the rev_list
happen unconditionally.

[1] The rationale is further described in the originating commit
f2cba9299b ("fetch-pack: Finish negotation if remote replies "ACK %s
ready"", 2011-03-14).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 2812499a5..60adfc073 100644
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
@@ -1096,6 +1096,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		die(_("git fetch-pack: fetch failed."));
 
  all_done:
+	clear_prio_queue(&rev_list);
 	return ref;
 }
 
@@ -1300,7 +1301,6 @@ static int process_acks(struct packet_reader *reader, struct oidset *common)
 		}
 
 		if (!strcmp(reader->line, "ready")) {
-			clear_prio_queue(&rev_list);
 			received_ready = 1;
 			continue;
 		}
@@ -1441,6 +1441,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		}
 	}
 
+	clear_prio_queue(&rev_list);
 	oidset_clear(&common);
 	return ref;
 }
-- 
2.17.0.582.gccdcbd54c4

