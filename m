Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C84BC2BA19
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D757220728
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUILpmxg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgDXAj3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 20:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgDXAj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 20:39:29 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52174C09B042
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 17:39:29 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id h11so3089290plr.11
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 17:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BiSPsZ/U+AOlecjL6yP675+Md4rVaiskSOpsW3+6Jrk=;
        b=PUILpmxgBTfVz8HhtkkHfEbv0JWqG3al7VoTW3OR3qCppU2MSOnUJnLNoDsusWycDz
         g/ZL/TLy8/6WrEExftyIyNigkUiSyjKW0pPb8v44tYFkGHfR8tz+Nzj9K9pmibxcM2ex
         z3MQNWgm4ZMR6JLR2TJpntZL/w0oa9nW8uK63gxQCKWpMvNL39fvjWZzOq36GybXa/kH
         srV1+aJ3evp0DWqwtItk7g1uA36Z9vxkkuw/bgnxx4nca2FLgoyom8wUtWQ38CjDIyzb
         HgXFKy1W6L6NKR1YJdW/AqNvTWtVLG3UBNheiGb1xHtvecJ45Ji8kwLNNlnACAtN1Pep
         +PgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BiSPsZ/U+AOlecjL6yP675+Md4rVaiskSOpsW3+6Jrk=;
        b=DlJy6lMfBIRyxRLgUFr6C1GfuNd/AYTt9QNgz+h7tFNSCKe/r912ExIRvqaMVFhQnW
         36f9qdjRkIxXjyMi2AExcuxFDUR4yxHjHHOCaqrvsL7niXsTl9eCbXiI+yDlk7P3VUIZ
         LVYEj5YmJn7VtgS8euZsoWhiLEAnVsAOdL68qavg+SrESMS19ulFZOmNlBjwJI8kS3fE
         sLj0jHV87+wglTnmbhVrPJGLxQA2u241mW2mg1+FgRToo4oU8R3bEcEeTCdhwW8FRASZ
         4yzAmSBExQ0QM8s7v1zt4BuIUd2+XGn6oh3NAKYBs95Kt7QVJ9bmE3x+rNeETU26g+Ux
         eIvw==
X-Gm-Message-State: AGi0PuZ+n+8PGZ0EWzsP3UJgBntFeyCC9t/zY6MppezmmnJv0LIRo4V+
        NfzEqW/xJj2+UeNlhRKoFFw=
X-Google-Smtp-Source: APiQypL9wFbRoBQqXCKOLB7KuHmql7F7fB3y7bafvJ1b0fgMbsqQsIEE2Nxr7Csz3B16DOAi6dWsyg==
X-Received: by 2002:a17:90b:3617:: with SMTP id ml23mr3420515pjb.170.1587688768571;
        Thu, 23 Apr 2020 17:39:28 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id 185sm4046997pfv.9.2020.04.23.17.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 17:39:28 -0700 (PDT)
Date:   Thu, 23 Apr 2020 17:39:26 -0700
From:   Carlo Marcelo Arenas =?iso-8859-1?Q?Bel=F3n?= <carenas@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] credential: handle
 `credential.<partial-URL>.<key>` again
Message-ID: <20200424003926.GC20669@Carlos-MBP>
References: <pull.615.git.1587588665.gitgitgadget@gmail.com>
 <pull.615.v2.git.1587685397.gitgitgadget@gmail.com>
 <daedaffe960581733c25383a2a1b30056a415594.1587685397.git.gitgitgadget@gmail.com>
 <20200424000558.GB20669@Carlos-MBP>
 <nycvar.QRO.7.76.6.2004240215100.18039@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2004240215100.18039@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 24, 2020 at 02:16:45AM +0200, Johannes Schindelin wrote:
> On Thu, 23 Apr 2020, Carlo Marcelo Arenas Belón wrote:
> > On Thu, Apr 23, 2020 at 11:43:17PM +0000, Johannes Schindelin via GitGitGadget wrote:
> > > diff --git a/credential.c b/credential.c
> > > index 52965a5122c..3505f6356d8 100644
> > > --- a/credential.c
> > > +++ b/credential.c
> > > @@ -53,7 +53,13 @@ static int credential_config_callback(const char *var, const char *value,
> > >  		char *url = xmemdupz(key, dot - key);
> > >  		int matched;
> > >
> > > -		credential_from_url(&want, url);
> > > +		if (credential_from_url_gently(&want, url, 1, 0) < 0) {
> >
> > definitely not worth a reroll, but just wondering if would make sense to call
> > credential_from_url_gently(!quiet) here, just for consistency?
> 
> We don't have any `quiet` variable here.

my bad, should had been more explicit as it is confusing with all those
booleans at the end without a flags parameter.

I mean the call should be instead :

  if (credential_from_url_gently(&want, url, 1, 1) < 0) {

since we want to warn if the configuration is not supported just like is
done after this check.

> 
> > other than that this series is looking great, under the assumption that there
> > is going to be some more followup with non essential changes.
> 
> I am sure I don't follow. What non-essential changes are you assuming will
> follow up?

the ones that were discussed with Jonathan in a differen thread :

* using a flags parameter instead of two ints
* whatever will be needed so it also works in master and maint

> > will chip in with an test helper for that series so we can hopefully keep our
> > sanity next time someone touches that function again.
> 
> Are the tests I added to t0300 not enough? Or do you think it will need a
> native test helper that is included in `t/helper/test-tool` and exercised
> in the test suite somehow?

I think they are enough, it is only that is easier to quickly iterate with
possible bad input with a helper. which is what I was offering for the next
thread since its need is orthogonal to what you are trying to accomplish.

Carlo
