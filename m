X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-cvsimport: add suport for CVS pserver method HTTP/1.x proxying
Date: Thu, 23 Nov 2006 16:24:48 -0800
Message-ID: <7v7ixlhesv.fsf@assigned-by-dhcp.cox.net>
References: <11642344172790-git-send-email-iarenuno@eteo.mondragon.edu>
	<7v64d5keke.fsf@assigned-by-dhcp.cox.net>
	<45661C36.9010101@catalyst.net.nz>
	<7vlkm1ix7b.fsf@assigned-by-dhcp.cox.net>
	<46a038f90611231552x3e33eec4w7863ce6a1da5781b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 00:25:02 +0000 (UTC)
Cc: git@vger.kernel.org, <iarenuno@eteo.mondragon.edu>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <46a038f90611231552x3e33eec4w7863ce6a1da5781b@mail.gmail.com>
	(Martin Langhoff's message of "Fri, 24 Nov 2006 12:52:13 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32183>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnOsC-0003Xr-PE for gcvg-git@gmane.org; Fri, 24 Nov
 2006 01:24:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757510AbWKXAYx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 19:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757520AbWKXAYx
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 19:24:53 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:18879 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1757510AbWKXAYw
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 19:24:52 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061124002449.HFP4226.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Thu, 23
 Nov 2006 19:24:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qQQx1V00A1kojtg0000000; Thu, 23 Nov 2006
 19:24:57 -0500
To: "Martin Langhoff" <martin.langhoff@gmail.com>
Sender: git-owner@vger.kernel.org

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> On 11/24/06, Junio C Hamano <junkio@cox.net> wrote:
>> It is more about HTTP proxying and it is my understanding that
>> response to CONNECT method request has that empty line after the
>> successful (2xx) response line and zero or more response
>> headers.  The code is still wrong; it does not have a loop to
>> discard the potential response headers that come before the
>> empty line the code we are discussing discards.
>
> You are right. It should be something along the lines of
>
>  # discard headers until first blank line
>  while (<$s> ne '') {
>      # nothing
>  }
>
> that is, assuming we can just ignore headers happily.

Yes, or "1 while (<$s> ne '')" which is listed as an example for
a kosher way to use a constant to express no-op in void context ;-).

        =head2 No-ops
        X<no-op> X<nop>

        Perl doesn't officially have a no-op operator, but the bare constants
        C<0> and C<1> are special-cased to not produce a warning in a void
        context, so you can for example safely do

            1 while foo();

