X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-cvsimport: add suport for CVS pserver method HTTP/1.x proxying
Date: Thu, 23 Nov 2006 15:02:00 -0800
Message-ID: <7vlkm1ix7b.fsf@assigned-by-dhcp.cox.net>
References: <11642344172790-git-send-email-iarenuno@eteo.mondragon.edu>
	<7v64d5keke.fsf@assigned-by-dhcp.cox.net>
	<45661C36.9010101@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 23 Nov 2006 23:02:22 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <45661C36.9010101@catalyst.net.nz> (Martin Langhoff's message of
	"Fri, 24 Nov 2006 11:09:58 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32167>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnNa6-0007i2-7Y for gcvg-git@gmane.org; Fri, 24 Nov
 2006 00:02:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934241AbWKWXCH convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006 18:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934242AbWKWXCH
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 18:02:07 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:5613 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S934241AbWKWXCE
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006
 18:02:04 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061123230201.EFZN18207.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Thu, 23
 Nov 2006 18:02:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qP281V01Q1kojtg0000000; Thu, 23 Nov 2006
 18:02:09 -0500
To: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
Sender: git-owner@vger.kernel.org

"Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz> writes:

> Junio C Hamano wrote:
>> Except that this statement made me go "huh?" wondering what it
>> would do to the $filehandle to evaluate <$filehandle> in a void
>> context:
>>
>> +			# Skip the empty line of the proxy server output
>> +			<$s>;
>
> It's a perl idiom that will discard one line of the $filehandle. If w=
e
> are 200% certain that it is empty, then it's fine. OTOH, it may well
> be a bug in the particular proxy implementation I=F1aki is using -- I
> don't know enough about CVS proxying to tell.

It is more about HTTP proxying and it is my understanding that
response to CONNECT method request has that empty line after the
successful (2xx) response line and zero or more response
headers.  The code is still wrong; it does not have a loop to
discard the potential response headers that come before the
empty line the code we are discussing discards.

By the way does anybody know where this behaviour is officially
specified?  Luotonen's draft-luotonen-web-proxy-tunneling-01.txt
is pretty clear about the empty line that comes after the
response headers, but that document being an internet-draft has
expired long time ago, but still seem to be quoted by others.

>> The "I/O Operators" section talks about evaluating <$s> in a
>> scalar context (i.e. "$rep =3D <$s>"), which we all know would
>> return a single line, and in list context, which swallows
>
> This is in scalar context, and that's safe to rely on.

If it were in scalar context I would agree fully.  That
behaviour is documented.  But my point is that it is in void
context, and I did not find document specifying what should
happen.
