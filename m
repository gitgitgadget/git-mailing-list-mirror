Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D43741F597
	for <e@80x24.org>; Tue, 17 Jul 2018 06:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeGQHY2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 03:24:28 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34010 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbeGQHY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 03:24:28 -0400
Received: by mail-pf0-f195.google.com with SMTP id k19-v6so32908pfi.1
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 23:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X7LPzdsZAXMNCGbFNvVTRfHWWXt5BjSCSds4rk074/o=;
        b=m7FupdhwUE0FCR9wEwhFBidz68e7Ja0e5hC6ZkanzsAOnLgkklchhhmn3fg754pDs1
         cR9Ta7JTbcuCjH2BdR6K5dqRrxsB6TNTO5PPxRt8uCpY8kkkKur6cohmkUXTuHQtx2qV
         0qtwbFJN87UniBXfK+HjYCIdD8VCzExkgxFwnxdDtB3MP0HEEXESY9K1MtO2xR4IYK8o
         ZzWjjCWBxvrbzJ65dFSFtF7qKCTyCHzKaJUf6e4RALA5TkfyElWJs1Bc3UqCv2KuS+9Q
         v+PUJfsDSmHOXRO6ZMQPXUEISMgFu/jQDeqoFwVlAld8V13EA4ubBuFrM4JWb6cFSvUc
         0UQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X7LPzdsZAXMNCGbFNvVTRfHWWXt5BjSCSds4rk074/o=;
        b=r91fC3eI4QKaN38sL/J9PH4noGv467fBj1BAUSzGflbV02+xMzDsNJhERYf0q/jKGD
         xFWwdWEVK64RRGB6svxN8mRlWo//FianpVEe0O9LJEg6tD0TtRWli4F5WUoLshRMDHFE
         g2oJ38VLjI7bktZ/3mqO0ESbpO6pocQhFc/mJlXdwDdploPS71cz/0EoLbLXgk03aQh8
         IadSPxQ5M8WHwG5rd85I2wpdvcs3T7pKunvQd31iUTmD0Tdln+dMZrbQAFpWokeg3uQ4
         IS12D+6iyKKMUGe00G480vxC3UQp9p7p0pgiQMmTlI9Q2BU9v0Cy1RBlNXvhxj70WdUs
         pxsg==
X-Gm-Message-State: AOUpUlHQ3ETuxsdfKrTWpMn6v08lENAR5ToYBJRFlt5lKGJr5e0z07ol
        rnbNTnOhnDk96y2aPA1HQwU=
X-Google-Smtp-Source: AAOMgpdm0aKQ/fgIu0/6h0XFnpCTc2OEMSmaox4ZbEOGy9zYqqGOTHJiY3wtxqQmXsEK0wx6pBcDHw==
X-Received: by 2002:a62:3c4f:: with SMTP id j76-v6mr420053pfa.119.1531810403222;
        Mon, 16 Jul 2018 23:53:23 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id f5-v6sm489668pga.58.2018.07.16.23.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 23:53:22 -0700 (PDT)
Date:   Mon, 16 Jul 2018 23:53:21 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 1/3] gc: improve handling of errors reading gc.log
Message-ID: <20180717065321.GB177907@aiede.svl.corp.google.com>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180717065151.GA177907@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717065151.GA177907@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A collection of minor error handling fixes:

- use an error message in lower case, following the usual style
- quote filenames in error messages to make them easier to read and to
  decrease translation load by matching other 'stat' error messages
- check for and report errors from 'read', too
- avoid being confused by a gc.log larger than INT_MAX bytes

Noticed by code inspection.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Split out from
https://public-inbox.org/git/20180716225639.GK11513@aiede.svl.corp.google.com/.

 builtin/gc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index ccfb1ceaeb..d69fc4c0b0 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -442,6 +442,7 @@ static int report_last_gc_error(void)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int ret = 0;
+	ssize_t len;
 	struct stat st;
 	char *gc_log_path = git_pathdup("gc.log");
 
@@ -449,15 +450,17 @@ static int report_last_gc_error(void)
 		if (errno == ENOENT)
 			goto done;
 
-		ret = error_errno(_("Can't stat %s"), gc_log_path);
+		ret = error_errno(_("cannot stat '%s'"), gc_log_path);
 		goto done;
 	}
 
 	if (st.st_mtime < gc_log_expire_time)
 		goto done;
 
-	ret = strbuf_read_file(&sb, gc_log_path, 0);
-	if (ret > 0)
+	len = strbuf_read_file(&sb, gc_log_path, 0);
+	if (len < 0)
+		ret = error_errno(_("cannot read '%s'"), gc_log_path);
+	else if (len > 0)
 		ret = error(_("The last gc run reported the following. "
 			       "Please correct the root cause\n"
 			       "and remove %s.\n"
-- 
2.18.0.233.g985f88cf7e

