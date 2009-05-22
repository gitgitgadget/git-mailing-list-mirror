From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] setup_revisions(): do not access outside argv
Date: Fri, 22 May 2009 11:34:26 -0400
Message-ID: <20090522153426.GA10390@coredump.intra.peff.net>
References: <1242806900-3499-1-git-send-email-pclouds@gmail.com> <4A13BC3C.5070000@viscovery.net> <fcaeb9bf0905200123r3649a7e5vc40ece402379e701@mail.gmail.com> <7v7i0btdwu.fsf@alter.siamese.dyndns.org> <20090521041812.GE8091@sigill.intra.peff.net> <4A159720.3020103@intra2net.com> <20090522075620.GC1409@coredump.intra.peff.net> <20090522080258.GD1409@coredump.intra.peff.net> <Ys7Cih8N_SClhy9WmlLefLAxz2_XjZb3KAO1jrRMNrMcLq4T98MuIA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Jarosch <thomas.jarosch@intra2net.com>,
	Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri May 22 17:34:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7WlX-0005te-FG
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 17:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756979AbZEVPe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 11:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756954AbZEVPe1
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 11:34:27 -0400
Received: from peff.net ([208.65.91.99]:54431 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753051AbZEVPe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 11:34:27 -0400
Received: (qmail 19972 invoked by uid 107); 22 May 2009 15:34:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 22 May 2009 11:34:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 22 May 2009 11:34:26 -0400
Content-Disposition: inline
In-Reply-To: <Ys7Cih8N_SClhy9WmlLefLAxz2_XjZb3KAO1jrRMNrMcLq4T98MuIA@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119735>

On Fri, May 22, 2009 at 10:33:22AM -0500, Brandon Casey wrote:

> >  		if (S_ISLNK(st.st_mode)) {
> > -			int ret;
> > -			char buf[PATH_MAX + 1]; /* ought to be SYMLINK_MAX */
> > -			ret = readlink(name, buf, sizeof(buf));
> > -			if (ret < 0)
> > +			struct strbuf sb = STRBUF_INIT;
> > +			if (strbuf_readlink(&sb, name, st.st_size) < 0)
> >  				die("readlink(%s)", name);
> > -			if (ret == sizeof(buf))
> > -				die("symlink too long: %s", name);
> > -			prep_temp_blob(name, temp, buf, ret,
> > +			prep_temp_blob(name, temp, sb.buf, sb.len,
> >  				       (one->sha1_valid ?
> >  					one->sha1 : null_sha1),
> >  				       (one->sha1_valid ?
> 
> Don't you need to strbuf_release() ?

Urgh, yes, of course. Thanks for noticing.

-Peff
