Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF8BC4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 23:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42E5223382
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 23:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbgLPXz1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 18:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgLPXz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 18:55:27 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42DDC061794
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 15:54:46 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id ba10so3229227plb.11
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 15:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=uv5lt73DSuGrA8yISvk9KQzyt86gDMX9Z6UGao922Jk=;
        b=lhnK2UMMj+ayyLke/wypwPdAU22sJvu5e3hzUvjy3FHg1UT7DcY0fqqdGSlCBhYy0H
         DKuMiwnXEhNRNAtT1ykIofkYMqxO/5p+VhLD6gp1310kCI37FeOlvbKf4GEn9nLEsMAe
         7+UjzJqPTG5hPopFsG0bEC+R7IO3e5F9SQagyAtjABq/LZew6bgAj1aAZi5w2rHgXlMH
         3BuDuG97BcTa+RpNl3Fw+rsAQ7J72wf/h18q6uuTc3KYRZ2OOovOIRQqlWxGK+fh7dVH
         7yb5FPSB1paGjZaJqNxNuqtptniGkNi6/tKFMERh/OkvcNrutWelMOPqhRVjbgtl1PBd
         7azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uv5lt73DSuGrA8yISvk9KQzyt86gDMX9Z6UGao922Jk=;
        b=mo2RyuBbnT76p0yoo0xZAeUtPw8a5BJ4i/3t3kIZmDuFlWkzmZ/zEkdcSxTGXp31JT
         6oZFx82gTrvzrFeTbVz1Bq7nHo2pbbyz0UG/6rpwgpgQZou+id70T5FwXRHrJUVkVkdo
         OdDy/4+XEVcaIUuhUXFH60Z7ztc7brEQCf02SG/P3peckR7eWsMaolMucWHWquWdv5xK
         jxd9rDvc/dxXlqRtaDcUrraFlQeSLxPbMsRoZAkeQoYvJhlJ72eQR6v+/7HAifqsxpSD
         FZsjtYGE3M/PcCUE8LsBFrBrhRa7h4EcQ+fvF1e6iF7AIqKHgT34m0Pv/rSbOeq8rD3o
         +EzQ==
X-Gm-Message-State: AOAM530NetsR3b3mNhd/uqoDtGat3s2tBb2joe5ydaKbTJxT68TSyMUH
        Oa3nRbbHBcAn6au4GIfYDJE2CsLv/M6SWAVsuESC
X-Google-Smtp-Source: ABdhPJyRwf2ByF8ivY0/Ia2Q63tYS02fohtkO1Pa7X9oxk0tfaBBdPfwfi5Xf9DQpCPFB9PxXiE+n93ES1j1J8+kf08r
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:8343:b029:dc:231e:110a with
 SMTP id z3-20020a1709028343b02900dc231e110amr1369139pln.67.1608162886170;
 Wed, 16 Dec 2020 15:54:46 -0800 (PST)
Date:   Wed, 16 Dec 2020 15:54:43 -0800
In-Reply-To: <X9pQjHrRQQqB6AFI@coredump.intra.peff.net>
Message-Id: <20201216235443.1674103-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <X9pQjHrRQQqB6AFI@coredump.intra.peff.net>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: Re: [PATCH v2 1/3] ls-refs: report unborn targets of symrefs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        felipe.contreras@gmail.com, gitster@pobox.com, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Tue, Dec 15, 2020 at 06:07:56PM -0800, Jonathan Tan wrote:
> 
> > +static int ls_refs_config(const char *var, const char *value, void *cb_data)
> > +{
> > +	struct ls_refs_data *data = cb_data;
> > +
> > +	if (!strcmp("lsrefs.unborn", var))
> > +		data->allow_unborn = !strcmp(value, "allow") ||
> > +			!strcmp(value, "advertise");
> 
> What's the reason we would want this to be configurable? I would think
> we would just want it always on for the server, and then clients can
> choose to make us of it or not (and probably not by omitting the
> capability; the question is what they want to do with the information
> about HEAD, but that is true whether it is unborn or not, and is
> controlled by options like "clone -b").

Firstly, this allows a staged rollout in load-balancing situations
wherein we turn on "allow" for all servers, then "advertise", so that we
don't end up with a client that sees the advertisement but then sends
the follow-up request to a server that has not received the latest
configuration yet.

Secondly, I wonder if some people purposely set HEAD to an unborn branch
just so that the repository would be presented as not having a HEAD.
Now, the name of the unborn branch would be revealed. I don't know if
that's a problem, though - but if it is, at least this configuration
variable is a way to solve that.

I'll include this in the documentation in a next version of this patch
set.
