From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] bisect: improve output when bad commit is found
Date: Tue, 12 May 2015 21:36:37 -0400
Message-ID: <20150513013637.GB3066@peff.net>
References: <1431472751-20974-1-git-send-email-tbsaunde@tbsaunde.org>
 <xmqqwq0dcrcf.fsf@gitster.dls.corp.google.com>
 <20150513005432.GF31257@tsaunders-iceball.corp.tor1.mozilla.com>
 <xmqqoalpcm9f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Trevor Saunders <tbsaunde@tbsaunde.org>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 13 03:36:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsLbJ-0005rr-BT
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 03:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbbEMBgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 21:36:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:57525 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965002AbbEMBgj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 21:36:39 -0400
Received: (qmail 23495 invoked by uid 102); 13 May 2015 01:36:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 May 2015 20:36:39 -0500
Received: (qmail 5717 invoked by uid 107); 13 May 2015 01:36:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 May 2015 21:36:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 May 2015 21:36:37 -0400
Content-Disposition: inline
In-Reply-To: <xmqqoalpcm9f.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268912>

On Tue, May 12, 2015 at 06:13:48PM -0700, Junio C Hamano wrote:

> >> See $gmane/268881
> >
> > Well, technically he just said it might be that people are parsing the
> > output and could be broken, but if you'd rather not take that risk then
> > I guess we just have to leave things the way they are.
> 
> FWIW.
> 
>  - I personally do not agree that those who scripted around "git
>    bisect" (as opposed to those who wrote scripts to be driven by
>    the "bisect run" interface) are worth worrying about.  But I am
>    not the whole of the Git world ;-)

It is not clear to me that people are actually scripting around the
output. Between the exit code and the stable output in BISECT_LOG, that
seems like a much more preferable way for scripted uses to find out what
happened.

Of course, that is not a guarantee that nobody scraped stderr, but at
least it makes me feel better that they're Doing It Wrong. :)

It would be nice if we had some actual data points. I followed the link
Christian gave to Ingo's old post, but I didn't see the actual script
there. There is:

  https://github.com/grosser/git-autobisect/blob/master/lib/git/autobisect.rb

which does seem to scrape stderr. Bleh.

>  - I _do_ think diff-tree --raw output without recursive is silly.
>    It is not useful for humans (it doesn't even give paths fully),
>    and it is insufficient for scripts, which can grok more through
>    information out of the 40-hex.
> 
> So perhaps if we keep
> 
> 	<40 char sha1> is the first bad commit
> 
> and then replace the diff-tree output with "show -s", then the
> result would be good enough, I would say.

That seems like a reasonable first step, at the very least. I wonder if
we should also better document the exit code and BISECT_LOG semantics,
and explicitly tell people not to scrape stderr. That at least frees us
up later to change the output as we see fit (I notice that most of the
messages in the script are already i18n'd; the ones from bisect--helper
are the odd ones out).

-Peff
