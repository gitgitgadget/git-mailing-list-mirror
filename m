Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5154BC433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiCUXK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbiCUXJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:09:26 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C974704D
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:53 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id b19so22634186wrh.11
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZmbdCKhUgG79oncaeepOLFW8cJAWGh4RtIWAJYt7I/M=;
        b=ElmGyJkfBoezCSXBGrmeaK3u/JYpSVbJTJrwGHimIZRmlopRe6ldt/mHvoytACQ1nL
         G+On3hEUsj6ZWgA/oswBdRDMdLvumgyJ0qnQvFFc1i3qwCesLKJEC57nmItcyGaevwVX
         aqMManInD8iTQ14o+NOhrFAgpqeiq/KsRqoh81WHGTXIktdGX2NOApTGxQDZ1JHQpj4P
         VsuUgxRWkboW4qb78S+mJz9h9RU/xpixiEeN0rG2lowOQg2Mam77yxq07J9y7YI3X9G9
         RX3drSev2Uk2f6OPqiptSSQ/WoKfyLK561Z0W8TwOXsxRBRnV5GxdGaMvFBTFY+Nrr9l
         m5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZmbdCKhUgG79oncaeepOLFW8cJAWGh4RtIWAJYt7I/M=;
        b=lba4HRxMmCdyuzPkvooCNW3uYZWv7UfL/kJVOihnHwxdxpZhu26RlSDNs/BqmfqUOP
         UPTMgI508sZMABNBgyTnBGQ7l/0Ttz3awpfjf/FvZwPK9yzdI9sGfiD0RwIVjEwmaJ6j
         BBQI6i6a8/0ZEXEvyuyR4r2c05TpH92T5/0Z3tBx1ifTe/WDNEPnx3f7StsD+a74iq9N
         QGp5RXFjAxlcDBeDpmg0jcdQKFMtZ7XeV+LIr53V2LB5m/3M/CSEf9qrfpa9Ufedq+jY
         CZ61oKL2v5WZWNTP+fNdUo4KxAnYab1G6N+v1+lD4c+pnIkYcyUVjJ0lPC6Jg3G0EQRB
         ST1w==
X-Gm-Message-State: AOAM530Vrgxkp4dRh2PKNpMCw7he10za5f7h5lyjQgZgGpzyYFaIGKgz
        igmtI8VjoJCFcfYuZM6WCsN97H3nT/k=
X-Google-Smtp-Source: ABdhPJwFKUqbBhIag2pLhK9B1xP6p/WAvn3RetZYv2bZ2fm2FhkcFkSs87IAP4pA0fwcPJklUjWLRg==
X-Received: by 2002:a05:6000:156e:b0:203:d6e6:bcd0 with SMTP id 14-20020a056000156e00b00203d6e6bcd0mr19478950wrz.135.1647903371679;
        Mon, 21 Mar 2022 15:56:11 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:56:11 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 32/41] remote-curl.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:55:14 +0000
Message-Id: <20220321225523.724509-33-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321225523.724509-1-gitter.spiros@gmail.com>
References: <20220321225523.724509-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C standard specifies two constants, EXIT_SUCCESS and  EXIT_FAILURE, that may
be  passed  to exit() to indicate successful or unsuccessful termination,
respectively. The value of status in exit(status) may be EXIT_SUCCESS,
EXIT_FAILURE, or any other value, though only the least significant 8 bits (that
is, status & 0377) shall be available to a waiting parent proces. So exit(-1)
return 255.

Use the C standard EXIT_SUCCESS and EXIT_FAILURE to indicate the program exit
status instead of "0" or "1", respectively. In <stdlib.h> EXIT_FAILURE has the
value "1": use EXIT_FAILURE even if the program uses exit(-1), ie 255, for
consistency.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 remote-curl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index ff44f41011..da61168c6f 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1063,7 +1063,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
 	client.git_cmd = 1;
 	strvec_pushv(&client.args, client_argv);
 	if (start_command(&client))
-		exit(1);
+		exit(EXIT_FAILURE);
 	write_or_die(client.in, preamble->buf, preamble->len);
 	if (heads)
 		write_or_die(client.in, heads->buf, heads->len);
-- 
2.35.1

