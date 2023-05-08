Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAE1C77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 17:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbjEHRiP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 13:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbjEHRiN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 13:38:13 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B0355A6
        for <git@vger.kernel.org>; Mon,  8 May 2023 10:38:08 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-55dc3431c64so21846177b3.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 10:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683567487; x=1686159487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8TeBF0xuH1LbzgnkZD6UEcZ92qemWE8+NWFPXmsKhjE=;
        b=Nv2HYmlbJ/nT0VncIr2IVV3lJ5tBqabIwlWcqz4IOvLENgL/5+TEc3q0DVy0vpi+1D
         dicLEnZFIrwEF7M7BLQz/Kue+riUpzU4cVxZYh6tsuprhSoIPEyCs2Hf64fTyoAQdpHJ
         Y8aWoZzXP1cymflO7WhUXOFB87M0L3yCJOBBmjYn/bQ/gI6rKAhu+GAliO0ETJ47+4+f
         rYdPfFaUqg9lqng4QRLSQSUpgK8qEc0lQtjTLqm64xAlseQwTljVj6Ezx8BSCows+iQP
         Mo6monwe+KVpQ7gABhB0SwQho8W/7aFnMxgXM2Vf6d8LuVNEDTC1+JFH2KhWOsnUiRqU
         ZCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683567487; x=1686159487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TeBF0xuH1LbzgnkZD6UEcZ92qemWE8+NWFPXmsKhjE=;
        b=KwSorqwIyW5M8FWb3ELcVXswa9/laTj/M3zviOomqsFqQ1jHWgLSpXc/5tSH5vWQa7
         NqwracP8mQww6m4dw35FmdZyYQH0l0eZWMbdAFHL9+dmI0jXFmTzdmrgOzunY+3IUcLu
         eoDNyRqUXZp+SXZNq5WYWxg124Eki7ohOcphq36ERi+BCLCqHKiw5cHtddhkrCBKtItb
         OZK4Bp0PELyheGvHxrowE/fONp0zKxioQyZ7Kh6t87BTBEYvMDfuiV3dDVfO9Gyi6I11
         CmkCmvgi/o36dAeAcOxvLj7OpHmeF2MHIyanNaVpPxCJrsTgbKHRnCbtvZzC4TBToLh6
         VG9g==
X-Gm-Message-State: AC+VfDygJdEzAJUxl6Vvav+UdS7XobTbtFepdrUnBI/OOTQpi7m1XB7x
        Lu8t9sqW2qBTvzIAXxPUWlPCY/DFr08PSXF9HI/JgQ==
X-Google-Smtp-Source: ACHHUZ7beMToWOIucctRFJiRC8sKvAxiqapxuUle+bMiWfyjss/yhcrCcGnab+hnHBpnIQSgDvJWaw==
X-Received: by 2002:a81:6383:0:b0:55d:f112:c35 with SMTP id x125-20020a816383000000b0055df1120c35mr4684620ywb.0.1683567487582;
        Mon, 08 May 2023 10:38:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a126-20020a0df184000000b0055d892357ddsm2663559ywf.57.2023.05.08.10.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 10:38:07 -0700 (PDT)
Date:   Mon, 8 May 2023 13:38:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/3] object: add object_array initializer helper function
Message-ID: <c31508ac4a5f335a6b923fdf84b20b4871298ee0.1683567065.git.me@ttaylorr.com>
References: <cover.1682380788.git.me@ttaylorr.com>
 <cover.1683567065.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1683567065.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The object_array API has an OBJECT_ARRAY_INIT macro, but lacks a
function to initialize an object_array at a given location in memory.

Introduce `object_array_init()` to implement such a function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 object.c | 6 ++++++
 object.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/object.c b/object.c
index 6d4ef1524d..f1adb458b6 100644
--- a/object.c
+++ b/object.c
@@ -356,6 +356,12 @@ void object_list_free(struct object_list **list)
  */
 static char object_array_slopbuf[1];
 
+void object_array_init(struct object_array *array)
+{
+	struct object_array blank = OBJECT_ARRAY_INIT;
+	memcpy(array, &blank, sizeof(*array));
+}
+
 void add_object_array_with_path(struct object *obj, const char *name,
 				struct object_array *array,
 				unsigned mode, const char *path)
diff --git a/object.h b/object.h
index 96e52e24fb..c335435f9c 100644
--- a/object.h
+++ b/object.h
@@ -57,6 +57,8 @@ struct object_array {
 
 #define OBJECT_ARRAY_INIT { 0 }
 
+void object_array_init(struct object_array *array);
+
 /*
  * object flag allocation:
  * revision.h:               0---------10         15             23------27
-- 
2.40.1.479.g8f2b93ade7

