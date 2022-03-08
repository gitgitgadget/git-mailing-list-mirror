Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2947CC433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350524AbiCHWZO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbiCHWZN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:25:13 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7AC58390
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:24:15 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id k25so725505iok.8
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uNnVZqzIgHmjnsMVK9IVTXmQHxX9mGj4BAmWzjkJLus=;
        b=7ibqzirxHhIlf5Qt90li1dBpS54xnTfT4zzElvQ0o/ZlZyVkTJGr+935hwocKJabMf
         Qf8qY863UGMvUXWqSpdu6DS4cdMKPK4snyjfo9WBJefvuRgEkG5YE6hAQ4HiNwz4ovOs
         oYc72OEPz+FTGCr23bQdrf+6aWdqD9gwg3IJ2vjsoos+3NQOYerkiRsawt0B2F2BW9Wa
         XMrkXuGIpqkUKEq6SEatuWppd/J1rJvg7ExkrL5Fu2sxkMj2tyFM8ZBnT064gj9zDgyH
         TBdBIjA6yrOE9VISynN21K/UDejWtj8l8m9FEYxvP5eA/+wXEYfEXcW+etu/z1DSTXDd
         JJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uNnVZqzIgHmjnsMVK9IVTXmQHxX9mGj4BAmWzjkJLus=;
        b=qU6WvUpXjmWMLWRijlL5Be9e0yJga2YjsxiiBAKZ28aIuFBiCVvTvNXgz8GMebFRfe
         jKboLnPXx1nP4XMS700I085oI7lWIrSjQ+nPhDiOBYxlsSVjFYCj3QlW6ublJk8NGnhD
         h0QIwpDDX9guBJE2wc+HvHbQOR7YrF7dhJObQdbLXjaogY7CGcnc9ocyfKavobL7BYoe
         PjnnNEWWP87hZCSOFHg33vGTFdV3/+078A4twnapEsZ+4Joa/4jL1yDNpEzbp22yV6n1
         vUnSvz1/YhP6XougB4TZjfviPQqYWlONDZz/d+SlPutTpjnLiEqcyeSXPxHPStP1D20i
         Lo9A==
X-Gm-Message-State: AOAM532PYvXkl3aF16COkZHLS/Uls7PzyOv9sTeKoDjJm0CQTmVJTYmc
        eck0MNMWXGS6Dtg5Gl5e1w/ASw==
X-Google-Smtp-Source: ABdhPJxrwma1JryL8oX7cBuLcxDw82WL8n1sn1O3sqp5mpWjIhXv/C5zbxFvVUnzF3sJLCqmC+/WWw==
X-Received: by 2002:a05:6638:4605:b0:319:9afe:baf6 with SMTP id bw5-20020a056638460500b003199afebaf6mr568650jab.165.1646778255237;
        Tue, 08 Mar 2022 14:24:15 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j9-20020a056e02154900b002c5f02e6eddsm68028ilu.76.2022.03.08.14.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:24:14 -0800 (PST)
Date:   Tue, 8 Mar 2022 17:24:14 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2] cat-file: skip expanding default format
Message-ID: <YifXjuN27U53c46c@nand.local>
References: <pull.1221.git.git.1646429845306.gitgitgadget@gmail.com>
 <pull.1221.v2.git.git.1646708063480.gitgitgadget@gmail.com>
 <YifSFQ8zEZimCkHl@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YifSFQ8zEZimCkHl@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 08, 2022 at 05:00:53PM -0500, Taylor Blau wrote:
> On my copy of git.git., it shaves off around ~7ms that we're spending
> just copying type names back and forth.

...while we're at it, I think we could go a little further and avoid
doing the mark_query phase altogether, by doing something like:

--- 8< ---

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index ab9a49e13a..4b3cfb9e68 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -542,24 +542,30 @@ static int batch_objects(struct batch_options *opt)
 	int save_warning;
 	int retval = 0;

-	/*
-	 * Expand once with our special mark_query flag, which will prime the
-	 * object_info to be handed to oid_object_info_extended for each
-	 * object.
-	 */
-	memset(&data, 0, sizeof(data));
-	data.mark_query = 1;
-	strbuf_expand(&output,
-		      opt->format ? opt->format : DEFAULT_FORMAT,
-		      expand_format,
-		      &data);
-	data.mark_query = 0;
-	strbuf_release(&output);
 	if (opt->cmdmode)
 		data.split_on_whitespace = 1;

-	if (opt->format && !strcmp(opt->format, DEFAULT_FORMAT))
+	memset(&data, 0, sizeof(data));
+	if (!opt->format || !strcmp(opt->format, DEFAULT_FORMAT)) {
+		data.info.sizep = &data.size;
+		data.info.typep = &data.type;
+
 		opt->format = NULL;
+	} else {
+		/*
+		 * Expand once with our special mark_query flag, which will prime the
+		 * object_info to be handed to oid_object_info_extended for each
+		 * object.
+		 */
+		data.mark_query = 1;
+		strbuf_expand(&output,
+			      opt->format ? opt->format : DEFAULT_FORMAT,
+			      expand_format,
+			      &data);
+		data.mark_query = 0;
+		strbuf_release(&output);
+	}
+
 	/*
 	 * If we are printing out the object, then always fill in the type,
 	 * since we will want to decide whether or not to stream.

--- >8 ---

...but in my experiments it doesn't seem to help much. Or, at least, it
doesn't obviously help, there's too much noise from run to run for me to
see a worthwhile speed-up here.

Thanks,
Taylor
