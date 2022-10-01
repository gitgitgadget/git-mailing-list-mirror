Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED90C433FE
	for <git@archiver.kernel.org>; Sat,  1 Oct 2022 18:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiJASwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Oct 2022 14:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiJASwB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2022 14:52:01 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7340ECE23
        for <git@vger.kernel.org>; Sat,  1 Oct 2022 11:52:00 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d24so6582384pls.4
        for <git@vger.kernel.org>; Sat, 01 Oct 2022 11:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=Nsbrabt3rY7hoWffg+li/XsrPdWCfGS4iLD36ygedNI=;
        b=gmL9JFxpnhZE8N/D98Xv0RCg3l212ujKpfAalwyUhaZGbVpr05oC/WuKxdnanHF4Xn
         yJggP4E4pMR5w0PT6rxaUe+Rhlni4XOYYmTbELG2l48ftBy+Yy6r/tlmBEvqun8buy9X
         cZliHaj2CQfy8yMxtCLS0VRhYiL1l1q5cJs5gzb51x1W+leXOzYBu6CSpJnFY/2MJqq8
         bQF1J5i7peiegjDFt0AnmG/LBtvAUDzV9x/rwEBT6c9K8hbL6wtys0If9E7yOXnfKYtA
         cSOoY+5HkxIYE6mdWECzCAPj6Ruk+ISPyj90TnMtxNufuKgq7F+wa/zFSEQdaCE0oyOY
         30TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Nsbrabt3rY7hoWffg+li/XsrPdWCfGS4iLD36ygedNI=;
        b=CLrXxFOGLjQrp6ajmDqAMN3IogsdRz/zrsbkpm8YjVzefJ1j6FcBQWMhI33bbd+dC4
         Mk7F3UxwyWEb9tXKD3GK2iw++05cHwBpA7JScong+AeWjxJg721hoAiST5UAQFxqeC9Y
         fWsMbCqvK0J+h6NC33MLAaf4DuEZAXHzDtX7V/igF5wmOjYHJiPCfPDtsVPTK99Mh6dH
         6+afz2EuofDfJVnEEK3jmui44lIhHmuahn9Y7+ulqlP7XzzcjS4uVwewVv9TEL5mnYh9
         dNeb4m3tQEry0Jw5OH3ccO+qPHWpHXh1B4E25zLbWwbVk6dSwyeRcbYqooDzg0a/GQj0
         OOFg==
X-Gm-Message-State: ACrzQf1Mcy1n9tn4VCFKyLroatRZM67zMOTuyGdwbKOtYxeorzucjOi8
        UMUMKbE7V2yvXCZOr943YGc=
X-Google-Smtp-Source: AMsMyM76R9fwrr78MF8htMQdgrSxdcaR84MRHWOy3jgOUJoGDMPs/aacEJB9EFnUGbgFrsWEs/DyCw==
X-Received: by 2002:a17:90b:3ec1:b0:202:f490:e508 with SMTP id rm1-20020a17090b3ec100b00202f490e508mr4501560pjb.156.1664650319891;
        Sat, 01 Oct 2022 11:51:59 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id k13-20020a170902c40d00b0017541ecdcfesm4215145plk.229.2022.10.01.11.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 11:51:59 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 24/36] doc txt & -h consistency: make "bundle"
 consistent
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
        <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
        <patch-v3-24.36-7f93da79fee-20220930T180415Z-avarab@gmail.com>
Date:   Sat, 01 Oct 2022 11:51:59 -0700
In-Reply-To: <patch-v3-24.36-7f93da79fee-20220930T180415Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 30 Sep
 2022 20:07:47
        +0200")
Message-ID: <xmqqbkqv2x80.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Amend the -h output to match that of the *.txt output, the differences
> were fairly small. In the case of "[<options>]" we only have a few of
> them, so let's exhaustively list them as in the *.txt.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/bundle.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/bundle.c b/builtin/bundle.c
> index 1b08700bf9e..544c78a5f3a 100644
> --- a/builtin/bundle.c
> +++ b/builtin/bundle.c
> @@ -12,13 +12,14 @@
>   */
>  
>  #define BUILTIN_BUNDLE_CREATE_USAGE \
> -	N_("git bundle create [<options>] <file> <git-rev-list args>")
> +	N_("git bundle create [-q | --quiet | --progress | --all-progress] [--all-progress-implied]\n" \
> +	   "                  [--version=<version>] <file> <git-rev-list-args>")

This looks like getting a bit on the longer side.  I think keeping
the original would be a far better option IF we can give the list of
options and their explanations like usage_with_options() does, and I
also think it would be the right thing in the longer term.  As an
intermediate state before getting there, I do not think the
postimage of this patch hurts, but is one more thing we need to
maintain and get distracted.  So, I dunno.

>  #define BUILTIN_BUNDLE_VERIFY_USAGE \
> -	N_("git bundle verify [<options>] <file>")
> +	N_("git bundle verify [-q | --quiet] <file>")
>  #define BUILTIN_BUNDLE_LIST_HEADS_USAGE \
>  	N_("git bundle list-heads <file> [<refname>...]")
>  #define BUILTIN_BUNDLE_UNBUNDLE_USAGE \
> -	N_("git bundle unbundle <file> [<refname>...]")
> +	N_("git bundle unbundle [--progress] <file> [<refname>...]")
>  
>  static char const * const builtin_bundle_usage[] = {
>  	BUILTIN_BUNDLE_CREATE_USAGE,
