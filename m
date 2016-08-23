Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11F8F1FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 21:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752456AbcHWVqC (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 17:46:02 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34424 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752306AbcHWVqB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 17:46:01 -0400
Received: by mail-pa0-f41.google.com with SMTP id fi15so51780524pac.1
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 14:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=hKLlh/C7wSRUnKK841KqKWRl5lz6P9g6BrpBTDI/eFI=;
        b=m2L7cnFWTcxK8Pn6XyPl3G1LBwbLATzgInGGWpIY3FzdAzkEmcSEhEgGRySn3MG8zk
         nQEpSVx7ud3guwD6s3/AuoKudFCNeq59xhn1iFMj0MA8BhBcvRLlTZk76p3aKvsnypSe
         /7GGjmNXIANmTuPWlthDsXmDHTr2medqVCxDUNObliyepvh3E0myIpUWTyIeKsVIQUWb
         beFtWwFUCSua7vtm5CZ6T1Vqyvhp3y360uhiZLFl8TBwKVhxxH2VloQgbjZ1bm70qi7e
         synSgIePEQWwF22fuNrqqbIVmAgMRoy10jGHUZSqbOJ3pQztb+XfOLiaxNZy+KiK1abw
         acag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hKLlh/C7wSRUnKK841KqKWRl5lz6P9g6BrpBTDI/eFI=;
        b=EdxrI0GUC8EogktdE6tIkhA+FoIOJeT+jLIZjpe4iaygE+2inrAwWQpdYUr7tkpvG2
         qmI7TlFXLKITbxJlSIeVmmkRY+gXJOrIdtq0HAr9kU7HkB/fcSfx55A6MS+iM1hog2zf
         q0zPqNLy4YB3u4m09FWwf09JD3mH3FD4UIwqNVVczLL+aT+TblRCa4FbRPCHM8vNk7et
         7RtymHgJ/Myz38mXTcGRUIqKcEVLHs9AxCgEcgnI3OHKSoxePX7cyaIQAtKZvx/3ITFH
         teKAhd4uGnIRH1fVFYnGzX8vZwjV/J9/DImUfYpeWEgEI+TOwzrRf5H72zIAiWPVCxbM
         b3pA==
X-Gm-Message-State: AEkoouvaLSK6D4lS3me5vwzH+XF4SLOwMdKYf0QeHf3uaCF8HXARNfXfTA3uc5qFMQY3zTzK
X-Received: by 10.66.20.41 with SMTP id k9mr43610771pae.142.1471988416535;
        Tue, 23 Aug 2016 14:40:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3048:6c56:97d1:a6eb])
        by smtp.gmail.com with ESMTPSA id b64sm7979723pfa.82.2016.08.23.14.40.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 Aug 2016 14:40:15 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, hvoigt@hvoigt.net,
        leandro.lucarella@sociomantic.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] transport: report missing submodule pushes consistently on stderr
Date:   Tue, 23 Aug 2016 14:40:08 -0700
Message-Id: <20160823214008.32331-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.0.rc1.1.g1ceb01a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The surrounding advice is printed to stderr, but the list of submodules
is not. Make the report consistent by reporting everything to stderr.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

  This fixes one of the bugs mentioned in
  https://public-inbox.org/git/CAGZ79kbkyupBJfvyX3Hj_R5ZW36+3ufOnnLC-Dpic40nPJAxDA@mail.gmail.com/T/#t
  
  How to fix the other was not as obvious to me as I do not understand the
  philosophy on verbosity in the transport code.
  
  Thanks,
  Stefan

 transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport.c b/transport.c
index cf8de6e..94d6dc3 100644
--- a/transport.c
+++ b/transport.c
@@ -771,7 +771,7 @@ static void die_with_unpushed_submodules(struct string_list *needs_pushing)
 	fprintf(stderr, _("The following submodule paths contain changes that can\n"
 			"not be found on any remote:\n"));
 	for (i = 0; i < needs_pushing->nr; i++)
-		printf("  %s\n", needs_pushing->items[i].string);
+		fprintf(stderr, "  %s\n", needs_pushing->items[i].string);
 	fprintf(stderr, _("\nPlease try\n\n"
 			  "	git push --recurse-submodules=on-demand\n\n"
 			  "or cd to the path and use\n\n"
-- 
2.10.0.rc1.1.g1ceb01a

