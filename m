Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01851C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 09:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB571207D8
	for <git@archiver.kernel.org>; Mon, 18 May 2020 09:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvW4TfIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgERJS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 05:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgERJS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 05:18:29 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA09C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 02:18:29 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id l1so7461070qtp.6
        for <git@vger.kernel.org>; Mon, 18 May 2020 02:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9Vp75R3Rp8RrPJgLyTnHZuLpUeHd0j6g7cMPqQXXxkw=;
        b=GvW4TfIn7DFJanntWuj32o49Z3h9TNHArtrE24ho/QQokAiBH46bbEtmNcE7SyMdHx
         eYjetI8zUZe6H+XI0NjXb++I2l9ttqO2834PT+TQYin+Lv7cnS3mJaRnNWUBHSJXMzbR
         A93bI63X1D9yAuzyeu6GC2Ra2exazbNyRMPiY8SZQq4HJSF3E9xOcJEpZsMJbDQOcrDi
         arzWHk56hA9sIZ/31wTrR+80TQIf0ejmr94tuZFBgVVOSFILxKRiknnD/bbDeyRRs5jj
         ql2TA6Ndx/Kr1uPoIy6P2QvtdCJFu5BfOhmQ11vIjRIAHwdFQcTz8marEBd18BsKHykN
         UwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Vp75R3Rp8RrPJgLyTnHZuLpUeHd0j6g7cMPqQXXxkw=;
        b=pZal06u+C8Y2nc43kOmNjIk18Eb/6fOXfeFs56MNJ3UP23+HPCpy1YnpVQmraUmpsZ
         G3ngYU+nhbAyMAjAHXPHSsHX9zAHrKR/NWX1CA120ANt1SYxZe+cWd5aODELd7VpsdD+
         IjD/cYwT7/IBTBdG4zmhvVtseHgM4HGNNB3raqcK+MKPxnBAih/yiAWtOyJde1QO6H+C
         G3M1UC5YP1aASODvfYCaHy2QMjQ8PCpoH2FY2+BMO+BSppyqSPGgsJT1IuEYJ0JgC68a
         fGu6UmkOeA7a2s5bDYzmpfOvHMefGdSLErCvGA7ZA2kzaQWS77hwyeogkz+Lm7VWiuQ/
         k1AA==
X-Gm-Message-State: AOAM530NQwFAGD0S+WCMdsTU2P20Gql24qEkyyor+p+diHbF8de1jz9W
        sw00IkVnGl1X7ntaDh6Xa+MvzbyN
X-Google-Smtp-Source: ABdhPJyRtHfvHXcWjek8cs+3WKUNs2zxqbtzI+q3eXrh8Wl5ugg8zorkzkIKE/cJqkyXNPRchGA+aA==
X-Received: by 2002:aed:3aa3:: with SMTP id o32mr16088717qte.364.1589793508622;
        Mon, 18 May 2020 02:18:28 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id y140sm7873797qkb.127.2020.05.18.02.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 02:18:27 -0700 (PDT)
Date:   Mon, 18 May 2020 05:18:25 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] transport: combine common cases with a fallthrough
Message-ID: <20200518091825.GB24557@generichostname>
References: <cover.1589393036.git.liu.denton@gmail.com>
 <c89c1841008dfc2d111369fb682b946a0c33b7be.1589393036.git.liu.denton@gmail.com>
 <CAPig+cQyCSMtSrdk54E6MVYL4prhNyWgBKkkBFHXo5hShqQ+=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cQyCSMtSrdk54E6MVYL4prhNyWgBKkkBFHXo5hShqQ+=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Wed, May 13, 2020 at 07:14:35PM -0400, Eric Sunshine wrote:
> > diff --git a/transport.c b/transport.c
> > @@ -370,15 +370,11 @@ static int fetch_refs_via_pack(struct transport *transport,
> >         switch (data->version) {
> > -       case protocol_v2:
> > -               refs = fetch_pack(&args, data->fd,
> > -                                 refs_tmp ? refs_tmp : transport->remote_refs,
> > -                                 to_fetch, nr_heads, &data->shallow,
> > -                                 &transport->pack_lockfile, data->version);
> > -               break;
> > -       case protocol_v1:
> >         case protocol_v0:
> > +       case protocol_v1:
> >                 die_if_server_options(transport);
> > +               /* fallthrough */
> > +       case protocol_v2:
> >                 refs = fetch_pack(&args, data->fd,
> >                                   refs_tmp ? refs_tmp : transport->remote_refs,
> >                                   to_fetch, nr_heads, &data->shallow,
> 
> I can't say that I'm a fan of this change. While it may make it clear
> that the two calls are identical, it makes it more difficult to reason
> about the distinct v0, v1, and v2 cases.

I would argue that it would make it easier to reason about the distinct
cases. From the rewritten version, it's more obvious that code used in
the v2 case is a subset of the code used in v0 and v1.

> It also makes it more
> difficult to extend or make changes to one or another case, should
> that become necessary in the future.

I would say that's the point of this change ;) When I was looking over
this code initially, I was scratching my head over the difference
between the two cases because I expected them to be different in the two
cases. If a change is necessary in the future, then it'll make sense to
write it as two separate calls to fetch_pack() or whatever but until
that happens, I think it makes more sense remove the duplication.

Actually, thinking about it some more, do you think it would make more
sense to just pull the fetch_pack() call out of the switch statement
entirely? We could entirely eliminate the fallthrough if we do this.
