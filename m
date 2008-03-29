From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with
	non-ascii characters
Date: Sat, 29 Mar 2008 05:11:45 -0400
Message-ID: <20080329091145.GA19501@coredump.intra.peff.net>
References: <20080328212700.GA9529@coredump.intra.peff.net> <200803290941.54091.robin.rosenberg.lists@dewire.com> <20080329084947.GB19200@coredump.intra.peff.net> <200803291002.43768.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Mar 29 10:12:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfX6z-0002U1-9h
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 10:12:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbYC2JLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 05:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752172AbYC2JLr
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 05:11:47 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1757 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751199AbYC2JLr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 05:11:47 -0400
Received: (qmail 21088 invoked by uid 111); 29 Mar 2008 09:11:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 29 Mar 2008 05:11:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Mar 2008 05:11:45 -0400
Content-Disposition: inline
In-Reply-To: <200803291002.43768.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78459>

On Sat, Mar 29, 2008 at 10:02:43AM +0100, Robin Rosenberg wrote:

> My proof is entirely empirical. What happens is that attempting to decode a 
> non-UTF-8 string will put a unicode surrogate pair into the (now Unicode) 
> string and encoding will just encode the surrogate pair into UTF-8 and not 
> the original. As a result, the encode(decode($x)) eq $x *only* if $x is a
> valid UTF-8 octet sequence. Why would you not get the original back if
> you start with valid UTF-8?

Because some UTF-8 sequences have multiple representations, and that
information may be lost by whatever intermediate form is the result of
decode($x). In practice, I don't know if this happens or not.

Though it looks like there is an Encode::is_utf8 function (which is also
utf8::is_utf8, but only in perl >= 5.8.1). So we could use that, but it
needs the utf-8 flag turned on for the string. Maybe utf8::valid is
actually what we want.

But there is still a larger question. You have some binary bytes that
will go in a subject header. There are non-ascii bytes. There are
non-utf8 sequences. What do you do?

-Peff
