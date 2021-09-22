Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1068C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 22:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9CF6610A1
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 22:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238319AbhIVWgc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 18:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238314AbhIVWgb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 18:36:31 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8D2C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 15:35:01 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id lb1-20020a17090b4a4100b001993f863df2so3456615pjb.5
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 15:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=pGBs4qf8Lt7NBr2R+EwVKXJorf5G7xE42j2JmlsXguQ=;
        b=TMOIEJt9kTwBGW3tKipX9Tf0semH5WYZiCyk7/RkYHlcEPK1tdbj1TA14P5/1kQ0fQ
         lePYYLMM6rYbibzKRwWsj9F5IAATUFN/B15SVo9AgO4B8Id0y5WEcbBtKL7qxEUqiv/x
         41tWUZye2bS3B5rM0o/+ItYX4vaptPorb1dzgcPWotOnOjMcdJ6akkG7sfLp2h11ySPc
         pgWf2TAKhMBCAsS5e832MI7ft2Iv13z+VF9nGswVpWgGH+epK6aKV8ssoiS3WzyhIEW7
         E6UfFH1OEG6Lpv98YvSDd00VV+o119cUBc/UatKGCSxiJWrd2BnJNjEcCd8svWCfho+T
         6cpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=pGBs4qf8Lt7NBr2R+EwVKXJorf5G7xE42j2JmlsXguQ=;
        b=EiFKEhkhCQ1+WyK/PVNc0gYW7zsLsUEbkZQ1CaEqJAWCCFVSDd59AMN7W8E3fOWrL0
         NHN77FqQ0xxMfODY3WyUIoTrhcn+58Hc+maN4Delq9QYd3SR/0Dg3n3F/qVnuG1iVZJu
         IVujuYGADOQo3LHIxcehy22dijRmeIYjNMpFZAA7PxJ4wS+34FnmtQ5K58BQQOjaZhIm
         sl4xcK8SXodOKg3eUr6biRQVf9kSO05qwxUyFfjVFuLFk0OTyEGlkwKHzPyAS74VAVgi
         i9RKCJlrwA53xr0aeCy03LSbMxxaIPBV0d4CnZEoDyMFz54BTR3scgoWkPtFiA2kR/LF
         Cp0A==
X-Gm-Message-State: AOAM532yXpdnDv/tBe+bOEfP1peknceRv2GJAQekAXpKOlkqKtWmBEbr
        1QrKqj0XTrv0aqp0GzqeosuMFg==
X-Google-Smtp-Source: ABdhPJwh+1jqwciqfr+aQyrAufX/bNvuMSV4YoU76eUkqJtLNKShPwb43VbaH6XFKU6eBXjgNdyNlQ==
X-Received: by 2002:a17:90a:2b88:: with SMTP id u8mr14046219pjd.216.1632350100261;
        Wed, 22 Sep 2021 15:35:00 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:3477:59f2:e961:3ce])
        by smtp.gmail.com with ESMTPSA id j26sm3351235pfe.35.2021.09.22.15.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 15:34:59 -0700 (PDT)
Date:   Wed, 22 Sep 2021 15:34:53 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
        avarab@gmail.com
Subject: Re: [PATCH v2 3/8] midx: preliminary support for `--refs-snapshot`
Message-ID: <YUuvjZl43k3G2SBn@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        gitster@pobox.com, avarab@gmail.com
References: <cover.1631331139.git.me@ttaylorr.com>
 <cover.1631730270.git.me@ttaylorr.com>
 <42f1ae9edeb55d8e1b0c8f2c3110e9c8326a5fc1.1631730270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42f1ae9edeb55d8e1b0c8f2c3110e9c8326a5fc1.1631730270.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A small nitpick for this patch:

On 2021.09.15 14:24, Taylor Blau wrote:
> diff --git a/midx.c b/midx.c
> index 0330202fda..97ba3421f2 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -968,7 +968,42 @@ static void bitmap_show_commit(struct commit *commit, void *_data)
>  	data->commits[data->commits_nr++] = commit;
>  }
>  
> +static int read_refs_snapshot(const char *refs_snapshot,
> +			      struct rev_info *revs)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	struct object_id oid;
> +	FILE *f = xfopen(refs_snapshot, "r");
> +
> +	while (strbuf_getline(&buf, f) != EOF) {
> +		struct object *object;
> +		int preferred = 0;
> +		char *hex = buf.buf;
> +		const char *end = NULL;
> +
> +		if (buf.len && *buf.buf == '+') {
> +			preferred = 1;
> +			hex = &buf.buf[1];
> +		}
> +
> +		if (parse_oid_hex(hex, &oid, &end) < 0)
> +			die(_("could not parse line: %s"), buf.buf);
> +		if (*end)
> +			die(_("malformed line: %s"), buf.buf);
> +
> +		object = parse_object_or_die(&oid, NULL);
> +		if (preferred)
> +			object->flags |= NEEDS_BITMAP;
> +
> +		add_pending_object(revs, object, "");
> +	}
> +
> +	fclose(f);
> +	return 0;
> +}

`buf` needs to be released here.
