From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin-blame.c: Use utf8_strwidth for author's names
Date: Sat, 31 Jan 2009 02:24:25 -0500
Message-ID: <20090131072425.GD3033@coredump.intra.peff.net>
References: <1233308489-2656-1-git-send-email-geofft@mit.edu> <1233308489-2656-2-git-send-email-geofft@mit.edu> <alpine.DEB.1.00.0901301811180.3586@pacific.mpi-cbg.de> <alpine.DEB.2.00.0901301710130.1984@vinegar-pot.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Geoffrey Thomas <geofft@MIT.EDU>
X-From: git-owner@vger.kernel.org Sat Jan 31 08:26:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTAEj-0005AE-1U
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 08:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbZAaHY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 02:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbZAaHY1
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 02:24:27 -0500
Received: from peff.net ([208.65.91.99]:43022 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409AbZAaHY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 02:24:27 -0500
Received: (qmail 10522 invoked by uid 107); 31 Jan 2009 07:24:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 31 Jan 2009 02:24:37 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 31 Jan 2009 02:24:25 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0901301710130.1984@vinegar-pot.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107911>

On Fri, Jan 30, 2009 at 05:22:07PM -0500, Geoffrey Thomas wrote:

> I don't believe there are any encoding conversions performed up to that  
> point. IIRC git doesn't require any encoding but encourages UTF-8; if it's 
> something obscure, I have no way of knowing how wide in screen columns the 
> author field is because I likely don't have a library for it in git at  
> all. I do have a utf8.c, though.

Don't we pull the author from the commit message after it has been
converted using reencode_commit_message (see get_commit_info)? That
should be respecting the log output encoding.

It looks like we just throw away the information on what we encoded _to_
(i.e., the second parameter of reencode_commit_message).  Probably we
need to remember that and use a generic "what is the width of this
string in this encoding" function.

-Peff
