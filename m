Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2031ECAAA3
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 13:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344128AbiHZNRn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 09:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbiHZNRk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 09:17:40 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812B6C6946
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 06:17:39 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id u6so2047154eda.12
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 06:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=fnNjFkOU3iyVquPf0vmugGWiN3iw7/Lv5y5GPY/HtjY=;
        b=TMH/qdhyiGydDm7hbkNrFYb0yVQzwGYe91i/NczOu6ELLALqiavKe4l7HlH9HY7Yz/
         etDTWLys0U8rryIElucTRo1KtUdY7/nmgNg37Gz9hVg4RhBNcGBQp1WEGeDH2gTVK88n
         p0PTCedi1OByaGknFvw+aJWBDwvHN/9uhe/+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=fnNjFkOU3iyVquPf0vmugGWiN3iw7/Lv5y5GPY/HtjY=;
        b=rSMLZp6jY7RoZ++gZcemiBO1zHw8aYO/Ok0Liy5/or0YsnTMgJh+5hcAMwSEft/GLe
         2vSonX64x+fZ9m87zR4QII6/LnVV/fAJVxHfEbfctLKjQmD69etMQDRsipIboRgWkWQk
         icy/cRrUmshGWoR+kZLmrx+bGvpIE8zObY6tyxqF6dvMGYZdgFCrGCgfcPK9bnAZcT+1
         dkcuurL7r1r77ozDhcGT3NLX0+JzxXNPP0NFpKzyMPBq3T9ON4Sbv7GFxUAtlcSbIg9m
         +zeXwlL89N6ZSos0NPJDDw61OW+okR+2y/uxx5iviSNmrS4PTMFJEzwuWLYzL1PQD3NW
         APRw==
X-Gm-Message-State: ACgBeo1va2dl7KWxtlBzcnmHtteQjJJlElrtnXi4HT/cdX6IEALNnaR5
        7JBKkheZQkw9z57ZMd7noGRZpFMDyOCsKfku
X-Google-Smtp-Source: AA6agR7EA+etuhSwmx2FC6qxj/FUS/3q+IvKXc2xLQ5FA2qstlKYStGHDwKChmSbuzi0ohyGAweFSw==
X-Received: by 2002:a05:6402:3482:b0:446:dd44:7125 with SMTP id v2-20020a056402348200b00446dd447125mr6899889edc.65.1661519857759;
        Fri, 26 Aug 2022 06:17:37 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.65])
        by smtp.gmail.com with ESMTPSA id l1-20020a1709063d2100b0072f1d8e7301sm907176ejf.66.2022.08.26.06.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 06:17:36 -0700 (PDT)
Message-ID: <c403e526-7455-4f26-fcef-97c99f9af539@rasmusvillemoes.dk>
Date:   Fri, 26 Aug 2022 15:17:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Git Mailing List <git@vger.kernel.org>
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: forcing an in-body From header
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Some mailing lists mangle the real From: header, making it a little hard
for maintainers to apply patches directly using 'git am'. See e.g.
https://lists.openembedded.org/g/openembedded-core/message/166515 . One
way to work around that is by having an in-body From: "header".

However, merely setting sendemail.from or format.from is not enough to
get such a header, if the value happens to be identical to the patch
author (which it would usually be). So, could we get some config knob
and/or command line switch to force an in-body from header? Then one
could set that on a per-project basis, for projects with such mailing lists.

I looked into the code, and while this is obviously just a hacky patch
to see that I found the right spot, it doesn't seem to be too hard to
implement properly.

diff --git a/pretty.c b/pretty.c
index ee6114e3f0..8b9ef6f644 100644
--- a/pretty.c
+++ b/pretty.c
@@ -503,7 +503,7 @@ void pp_user_info(struct pretty_print_context *pp,
                map_user(pp->mailmap, &mailbuf, &maillen, &namebuf,
&namelen);

        if (cmit_fmt_is_mail(pp->fmt)) {
-               if (pp->from_ident && ident_cmp(pp->from_ident, &ident)) {
+               if (pp->from_ident && (ident_cmp(pp->from_ident, &ident)
|| getenv("GIT_FORCE_BODY_FROM"))) {
                        struct strbuf buf = STRBUF_INIT;

                        strbuf_addstr(&buf, "From: ");

Thanks,
Rasmus
