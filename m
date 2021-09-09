Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3730C433FE
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3E096108B
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349555AbhIIXZn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 19:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhIIXZl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 19:25:41 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A48C061575
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 16:24:31 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id q14so100912ils.5
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 16:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jVjmHPs9Vzn+FL0BItXKX43L71zgap2RPxsgO9/F3J4=;
        b=CaJ6lF9+siHmTQlNvqRfONnAZIOHvgwK2Glk+hhVYmJ7mxxqTBFK/Q+DvaX4IXWqkP
         9m9hjS7vLbffjKZ50sq3Cnt84D9olUlPuYXYSHr0ofttQKbZpGE5858oumjXbCvyw2fT
         gqHKLnkVNhadU3jmT1SI7pGFaz12lR9ViKdp2w5YzFttbKRJy7EvcN12oTqlkOHFIivd
         DvVSuVje68FOOoI3+GHkp1OgLARpjG4n+cRe370BTYzkSdq3W1lYPkEHhKlAfaTsYY9d
         vwnxMwtjuZqB49gv1jvv78+q5aljdp7256cNi0+oQo29RVqxEfzr4bNtBOztwcVVp2YX
         WJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jVjmHPs9Vzn+FL0BItXKX43L71zgap2RPxsgO9/F3J4=;
        b=MFovf/C5xeOY4b+u9iJgdojx77UbAv5k7Z4P5+ht+CXA+CACr76Cc2urUFfHnqIemE
         uS8sPmry70b+Yd1ZwR6g8AGniiKJk34W4HHOrpiws5uecyOLOsnmi4ea57+tQmuNHiPq
         PHixkHVKGbcctu5zmGiVmxb5Eb8oqdPimKcbKlx1az+KowGsk4yTZghyATpqRYaRHSFX
         ozXxr+ceAlckO6xwi4lFopuTM8LRb5xqS84f6N3PlYAbYyMFLhDJPYOvD6HV8bYzzNQH
         9K80O1/1ODKfQmK/tHMNDaS0D5Ph3JM57XJWRJ0G4W10Gqg3Qt1Dr34Ay1im5q25KXE+
         QeXQ==
X-Gm-Message-State: AOAM530HM+cLASRjQ6fAOlnYZyXCWNZ48pChBS1gV3AEJ6BttzR5rtb4
        CqFXw5Vac09btwqKPjVjyhvJJxMNJoHoyNbr
X-Google-Smtp-Source: ABdhPJyn/CwZUKffkxJbI0JsVOQgOE74VTner8iGDHqv+hf/uDnqNKul3xtaajLJjyoYYolNlVbdRw==
X-Received: by 2002:a92:cb4b:: with SMTP id f11mr4255731ilq.189.1631229871281;
        Thu, 09 Sep 2021 16:24:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y27sm1582735iot.10.2021.09.09.16.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 16:24:30 -0700 (PDT)
Date:   Thu, 9 Sep 2021 19:24:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com
Subject: [PATCH v2 1/9] pack.h: line-wrap the definition of
 finish_tmp_packfile()
Message-ID: <0b07aa4947caff53878a9000e2866f98146e2ccd.1631228928.git.me@ttaylorr.com>
References: <cover.1631157880.git.me@ttaylorr.com>
 <cover.1631228928.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1631228928.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Line-wrap the definition of finish_tmp_packfile() to make subsequent
changes easier to read. See 0e990530ae (finish_tmp_packfile(): a
helper function, 2011-10-28) for the commit that introduced this
overly long line.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/pack.h b/pack.h
index fa13954526..1c17254c0a 100644
--- a/pack.h
+++ b/pack.h
@@ -110,6 +110,11 @@ int encode_in_pack_object_header(unsigned char *hdr, int hdr_len,
 int read_pack_header(int fd, struct pack_header *);
 
 struct hashfile *create_tmp_packfile(char **pack_tmp_name);
-void finish_tmp_packfile(struct strbuf *name_buffer, const char *pack_tmp_name, struct pack_idx_entry **written_list, uint32_t nr_written, struct pack_idx_option *pack_idx_opts, unsigned char sha1[]);
+void finish_tmp_packfile(struct strbuf *name_buffer,
+			 const char *pack_tmp_name,
+			 struct pack_idx_entry **written_list,
+			 uint32_t nr_written,
+			 struct pack_idx_option *pack_idx_opts,
+			 unsigned char sha1[]);
 
 #endif
-- 
2.33.0.96.g73915697e6

