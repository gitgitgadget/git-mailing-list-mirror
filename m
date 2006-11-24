X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-cvsimport: add suport for CVS pserver method HTTP/1.x proxying
Date: Thu, 23 Nov 2006 20:42:05 -0500
Message-ID: <20061124014205.GA19515@sigio.intra.peff.net>
References: <11642344172790-git-send-email-iarenuno@eteo.mondragon.edu> <7v64d5keke.fsf@assigned-by-dhcp.cox.net> <45661C36.9010101@catalyst.net.nz> <7vlkm1ix7b.fsf@assigned-by-dhcp.cox.net> <46a038f90611231552x3e33eec4w7863ce6a1da5781b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 01:46:36 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <46a038f90611231552x3e33eec4w7863ce6a1da5781b@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32185>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnQ4Y-0006hC-Rk for gcvg-git@gmane.org; Fri, 24 Nov
 2006 02:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757557AbWKXBln (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 20:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757558AbWKXBln
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 20:41:43 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:50886
 "HELO peff.net") by vger.kernel.org with SMTP id S1757557AbWKXBlm (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 20:41:42 -0500
Received: (qmail 24273 invoked from network); 23 Nov 2006 20:41:47 -0500
Received: from unknown (HELO sigio.intra.peff.net) (10.0.0.10) by
 segfault.intra.peff.net with SMTP; 23 Nov 2006 20:41:47 -0500
Received: by sigio.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Nov
 2006 20:42:05 -0500
To: Martin Langhoff <martin.langhoff@gmail.com>
Sender: git-owner@vger.kernel.org

On Fri, Nov 24, 2006 at 12:52:13PM +1300, Martin Langhoff wrote:

> You are right. It should be something along the lines of
> 
>  # discard headers until first blank line
>  while (<$s> ne '') {
>      # nothing
>  }
> 
> that is, assuming we can just ignore headers happily.

That code won't work; the value of a blank line will actually be "\n"
(or "\r\n"). So you probably want:

while (<$s>) {
  chomp; chomp;
  last unless $_;
}

or perhaps more readably:

while (<$s>) {
  last if $_ eq "\n" || $_ eq "\r\n";
}

