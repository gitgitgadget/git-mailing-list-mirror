Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9648BC433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 16:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A3561209
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 16:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhIKQ0V (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 12:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbhIKQ0U (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 12:26:20 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECDDC061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 09:25:07 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id b200so6374154iof.13
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 09:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WpbcaQMkUzzDAgRrA5+49/VKQq97b+AwEUDFAw561Ew=;
        b=FDW79OoxM7KV4ZL9ihnGfpAor5lHDRxI/xIe4BkGQosmD62hqbNhq4bbq5KdNmy+kL
         yspZ7JrGpXsAmqI6ZatkVr9LBLVQjZK+nUiAJufj/Vb2dzgAv4O3iQxDMKZvrOQ82jH4
         tnJzmdfEPyepJpIfB0VMzmJB93dh4oHTH29Gwp8Cw8HGETOtDiz3xXG/uK+kjIPvsQBx
         R1JRYvBHBp/Iud4K9Ul53ueSwjAid4Lg0s4TWz09NolAU0f+UeL/8IgYUfP6OjPv1Ses
         YAeI6V1OE4gb4edDJ6o9iS5+y50u9NK6NiZ0DHchYldi55VziPmFKZtk/sZPkpEdAz81
         VwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WpbcaQMkUzzDAgRrA5+49/VKQq97b+AwEUDFAw561Ew=;
        b=0Mxv69EiikRCgAmrmS50mp8qF7N/8NlX1T9uoCdALPfdA2p0jtTPqc/w9Z7Mjo3ynx
         AldPU4n9VqKjRGyMp7k0ApwGIU6wuzlaf0Jn+Hj8TIwh1XYQumEe4y74EJc79nwn4Coy
         sIJRbIVrgkvHdYtfefmO0tibpnxGYwvf7/1GkgoOkHXtqotbw64D9Su/DaawL8j7Arv9
         9dGauDWpMep9I+9V+bQYYQiFdtLSKqvx4s46E2iJwRsO6Xm8mp9EBOU0aYH2uguOslne
         ez4tfVCAz8lEValK8klkXqFOhpwFMMo5GYb42rgE9XAHirHDRJ5FA/gN/Jysc6p0pgkz
         xTLQ==
X-Gm-Message-State: AOAM533USeYPIsM/IlQj7EjsshTeDcSaoqiUY5lYqIOB1wg2qqE4AM/G
        WDgMFo/tEfu9ewGuU+dkurra5shst1bHrsi2
X-Google-Smtp-Source: ABdhPJz1ubTBgybkppasouvmU+hYUZLBTDHI0Mhezd+J+HDp/s8i3FjLOsTheqk3QaepxdkZR36E+w==
X-Received: by 2002:a5d:851a:: with SMTP id q26mr2421238ion.163.1631377506973;
        Sat, 11 Sep 2021 09:25:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c23sm1085360ioi.31.2021.09.11.09.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 09:25:06 -0700 (PDT)
Date:   Sat, 11 Sep 2021 12:25:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 2/8] builtin/multi-pack-index.c: support --stdin-packs
 mode
Message-ID: <YTzYYfBGqG87O5mN@nand.local>
References: <cover.1631331139.git.me@ttaylorr.com>
 <2a16f11790b79ab452233b6f28acac607c0abd28.1631331139.git.me@ttaylorr.com>
 <87ee9va0ie.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ee9va0ie.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 12:05:05PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Fri, Sep 10 2021, Taylor Blau wrote:
>
> > +	struct strbuf buf = STRBUF_INIT;
> > +	while (strbuf_getline(&buf, stdin) != EOF) {
> > +		string_list_append(to, strbuf_detach(&buf, NULL));
>
> If you strbuf_detach() it...
>
>
> > +		struct string_list packs = STRING_LIST_INIT_NODUP;
>
> ...init the list with NODUP...
>
> > +		string_list_clear(&packs, 0);
>
> ...and call string_list_clear() you'll leak memory, since the
> string_list will think that someone else is taking care of this memory.
>
> I had some recent musings about how this API is bad, and I've got local
> WIP patches to fix it, but in the meantime you need to:
>
>     packs.strdup_strings = 1;
>
> Before calling string_list_clear(). I.e. we didn't strdup(), but during
> free() we pretend that we did, because we did, just not in
> string_list_append().

Good catch. It's kind of gross, but the result is:

--- 8< ---

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 77488b6b7b..e6cab975e3 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -64,7 +64,7 @@ static struct option *add_common_options(struct option *prev)

 static void read_packs_from_stdin(struct string_list *to)
 {
-	struct strbuf buf = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT_NODUP;
 	while (strbuf_getline(&buf, stdin) != EOF) {
 		string_list_append(to, strbuf_detach(&buf, NULL));
 	}
@@ -107,6 +107,11 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
 		ret = write_midx_file_only(opts.object_dir, &packs,
 					   opts.preferred_pack, opts.flags);

+		/*
+		 * pretend strings are duplicated to free the memory allocated
+		 * by read_packs_from_stdin()
+		 */
+		packs.strdup_strings = 1;
 		string_list_clear(&packs, 0);

 		return ret;
