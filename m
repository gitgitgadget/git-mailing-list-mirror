From: Jeff King <peff@peff.net>
Subject: Re: a bug about format-patch of multibyte characters comment
Date: Sun, 13 Feb 2011 03:31:37 -0500
Message-ID: <20110213083137.GB12112@sigill.intra.peff.net>
References: <4D565D3B.7060808@gmail.com>
 <20110213075337.GA12112@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: xiaozhu <xiaozhu@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 13 09:31:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoXN2-0006Ax-0R
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 09:31:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382Ab1BMIbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 03:31:39 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:48172 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751718Ab1BMIbi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 03:31:38 -0500
Received: (qmail 11228 invoked by uid 111); 13 Feb 2011 08:31:37 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 13 Feb 2011 08:31:37 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Feb 2011 03:31:37 -0500
Content-Disposition: inline
In-Reply-To: <20110213075337.GA12112@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166643>

On Sun, Feb 13, 2011 at 02:53:37AM -0500, Jeff King wrote:

> No, that's not right. It breaks the use-whole-paragraph feature. The
> right fix is to encode the embedded newline in the subject properly.

Hrm. It is actually a little more complex. Right now for a subject like:

  one
  two
  three

we will convert that to the subject "one two three" for "git log
--oneline" output. But for email messages, we actually return "one\n
two\n three", which is conflating header folding with the actual
construction of the title.

Shouldn't we still be generating "one two three", encoding it via
rfc2047 if necessary, and _then_ deciding if folding is required? Yes,
individual lines in a multi-line subject are good candidates for
folding, but don't we need to be checking for and folding long lines
anyway?

-Peff
