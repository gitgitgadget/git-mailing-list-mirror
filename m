Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20250C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 05:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E11E760F26
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 05:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhIUFfb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 01:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhIUFfa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 01:35:30 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BF9C061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 22:34:02 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id q23so16308627pfs.9
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 22:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=yNITUkrEjQz3JYlRvvMcFwBLKZSGSRNPDDjqcoxcauk=;
        b=GkbPFQDZ0j0TBynlvDxaeNWYr3b4uDrKNfVWCtV8ZUX8KW5utiBPQtK2m9Gz92rH9i
         TvdR+UV375fQwFzKIRuGNKrSSCmV0ONmj9IF0IqOKYxQQnKZpS8ei70/mlbPz5IIrPCA
         HHIyMNgi7eYrJldcqN4eNUpKWHK8rdug2FBZSV0LXF9eYAR+o92JgYcSoUuehA7gH4a8
         PYZIdHeIIxr98X2Z7r+zBRZNk7IC4cqQmngr/ifZcSu+lRysEeRp4Ip+fl7IGPchhSvK
         18aPLCkDNFHiEws5APCsXWVUlHiVu0LKOb4zES2R0z+wirG91naUwJRvcGGesLb+55Wl
         0hnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yNITUkrEjQz3JYlRvvMcFwBLKZSGSRNPDDjqcoxcauk=;
        b=IrZURV9hzBC9WdBxMytjTQm5r/MX+fPtqpJp5cyLSloMi65pzxanFYgmvA7GLCFZfS
         GcIMp8goaxJSKzq03dYP9HLqlQme0iWKqALNBTLf/ArGgaKnva1d84acsv/trVKrCeZS
         mGcG++kKTkBhrFCJ61M5nKzFL73pmuddEoe0+Qw9wbA0py96xNZ9zSCSbr08pcz0xydf
         28RjKrK051IZks2Qtfe8erQ4io4CD/BSbk+ug78wacDhMiKCH/s58sASavmfWNK4G6aE
         tNaIP7JURm9K4KZG7jg3ca1265IFfWsJl4NeAjlFEf7g9nzFIvJgImmrN7jYX5MWrIQN
         AD9A==
X-Gm-Message-State: AOAM532gH1KUl5ShfyuD+sefDDDUJ38iHz88/g4KJRAE/2RvKdhl4pwo
        baWPwXl8r2hBJpnis9S6MNWzn/1VtmY0ww==
X-Google-Smtp-Source: ABdhPJyuP+WcCClhrzNTbN3+HBO8tefVsYwleyq2M00OU6RPUEZDaVyLLJ4jp2x4PgUtEQl+xC/Pcw==
X-Received: by 2002:aa7:9a51:0:b0:43d:f0b0:532a with SMTP id x17-20020aa79a51000000b0043df0b0532amr28628152pfj.76.1632202442166;
        Mon, 20 Sep 2021 22:34:02 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-3.three.co.id. [180.214.233.3])
        by smtp.gmail.com with ESMTPSA id gp11sm1103164pjb.2.2021.09.20.22.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 22:34:01 -0700 (PDT)
Subject: Re: [PATCH v2] MyFirstContribution: Document --range-diff option when
 writing v2
To:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
References: <20210913194816.51182-1-chooglen@google.com>
 <20210920223226.25877-1-chooglen@google.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <00f94ddf-7019-a5e0-8fd5-a88a4b1cc5c3@gmail.com>
Date:   Tue, 21 Sep 2021 12:33:59 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210920223226.25877-1-chooglen@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/09/21 05.32, Glen Choo wrote:
> -Skip ahead to <<reviewing,Responding to Reviews>> for information on how to
> -handle comments from reviewers. Continue this section when your topic branch is
> -shaped the way you want it to look for your patchset v2.
> +This section will focus on how to send a v2 of your patchset. To learn what
> +should go into v2, skip ahead to <<reviewing,Responding to Reviews>> for
> +information on how to handle comments from reviewers.
> +
> +We'll reuse our `psuh` topic branch for v2. Before we make any changes, we'll
> +mark the tip of our v1 branch for easy reference:
>   
> -When you're ready with the next iteration of your patch, the process is fairly
> -similar.
> +----
> +$ git checkout psuh
> +$ git branch psuh-v1
> +----
>   

Alternatively we can branch off psuh-v2 from the original psuh:
----
$ git checkout psuh
$ git checkout -b psuh-v2
----

The original psuh thus become v1. To easily identify it, we can run:
----
$ git checkout psuh
$ git branch -M psuh-v1
----

> -First, generate your v2 patches again:
> +Make your changes with `git rebase -i`. Once you're ready with the next
> +iteration of your patch, the process is fairly similar to before. Generate your
> +patches again, but with some new flags:
>   

For completeness, we can say "Make your changes with `git rebase -i`. 
Actions that you have to select in the todo editor of rebase depend on 
reviewers' comments. For example, if they asked to squash a commit into 
previous one, say `pick` on the latter and `squash` on the former."

>   ----
> -$ git format-patch -v2 --cover-letter -o psuh/ master..psuh
> +$ git format-patch -v2 --cover-letter -o psuh/ --range-diff master..psuh-v1 master..
>   ----
>   
> -This will add your v2 patches, all named like `v2-000n-my-commit-subject.patch`,
> -to the `psuh/` directory. You may notice that they are sitting alongside the v1
> -patches; that's fine, but be careful when you are ready to send them.
> +The `--range-diff master..psuh-v1` parameter tells `format-patch` to include a
> +range-diff between `psuh-v1` and `psuh` (see linkgit:git-range-diff[1]). This
> +helps tell reviewers about the differences between your v1 and v2 patches.
> +
> +The `-v2` parameter tells `format-patch` to output "v2" patches. For instance,
> +you may notice that your v2 patches, are all named like
> +`v2-000n-my-commit-subject.patch`. `-v2` will also format your patches by
> +prefixing them with "[PATCH V2]" instead of "[PATCH]", and your range-diff will
> +be prefaced with "Range-diff against v1".
> +

More accurately, `-v 2` marks the patchset as second iteration of it.

> +Afer you run this command, `format-patch` will output the patches to the `psuh/`
> +directory, alongside the v1 patches. Using a single directory makes it easy to
> +refer to the old v1 patches while proofreading the v2 patches, but you will need
> +to be careful to send out only the v2 patches. We will use a pattern like
> +"psuh/v2-*.patch" ("psuh/*.patch" would match v1 and v2 patches).
>   
>   Edit your cover letter again. Now is a good time to mention what's different
>   between your last version and now, if it's something significant. You do not
> @@ -1082,7 +1101,7 @@ to the command:
>   ----
>   $ git send-email --to=target@example.com
>   		 --in-reply-to="<foo.12345.author@example.com>"
> -		 psuh/v2*
> +		 psuh/v2-*.patch
>   ----
>   
>   [[single-patch]]
> 


-- 
An old man doll... just what I always wanted! - Clara
