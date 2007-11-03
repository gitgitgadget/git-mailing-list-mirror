From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Reuse previous annotation when overwriting a tag
Date: Sat, 3 Nov 2007 13:10:02 +0100
Organization: glandium.org
Message-ID: <20071103121002.GA4295@glandium.org>
References: <1194082273-19486-1-git-send-email-mh@glandium.org> <Pine.LNX.4.64.0711031148460.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 03 13:11:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoHqp-0004cB-DQ
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 13:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306AbXKCMLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 08:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752975AbXKCMLZ
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 08:11:25 -0400
Received: from vawad.err.no ([85.19.200.177]:36264 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752838AbXKCMLY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 08:11:24 -0400
Received: from aputeaux-153-1-33-156.w82-124.abo.wanadoo.fr ([82.124.3.156] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IoHqO-0001cz-S4; Sat, 03 Nov 2007 13:11:19 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IoHpC-0001CR-F2; Sat, 03 Nov 2007 13:10:02 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711031148460.4362@racer.site>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63247>

On Sat, Nov 03, 2007 at 11:54:38AM +0000, Johannes Schindelin wrote:
> > +{
> > +	int i;
> > +	unsigned long size;
> > +	enum object_type type;
> > +	char *buf, *sp, *eol;
> > +	size_t len;
> > +
> > +	sp = buf = read_sha1_file(sha1, &type, &size);
> > +	if (!buf)
> > +		return;
> > +	if (!size || (type != OBJ_TAG)) {
> 
> Please lose the extra parents.

What do you mean ?

(...)
> This can be done much easier with 'sp = strstr(buf, "\n\n");'.  You can 
> even do that before the previous if(), to free() && return if there is no 
> body.
(...)
> This can be done much easier with 'eob = strstr(sp, "\n" PGP_SIGNATURE 
> "\n");'.

I must say I just stole most of it in show_reference() in the same file.

> > +}
> > +
> >  static void create_tag(const unsigned char *object, const char *tag,
> >  		       struct strbuf *buf, int message, int sign,
> > -			   unsigned char *result)
> > +			unsigned char *prev, unsigned char *result)
> 
> This changes indentation.

I'll fix this.

> > @@ -282,6 +315,10 @@ static void create_tag(const unsigned char *object, const char *tag,
> >  		if (fd < 0)
> >  			die("could not create file '%s': %s",
> >  						path, strerror(errno));
> > +
> > +		if (prev)
> > +			write_annotation(fd, prev);
> > +
> >  		write_or_die(fd, tag_template, strlen(tag_template));
> 
> Isn't an "else" missing before the write_or_die() here?

You're obviously right.

(...)
> Why not teach write_annotations() (or write_tag_body() like I would prefer 
> it to be called) to grok a null_sha1?  It's not like we care for 
> performance here, but rather for readability and ease of use.

I would have if I had looked up for is_null_sha1() earlier ;)

Cheers,

Mike
