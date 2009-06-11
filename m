From: Karsten Weiss <knweiss@gmx.de>
Subject: Re: https, client certificate, pem pass phrase
Date: Thu, 11 Jun 2009 18:43:50 +0200 (CEST)
Message-ID: <alpine.OSX.2.00.0906111801400.67531@xor.localnet>
References: <alpine.OSX.2.00.0906110956370.945@xor.localnet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 18:45:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEnOh-0000U1-V3
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 18:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758457AbZFKQoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 12:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756803AbZFKQoe
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 12:44:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:38527 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755453AbZFKQod (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 12:44:33 -0400
Received: (qmail invoked by alias); 11 Jun 2009 16:44:33 -0000
Received: from port-92-200-99-90.dynamic.qsc.de (EHLO mail.localnet) [92.200.99.90]
  by mail.gmx.net (mp012) with SMTP; 11 Jun 2009 18:44:33 +0200
X-Authenticated: #3612999
X-Provags-ID: V01U2FsdGVkX19+YTRVxDd+We/8YBqAWgOc9Cxqp/1HCx1KW0w8C6
	Rb6KELFw92sdiO
Received: by mail.localnet (Postfix, from userid 502)
	id E1680B863B7; Thu, 11 Jun 2009 18:43:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.localnet (Postfix) with ESMTP id CE576B863A8;
	Thu, 11 Jun 2009 18:43:50 +0200 (CEST)
In-Reply-To: <alpine.OSX.2.00.0906110956370.945@xor.localnet>
User-Agent: Alpine 2.00 (OSX 1167 2008-08-23)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121348>

On Thu, 11 Jun 2009, Karsten Weiss wrote:

> However, it only works as long as I do *not* protect the client's private key 
> (PEM) with a pass phrase which is not secure (especially when using 
> FakeBasicAuth!). When I do protect the private key with a pass phrase *each* 
> git fetch/pull/push prompts the user *several* times with "Enter PEM pass 
> phrase:". Thus, it's not usable (even though it works).

Somehow I managed to miss Mark Lodato's posting from 2009-05-28 before:

[PATCH 1/2] http.c: prompt for SSL client certificate password
http://marc.info/?l=git&m=124348062226665&w=4
[PATCH 2/2] http.c: add http.sslCertNoPass option
http://marc.info/?l=git&m=124348062326671&w=4

I can confirm that his two patches solve the problem. I.e. there is now 
only a single passphrase prompt during each Git invocation that involves 
the https protocol. Great!

However, I want to add two additional suggestions:

With the patch Git prompts for a "Certificate Password". IMHO it would be 
better to prompt for the "Certificate private key passphrase" because it's 
the private key which is protected and not the certificate itself. The 
config flag IMHO also should be renamed from http.sslCertNoPass to 
http.sslKeyNoPassphrase. (Of course it would be even nicer if the code 
could detect if the key has a passphrase and only prompt for it when 
really necessary)

Regarding the caching of the passphrase in memory: Maybe the passphrase 
memory region could be mlock()ed to prevent the kernel from paging it to 
disk? But I'm not sure if this is worth effort.
