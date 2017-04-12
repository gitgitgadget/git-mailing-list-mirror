Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 521601FA14
	for <e@80x24.org>; Wed, 12 Apr 2017 18:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752372AbdDLSGO (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 14:06:14 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35678 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752057AbdDLSGM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 14:06:12 -0400
Received: by mail-pf0-f176.google.com with SMTP id i5so17212892pfc.2
        for <git@vger.kernel.org>; Wed, 12 Apr 2017 11:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BByupqDuvCDn1W+oDieBl9c1RHXt9X2JbnW9/Y/stuw=;
        b=My9FByzC19vNCgMbs3ys+uCMaGnRS9El1tPztshCVYU20EGaQpSkU4hLC9mwy9fXXL
         /bi2httYHrRuu8bVJqjksGkbCs0Az3MTGruTFhP1wBwv/b+y0JNMAOP9baKP6UxbS5nJ
         ZuUxZqcTzDp6iccW0Ap9FWHtQgB2Z9Op6FOx5ARPRHMC8tZfnED+6A12zeaxTzadLdH9
         V8G+siLuKpLiWom+Yel0kkYhugUQuOZAqlLB8uSgBHfCLmJfDHd/0ZTwQkZJOTF0WGVN
         +31OHTGH9/zdwgTQyW0IJm4747wbV95Zp8hrHR9AsE2/vlabZqwR1808D5OcboYLm2Fu
         aOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BByupqDuvCDn1W+oDieBl9c1RHXt9X2JbnW9/Y/stuw=;
        b=b1oUqVJqGlHIWGxY78bkwHDNRbzCC2kvAUVoe93CifRfAacc3bcEanPU3OSxDkZ5zy
         7NIiyQF323ML55bZKMCdYL0bpV7eIEiuYOFBBScV2F5S8nBLO65CyrwfI1jARFBcnQnF
         aPr2iTcuvnGCCukkzDv12u/vQ+y7sjyWyoQlCr2xC2pHC1WuVWy7AmXOMR3Rpw5/V+Oi
         kwsVOtn0wFNapptUO2yFAlIQ9iVZRpBbsaEFm9+gG56SlNigiw0pcWHse6XEnFarZscC
         EIZrC3lF16ys9RAX7ZHzwUFSIuVbKz/HolKpK9r9jM97ykjF79gfxJo/RFnMsT1EVkZr
         N1ng==
X-Gm-Message-State: AN3rC/4Zb3eKmJOWhFIdTk1ZaTLGHakZrwx3DQMMwmEtxOzRjq7PveEeVPjdS3ijefAZC7L7
X-Received: by 10.98.252.72 with SMTP id e69mr26084514pfh.247.1492020372135;
        Wed, 12 Apr 2017 11:06:12 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id k2sm37914382pga.47.2017.04.12.11.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Apr 2017 11:06:10 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com
Subject: [PATCH v2] fetch-pack: show clearer error message upon ERR
Date:   Wed, 12 Apr 2017 11:06:02 -0700
Message-Id: <20170412180602.12713-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.12.2.715.g7642488e1d-goog
In-Reply-To: <20170410210511.8505-1-jonathantanmy@google.com>
References: <20170410210511.8505-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, fetch-pack prints a confusing error message ("expected
ACK/NAK") when the server it's communicating with sends a pkt-line
starting with "ERR".  Replace it with a less confusing error message.

Also update the documentation describing the fetch-pack/upload-pack
protocol (pack-protocol.txt) to indicate that "ERR" can be sent in the
place of "ACK" or "NAK". In practice, this has been done for quite some
time by other Git implementations (e.g. JGit sends "want $id not valid")
and by Git itself (since commit bdb31ea: "upload-pack: report "not our
ref" to client", 2017-02-23) whenever a "want" line references an object
that it does not have. (This is uncommon, but can happen if a repository
is garbage-collected during a negotiation.)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---

Changes from v1:
 - used jrneider's suggested change to error message
 - added documentation about "ERR" in protocol
 - updated commit message to explain documentation change

 Documentation/technical/pack-protocol.txt | 7 ++++++-
 fetch-pack.c                              | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index c59ac9936..5b0ba3ef2 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -351,14 +351,19 @@ ACK after 'done' if there is at least one common base and multi_ack or
 multi_ack_detailed is enabled. The server always sends NAK after 'done'
 if there is no common base found.
 
+Instead of 'ACK' or 'NAK', the server may send an error message (for
+example, if it does not recognize an object in a 'want' line received
+from the client).
+
 Then the server will start sending its packfile data.
 
 ----
-  server-response = *ack_multi ack / nak
+  server-response = *ack_multi ack / nak / error-line
   ack_multi       = PKT-LINE("ACK" SP obj-id ack_status)
   ack_status      = "continue" / "common" / "ready"
   ack             = PKT-LINE("ACK" SP obj-id)
   nak             = PKT-LINE("NAK")
+  error-line     =  PKT-LINE("ERR" SP explanation-text)
 ----
 
 A simple clone may look like this (with no 'have' lines):
diff --git a/fetch-pack.c b/fetch-pack.c
index d07d85ce3..4bed270c5 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -276,6 +276,8 @@ static enum ack_type get_ack(int fd, unsigned char *result_sha1)
 			return ACK;
 		}
 	}
+	if (skip_prefix(line, "ERR ", &arg))
+		die(_("remote error: %s"), arg);
 	die(_("git fetch-pack: expected ACK/NAK, got '%s'"), line);
 }
 
-- 
2.12.2.715.g7642488e1d-goog

