X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff Garzik <jeff@garzik.org>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sun, 10 Dec 2006 08:45:51 -0500
Message-ID: <457C0F8F.7030504@garzik.org>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org> <200612101109.34267.jnareb@gmail.com> <457C0060.3050605@garzik.org> <200612101402.51363.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050109000907060603030209"
NNTP-Posting-Date: Sun, 10 Dec 2006 13:46:08 +0000 (UTC)
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <200612101402.51363.jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33888>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtP0H-00011b-2v for gcvg-git@gmane.org; Sun, 10 Dec
 2006 14:46:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760736AbWLJNp4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 08:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760735AbWLJNp4
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 08:45:56 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:38003 "EHLO mail.dvmed.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760732AbWLJNpz
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 08:45:55 -0500
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75]
 helo=[10.10.10.10]) by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat
 Linux)) id 1GtP04-0000U0-DP; Sun, 10 Dec 2006 13:45:53 +0000
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

This is a multi-part message in MIME format.
--------------050109000907060603030209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jakub Narebski wrote:
> Jeff Garzik wrote:
>> Jakub Narebski wrote:
>>> P.S. Any hints to how to do this with CGI Perl module?
>> It's impossible, Apache doesn't supply e-tag info to CGI programs.  (it 
>> does supply HTTP_CACHE_CONTROL though apparently)
> 
> By ETag info you mean access to HTTP headers sent by browser
> If-Modified-Since:, If-Match:, If-None-Match: do you?

You can use this attached shell script as a CGI script, to see precisely 
what information Apache gives you.  You can even experiment with passing 
back headers other than Content-type (such as E-tag), to see what sort 
of results are produced.  The script currently passes back both E-Tag 
and Last-Modified of a sample file; modify or delete those lines to suit 
your experiments.


> It's a pity that CGI interface doesn't cover that...
> 
>> You could probably do it via mod_perl.
> 
> So the cache verification should be wrapped in if ($ENV{MOD_PERL}) ?

Sorry, I was /assuming/ mod_perl would make this available.  The HTTP 
header info is available to all Apache modules, but I confess I have no 
idea how mod_perl passes that info to scripts.

Also, an interesting thing while I was testing the attached shell 
script:  even though repeated hits to the script generate a proper 304 
response to the browse, the CGI script and its output run to completion. 
  So, it didn't save work on the CGI side; the savings was solely in not 
transmitting the document from server to client.  The server still went 
through the work of generating the document (by running the CGI), as one 
would expect.

	Jeff



--------------050109000907060603030209
Content-Type: text/plain;
 name="fenv"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fenv"

#!/bin/sh

FN=/tmp/foo

if [ ! -f "$FN" ]
then
	echo "blah blah blah" > "$FN"
fi

HASH=`md5sum "$FN"`

echo "Content-type: text/plain"
echo "E-tag: $HASH"
echo Last-Modified: `date -r /tmp/foo '+%a, %d %b %Y %T %Z'`
echo ""

# don't pollute server environment output with our local additions
unset FN
unset HASH

set

