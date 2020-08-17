Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21118C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 20:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE0A720674
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 20:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lZZEiV2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgHQUWk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 16:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgHQUWj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 16:22:39 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC23C061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 13:22:39 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id y185so11464304pfb.3
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 13:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IEjK08vVDFkjygdiRw51RMUrYpa4AKlaQvqpgNtX6rY=;
        b=lZZEiV2j++6HjjnU1ayvhCrfCd7AGb9+1ftu63poIDp8KcFZ1Ljb+0IwLK4QU8Eq4f
         lwbTl2yFUPfa66NuSRhIpJwgdF0VDNo8MtaM/25CcixRlSO77m5j88TVtiesQf4K+/Ha
         0elBO85n/hy5Fl56tixFqBgajFgVCG8W89x8A/FAe2a8AdcTiZAU7ITne5MXb7bLKAHx
         +FCmMeiTwQT2y4fsxyt0uoGv8l+RkzCSnAOkHCjaJsUZBAVEwPvURYRUvtckgai1vZ0t
         6iuF7Up/CWTuQ0aFDGQtJvmp1RJSjHVSBW7CxnKQWRJ9ZIzDZFIKI/FWcvwSYMxfmKzH
         +6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IEjK08vVDFkjygdiRw51RMUrYpa4AKlaQvqpgNtX6rY=;
        b=bc6XvjEZlhO/Z1SCh265yLyi9CIxbNQAmW58Vjc6EI+J2o8hn+xM10vWjzqBAEgYbt
         q+nyO2e+ZhgYe3GFyccyCnDlny7N7m/e+ulFrgB68BUIwoCXWOQAAYwhPaRPC++oi14Q
         91DrBgDZ6RFCyRKLV1ZiMbZ7ENObRLEb+aYCimx4qYEHpwJoGqzQlNgyvBEFx3sZKIW9
         zGo5H4zA1brdWZTxpRRhGX8nQ8OdB3jcq47huYuwO+qKFlDbf9iEMTG0o9Rre5fTDFZ7
         LFk4nK8eBsrkImj9e4vHr9N56TdY+ZNT4CesBpNwUmPNTt5iNBi5k3xUtldKFaQmcvm7
         K9Kg==
X-Gm-Message-State: AOAM532PKGXt0SBdkq3VaRkEW7nBt9KBh7E7dHjrEyLruNnvb3HywucZ
        8MFYAlhmK7tDpaqyCPFk+LWYhJJSoL9AOa+Q6ytY
X-Google-Smtp-Source: ABdhPJxZBPF/4vsfNhNZWAn5Xy7psJ8Mhbp5j/4Yh1Rgh10YsDo56tCTg/b7tdf28otsToZIJSn5SK+ncUS8ZyknrwbP
X-Received: by 2002:a17:90a:e107:: with SMTP id c7mr14297460pjz.100.1597695758932;
 Mon, 17 Aug 2020 13:22:38 -0700 (PDT)
Date:   Mon, 17 Aug 2020 13:22:36 -0700
In-Reply-To: <CAPig+cTv4JiLt+hCSy_RqmwUwu5btTjac6+cFH=ztWeHQgHEyw@mail.gmail.com>
Message-Id: <20200817202236.1703961-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAPig+cTv4JiLt+hCSy_RqmwUwu5btTjac6+cFH=ztWeHQgHEyw@mail.gmail.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: Re: [PATCH v2 3/3] fetch-pack: make packfile URIs work with transfer.fsckobjects
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sunshine@sunshineco.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Mon, Aug 17, 2020 at 3:49 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> > +test_expect_success 'packfile-uri with transfer.fsckobjects fails on bad object' '
> > +       P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> > +       rm -rf "$P" http_child log &&
> > +
> > +       git init "$P" &&
> > +       git -C "$P" config "uploadpack.allowsidebandall" "true" &&
> > +
> > +       cat >bogus-commit <<EOF &&
> > +tree $EMPTY_TREE
> > +author Bugs Bunny 1234567890 +0000
> > +committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
> > +
> > +This commit object intentionally broken
> > +EOF
> 
> The v2 cover letter says that this now uses <<-EOF so the here-doc
> body can be indented, but that doesn't seem to be the case.

Ah, good catch. I forgot to amend my commit. If Junio doesn't do it
locally then I will send out a v3.
