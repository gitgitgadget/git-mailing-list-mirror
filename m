From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] for-each-ref: add split message parts to %(contents:*).
Date: Wed, 31 Aug 2011 19:22:01 -0400
Message-ID: <20110831232201.GA29296@sigill.intra.peff.net>
References: <4E5CB0D0.7000905@drmicha.warpmail.net>
 <1314781909-19252-1-git-send-email-mgorny@gentoo.org>
 <7vy5y9xkd0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 01 01:22:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qyu6q-0001v2-GY
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 01:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887Ab1HaXWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 19:22:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47876
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752207Ab1HaXWE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 19:22:04 -0400
Received: (qmail 8227 invoked by uid 107); 31 Aug 2011 23:22:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 31 Aug 2011 19:22:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Aug 2011 19:22:01 -0400
Content-Disposition: inline
In-Reply-To: <7vy5y9xkd0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180510>

On Wed, Aug 31, 2011 at 03:54:35PM -0700, Junio C Hamano wrote:

> > +The complete message in a commit and tag object is `contents`.
> > +Its first line is `contents:subject`, the remaining lines
> > +are `contents:body` and the optional GPG signature
> > +is `contents:signature`.
> 
> To match the parsing of commit objects, I would prefer to see "subject" to
> mean "the first paragraph" (usually the first line alone but that is
> purely from convention), but that probably is a separate topic.

Good idea. I suspect pretty.c:format_subject can be reused here.

> To paraphrase the last part of your sentence, if a tag is merely annotated
> and not signed, contents:signature would be empty (I am just making sure
> that I am reading the description correctly).

That is what I checked for in the tests I added.

> >  	while (*buf == '\n')
> >  		buf++; /* skip blank between subject and body */
> >  	*body = buf;
> > +	*signature = buf + parse_signature(buf, strlen(buf));
> 
> If there is no signature, parse_signature() would return (size_t) 0, no?

No, it returns strlen(buf) in that case, making signature the empty
string. It would perhaps better be called find_signature_in_body(),
since it is actually about parsing the rest of the body until we get to
the signature.

-Peff
