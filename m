Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 192C6201A9
	for <e@80x24.org>; Thu, 23 Feb 2017 06:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750891AbdBWG7a (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 01:59:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:60470 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750876AbdBWG7a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 01:59:30 -0500
Received: (qmail 23566 invoked by uid 109); 23 Feb 2017 05:58:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 05:58:34 +0000
Received: (qmail 22203 invoked by uid 111); 23 Feb 2017 05:58:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 00:58:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2017 00:58:31 -0500
Date:   Thu, 23 Feb 2017 00:58:31 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] config: reject invalid VAR in 'git -c VAR=VAL command'
Message-ID: <20170223055831.u3yofkby3c56t7l4@sigill.intra.peff.net>
References: <xmqqtw7v123n.fsf@gitster.mtv.corp.google.com>
 <xmqqa89n10df.fsf_-_@gitster.mtv.corp.google.com>
 <D0CDD1AC-05CA-47F3-8CB5-61EA1C6515A8@gmail.com>
 <20170216232730.xsx3xks5ppjws5rg@sigill.intra.peff.net>
 <xmqqwpcptxps.fsf@gitster.mtv.corp.google.com>
 <xmqqino5jia8.fsf@gitster.mtv.corp.google.com>
 <xmqq37f7gyuj.fsf_-_@gitster.mtv.corp.google.com>
 <CAGZ79kbR2QQyYO1dnQ0jW3-ztKEFj1MtJfDqEc0xoftMFeN=WA@mail.gmail.com>
 <xmqqlgszffm0.fsf@gitster.mtv.corp.google.com>
 <xmqqd1ebfd9l.fsf_-_@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd1ebfd9l.fsf_-_@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2017 at 01:24:38PM -0800, Junio C Hamano wrote:

> The parsing of one-shot assignments of configuration variables that
> come from the command line historically was quite loose and allowed
> anything to pass.
> 
> The configuration variable names that come from files are validated
> in git_config_parse_source(), which uses get_base_var() that grabs
> the <section> (and subsection) while making sure that <section>
> consists of iskeychar() letters, the function itself that makes sure
> that the first letter in <variable> is isalpha(), and get_value()
> that grabs the remainder of the <variable> name while making sure
> that it consists of iskeychar() letters.
> 
> Perform an equivalent check in canonicalize_config_variable_name()
> to catch invalid configuration variable names that come from the
> command line.

FWIW, the code looks OK here. It is a shame to duplicate the policy
found in git_config_parse_key(), though.

I wonder if we could make a master version of that which canonicalizes
in-place, and then just wrap it for the git_config_parse_key()
interface. Actually, I guess the function you just wrote _is_ that inner
function, as long as it learned about the "quiet" flag.

-Peff
