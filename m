From: Jeff King <peff@peff.net>
Subject: Re: a bug about format-patch of multibyte characters comment
Date: Sun, 13 Feb 2011 03:52:36 -0500
Message-ID: <20110213085236.GA2251@sigill.intra.peff.net>
References: <4D565D3B.7060808@gmail.com>
 <20110213075337.GA12112@sigill.intra.peff.net>
 <20110213083137.GB12112@sigill.intra.peff.net>
 <4D579A35.1000007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: xiaozhu <xiaozhu@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 13 09:52:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoXhB-0003bk-Ui
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 09:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555Ab1BMIwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 03:52:37 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:57119 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753382Ab1BMIwg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 03:52:36 -0500
Received: (qmail 11806 invoked by uid 111); 13 Feb 2011 08:52:35 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 13 Feb 2011 08:52:35 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Feb 2011 03:52:36 -0500
Content-Disposition: inline
In-Reply-To: <4D579A35.1000007@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166646>

On Sun, Feb 13, 2011 at 05:45:41PM +0900, xiaozhu wrote:

> >Shouldn't we still be generating "one two three", encoding it via
> >rfc2047 if necessary, and _then_ deciding if folding is required? Yes,
> >individual lines in a multi-line subject are good candidates for
> >folding, but don't we need to be checking for and folding long lines
> >anyway?
> 
> It seems that by rfc2047 there is no multi-line subject spec. A subject
> with multi-line will be always conflated to one single line.

Sorry, I don't quite parse what you're saying. If the header takes up
multiple lines, then yes, that gets decoded as a single line by rfc822
header folding. I would then expect that result to be rfc2047-decoded if
necessary, and in theory it could contain encoded newlines.

> And also that if we just generate the subject within multi-line just
> like the current implemention, yes, we can modify the git-am to decode
> it correctly, but most of the mail client will can not show it
> correctly.

Again, I don't quite understand what you're saying. The output generated
by format-patch now is _not_ valid according to rfc2822. Changing git-am
to parse its bogus output won't help that.

> So it seems that there is only one way that combining the whole first
> paragraph to a single line? But it will be a nightmare for some long comment.

It's not the only way, but it is how we treat multi-line subjects in all
other parts of git, so it is at least consistent (and that behavior was
agreed upon after seeing what is worse: truncating to a single line, or
merging lines).

-Peff
