Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D9C71F516
	for <e@80x24.org>; Thu, 28 Jun 2018 14:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966804AbeF1OeK (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 10:34:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:58230 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S966506AbeF1OeI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 10:34:08 -0400
Received: (qmail 14328 invoked by uid 109); 28 Jun 2018 14:34:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Jun 2018 14:34:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20258 invoked by uid 111); 28 Jun 2018 14:34:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Jun 2018 10:34:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jun 2018 10:34:06 -0400
Date:   Thu, 28 Jun 2018 10:34:06 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Steve Groeger <GROEGES@uk.ibm.com>, git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>
Subject: Re: Use of new .gitattributes working-tree-encoding attribute across
 different platform types
Message-ID: <20180628143405.GA16657@sigill.intra.peff.net>
References: <OF5D40FE06.C18CD7CD-ON002582B9.002B7A02-002582B9.002B7A07@notes.na.collabserv.com>
 <20180628024446.GD644867@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180628024446.GD644867@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 28, 2018 at 02:44:47AM +0000, brian m. carlson wrote:

> On Wed, Jun 27, 2018 at 07:54:52AM +0000, Steve Groeger wrote:
> > We have common code that is supposed to be usable across different platforms and hence different file encodings. With the full support of the working-tree-encoding in the latest version of git on all platforms, how do we have files converted to different encodings on different platforms?
> > I could not find anything that would allow us to say 'if platform = z/OS then encoding=EBCDIC else encoding=ASCII'.   Is there a way this can be done?
> 
> I don't believe there is such functionality.  Git doesn't have
> attributes that are conditional on the platform in that sort of way.
> You could use a smudge/clean filter and adjust the filter for the
> platform you're on, which might meet your needs.

We do have prior art in the line-ending code, though. There the
attributes say either that a file needs a specific line-ending type
(which is relatively rare), or that it should follow the system type,
which is then set separately in the config.

I have the impression that the working-tree-encoding stuff was made to
handle the first case, but not the second. It doesn't seem like an
outrageous thing to eventually add.

(Though I agree that clean/smudge filters would work, and can even
implement the existing working-tree-encoding feature, albeit less
efficiently and conveniently).

-Peff
