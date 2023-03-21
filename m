Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11F2C6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 17:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjCURWu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 13:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCURWt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 13:22:49 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AFE4E5DF
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 10:22:46 -0700 (PDT)
Received: (qmail 27440 invoked by uid 109); 21 Mar 2023 17:22:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Mar 2023 17:22:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2244 invoked by uid 111); 21 Mar 2023 17:22:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Mar 2023 13:22:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Mar 2023 13:22:45 -0400
From:   Jeff King <peff@peff.net>
To:     Stanislav M <stanislav.malishevskiy@gmail.com>
Cc:     Stanislav Malishevskiy via GitGitGadget <gitgitgadget@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org,
        Stanislav Malishevskiy <s.malishevskiy@auriga.com>
Subject: Re: [PATCH v2] http: add support for different sslcert and sslkey
 types.
Message-ID: <20230321172245.GB3119834@coredump.intra.peff.net>
References: <pull.1474.git.git.1679233875803.gitgitgadget@gmail.com>
 <pull.1474.v2.git.git.1679327330032.gitgitgadget@gmail.com>
 <20230320171051.GA2615782@coredump.intra.peff.net>
 <CAEpdKf=THU=sc3S3W4azBmYp7+J945GxFqhh_i-5kV0kunMdNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEpdKf=THU=sc3S3W4azBmYp7+J945GxFqhh_i-5kV0kunMdNw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2023 at 09:21:44PM +0300, Stanislav M wrote:

> > > @@ -1014,10 +1020,14 @@ static CURL *get_curl_handle(void)
> > >
> > >       if (ssl_cert)
> > >               curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
> > > +     if (ssl_cert_type)
> > > +             curl_easy_setopt(result, CURLOPT_SSLCERTTYPE, ssl_cert_type);
> >
> > We're just feeding curl whatever string the user gave us (which is good,
> > since we don't know which ones are valid). But what happens with:
> >
> >   GIT_SSL_CERT_TYPE=bogus git fetch ...
> >
> > Should we check for an error here, or will the actual request later
> > complain properly?
> 
> Curl itself validates that string. And if we pass the wrong type or
> not pass 'ENG' in case of pkcs11: curl will return an error. In that
> case git do the same if GIT_SSL_CERT passed wrong ss 'ENG' in case of
> pkcs11: curl will return an error. In that case git do the same if
> GIT_SSL_CERT passed wrong

That sounds great. Thanks for confirming!

-Peff
