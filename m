Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDAEC433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 02:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhKWCPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 21:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbhKWCPe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 21:15:34 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43ADC061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 18:12:26 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id u4-20020a056a00098400b004946fc3e863so10866574pfg.8
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 18:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=icTdWZSWGvZcbw1DcmpZR6KYm9nBIeR+7RGNgwdaYKo=;
        b=VfY1Q37zgurxODbMWToUttwoDbVZUdgkxCiQXZ/eXVeKPpOWXRoeWVKCfd60EA11TI
         cdk6Nd9xUMz/cN1Rgu2u7Xf0cYjyBXMa9HVj18ejooqun409PXGJgAwP+F3fUGk6yYHZ
         hwMfsz1Lq55NMwUGNsa8iZqBzOI4XD/YHR4DNz7FPMSUFSWv3AXpq4lAu0LqV+diRydX
         VGTtJuoGQbcl4g2ZjBiQAoXPbSXi3GE5HDIDQnIvnDg88wjmpEwnwyG0V6p7zHAxSBiW
         Vk6b7o4HNeTUSGxpz1xLCRgBpHtXqSU2VWAmsQn7CmHADYOBcQpBVnLcU6BvC1/1673u
         LWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=icTdWZSWGvZcbw1DcmpZR6KYm9nBIeR+7RGNgwdaYKo=;
        b=q+ZFiK9o5AR7Cu8kLvFGCYmR/muee/c9QjIZq+Sh2R+6nBxwg3CPxSd/lrMaPLCcM0
         CvmkQsjxH71x8edt08mR9zIs09oF65K3fRdcSbCx+/ZEngzJ9QtXELxahINzBqPmgsjI
         e4rcntiL9NGtBbIdRD7d7g+dOb8y4MKafCq8quz18Hbga+5iKsIDM59YKK6ZktmR1hKZ
         efu7ChN26+U2YII7jUG8EWQQh6D1RbGcMpvoHl+N95GE7B90sYdcP8QWA0ESxQyYjM7X
         3JGoZQbVPeQMC+xiLjZL11mE2rwWem+go6fxaxfi/M7xJUDJ17NbtWzniE1KSHHioyLn
         Be6A==
X-Gm-Message-State: AOAM532LC9OuAl+OrE+e+mV4HjqXL7kBPsdTk1END6BWs/UzH3NEkRmM
        bY5/Hv9/8loDT0p8m3c2PrthCjTZcpOogzyj9Ogc
X-Google-Smtp-Source: ABdhPJzKcQ9F3EWc2CBanf6Vm06eEzbClcTU/OoEy02W4aXq1EjNc2KijCa+hoBBXmoLg/UyylrtGBb9RcD8MvPA9hi1
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:9349:b0:143:88c3:375e with
 SMTP id g9-20020a170902934900b0014388c3375emr2475779plp.16.1637633546373;
 Mon, 22 Nov 2021 18:12:26 -0800 (PST)
Date:   Mon, 22 Nov 2021 18:12:23 -0800
In-Reply-To: <20211122223252.19922-2-chooglen@google.com>
Message-Id: <20211123021223.3472472-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20211122223252.19922-2-chooglen@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: Re: [PATCH 1/4] submodule-config: add submodules_of_tree() helper
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, steadmon@google.com,
        emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> +struct submodule_entry_list *
> +submodules_of_tree(struct repository *r, const struct object_id *treeish_name)
> +{
> +	struct tree_desc tree;
> +	struct name_entry entry;
> +	struct submodule_entry_list *ret;
> +
> +	CALLOC_ARRAY(ret, 1);
> +	fill_tree_descriptor(r, &tree, treeish_name);
> +	while (tree_entry(&tree, &entry)) {

I think that tree_entry() doesn't recurse into subtrees, but in any case we
should test this. (I looked at patch 4 and I think that the submodules are
always in the root tree.)

This reminded me of a similar thing when fetching submodules recursively and we
needed the "before" and "after" of submodule gitlinks. You can look at the code
(collect_changed_submodules_cb() and the functions that use it in submodule.c)
but it may not be useful - in particular, that uses diff since we need to see
differences there, but we don't need that here.

I'll review the other patches tomorrow.
