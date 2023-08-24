Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC47C6FA8F
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 17:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242846AbjHXRbx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 13:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242862AbjHXRbl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 13:31:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332FC19BA
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 10:31:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7493303b5cso86656276.2
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 10:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692898298; x=1693503098;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4uUMJR6m5P3z7KXAEhU92/fJswe7SmRzMNteARwHxXU=;
        b=TBngpS8SQsYaH9tiRSJEx9DEyJSNafNX/d3fPTufdxjCF/P9ry22fZmPYS363zarDQ
         cvgUIJfMmZ7eUaOwsAh3IqXoE4n29jQ51Mr6k8JWG5Hh1f0b9kqHBOuzNEo2lseW3FJW
         iTPBVJQd3qROkEED6tmFLWrZBxpKqi8Cro43qnOzUQmfZHvkO9cJHijxu1laU0Z/gPBQ
         ieNj/0V9wnU25aq4SauaarFeVILvDlgnlGLtK8e9sT0HklvIrLVNpW6RBH4Ob3a74f5S
         G4XK6qELeADhG7MegLeOfWPYIayt+UPDZicCWN27B94mi86hGwMySGulzpal/agSkeZj
         95MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692898298; x=1693503098;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4uUMJR6m5P3z7KXAEhU92/fJswe7SmRzMNteARwHxXU=;
        b=FOqTpLAJO6K2lP9kM5WJyoBm+JDcLRhsODzi1fX/AviXQIb3vXr4kxk+jHxH7QuSd+
         L965LO9Hw87ptm1D5Nw5foqYZ1KoLOJOjUXaaRvlZcyrg54mLGm2+5AVidv7grgto8rB
         BOwLInRCr4OgBSwUK8J8I71uF2joIuX3AemMG3lc8esy4L6gvKtcac4pdD998Jaobaev
         /k4SPuiRA/IB8oi0lZNSBjZW2wYINtre24gShr4/kFY+zSMsjz3fcfxX30EfBvOUiGMA
         Q9yi5iu8caRZyhCLsoBv70X3r9D2ZLL+cmGeg/G9CaQrmCnTjqksCetehc97yghsfHNh
         +46g==
X-Gm-Message-State: AOJu0YxxG+2XktIE2bSUZC1IHAqkealmhiARO9U8FRKxlXSt0kyT9jPQ
        B5OHKKb+ZeaLi2Jr+Nwy5lR9fRmawbtFQZ1ON3XJ
X-Google-Smtp-Source: AGHT+IHPfA/+sDmryMPj027JPcJ2Y+W5qR7d/ky0cNph5xeTo5gnjw2ZK8kRtfruQrR58svxfokIqwwoW3rXDQarH3WR
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:d0eb:2757:7b54:470])
 (user=jonathantanmy job=sendgmr) by 2002:a25:ef4c:0:b0:d4c:fe4d:31ff with
 SMTP id w12-20020a25ef4c000000b00d4cfe4d31ffmr220584ybm.8.1692898298471; Thu,
 24 Aug 2023 10:31:38 -0700 (PDT)
Date:   Thu, 24 Aug 2023 10:31:36 -0700
In-Reply-To: <xmqqttspck4a.fsf@gitster.g>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230824173136.2252024-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 2/4] config: report config parse errors using cb
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        calvinwan@google.com, glencbz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> > @@ -1035,8 +1088,6 @@ static int git_parse_source(struct config_source *cs, config_fn_t fn,
> >  	int comment = 0;
> >  	size_t baselen = 0;
> >  	struct strbuf *var = &cs->var;
> > ...
> > +	/*
> > +	 * FIXME for whatever reason, do_event passes the _previous_ event, so
> > +	 * in order for our callback to receive the error event, we have to call
> > +	 * do_event twice
> > +	 */
> > +	do_event(cs, CONFIG_EVENT_ERROR, &event_data);
> > +	do_event(cs, CONFIG_EVENT_ERROR, &event_data);
> > +	return -1;
> >  }
> 
> This indeed is very curious and needs to be looked into before we
> proceed further.  How does the current control flow cope with the
> behaviour?

I plan to look at this more fully later, but about this, I wrote about
this in a reply to the previous version:
https://lore.kernel.org/git/20230804213457.1174493-1-jonathantanmy@google.com/
