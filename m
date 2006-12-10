X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff Garzik <jeff@garzik.org>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sun, 10 Dec 2006 17:05:32 -0500
Message-ID: <457C84AC.7060105@garzik.org>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org> <200612101402.51363.jnareb@gmail.com> <457C0F8F.7030504@garzik.org> <200612102011.52589.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 22:05:53 +0000 (UTC)
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <200612102011.52589.jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33935>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtWns-00082e-Up for gcvg-git@gmane.org; Sun, 10 Dec
 2006 23:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935310AbWLJWFh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 17:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935336AbWLJWFg
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 17:05:36 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:41227 "EHLO mail.dvmed.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S935310AbWLJWFf
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 17:05:35 -0500
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75]
 helo=[10.10.10.10]) by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat
 Linux)) id 1GtWnd-0002tw-8C; Sun, 10 Dec 2006 22:05:34 +0000
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
> Adn in CGI standard there is a way to access additional HTTP headers
> info from CGI script: the envirionmental variables are HTTP_HEADER,
> for example if browser sent If-Modified-Since: header it's value
> can be found in HTTP_IF_MODIFIED_SINCE environmental variable.

The CGI spec does not at all guarantee that the CGI environment will 
contain all the HTTP headers sent by the client.  That was the point of 
the environment dump script -- you can see exactly which headers are, 
and are not, passed through to CGI.

CGI only /guarantees/ a bare minimum (things like QUERY_STRING, 
PATH_INFO, etc.)

Even basic server info environment variables are optional.


> It is ETag, not E-tag. Besides, I don't see what the attached script is
> meant to do: it does not output the sample file anyway.

It's not meant to output the sample file.  It outputs the server 
metadata sent to the CGI script (the environment variables).  The sample 
file was simply a way to play around with etag and last-modified metadata.


> The idea is of course to stop processing in CGI script / mod_perl script
> as soon as possible if cache validates.

Certainly.  That should help cut down on I/O.  FWIW though the projects 
list is particularly painful, with its File::Find call, which you'll 
need to do in order to return 304-not-modified.


> I don't know if Apache intercepts and remembers ETag and Last-Modified
> headers, adds 304 Not Modified HTTP response on finding that cache validates
> and cuts out CGI script output. I.e. if browser provided If-Modified-Since:,
> script wrote Last-Modified: header, If-Modified-Since: is no earlier than
> Last-Modified: (usually is equal in the case of cache validation), then
> Apache provides 304 Not Modified response instead of CGI script output.

This wanders into the realm of mod_cache configuration, I think.  (which 
I have tried to get working as reverse proxy, and failed serveral times) 
  If you are not using mod_*_cache, then Apache must execute the CGI 
script every time AFAICS, regardless of etag/[if-]last-mod headers.

	Jeff


