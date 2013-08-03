From: Jeff King <peff@peff.net>
Subject: Re: [regression] Re: git-cat-file --batch reversion; cannot query
 filenames with spaces
Date: Sat, 3 Aug 2013 00:18:42 -0700
Message-ID: <20130803071842.GB26894@sigill.intra.peff.net>
References: <20130801201842.GA16809@kitenet.net>
 <20130802064003.GB3013@elie.Belkin>
 <20130802105402.GA25697@sigill.intra.peff.net>
 <20130802115906.GA9183@sigill.intra.peff.net>
 <7vtxj8oxin.fsf@alter.siamese.dyndns.org>
 <20130802172804.GB11329@sigill.intra.peff.net>
 <7vmwp0osic.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, Joey Hess <joeyh@debian.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 03 09:18:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5W70-0003cm-T4
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 09:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072Ab3HCHSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 03:18:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:44869 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750742Ab3HCHSq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 03:18:46 -0400
Received: (qmail 23526 invoked by uid 102); 3 Aug 2013 07:18:46 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 03 Aug 2013 02:18:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Aug 2013 00:18:42 -0700
Content-Disposition: inline
In-Reply-To: <7vmwp0osic.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231569>

On Fri, Aug 02, 2013 at 11:30:03AM -0700, Junio C Hamano wrote:

> > I didn't see the result of your wrangling in pu, but I will keep an eye
> > out to double-check it (unless you did not finish, in which case I am
> > happy to do the wrangling myself).
> 
> Here is what is on top of the revert that has been pushed out on
> 'pu'.

Thanks, that looks good to me.

We may want to also squash in the patch below, which puts the pointer
variable in the most-local block and re-wraps the newly indented comment
for line length. Neither introduced by your adaptation, but they became
more obvious to me when seen on top of the revert.

-Peff

---
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 07b4818..41afaa5 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -286,15 +286,15 @@ static int batch_objects(struct batch_options *opt)
 	warn_on_object_refname_ambiguity = 0;
 
 	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
-		char *p;
 		int error;
 
 		if (data.split_on_whitespace) {
 			/*
-			 * Split at first whitespace, tying off the beginning of the
-			 * string and saving the remainder (or NULL) in data.rest.
+			 * Split at first whitespace, tying off the beginning
+			 * of the string and saving the remainder (or NULL) in
+			 * data.rest.
 			 */
-			p = strpbrk(buf.buf, " \t");
+			char *p = strpbrk(buf.buf, " \t");
 			if (p) {
 				while (*p && strchr(" \t", *p))
 					*p++ = '\0';
