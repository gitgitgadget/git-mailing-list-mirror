From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/25] detecting &&-chain breakage
Date: Fri, 20 Mar 2015 06:23:32 -0400
Message-ID: <20150320102331.GZ12543@peff.net>
References: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:23:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYu5c-0006SI-6M
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 11:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbbCTKXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 06:23:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:35744 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751332AbbCTKXe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 06:23:34 -0400
Received: (qmail 6393 invoked by uid 102); 20 Mar 2015 10:23:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 05:23:34 -0500
Received: (qmail 21861 invoked by uid 107); 20 Mar 2015 10:23:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 06:23:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 06:23:32 -0400
Content-Disposition: inline
In-Reply-To: <20150320100429.GA17354@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265900>

On Fri, Mar 20, 2015 at 06:04:30AM -0400, Jeff King wrote:

> It's a lot of patches, and a few of them are long. I tried to group
> them by functionality rather than file (though as you can see, some of
> the tests were unique enough snowflakes that it made sense to discuss
> their issues separately). I'm hoping it should be an easy review, if
> not a short one.

I hoped that would make it easier to review, but I was also curious
about the patterns I would see. Here are a few things I noticed:

  - the single most common place to forget an "&&" was at the start of a
    here-doc

    I complained earlier that I would prefer a way to put it at the end.
    And indeed, I found somebody who agreed with me and was more clever
    than I. They wrote in one test:

      (cat >expect <<EOF
       ... whatever ...
      EOF
      ) &&

    which I suspect would be less error-prone, but is also quite ugly. I
    actually pulled that out in favor of a more conventional form
    (ironically, I found it because the author screwed up the
    &&-operator a few lines above).

    With automated &&-checking, I don't think there's any need to
    contort our syntax. The test suite will remind us when we forget.

  - the other common place I noticed was at the trailing ")" of a
    sub-shell

  - Running through old tests, I saw a lot of opportunity for cleanups
    that I resisted. Places where we could use "verbose" for better
    output, where "test_cmp" would be nicer than using "test X = Y",
    where people had indented here-docs badly (mostly failing to use
    "<<-", places where people had some arcane indentation style for the
    test titles and snippets themselves, etc.

    The series was already bordering on intractable, so I tried to leave
    those be (though I did fix "cat > foo" redirects when I was touching
    those particular lines :) ).

    Which is all to say, please don't mention ugly style issues you see
    in the context lines during review, unless it is to point me to your
    patch series that comes on top of mine and cleans them up. :)

-Peff
