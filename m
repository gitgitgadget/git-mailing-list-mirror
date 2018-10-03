Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E0351F453
	for <e@80x24.org>; Wed,  3 Oct 2018 18:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeJDBNm (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 21:13:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:40176 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726851AbeJDBNm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 21:13:42 -0400
Received: (qmail 3223 invoked by uid 109); 3 Oct 2018 18:24:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 03 Oct 2018 18:24:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15475 invoked by uid 111); 3 Oct 2018 18:23:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 03 Oct 2018 14:23:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Oct 2018 14:24:09 -0400
Date:   Wed, 3 Oct 2018 14:24:09 -0400
From:   Jeff King <peff@peff.net>
To:     Dimitri Kopriwa <d.kopriwa@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Fwd: Git credentials not working
Message-ID: <20181003182409.GA14848@sigill.intra.peff.net>
References: <a1ceb967-6020-6074-f504-c684242c79ab@gmail.com>
 <f4f7bd2c-4c48-e749-4df1-ddf05896b337@gmail.com>
 <20181003171104.GA12200@sigill.intra.peff.net>
 <89f60502-c67d-83b6-593b-a0e6d8567183@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <89f60502-c67d-83b6-593b-a0e6d8567183@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 04, 2018 at 01:12:11AM +0700, Dimitri Kopriwa wrote:

> Thanks for your reply. I have activated GIT_TRACE_CURL=1 and I can see that
> the request is failing 401.
> 
> I can't see which token is used and using what header ?
> 
> The log say:
> 
> 17:50:26.414654 http.c:657              => Send header: Authorization: Basic <redacted>

Yeah, we redact the auth information so people don't accidentally share
it publicly. If you use the older GIT_CURL_VERBOSE=1, it will include
the credential (I think it may be base64 encoded, though, so you'll have
to decipher it).

> I have retested the token locally and it work when used in the url or using
> `Private-Token: <token>` as stated in the Gitlab documentation
> https://docs.gitlab.com/ee/api/README.html#personal-access-tokens

I don't think Git will ever send your token in either of those ways. It
will always some as an Authorization header.

> Peff, what would be the appropriate way to input my git credential in a 100%
> success way in a CI?

I don't know the details of what GitLab would want, but...

> Is this good:
> 
> git credential approve <<EOF
> protocol=https
> host=example.com
> username=bob
> password=secr3t
> OEF

Yes, that would work to preload a token into any configured helpers.

-Peff
