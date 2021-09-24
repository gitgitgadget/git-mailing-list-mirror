Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E53EC433FE
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 06:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F4BA6124F
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 06:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244145AbhIXGXA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 02:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244176AbhIXGUj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 02:20:39 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A38C061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 23:19:07 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id s16so8101361pfk.0
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 23:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rwg3fnzo+/Hy6c/OEJVfPFJCMTIasnwP4NmlLZXYI8A=;
        b=CTZjOssME88L8GM0/XKdFi36AuQ6hYYDDjrYGeqXWGAT3q7uq0N4j6dSUcBdJdYy9c
         mI3fx12uu4thrYTuPEshnY3/Q0aANOH2v5LzZDtpj28eZdyA2ZJIpeGQFYq0mh+qxOii
         0YL0dVa71YH/8baL6K44NbGhIFwLmSy5vayYbq3MB3dP3CEhGpFIHm1iFzwhqFuglinf
         La6Y2YMwz6azqrheanxK1K3pTVmYwhmzoX4Fa40PSZi5Z9korLdJPphzCdd+Dk94gv2U
         VwvPx4C8FZ2KJWimYm2TgT3QY65v/VZROB7PGS6SsbNSNHwPlP+H6bZBtv7HLgRlQa2c
         n+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rwg3fnzo+/Hy6c/OEJVfPFJCMTIasnwP4NmlLZXYI8A=;
        b=25MPpfLCFBtvM3y58C+DSRSKjoh/EdMuCgIhb/F3KWeNTFnzHgxh/9o1rRSSdpLLTp
         SlcnAcdLnRxUTirGWD236HSQ2FQg1FAFKosP9KDXhjQTXq/EQtWOrPWEvOBW7Ig95G7Y
         W4GMnFqMCCwjj030z/VtNxK7xDzWqWAFLEkUlVClAiDh1vDWSywnu/jSOLRZDUSnXaiD
         +9VeuHYdMj5a6voWAUi3NU+Cc0plGDeGGfcIRz2jD0XMsIQe5wzWTJGkBR+p4m1r/+Hv
         kh9Tu1FVOG7MAk5nfKpdAUuxFOCf2RMv/TomlLvJiWHyqAUqj7eswKfkLCTsuWal7qrB
         xKbQ==
X-Gm-Message-State: AOAM532h35IFeYlNDQm5BtYHQeaNl/+ZISosJ7ksGxcgJDh3R6IdtE6N
        peo9hPfBavQNpdsH9tO3rdDEnHIx4QzOiQ==
X-Google-Smtp-Source: ABdhPJzDhhANitFGZ3VhQgacDQtNKluMhb/PJl3Kqgt0406Xo4dZtAF0oqp9JAsSB+Nq161yqF+F1w==
X-Received: by 2002:a63:b50d:: with SMTP id y13mr2389708pge.286.1632464346524;
        Thu, 23 Sep 2021 23:19:06 -0700 (PDT)
Received: from [192.168.43.80] (subs09a-223-255-225-75.three.co.id. [223.255.225.75])
        by smtp.gmail.com with ESMTPSA id z70sm3897519pgz.93.2021.09.23.23.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 23:19:06 -0700 (PDT)
Subject: Re: [PATCH v5 3/3] send-email docs: add format-patch options
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Thiago Perrotta <tbperrotta@gmail.com>, gitster@pobox.com,
        avarab@gmail.com, git@vger.kernel.org
References: <87zgs34ccx.fsf@evledraar.gmail.com>
 <20210924024606.20542-4-tbperrotta@gmail.com>
 <9a60226c-7a35-0486-a687-31f7691e7551@gmail.com>
 <CAPUEspjxYy4GOABXkzRza-wmKnZAdq-v=OP-9+-wfV2PCnDGwQ@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <4c415fd4-a74e-5eb0-061e-39185be623ca@gmail.com>
Date:   Fri, 24 Sep 2021 13:19:03 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPUEspjxYy4GOABXkzRza-wmKnZAdq-v=OP-9+-wfV2PCnDGwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/09/21 11.53, Carlo Arenas wrote:
> no; as Junio explained [1] this omission is intentional while the
> rev-list options that
> got cut to make space are not and are more relevant.
> 
> IMHO leaving [<options>] to imply ALL options (that also include diff
> options, for example) is better

Quoting what you linked:

> The program works in two majorly different modes.  It either takes
> 
>  * message files that are already proof-read and copy-edited from
>    the filesystem and sends them out, or 
> 
>  * format-patch options to generate message files out of the commits
>    and send them out without any proofreading.

I think we need to again modify SYNOPSIS and DESCRIPTIONS to highlight 
above fact:

---- 8> ----
diff --git a/Documentation/git-send-email.txt 
b/Documentation/git-send-email.txt
index 3db4eab4ba..6002ca1a02 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -9,17 +9,19 @@ git-send-email - Send a collection of patches as emails
  SYNOPSIS
  --------
  [verse]
-'git send-email' [<options>] <file|directory|rev-list options>...
+'git send-email' [<options>] <file|directory>...
+'git send-email' [<options>] <revision list>...
  'git send-email' --dump-aliases


  DESCRIPTION
  -----------
-Takes the patches given on the command line and emails them out.
-Patches can be specified as files, directories (which will send all
-files in the directory), or directly as a revision list.  In the
-last case, any format accepted by linkgit:git-format-patch[1] can
-be passed to git send-email.
+In the first form, take the patches in <file> or <directory> and
+emails them out. In the second form, generate patches from specified
+<revision list> (it can be revision range or explicit list of
+revisions from linkgit:git-rev-list[1]), then emails them out.
+<options> can also include options understood by
+linkgit:git-format-patch[1] if the second form is specified.

  The header of the email is configurable via command-line options.  If not
  specified on the command line, the user will be prompted with a ReadLine

-- 
An old man doll... just what I always wanted! - Clara
