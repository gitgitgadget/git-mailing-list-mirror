From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 3/3] config: add '--show-origin' option to print the
 origin of a config value
Date: Mon, 15 Feb 2016 17:59:38 -0500
Message-ID: <20160215225938.GA30631@sigill.intra.peff.net>
References: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com>
 <1455531466-16617-4-git-send-email-larsxschneider@gmail.com>
 <xmqqegcdpqhh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: larsxschneider@gmail.com, git@vger.kernel.org,
	sschuberth@gmail.com, ramsay@ramsayjones.plus.com,
	sunshine@sunshineco.com, hvoigt@hvoigt.net, sbeller@google.com,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 23:59:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVS7N-0008EF-6Z
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 23:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbcBOW7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 17:59:41 -0500
Received: from cloud.peff.net ([50.56.180.127]:42604 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753246AbcBOW7k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 17:59:40 -0500
Received: (qmail 5531 invoked by uid 102); 15 Feb 2016 22:59:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 17:59:40 -0500
Received: (qmail 14121 invoked by uid 107); 15 Feb 2016 22:59:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 17:59:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 17:59:38 -0500
Content-Disposition: inline
In-Reply-To: <xmqqegcdpqhh.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286285>

On Mon, Feb 15, 2016 at 02:18:18PM -0800, Junio C Hamano wrote:

> larsxschneider@gmail.com writes:
> 
> > +test_expect_success 'set up custom config file' '
> > +	CUSTOM_CONFIG_FILE=$(printf "file\twith\ttabs.conf") &&
> > +	cat >"$CUSTOM_CONFIG_FILE" <<-\EOF
> > +		[user]
> > +			custom = true
> > +	EOF
> > +'
> > +
> > +test_expect_success '--show-origin escape special file name characters' '
> > +	cat >expect <<-\EOF &&
> > +		file:"file\twith\ttabs.conf"	user.custom=true
> > +	EOF
> > +	git config --file "$CUSTOM_CONFIG_FILE" --show-origin --list >output &&
> > +	test_cmp expect output
> > +'
> 
> Do we really need to use a file with such a name?
> 
> An existing test t3300 tells me that a test that uses a path with a
> tab needs to be skipped on FAT/NTFS.  If your goal is to make sure
> dquote is exercised, can't we just do with a path with a SP in it or
> something?

It has to trigger quote_c_style(). You can see the complete set of
quoted characters in quote.c:sq_lookup, but space is not one of them.
Probably double-quote or backslash is the best bet, as the rest are all
control characters.

-Peff
