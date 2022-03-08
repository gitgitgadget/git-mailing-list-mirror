Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCA4C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbiCHWB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiCHWB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:01:56 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F6555BC3
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:00:56 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id z66so260210qke.10
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=A9XRvrQP5P8pvIWg2hDHWr4oA/EKpMTazUjjW5QlLQg=;
        b=xo2gjOs6wXIqOQOBTGRTuN36EyAhCCpzogfohTEES5maIGODkUI3MmBqvCvQZ68d3R
         giiqp3H/HnQl26SQnQy9AxiX/L2GV+LBrlg351s8eHN3URP2lRIxlZKzBvztKrBx1JYc
         psLyX2W4OhmmxsH3INeWvRNdOnHmMyVKhtPgaLwmgSbND6kXiiEaE0DnwVd2f495qFhJ
         PyZY5MU0kxa66oVhu+I4ZuwFHCCJWg5FsrKry5ZRDOrtQXZVS2T9oj1a9WtPiIbE9byI
         SZBQm64+xJqc646w92pn2UxSyIMvgyTqMrMHoHBnO7e+CFbegpJxJFQtkLW0sUy7km8n
         +ZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=A9XRvrQP5P8pvIWg2hDHWr4oA/EKpMTazUjjW5QlLQg=;
        b=5nK5RXzBaE4th47PlUEXRakXQjzxUPCQMRm8G9ys68SSBb3nW2mmO2E1cwEgHOWPBg
         ZefVOp+QiiPs1Z6XbzHnU7mjnW3+EcTKbxb+4OKE/3hyydWHr8WPU0f9zbhbkyKu6Y7x
         7OoWPe8YpZ+wnGC36Omc7dLp9rBb/EcShRJcB9dKLzXi52YW/2OKSUlgPFnetvdfUHXI
         eJ19ub6+ORFl5G7q0xHbF9c3tDl8E2Lw23+8MmFICWD7EeKyEjL1QvvKEZxJqURgH8ix
         0WCkaFXQRiYQUiz7lpY4IaE3c+1Jt6hHz42ls2tMrUOeTh+srXGWfSE0V3Jk+llkNG+H
         0bSQ==
X-Gm-Message-State: AOAM5306dqmMxHpPOz6VNk9Tuc7KCXpTOPbaDpl34YHObf4fUxffPL8E
        W+UH/kEfdMWF+VpEyQSmMtEWCA==
X-Google-Smtp-Source: ABdhPJy0qAfY1nPfHehzjRzj+Sk94Kf3Lfcti974uLCosZ+2XEFeNzs5IIPNxQ2vnFoSl6F8+4/CBQ==
X-Received: by 2002:ae9:e101:0:b0:663:7381:5c8d with SMTP id g1-20020ae9e101000000b0066373815c8dmr11662515qkm.653.1646776855305;
        Tue, 08 Mar 2022 14:00:55 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f9-20020a05620a15a900b00646d7cb7afbsm85922qkk.19.2022.03.08.14.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:00:54 -0800 (PST)
Date:   Tue, 8 Mar 2022 17:00:53 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2] cat-file: skip expanding default format
Message-ID: <YifSFQ8zEZimCkHl@nand.local>
References: <pull.1221.git.git.1646429845306.gitgitgadget@gmail.com>
 <pull.1221.v2.git.git.1646708063480.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.1221.v2.git.git.1646708063480.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 08, 2022 at 02:54:23AM +0000, John Cai via GitGitGadget wrote:
>  /*
>   * If "pack" is non-NULL, then "offset" is the byte offset within the pack from
>   * which the object may be accessed (though note that we may also rely on
> @@ -363,6 +371,11 @@ static void batch_object_write(const char *obj_name,
>  			       struct packed_git *pack,
>  			       off_t offset)
>  {
> +	struct strbuf type_name = STRBUF_INIT;
> +
> +	if (!opt->format)
> +		data->info.type_name = &type_name;

Hmmm, I'm not quite sure I understand why the extra string buffer is
necessary here. When we do the first expansion with the DEFAULT_FORMAT,
we set data->info.typep to point at data->type.

So by the time we do our actual query (either with
`packed_object_info()` or just `oid_object_info_extended()`), we will
get the type filled into data->type.

And we should be able to use that in print_default_format(), which saves
us in a couple of ways:

  - We don't have to (stack) allocate a string buffer, which then needs
    to be cleaned up after printing each object.

  - (More importantly) we can avoid the extra string copy through the
    intermediate buffer by using type_name() directly.

Here's a small patch on top that you could apply, if you're interested:

--- >8 ---


diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index ab9a49e13a..9f55afa75b 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -355,5 +355,5 @@ static int print_default_format(char *buf, int len, struct expand_data *data)
 {
 	return xsnprintf(buf, len, "%s %s %"PRIuMAX"\n", oid_to_hex(&data->oid),
-		 data->info.type_name->buf,
+			 type_name(data->type),
 		 (uintmax_t)*data->info.sizep);

@@ -372,9 +372,4 @@ static void batch_object_write(const char *obj_name,
 			       off_t offset)
 {
-	struct strbuf type_name = STRBUF_INIT;
-
-	if (!opt->format)
-		data->info.type_name = &type_name;
-
 	if (!data->skip_object_info) {
 		int ret;
@@ -391,5 +386,5 @@ static void batch_object_write(const char *obj_name,
 			       obj_name ? obj_name : oid_to_hex(&data->oid));
 			fflush(stdout);
-			goto cleanup;
+			return;
 		}
 	}
@@ -410,7 +405,4 @@ static void batch_object_write(const char *obj_name,
 		batch_write(opt, "\n", 1);
 	}
-
-cleanup:
-	strbuf_release(&type_name);
 }

--- 8< ---

On my copy of git.git., it shaves off around ~7ms that we're spending
just copying type names back and forth.

    (without the above)
    Benchmark 1: git.compile cat-file --batch-check --batch-all-objects
      Time (mean ± σ):     578.7 ms ±  12.7 ms    [User: 553.4 ms, System: 25.2 ms]
      Range (min … max):   568.1 ms … 600.1 ms    10 runs

    (with the above)
    Benchmark 1: git.compile cat-file --batch-check --batch-all-objects
      Time (mean ± σ):     571.5 ms ±   7.9 ms    [User: 544.0 ms, System: 27.3 ms]
      Range (min … max):   558.8 ms … 583.2 ms    10 runs

Thanks,
Taylor
