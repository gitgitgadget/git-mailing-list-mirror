From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 1/2] attr: map builtin userdiff drivers to well-known
 extensions
Date: Mon, 19 Dec 2011 13:55:11 -0500
Message-ID: <20111219185511.GA3852@sigill.intra.peff.net>
References: <20111217033808.GA8683@elie.hsd1.il.comcast.net>
 <20111219154938.GA19829@sigill.intra.peff.net>
 <20111219180733.GA12200@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 19 19:55:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RciMp-00060f-Qs
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 19:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731Ab1LSSzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 13:55:16 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45949
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751393Ab1LSSzO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 13:55:14 -0500
Received: (qmail 1272 invoked by uid 107); 19 Dec 2011 19:01:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 Dec 2011 14:01:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Dec 2011 13:55:11 -0500
Content-Disposition: inline
In-Reply-To: <20111219180733.GA12200@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187464>

On Mon, Dec 19, 2011 at 12:07:33PM -0600, Jonathan Nieder wrote:

> > The C mappings are still here, but see the next patch.
> 
> This is adding a regression in order to remove it.  I guess it's
> harmless, but I don't see the point.

It's purely an attempt to help somebody reading "git log" later
understand what happened. Maybe a comment in the commit message is more
appropriate.

> > +test_expect_success 'binary files are not considered text by file extension' '
> > +	echo Q | q_to_nul >binary.c &&
> > +	git add binary.c &&
> > +	cat >expect <<-\EOF &&
> > +	diff --git a/binary.c b/binary.c
> > +	new file mode 100644
> > +	index 0000000..1f2a4f5
> > +	Binary files /dev/null and b/binary.c differ
> > +	EOF
> > +	git diff --cached binary.c >actual &&
> > +	test_cmp expect actual
> 
> Re the idea of this test: very good idea.
> 
> Re the mechanics: I would have been happier to see
> 
> 	echo Q | q_to_nul >binary.c &&
> 	git add binary.c &&
> 	git diff --cached binary.c >diff &&
> 	grep Binary files diff

Yeah, I think that's fine, and I'll squash it in to my local version.

It does miss one problem, though (that is also present in my original):
using "binary.c" is no longer a good name, since the next patch will
revert the "*.c" bits. :)

> > --- a/t/t4018-diff-funcname.sh
> > +++ b/t/t4018-diff-funcname.sh
> > @@ -124,7 +124,9 @@ do
> >  done
> >  
> >  test_expect_success 'default behaviour' '
> > -	rm -f .gitattributes &&
> > +	cat >.gitattributes <<-\EOF &&
> > +	*.java diff=default
> > +	EOF
> >  	test_expect_funcname "public class Beer\$"
> >  '
> 
> 	echo "*.java diff=default" >.gitattributes
> 
> would do the same with two lines fewer. :)

Yup. I was following the style of the test directly below, which sets
both java and perl drivers. But the "default" test that needed updating
only checks the java case.

Will squash.

> Thanks for working on this.  I owe you a beer.

You're welcome. :)

-Peff
