From: Jeff King <peff@peff.net>
Subject: Re: [bug report] git-am applying maildir patches in reverse
Date: Sun, 3 Mar 2013 01:26:47 -0500
Message-ID: <20130303062647.GA23221@sigill.intra.peff.net>
References: <20130301222018.GA839@WST420>
 <7vwqtqeox7.fsf@alter.siamese.dyndns.org>
 <20130301225231.GB862@sigill.intra.peff.net>
 <20130301230508.GC862@sigill.intra.peff.net>
 <7vlia6em9x.fsf@alter.siamese.dyndns.org>
 <20130301233548.GA13422@sigill.intra.peff.net>
 <7v1ubyek9n.fsf@alter.siamese.dyndns.org>
 <20130302004120.GB14936@sigill.intra.peff.net>
 <m28v66198o.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	William Giokas <1007380@gmail.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Mar 03 07:27:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UC2OD-0005rf-Qw
	for gcvg-git-2@plane.gmane.org; Sun, 03 Mar 2013 07:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473Ab3CCG0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 01:26:53 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40386 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751123Ab3CCG0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 01:26:52 -0500
Received: (qmail 16108 invoked by uid 107); 3 Mar 2013 06:28:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 03 Mar 2013 01:28:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 03 Mar 2013 01:26:47 -0500
Content-Disposition: inline
In-Reply-To: <m28v66198o.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217336>

On Sat, Mar 02, 2013 at 09:44:39AM +0100, Andreas Schwab wrote:

> > +	return *a - *b;
> 
> You should always cast to unsigned char when determining the order of
> characters, to be consistent with strcmp/memcmp.

Thanks, I hadn't heard that advice before, but it makes obvious sense.
Junio, do you want to squash this on top?

diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 1ddbff4..06296d4 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -143,12 +143,12 @@ static int maildir_filename_cmp(const char *a, const char *b)
 		}
 		else {
 			if (*a != *b)
-				return *a - *b;
+				return (unsigned char)*a - (unsigned char)*b;
 			a++;
 			b++;
 		}
 	}
-	return *a - *b;
+	return (unsigned char)*a - (unsigned char)*b;
 }
 
 static int split_maildir(const char *maildir, const char *dir,

-Peff
