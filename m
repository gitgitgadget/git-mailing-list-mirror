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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF61C433FE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 03:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7014F23EF5
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 03:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405230AbgLKDlB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 22:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395182AbgLKDki (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 22:40:38 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E6FC061793
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 19:39:58 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id y24so7076958otk.3
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 19:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ULLIJcjz8hTTz1XR6QEE0cmVHCA6TShDeoDN1rIofPo=;
        b=TRu9HbfRA1ljNSjIhRU1R0jN3hKfBNwrqh1ehHJSHFRLv/5vz0AV8LAwkcKRHWnss6
         y0qatZyp0/sCXvlSnV24D/1a/n6oJkZyh7lXdd6vT8bcdqsoVykt4bgsV11ludkHFCTE
         zYqh2LNiTZc2RV1G4ptq4OpB4bCHuPkt934Gxl3GP+chYHPEYuAbVTRc2Xs4UBWutb8B
         cswOINbCKGE6l+1yNyZJOFXCFAFXBEWd1b6zcMZO1bpJUqBQyYP/5mallmriAKF6tTmr
         LeI3TXwia9cieM1P1Qn/MnZgMBZUOepDBw9Ah4Vo0NAOed/dM+aadAf0Eir1aBZtUIXw
         73tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ULLIJcjz8hTTz1XR6QEE0cmVHCA6TShDeoDN1rIofPo=;
        b=ZPyQFfQEblbGDcfF1ZjhnicpYYhsvadrszk67qO/ESbJ4ayUkMHo2ySsRxPnlXDeNS
         ZoeB0wbpu16+k+V8Xu8SJ3JeT2ea8e/6pFfe73VC7qwg+euKs4tyoJb69qdD9V4TAL2s
         K57NkrctlV9iEx2HeV0i7qjfWPDcgnEBMQ3/BPBwQonpYsnka7Hd+F5swGuQQDTrabXD
         tyWqlCiRU/VTWxmOiZveJM3c06Bk3cFZscwEu9JwyiqEBrOKlmr1+oPisPEUc7V2Vy2C
         VAMILpwgIO92N6N12EkfBViiWDyu22IEycNikIxCGf9lKCMIEyJ2rvouFkw/U7eixKGT
         iZPw==
X-Gm-Message-State: AOAM532dCNRs7uPmASfJWLKa3XmzOlnufXvEK4WZbDomX+XXiFzQriLv
        w6LdTJ1G8vClBkwwoxxA2XuiZZ3Y2mgClw==
X-Google-Smtp-Source: ABdhPJzvQr6bQlSjigQ/Mwi264havEcN2PUQngIcp/ux3X565dBnWsKw6GzxgYqvx9NwOphmnd8UFQ==
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr8718666ote.132.1607657997758;
        Thu, 10 Dec 2020 19:39:57 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:585e:c315:5afa:f8a1? ([2600:1700:e72:80a0:585e:c315:5afa:f8a1])
        by smtp.gmail.com with UTF8SMTPSA id j8sm1514051oif.55.2020.12.10.19.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 19:39:57 -0800 (PST)
Subject: Re: [PATCH 07/11] merge-ort: add implementation of both sides
 renaming differently
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
 <d4595397052568ea6ea0cf46190374c74140fed7.1607542887.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5b9f5db0-b4d5-f60d-b5c5-2f8376d4bf12@gmail.com>
Date:   Thu, 10 Dec 2020 22:39:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <d4595397052568ea6ea0cf46190374c74140fed7.1607542887.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/9/2020 2:41 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Implement rename/rename(1to2) handling, i.e. both sides of history
> renaming a file and rename it differently.  This code replaces the
> following from merge-recurisve.c:
> 
>   * all the 1to2 code in process_renames()
>   * the RENAME_ONE_FILE_TO_TWO case of process_entry()
>   * handle_rename_rename_1to2()
> 
> Also, there is some shared code from merge-recursive.c for multiple
> different rename cases which we will no longer need for this case (or
> other rename cases):
> 
>   * handle_file_collision()
>   * setup_rename_conflict_info()
> 
> The consolidation of five separate codepaths into one is made possible
> by a change in design:

Excellent!

>  			/* This is a rename/rename(1to2) */
> -			die("Not yet implemented");
> +			clean_merge = handle_content_merge(opt,
> +							   pair->one->path,
> +							   &base->stages[0],
> +							   &side1->stages[1],
> +							   &side2->stages[2],
> +							   pathnames,
> +							   1 + 2 * opt->priv->call_depth,
> +							   &merged);

(this method currently die()s. ok)

> +			if (!clean_merge &&
> +			    merged.mode == side1->stages[1].mode &&
> +			    oideq(&merged.oid, &side1->stages[1].oid)) {
> +				was_binary_blob = 1;
> +			}

nit: Extraneous braces?

> +			memcpy(&side1->stages[1], &merged, sizeof(merged));
> +			if (was_binary_blob) {
> +				/*
> +				 * Getting here means we were attempting to
> +				 * merge a binary blob.
> +				 *
> +				 * Since we can't merge binaries,
> +				 * handle_content_merge() just takes one
> +				 * side.  But we don't want to copy the
> +				 * contents of one side to both paths.  We
> +				 * used the contents of side1 above for
> +				 * side1->stages, let's use the contents of
> +				 * side2 for side2->stages below.
> +				 */
> +				oidcpy(&merged.oid, &side2->stages[2].oid);
> +				merged.mode = side2->stages[2].mode;
> +			}
> +			memcpy(&side2->stages[2], &merged, sizeof(merged));
> +
> +			side1->path_conflict = 1;
> +			side2->path_conflict = 1;
> +			/*
> +			 * TODO: For renames we normally remove the path at the
> +			 * old name.  It would thus seem consistent to do the
> +			 * same for rename/rename(1to2) cases, but we haven't
> +			 * done so traditionally and a number of the regression
> +			 * tests now encode an expectation that the file is
> +			 * left there at stage 1.  If we ever decide to change
> +			 * this, add the following two lines here:
> +			 *    base->merged.is_null = 1;
> +			 *    base->merged.clean = 1;
> +			 * and remove the setting of base->path_conflict to 1.
> +			 */
> +			base->path_conflict = 1;

I'm getting the point of the review/evening where I'm starting to gloss
over these important details. Time to take a break (after this patch).

> +			path_msg(opt, oldpath, 0,
> +				 _("CONFLICT (rename/rename): %s renamed to "
> +				   "%s in %s and to %s in %s."),
> +				 pathnames[0],
> +				 pathnames[1], opt->branch1,
> +				 pathnames[2], opt->branch2);

This output differs a bit from handle_rename_rename_1to2() in
merge-recursive.c:

	output(opt, 1, _("CONFLICT (rename/rename): "
	       "Rename \"%s\"->\"%s\" in branch \"%s\" "
	       "rename \"%s\"->\"%s\" in \"%s\"%s"),
	       o->path, a->path, ci->ren1->branch,
	       o->path, b->path, ci->ren2->branch,
	       opt->priv->call_depth ? _(" (left unresolved)") : "");

How much do we want to have _exact_ output matches between the
two strategies, at least in the short term?

> @@ -1257,13 +1309,13 @@ static void process_entry(struct merge_options *opt,
>  		int side = (ci->filemask == 4) ? 2 : 1;
>  		ci->merged.result.mode = ci->stages[side].mode;
>  		oidcpy(&ci->merged.result.oid, &ci->stages[side].oid);
> -		ci->merged.clean = !ci->df_conflict;
> +		ci->merged.clean = !ci->df_conflict && !ci->path_conflict;
>  	} else if (ci->filemask == 1) {
>  		/* Deleted on both sides */
>  		ci->merged.is_null = 1;
>  		ci->merged.result.mode = 0;
>  		oidcpy(&ci->merged.result.oid, &null_oid);
> -		ci->merged.clean = 1;
> +		ci->merged.clean = !ci->path_conflict;

These exist because this is the first time we assign path_conflict.
Sure.

Thanks,
-Stolee

