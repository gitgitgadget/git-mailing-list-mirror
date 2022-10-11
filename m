Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F3FC433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 00:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiJKAe0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 20:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiJKAeV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 20:34:21 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4460A814DA
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:34:11 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id r142so5546629iod.11
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7rZiE8Oj3+fmwxWQeFr391ZkqbeY7mq0/KuPh7tsjHM=;
        b=iAvumZ9n88IEoyaWTPhU7Cdu1fRDxnLIMZ2n/g2JrapPMz7/rckDLVI240NDR5Cgcm
         7xlnZnW6ij9FWpvCbJ4XKowqNOYOwHmofvQcvBjukdLFEalsp4kG/rbubE/uGiW7Umok
         lzCFsL3X5j55LP103ljxOdYQ/mbaRoatgs9dKa1PwFFHSCOJCAFA+iIMePO5rPQszsFr
         m7lfX5t9Glv9a6d8H9gXanF0bqB4DTl/qLgSjp2a+HB4szpY7sUQOjHZnrCTw43nD02Y
         S9q3zMYMnxeJv+4ink7/KdXWuf8FA58sK2XElPSUOYwE36mjPI02F0tCux8aFP87JmQ+
         TXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rZiE8Oj3+fmwxWQeFr391ZkqbeY7mq0/KuPh7tsjHM=;
        b=k52KcVEQ03phF+b/p+u9/vurpG64I7q3Yg7SoXc/H4tX56eCYfgk2uBTnY0UTEURYE
         R7Q6egD3KkFuGqiwTbbsQLTxU2qu347R9n+6k4TMtcZ4prAF9y1vSoW0bBFCDiDhOoND
         2aIwYOEAW84BRgZghC1ZLHTeFLJ2r17IavAzPvGc4h2qjqWoj4kE6lM3caVYJtDM/Fiq
         loO36Ubp6S1KbJq81SYeANE0JzgxkQr3sGs5SNPjHwsA9N09XH05K6HQ22Ty8xHinE5n
         A5XtHUlFhTaFJa89IVuZpXRBRX4QBQ8xgkK0KoNZfwNKcpt4UI/QIQPyUTKUxEZR4URH
         3Wdg==
X-Gm-Message-State: ACrzQf3hCBQjlgUlJp2ktHmCntW+4pURGq+eZAaoe/iG6ZgysxEQ22Yo
        JrVXH3vRYQu/ERpjWQbrleziFNJNbjap4fmZ
X-Google-Smtp-Source: AMsMyM7Kp7h0GS22KwWVZOcJcqieL21KUi7ZQjjMz2/Baf74EmOkrdfUGQ6s2kWm0JWvQ5UZvtHC/Q==
X-Received: by 2002:a05:6602:168d:b0:6bc:36a0:254b with SMTP id s13-20020a056602168d00b006bc36a0254bmr3056016iow.80.1665448450330;
        Mon, 10 Oct 2022 17:34:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u11-20020a056e02080b00b002f68a98e1c2sm3012362ilm.50.2022.10.10.17.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 17:34:09 -0700 (PDT)
Date:   Mon, 10 Oct 2022 20:34:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jacob@initialcommit.io, peff@peff.net, gitster@pobox.com
Subject: [PATCH 3/7] shortlog: extract `--group` fragment for translation
Message-ID: <c3f50465cba4430b2014a76c5e473b906db50059.1665448437.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1665448437.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The subsequent commit will add another unhandled case in
`read_from_stdin()` which will want to use the same message as with
`--group=trailer`.

Extract the "--group=trailer" part from this message so the same
translation key can be used for both cases.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/shortlog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 53c379a51d..051c97bd5a 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -132,7 +132,7 @@ static void read_from_stdin(struct shortlog *log)
 		match = committer_match;
 		break;
 	case SHORTLOG_GROUP_TRAILER:
-		die(_("using --group=trailer with stdin is not supported"));
+		die(_("using %s with stdin is not supported"), "--group=trailer");
 	default:
 		BUG("unhandled shortlog group");
 	}
-- 
2.37.0.1.g1379af2e9d

