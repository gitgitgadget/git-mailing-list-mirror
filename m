Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0389AC47257
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7344206A4
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="UCyz1R+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbgEEQOp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 12:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbgEEQOo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 12:14:44 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BB6C061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 09:14:44 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id z6so1003660plk.10
        for <git@vger.kernel.org>; Tue, 05 May 2020 09:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wzexbmqro0cJQZAd/edErVVGk81OhKUYQHVxrGTQrBU=;
        b=UCyz1R+DSEzRdKkLixYorLyAjWx1fXCqtj1oSo6b23G/iTpqhdFkL36R1nFUhZ/kCj
         09nc9G6W75I47CyTPNsdGDBMnn7uNx6hO0oYo+eRfP31VOJI7Wis4m4Aa98nSBsjoKqn
         yV3ImNIC+5DPaDOsNfZzhn8bq+jdq4eWbMqQzLRUWcMs0oOYoTY1Mf45hzXpf//x8VI5
         V8Kz8qNxT9zx7OSaqjh2Y4PUCJJMgqzFK/dV7eNwslHzgdAx0ges4Yxgh+VLmrakrVc2
         jU3Vk39/eXWgJ8tQnwFor58ueUmoa8JcBdzykEXgnf7Ha6YA0qHq/Ra5x76KHx7d8oWt
         /L4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wzexbmqro0cJQZAd/edErVVGk81OhKUYQHVxrGTQrBU=;
        b=XDa2k3IapBspDht6KCvmUzA8M2r3ml2zYFEkuaFvUoC1t0ACAyRAbXDWHloGP9M+b+
         fnyfidR1UjFOxFs0oHTXh8hAIhShKXcIidN4VN4clBzthXOXiXWsBvueyFs9OOgR85+C
         99x/+Wrq6Hb0W/13bYPMcHbqSEm2VlZmYl5tuX3ktQJttm0UPl1J3ef/3pKEl/Rmcr5G
         NzbAjYIc6bGjb+P4m51Eq2yBGTY4Reh+OTG4gSzF2UWFIEVDClnv8pelGE1CgFihVzk8
         DxqeUb80YtCr6cnYP9S2frX+dVZN3YiqwHBA/6lnyCX0H4zPBFFUW8feoubnxxa1M5oK
         sHsw==
X-Gm-Message-State: AGi0PubXvzLJefOcLvmZVBufQW7ilKcz8JwSohjjh2UiCKfE5ktS38DF
        utrK39VdN1IgKl6dWABSfgY0jw==
X-Google-Smtp-Source: APiQypJrWriPamwBOQA2SUQRuVsrskUl8bExeZkakVZSOtRG4cxw1oaLbGUBjUgIO9SspnpZJ/qvjA==
X-Received: by 2002:a17:90a:4fc5:: with SMTP id q63mr3872724pjh.70.1588695283650;
        Tue, 05 May 2020 09:14:43 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id t21sm1837194pgu.39.2020.05.05.09.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 09:14:42 -0700 (PDT)
Date:   Tue, 5 May 2020 10:14:41 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: Re: [PATCH 5/8] builtin/commit-graph.c: dereference tags in builtin
Message-ID: <20200505161441.GF69300@syl.local>
References: <cover.1588641176.git.me@ttaylorr.com>
 <513a634f14e90ec0c2e80a6aaf8cb66bbedf8966.1588641176.git.me@ttaylorr.com>
 <1b0bf610-640e-de4e-ab31-ca8719d533f7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b0bf610-640e-de4e-ab31-ca8719d533f7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 05, 2020 at 08:01:29AM -0400, Derrick Stolee wrote:
> On 5/4/2020 9:13 PM, Taylor Blau wrote:
> > @@ -228,18 +240,25 @@ static int graph_write(int argc, const char **argv)
> >  		if (opts.stdin_commits) {
> >  			oidset_init(&commits, 0);
> >  			flags |= COMMIT_GRAPH_WRITE_CHECK_OIDS;
> > +			if (opts.progress)
> > +				progress = start_delayed_progress(
> > +					_("Analyzing commits from stdin"), 0);
> The code functions as you intend and is an improvement. Similar to my
> earlier suggestion to use something like "Collecting referenced commits"
> for the --reachable case, perhaps this could be "Collecting commits from input"?

Yep, making these consistent with one another is a good thing to do,
thanks.

> Thanks,
> -Stolee

Thanks,
Taylor
