Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978A7C433FE
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D64261247
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238644AbhI1CU6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 22:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238567AbhI1CUs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 22:20:48 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E78C061604
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:09 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c73-20020a1c9a4c000000b0030d040bb895so1493406wme.2
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b88RcZqYlYMpUuXMPMIWwB3G8ZEG8s3VzD/ra7YFT/o=;
        b=YzK9xEoXxHTzMGb9TcSVwFh92xm9nCU+5ZVKQOmoWmWL7DdubeagifjP3DV/D780gG
         5VTpG35Rv3OQuwGmuc8Pc93sJ0P+3XXb0/JzoeZRIkmeaq1RFhZL71F+Nr9iH+Cl6jSM
         4mQGSQa1s5xgX9CgV6krjnH/CzHyclv1MAJsMMWuT6nNiQBpLfn6NKL1QN1dhRZSRNqD
         t/yU+f49h6bMq8urPIwZpJWgcZufuw0eaLMZqoEefAaXtpuE5MyU7T97RHWDR5B82bN8
         KFCqF1UzH+hUqp0jawtSR1dTtLYQO+TAekUdklLnvmK0L6ywlNLO0Om++7uHFAD/qcoz
         q+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b88RcZqYlYMpUuXMPMIWwB3G8ZEG8s3VzD/ra7YFT/o=;
        b=bK4lP7UpGMo7dvKO//3KdhYbxf2sIlwIgdtI7VrvaK7WD+osEc7JDjqL7Ucwv4PMCS
         nQHdspunRJv+1o4Ua1fRqvIMbZ0Mph6dKoQxhpzGaIyrB8PjrHpHTTRGgRTXtW2CtrFf
         3VhP/1KVxGkplcDWvvBN06+NYn5COIkWYmBiode1QsJq2B4xxMZnBRdk91vdRcpb2mwM
         rjrp3HNe0gb0r5qfAobvEIKAnxeni0VlvmQSsVsOx3T12FzLSFGp2tRk6dUGjhwLAZzz
         dVXsDomenuH1Rs3rUEB7XN8x0xifCSnqvZHO2Sj5Hqp8HxDNEhOUlPhikCJZkyVGGmtD
         fc/g==
X-Gm-Message-State: AOAM533mZhqk1TIuC1SGMb2HPm01MOagBWdlfNj/wWn0YqutI50xxS7D
        aGKZ1syeTMw7DHoB50QWciCpRqJ0MYoPzA==
X-Google-Smtp-Source: ABdhPJzWTKI0ZVXv5EhtS10S8pEr3nwDol7njopZFeHYNzO2gcIaTvEHFs9C8ciMl1/TxCbi173cNg==
X-Received: by 2002:a1c:7e53:: with SMTP id z80mr2203759wmc.152.1632795547824;
        Mon, 27 Sep 2021 19:19:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c132sm1126987wma.22.2021.09.27.19.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 19:19:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 10/17] object-file.c: return -1, not "status" from unpack_loose_header()
Date:   Tue, 28 Sep 2021 04:18:51 +0200
Message-Id: <patch-v8-10.17-b96828f3d5b-20210928T021616Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1327.g9926af6cb02
In-Reply-To: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
References: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com> <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Return a -1 when git_inflate() fails instead of whatever Z_* status
we'd get from zlib.c. This makes no difference to any error we report,
but makes it more obvious that we don't care about the specific zlib
error codes here.

See d21f8426907 (unpack_sha1_header(): detect malformed object header,
2016-09-25) for the commit that added the "return status" code. As far
as I can tell there was never a real reason (e.g. different reporting)
for carrying down the "status" as opposed to "-1".

At the time that d21f8426907 was written there was a corresponding
"ret < Z_OK" check right after the unpack_sha1_header() call (the
"unpack_sha1_header()" function was later rename to our current
"unpack_loose_header()").

However, that check was removed in c84a1f3ed4d (sha1_file: refactor
read_object, 2017-06-21) without changing the corresponding return
code.

So let's do the minor cleanup of also changing this function to return
a -1.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 766ba88b851..8475b128944 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1284,7 +1284,7 @@ int unpack_loose_header(git_zstream *stream,
 					       buffer, bufsiz);
 
 	if (status < Z_OK)
-		return status;
+		return -1;
 
 	/* Make sure we have the terminating NUL */
 	if (!memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
-- 
2.33.0.1327.g9926af6cb02

