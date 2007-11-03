From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Reuse previous annotation when overwriting a tag
Date: Sat, 3 Nov 2007 12:23:55 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711031219530.4362@racer.site>
References: <1194082273-19486-1-git-send-email-mh@glandium.org>
 <Pine.LNX.4.64.0711031148460.4362@racer.site> <20071103121002.GA4295@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Nov 03 13:25:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoI3f-0007G6-NH
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 13:25:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506AbXKCMYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 08:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753503AbXKCMYo
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 08:24:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:39293 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753374AbXKCMYn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 08:24:43 -0400
Received: (qmail invoked by alias); 03 Nov 2007 12:24:41 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp054) with SMTP; 03 Nov 2007 13:24:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18TnYILvKwTIbZkqHeaMLMPblGuCRPtcLTfrPvIyQ
	T8FUh2h/uMeM+K
X-X-Sender: gene099@racer.site
In-Reply-To: <20071103121002.GA4295@glandium.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63254>

Hi,

On Sat, 3 Nov 2007, Mike Hommey wrote:

> On Sat, Nov 03, 2007 at 11:54:38AM +0000, Johannes Schindelin wrote:
> > > +{
> > > +	int i;
> > > +	unsigned long size;
> > > +	enum object_type type;
> > > +	char *buf, *sp, *eol;
> > > +	size_t len;
> > > +
> > > +	sp = buf = read_sha1_file(sha1, &type, &size);
> > > +	if (!buf)
> > > +		return;
> > > +	if (!size || (type != OBJ_TAG)) {
> > 
> > Please lose the extra parents.
> 
> What do you mean ?

Typo.  I meant the parens, and my fingers typed parents. D'oh.

> (...)
> > This can be done much easier with 'sp = strstr(buf, "\n\n");'.  You can 
> > even do that before the previous if(), to free() && return if there is no 
> > body.
> (...)
> > This can be done much easier with 'eob = strstr(sp, "\n" PGP_SIGNATURE 
> > "\n");'.
> 
> I must say I just stole most of it in show_reference() in the same file.

I agree for the "\n\n"; this was my mistake (IOW it should be fixed both 
in show_reference() as well as in your code).

But for the signature, show_reference() _has_ to go line by line, because 
the user is allowed to specify a maximal line count.  This does not apply 
for your function.

> (...)
> > Why not teach write_annotations() (or write_tag_body() like I would prefer 
> > it to be called) to grok a null_sha1?  It's not like we care for 
> > performance here, but rather for readability and ease of use.
> 
> I would have if I had looked up for is_null_sha1() earlier ;)

Hehe.  This is what I really like about git's mailing list: it is a place 
where you learn something new every day.

Ciao,
Dscho
