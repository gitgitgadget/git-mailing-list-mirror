From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
Date: Tue, 15 Dec 2015 21:46:05 -0500
Message-ID: <20151216024605.GA618@sigill.intra.peff.net>
References: <1449594916-21167-8-git-send-email-chriscool@tuxfamily.org>
 <xmqqsi3ckadi.fsf@gitster.mtv.corp.google.com>
 <xmqqfuzck1dp.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD3at0X9ThpXGTwyPnu_dXFj6x=YzfkCa82m+RsWwhFOOA@mail.gmail.com>
 <xmqq6100ke7v.fsf@gitster.mtv.corp.google.com>
 <xmqqa8pciuqq.fsf@gitster.mtv.corp.google.com>
 <CACBZZX6=sU2cb_vRn5DAqVEuNTwsk0m7vQ0_WUp5qPWeQq5JhQ@mail.gmail.com>
 <xmqqh9jjfqk4.fsf@gitster.mtv.corp.google.com>
 <CACBZZX7QW2J6DcMSXTa1y+QdMrqq5DXs1Fu3m8toV5a4yZKNjw@mail.gmail.com>
 <xmqqy4cvco25.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 03:46:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a926Z-0000th-MT
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 03:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511AbbLPCqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 21:46:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:42790 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752253AbbLPCqI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 21:46:08 -0500
Received: (qmail 1459 invoked by uid 102); 16 Dec 2015 02:46:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Dec 2015 20:46:08 -0600
Received: (qmail 23311 invoked by uid 107); 16 Dec 2015 02:46:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Dec 2015 21:46:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Dec 2015 21:46:05 -0500
Content-Disposition: inline
In-Reply-To: <xmqqy4cvco25.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282528>

On Tue, Dec 15, 2015 at 03:03:14PM -0800, Junio C Hamano wrote:

> The thing is, I do not necessarily view this as "configuration".
> The way I see the feature is that you say "--untracked" when you
> want the states of untracked paths be kept track of in the index,
> just like you say "git add Makefile" when you want the state of
> 'Makefile' be kept track of in the index.  Either the index keeps
> track of it, or it doesn't, based solely on user's request, and the
> bit to tell us which is the case is already in the index, exactly
> because that is part of the data that is kept track of in the index.

I know this is a fairly subjective argument, but it feels quite weird
for me for such a config to persist in the index and not be mentioned
anywhere else.

Is there any other user-specified configuration option for which:

  rm -f .git/index
  git read-tree HEAD

will actually _lose_ information?

It seems to me that all other things being equal, we should be in favor
of a config option simply because it reduces the cognitive burden on the
user: it's one fewer place they need to be aware that git is keeping
persistent decisions.

> If the feature is something only those with really large repositories
> care about, is it a good trade-off to make everybody pay the runtime
> cost and make code more complex and fragile?  I am not yet convinced.

I'm not sure I understand the runtime and complexity costs of the config
option. Isn't it just:

  if (core_untracked_cache) {
	/* do the thing */
  }

and loading core_untracked_cache in git_default_core_config()? Versus:

  if (the_index.has_untracked_cache) {
        /* do the thing */
  }

I ask as somebody who hasn't followed the topic closely. I just don't
see what is that different about this versus other config options. What
am I missing?

-Peff
