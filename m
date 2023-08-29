Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08D7C6FA8F
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 17:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbjH2RB5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 13:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237584AbjH2RBe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 13:01:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7371B6
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 10:01:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d74a6dfb0deso5433823276.0
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 10:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693328491; x=1693933291;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0dA2gTz5BU8i0ChuCaxRtYqzXXRAddpPkN8ipgpCD5k=;
        b=ffx6xrWp9pv+Tl4OhtVuqm6ppK1CpaO9rUBQej62hAee8QvM4/mwLOclpanKKoW8wC
         ePC07xJeCxZaAUnhLzruadHnax8AdAzYAR0CJJVzbg5WCInCTGX4CIVYUTARF72ugVWo
         PBC+2mRZ6hqO0oBPetirIpXCkpttmskANkID7Y9iS1vNMMd5kKtCsV4MLtupk54TUzT5
         BG7esMysNrg8jMDr3oHnuVYK0NFI60MnufNIsTrNQmWEXa1xoT3RaRUrp8/CZ1pDuHuh
         Ks0sJWuVE5hn2Vtz1YOYWPg6GSwz1KfMx04nC9NcBJv7cZqvgLsBW2ePUxZPDKAX0yBc
         ZrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693328491; x=1693933291;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0dA2gTz5BU8i0ChuCaxRtYqzXXRAddpPkN8ipgpCD5k=;
        b=YKHlxhvczlr1Q3+KMYe34+SP5kRUHrzwZ4FcaSpqJrY/eEl0/1IJYOqAYIdMmsnVHg
         kdV/U3JCSnOn5/EgHSCHdEnDUQUus36V/db0X1FGyCKbx2rP+xLd1RANWtEXWwUIju1r
         l/ZtQ3UVl2is6NFL5aiV8yDllHY1BU4E12P+tbDc8/HOjcYbH512plGkGx5jfyIZjjvu
         JHiLBEsepfV74oRsQ/VHFZJVUE1jPu8X911K5CKk0Cqb3JgDqj6cvzIhd1lgRTpxI/QQ
         ZYqF9dqOvGBYZxBdblskooFYaT0PqPhfdoZ3luxF8xjICoJ8QmjwZPTfqJ2QbQW8XxoS
         FOKg==
X-Gm-Message-State: AOJu0Yxoh8FG9yKTSQQD9XL1awzM+q0B/IBBxdOJdf+QeFAtNQ4nnshQ
        RpZDYjRt8fvUtjFKopsqJNCp8TnnXILN8WuTZ/Qa
X-Google-Smtp-Source: AGHT+IFCfZJx3l90/brCFq8Ueeha1D9aVUiABK3HgzzCedW9uHfYVvFxo5akEG0qlzpF25ZcLK+z4/kSIqJcpPlwJ/EN
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:ec07:4d48:eb22:d87c])
 (user=jonathantanmy job=sendgmr) by 2002:a25:cf12:0:b0:d78:2c3:e633 with SMTP
 id f18-20020a25cf12000000b00d7802c3e633mr744864ybg.2.1693328491347; Tue, 29
 Aug 2023 10:01:31 -0700 (PDT)
Date:   Tue, 29 Aug 2023 10:01:28 -0700
In-Reply-To: <03464c34-2f83-ba26-69be-d3502ed2ed38@jeffhostetler.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230829170128.370527-1-jonathantanmy@google.com>
Subject: Re: Strange diff-index with fsmonitor, submodules
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:
> 
> 
> On 8/28/23 8:56 PM, Jonathan Tan wrote:
> > There is a strange interaction where diff-index not only produces
> > different results when run with and without fsmonitor, but produces
> > different results for 2 entries that as far as I can tell, should behave
> > identically (sibling files in the same directory - file_11 and file_12,
> > and both of these filenames are only mentioned once each in the entire
> > test).
> > 
> > You can see this with this patch:
> 
> Jonathan, what platform are you seeing this on?
> 
> Jeff

Ah, I should have mentioned this. This is on Mac OS X.
