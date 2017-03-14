Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF29D20951
	for <e@80x24.org>; Tue, 14 Mar 2017 22:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750982AbdCNWOt (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 18:14:49 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33351 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbdCNWOs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 18:14:48 -0400
Received: by mail-pg0-f46.google.com with SMTP id n190so7876661pga.0
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 15:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bbxUhN8a5xteP9l85CwfISUObGyQ/14DE/+FZ5HyQS4=;
        b=M7jyN3/Xf0ZK1IhitVwHNJo/NouObSKYS6+d2ljh43N3L8KrX2WRPTvsfAqmSHWR2v
         pMfbk4Wzc5Hi5Vu+01eI0p0WdPr0SwYy/KZHm+wkUGKrlZ4HY2hyZ0wyG2BoBkMAB5hA
         DPlGok9RoHAnx0ngg6CtGl63GuY4C0INmYa4euxYXd8whRUNThRgqkV3gUUdDPGK/mAR
         x972cDt2OlCUOhTUrRgqjAUttw1EyGA3Gr9Wb8vh6FF4ghJDeEv+ZkH5OfZSPlpB9VrT
         xvNLupYWnxlhDic254H8PF0X3yuFKAn3m06IBc/0Bu8VygLK9ZDhYQlH3VHanH8XY3+Q
         YeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bbxUhN8a5xteP9l85CwfISUObGyQ/14DE/+FZ5HyQS4=;
        b=EjdRxMDe53xElmkvtKosaN7Vsjl0DIRFNb854c8Y/cFo0TbO0j+SDbjhgo/XoCY2dr
         Hh1K76FY4IVzgzQ85eMZqEirXT7+Rxm5lqpSkoRUPMSVgZvzUn768I3Qz6QdX869iHtA
         DLQMm+LWS4vRCvsO5aUl8tAbmHsNWf8HuCBayrj1V6PEZjRtv5ipX19VTLIcSysEq+QL
         jda/ft/HZ8B+lj3V+vog6KORZkiUCDmn42Mxp3LMTlkFCZlVb/SW6M/rgaVKYBW1F2iX
         qFUdobpFyZylYpxBcni6s6hMXGhILkbdzvtTHaUWxZ/UA+zgLwY15g7eGDRziHvwaSL/
         lS7A==
X-Gm-Message-State: AFeK/H1TZyNY/ZlvwDB1HBYU/o3NVBd2RAjIN6e9nArZTHFSC7hwVu4etaU12vSozpWuwwFM
X-Received: by 10.84.175.67 with SMTP id s61mr2641559plb.126.1489529687467;
        Tue, 14 Mar 2017 15:14:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:8559:2c0d:dab3:f802])
        by smtp.gmail.com with ESMTPSA id g29sm40405290pfg.37.2017.03.14.15.14.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 15:14:46 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule-config: correct error reporting for invalid ignore value
Date:   Tue, 14 Mar 2017 15:14:40 -0700
Message-Id: <20170314221440.18259-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.264.gd6db3f2165.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As 'var' contains the whole value we get error messages that repeat
the section and key currently:

warning: Invalid parameter 'true' for config option 'submodule.submodule.plugins/hooks.ignore.ignore'

Fix this by only giving the section name in the warning.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/submodule-config.c b/submodule-config.c
index 93453909cf..bb069bc097 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -333,7 +333,7 @@ static int parse_config(const char *var, const char *value, void *data)
 			 strcmp(value, "all") &&
 			 strcmp(value, "none"))
 			warning("Invalid parameter '%s' for config option "
-					"'submodule.%s.ignore'", value, var);
+					"'submodule.%s.ignore'", value, name.buf);
 		else {
 			free((void *) submodule->ignore);
 			submodule->ignore = xstrdup(value);
-- 
2.12.0.264.gd6db3f2165.dirty

