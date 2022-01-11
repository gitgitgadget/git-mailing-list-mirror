Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE76C433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 18:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350282AbiAKS5K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 13:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242717AbiAKS5J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 13:57:09 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124C3C06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 10:57:09 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso2048652wmj.2
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 10:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8bWchWtlDvf7z1xlIHoZ9tvFCQhiQQN6/ovclM8xjRM=;
        b=pujE91EmSBT+nA4ZAQ9k4/5Vn0Klih8+e/vs7/STRwAoV7aQ1VzR8HB5H5VK1U4aqW
         CSxpbGRPoHdlsRkqCUbEyG4ICaa1zivFwyAsVMp+BqdbINT2CJ7oirRdJa68SLuU0Ecs
         twkIxOgbjlWnStMA+ug2ODa3Tf/FssGJjChy2vnsApvrq/hpyvmuY6MCf1uvfyEb0/jB
         skoMBv4uWv9XXkfpNxrJAgjlJGDga2HZ2sHDV5ntmxaWQN0+MsiZzA89owmxtIwWnVWm
         j/zom9o277uFDOiwQPfLpx7B4Ak5iyMcBogVp5h0DEcSSjTXXfXxTbpvz7nV0HP1fev3
         DFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8bWchWtlDvf7z1xlIHoZ9tvFCQhiQQN6/ovclM8xjRM=;
        b=3ErECIviNTTVBybCwza4jkvZacjydIW1p5RruqlQ9/MvEoxZ2sVm0lZGVEfWy1Bpjy
         5U8RoVHJ/ouqm91Os9eQzIAPj8UZxjV9+V8GluKV233QNEpVKWkHjvEtSaz74uHx8LQf
         Mvw+36uJ2qSTtOur7HESI9g/0p++fDYr/bvfFD3Spe5qkBxmn8mFybJsCWuvDSGxWmrO
         OYRsairIngzphqGKRsbr/fMnp+n41/JxYREuFZNHqoHCBXeiA+fJpT2t7jzrRyzDebrV
         jOgbsxeuariirW//yn0r4DoSdOJQYJueJL1mH/PeqDUyvdSD/oLDBjh1Zj+/YYH/35rY
         aVDw==
X-Gm-Message-State: AOAM532gzEW/+5YekiFn8EQYZbKPbgBbZ6ZJXEXJ+WyWfVFvVfLt19ZP
        SnlhMtnpBniOHQ1Nnrq4cKg=
X-Google-Smtp-Source: ABdhPJzFO7maUNCqLfnj6WAx2dH8nT9yrkLZMSv+6uN65h3MDru+/8tksfPkTAohpurMGQhCLvCy+w==
X-Received: by 2002:a1c:4644:: with SMTP id t65mr3575496wma.19.1641927427667;
        Tue, 11 Jan 2022 10:57:07 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id n7sm2431108wms.46.2022.01.11.10.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 10:57:07 -0800 (PST)
Message-ID: <348d37a3-f01b-cda6-8ce4-1536e0bd3b06@gmail.com>
Date:   Tue, 11 Jan 2022 18:57:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/2] builtin add -p: fix hunk splitting
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1100.git.1640010777.gitgitgadget@gmail.com>
 <pull.1100.v2.git.1641899530.gitgitgadget@gmail.com>
 <220111.861r1ezcxn.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220111.861r1ezcxn.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 11/01/2022 12:07, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Jan 11 2022, Phillip Wood via GitGitGadget wrote:
> 
>> Thanks to Junio and Ævar for their comments on V1. I've updated the commit
>> message and added a helper function as suggested.
> 
> This v2 LGTM as far as the functionality of the end-state is concerned.

Thanks for taking a look

> As a remaining nit the complete_file() helper you introduce in 2/2
> changes 2/4 places that increment "hunk->splittable+into".
> 
> I grabbed this PR and came up with this amendmend to it which adds a 2/3
> step that converts 3/3 of them, followed by adding the 4th user in your
> 2/2 (now patch 3/3):
> https://github.com/git/git/compare/master...avar:phillipwood-avar/wip/add-p-fix-hunk-splitting-v2.1
> 
> It changes nothing as far as the end-state is concerned, but I think it
> makes this easier to read & follow. The actual behavior change becomes a
> one-line addition to add-patch.c, instead of being mixed up with the
> refactoring of adding the new helper.
> 
> If you'd like to pick that up & run with it as a v3 that's fine by me,
> and if not that's also fine :) Just a suggestion.

I'm not sure I want to go with your extra changes. I've left some
comments on them below

> @@ -488,12 +499,12 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>  	else if (starts_with(p, "@@ ") ||
>  		 (hunk == &file_diff->head &&
>  		  (skip_prefix(p, "deleted file", &deleted)))) {
> -		if (marker == '-' || marker == '+')
> -			/*
> -			 * Should not happen; previous hunk did not end
> -			 * in a context line? Handle it anyway.
> -			 */
> +			hunk->splittable_into++;
> +		/*
> +		 * Should not increment "splittable_into";
> +		 * previous hunk did not end in a context
> +		 * line? Handle it anyway.
> +		 */
> +		complete_file(marker, &hunk->splittable_into);
>  
>  		ALLOC_GROW_BY(file_diff->hunk, file_diff->hunk_nr, 1,
>  			   file_diff->hunk_alloc);

I deliberately left this alone as I think we should probably make this
BUG() out instead of silently accepting an invalid diff.

> @@ -566,8 +577,8 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>  			    (int)(eol - (plain->buf + file_diff->head.start)),
>  			    plain->buf + file_diff->head.start);
>  
> -		if ((marker == '-' || marker == '+') && *p == ' ')
> -			hunk->splittable_into++;
> +		if (*p == ' ')
> +			complete_file(marker, &hunk->splittable_into);
>  		if (marker && *p != '\\')
>  			marker = *p;
  
Here you are calling complete_file() which has the following comment

      /*
       * Last hunk ended in non-context line (i.e. it
       * appended lines to the file, so there are no
       * trailing context lines).
       */

for all context lines so the function name and comment would need
updating.

Best Wishes

Phillip

> A range-diff between your v2 here and that linked-to
> phillipwood-avar/wip/add-p-fix-hunk-splitting-v2.1:
> 
> 1:  cc8639fc29d = 1:  34392397f04 t3701: clean up hunk splitting tests
> -:  ----------- > 2:  c082176f8c5 add-file.c: use static helper to check marker == +|-
> 2:  b698989e265 ! 3:  defca0baba4 builtin add -p: fix hunk splitting
>      @@ Commit message
>           Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>       
>        ## add-patch.c ##
>      -@@ add-patch.c: static int is_octal(const char *p, size_t len)
>      - 	return 1;
>      - }
>      -
>      -+static void complete_file(char marker, struct hunk *hunk)
>      -+{
>      -+	if (marker == '-' || marker == '+')
>      -+		/*
>      -+		 * Last hunk ended in non-context line (i.e. it
>      -+		 * appended lines to the file, so there are no
>      -+		 * trailing context lines).
>      -+		 */
>      -+		hunk->splittable_into++;
>      -+}
>      -+
>      - static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>      - {
>      - 	struct strvec args = STRVEC_INIT;
>       @@ add-patch.c: static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>        			eol = pend;
>        
>        		if (starts_with(p, "diff ")) {
>      -+			complete_file(marker, hunk);
>      ++			complete_file(marker, &hunk->splittable_into);
>        			ALLOC_GROW_BY(s->file_diff, s->file_diff_nr, 1,
>        				   file_diff_alloc);
>        			file_diff = s->file_diff + s->file_diff_nr - 1;
>      -@@ add-patch.c: static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>      - 				file_diff->hunk->colored_end = hunk->colored_end;
>      - 		}
>      - 	}
>      --
>      --	if (marker == '-' || marker == '+')
>      --		/*
>      --		 * Last hunk ended in non-context line (i.e. it appended lines
>      --		 * to the file, so there are no trailing context lines).
>      --		 */
>      --		hunk->splittable_into++;
>      -+	complete_file(marker, hunk);
>      -
>      - 	/* non-colored shorter than colored? */
>      - 	if (colored_p != colored_pend) {
>       
>        ## t/t3701-add-interactive.sh ##
>       @@ t/t3701-add-interactive.sh: test_expect_success 'correct message when there is nothing to do' '

