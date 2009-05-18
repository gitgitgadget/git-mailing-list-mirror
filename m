From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] Extend sample pre-commit hook to check for non ascii
	filenames
Date: Mon, 18 May 2009 13:50:11 +0200
Message-ID: <20090518115002.GA3374@heiko-voigts-macbook.local>
References: <20090512214250.GA22974@macbook.lan> <200905122356.00659.jnareb@gmail.com> <20090514175850.GA26267@macbook.lan> <7vbpputewv.fsf@alter.siamese.dyndns.org> <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <200905122356.00659.jnareb@gmail.com> <20090514175850.GA26267@macbook.lan> <200905151657.47225.jnareb@gmail.com> <20090518095044.GB910@heiko-voigts-macbook.local> <4A113B09.6040301@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon May 18 13:50:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M61MR-0000AP-9p
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 13:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739AbZERLuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 07:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752349AbZERLuQ
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 07:50:16 -0400
Received: from darksea.de ([83.133.111.250]:51631 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751727AbZERLuP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 07:50:15 -0400
Received: (qmail 21411 invoked from network); 18 May 2009 13:50:04 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 18 May 2009 13:50:04 +0200
Content-Disposition: inline
In-Reply-To: <4A113B09.6040301@viscovery.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119438>

On Mon, May 18, 2009 at 12:40:09PM +0200, Johannes Sixt wrote:
> Heiko Voigt schrieb:
> > +# is_ascii() Tests the string given given on standard input for
> > +# printable ascii conformance. We exploit the fact that the printable
> > +# range starts at the space character and ends with tilde.
> > +is_ascii() {
> > +    test -z "$(LC_ALL=C tr -d \ -~)"
> > +}
> > +
> > +if [ "$allownonascii" != "true" ]
> > +then
> > +	# until git can handle non-ascii filenames gracefully
> > +	# prevent them to be added into the repository
> > +	if ! git diff --cached --name-only --diff-filter=A -z \
> > +	   | tr "\0" "\n" | is_ascii; then
> 
> Will this not fail to add more than one file with allowed names? The \n is
> not removed in is_ascii(), and so the resulting string will not be empty.

No currently it does not. At least on my system, but good point.

> BTW, not all tr work well with NULs. See the commit message of e85fe4d8,
> for example. Otherwise, I would have suggested to convert the NUL to some
> allowed ASCII character, e.g. 'A'. BTW, you should really use '\0' and
> '\n' (single-quotes) to guarantee that the shell does not ignore the
> backslash.

Are there any problems with '\0' and tr other than swallowing of it. In
case not I would just change

	tr "\0" "\n"
to
  	tr -d '\0'

That way there are no '\n's left over and it doesn't matter if tr
swallows the '\0'.

Waiting for further comments before sending the cleanup.

cheers Heiko
