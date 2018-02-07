Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E44121FAE2
	for <e@80x24.org>; Wed,  7 Feb 2018 01:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932241AbeBGBOG (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 20:14:06 -0500
Received: from mail-oi0-f74.google.com ([209.85.218.74]:37939 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932229AbeBGBOA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 20:14:00 -0500
Received: by mail-oi0-f74.google.com with SMTP id c5so1882500oic.5
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 17:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=ZBcseXfLf/LWiklmecEFnCScOiRMDqmUfsSyKBpHnEI=;
        b=s/LyvzmkqAwq8eVjBbX4eE/naFAyBOD00sJJzDbXlUYdpz5CFF32GD1UtAq8dqkQaj
         nAzPCDmNOKula6RWsOu4OrSmlGGHOHskgDSPYeTTuzKCsQmst2ZnTTmRjYzMWfonWueE
         /BQnzkGPugQl48sdwj8m3VS1j2kP6ENvlvCR5kIsijjM4ZCETYkt64Nz1t53q3ze6TIS
         rCDNRdv+ANfJYBoTMjW7Deuz5vs9kBR+K/PVMU1eyJAioaOVFm7kxaNqo+JwCwnqTBqu
         3s9/3YfkwbjN8x0BdYg7tQUb2ij6sLSQqavpfGUpr8DRLcOWrUDt13GKZYbQ3nkX4t+W
         yhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=ZBcseXfLf/LWiklmecEFnCScOiRMDqmUfsSyKBpHnEI=;
        b=SKq3J/RksYJdDW5k979Tm+hranJDyvzcDkPL3QBTLgRcvrXUP41BN3W2big6D1mhjN
         ErECmpFLX4D98tS7qOI2fVQ5Sod5SAUXYC+PTTb9aF6MgHCPn55i9lT+wBqTC9HUk+Xb
         j+w9kPhDYCxc9vFYFQsOssrjMZiF1MfrWwWAm3CN2chY5fV6lPlWnApFmq5csx0Y4HIh
         m5KbyRByuaPU3KhAS6DDqW02NkrdWu/wxrm/Gw7tu2gLALB0bJSZrjAeWG/hYEnXhzq/
         L2y7xG1NwK2k1tJTRitj1yNDhfY5Mo3AO6l+Nz4HaXki3EJfRm8KCxzHqKSJr3dKOq1p
         kasg==
X-Gm-Message-State: APf1xPAI3YE1ONNvC/rZu4zG2DGXTbmhH4p7WLQyEwAIoDziO2Yc2tyO
        hDHfZmb5irex1DGFojfQS2IV5EWJva6AqwkZHDW8YZiGl5pA5EMngfPz/mVNX15vBFwaSAJcN5H
        gA2wcp4C97p4qccUUU2nGvTcZX/wDVPBn1eVhguoMSTYGev0KwpD8ZqoceA==
X-Google-Smtp-Source: AH8x227T+9z04UEwWBTG/os56UmDt5gkxaxQbkBJhPiOcMc48+KMP3nI6n4JzQ3bIJG3vBlXtecTcXp/V7w=
MIME-Version: 1.0
X-Received: by 10.157.83.202 with SMTP id i10mr2301868oth.50.1517966039513;
 Tue, 06 Feb 2018 17:13:59 -0800 (PST)
Date:   Tue,  6 Feb 2018 17:12:56 -0800
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Message-Id: <20180207011312.189834-20-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v3 19/35] push: pass ref patterns when pushing
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Construct a list of ref patterns to be passed to 'get_refs_list()' from
the refspec to be used during the push.  This list of ref patterns will
be used to allow the server to filter the ref advertisement when
communicating using protocol v2.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 transport.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/transport.c b/transport.c
index dfc603b36..6ea3905e3 100644
--- a/transport.c
+++ b/transport.c
@@ -1026,11 +1026,26 @@ int transport_push(struct transport *transport,
 		int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
 		int pretend = flags & TRANSPORT_PUSH_DRY_RUN;
 		int push_ret, ret, err;
+		struct refspec *tmp_rs;
+		struct argv_array ref_patterns = ARGV_ARRAY_INIT;
+		int i;
 
 		if (check_push_refs(local_refs, refspec_nr, refspec) < 0)
 			return -1;
 
-		remote_refs = transport->vtable->get_refs_list(transport, 1, NULL);
+		tmp_rs = parse_push_refspec(refspec_nr, refspec);
+		for (i = 0; i < refspec_nr; i++) {
+			if (tmp_rs[i].dst)
+				argv_array_push(&ref_patterns, tmp_rs[i].dst);
+			else if (tmp_rs[i].src && !tmp_rs[i].exact_sha1)
+				argv_array_push(&ref_patterns, tmp_rs[i].src);
+		}
+
+		remote_refs = transport->vtable->get_refs_list(transport, 1,
+							       &ref_patterns);
+
+		argv_array_clear(&ref_patterns);
+		free_refspec(refspec_nr, tmp_rs);
 
 		if (flags & TRANSPORT_PUSH_ALL)
 			match_flags |= MATCH_REFS_ALL;
-- 
2.16.0.rc1.238.g530d649a79-goog

