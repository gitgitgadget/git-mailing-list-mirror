Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBDAC433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 18:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377323AbiBDSCh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 13:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241744AbiBDSCg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 13:02:36 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4E6C061714
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 10:02:36 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id r9-20020a6560c9000000b00343fa9529e5so3271638pgv.18
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 10:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I4sm5N66uBxVzfadAcJYyC/pTFmjSFwFE++8+A0F8Lw=;
        b=F7+wi/uJIqekNh658txvdQbMy8kCKbQ99ta9R/dgWyr8C3JMtHshp4FR8+z2Gcz1W1
         QD5aYN3TOvFHcbSfSuCRvYTNAPmGO3CDi3fHvNS+Qz137oJJu/mHMSpCRL/PZWY72jN8
         ZM1db12ifOAU4SI9/BdeOOQnew7rzH56ASku+qFTe1dCeFTPguHHK1KVALuiHJb+NDje
         XM9q6FbgWGOcFgJf8v6rygud0nop4jAY0TmowXMFKV3Ty2BKC+g/yLhXWhgGViTWA59B
         hU+MvCjs35bMLyfYX7hGWlg4JmzBfSMk5QCpMJbD8YJvE3R89IMlsk5mr92+OfI3swdA
         JPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I4sm5N66uBxVzfadAcJYyC/pTFmjSFwFE++8+A0F8Lw=;
        b=qo2NUzhtbxcO1lO+wc7jozQMtbnhGhlmIWOfVIpkRD+HsiMpzf3ylO4EqAopevan0Z
         PZghCGMtvzn/cJhxa6xI493+pQQXgyx4N1vDWHp0J7uA5fRIJlCUqP6SsHKtnrb3y9W/
         iYJcVMV1zM+RlHaWvercqe3I1ZdbuLxBOo6rZTsPQ8CW3N25pDvQv0AXVhAT4sWxgN+5
         GDAuBT09ByXms9gd/MfcIs/CxnxzkXvjgVRgVIkP6AVIEcJn6n/ShUxHMs0k9vf9eDlg
         sSnKdJcGkmGDLARXeWPNfbQbxP5UZoj86BCr9RhZ1T2bKMEAUMaPP4i3VV4pdg7AhCJx
         jfnw==
X-Gm-Message-State: AOAM5330ilAejWDlcg+ieAGySLj6kTCc2w3rtZCZ6fsHPqhlpYwVyJso
        Vw9Fq/pSiDst90vT29hmsH0S689uTBMee1tkAB34
X-Google-Smtp-Source: ABdhPJzDPOGE/cdlLqBtVH/lZx02MfmzsevyT3ifSzu7f1BAjWdadSnGYlw0cVVtDElnEMi5OKvoOcp1GeoBpVdE6o6K
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:1a4f:: with SMTP id
 h15mr4240638pfv.50.1643997756097; Fri, 04 Feb 2022 10:02:36 -0800 (PST)
Date:   Fri,  4 Feb 2022 10:02:30 -0800
In-Reply-To: <a3c1999936d241fdec2a958cd5a4ebc21f4c7aec.1643730593.git.gitgitgadget@gmail.com>
Message-Id: <20220204180230.2346654-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <a3c1999936d241fdec2a958cd5a4ebc21f4c7aec.1643730593.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: Re: [PATCH 2/6] fetch-pack: add partial clone refiltering
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, stolee@gmail.com,
        me@ttaylorr.com, christian.couder@gmail.com, johncai86@gmail.com,
        robert@coup.net.nz
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert Coup via GitGitGadget" <gitgitgadget@gmail.com> writes:
> @@ -312,19 +312,21 @@ static int find_common(struct fetch_negotiator *negotiator,
>  		const char *remote_hex;
>  		struct object *o;
>  
> -		/*
> -		 * If that object is complete (i.e. it is an ancestor of a
> -		 * local ref), we tell them we have it but do not have to
> -		 * tell them about its ancestors, which they already know
> -		 * about.
> -		 *
> -		 * We use lookup_object here because we are only
> -		 * interested in the case we *know* the object is
> -		 * reachable and we have already scanned it.
> -		 */
> -		if (((o = lookup_object(the_repository, remote)) != NULL) &&
> -				(o->flags & COMPLETE)) {
> -			continue;
> +		if (!args->refilter) {
> +			/*
> +			* If that object is complete (i.e. it is an ancestor of a
> +			* local ref), we tell them we have it but do not have to
> +			* tell them about its ancestors, which they already know
> +			* about.
> +			*
> +			* We use lookup_object here because we are only
> +			* interested in the case we *know* the object is
> +			* reachable and we have already scanned it.
> +			*/
> +			if (((o = lookup_object(the_repository, remote)) != NULL) &&
> +					(o->flags & COMPLETE)) {
> +				continue;
> +			}

The approach that I would have expected is to not call
mark_complete_and_common_ref(), filter_refs(), everything_local(), and
find_common(), but your approach here is to ensure that
mark_complete_and_common_ref() and find_common() do not do anything.
Comparing the two approaches, the advantage of yours is that we only
need to make the change once to support both protocol v0 and v2
(although the change looks more substantial than just skipping function
calls), but it makes the code more difficult to read in that we now have
function calls that do nothing. What do you think about my approach?
