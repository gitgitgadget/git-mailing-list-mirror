From: Karsten Weiss <knweiss@gmx.de>
Subject: Re: [PATCH 2/2] http.c: add http.sslCertType and http.sslKeyType
Date: Tue, 16 Jun 2009 22:07:34 +0200 (CEST)
Message-ID: <alpine.OSX.2.00.0906162137100.80034@xor.localnet>
References: <1245033541-15558-1-git-send-email-lodatom@gmail.com>  <1245033541-15558-2-git-send-email-lodatom@gmail.com>  <alpine.OSX.2.00.0906151927010.816@xor.localnet> <ca433830906151755t783fbf98k3fd09e4bdd6781e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Stenberg <daniel@haxx.se>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 22:09:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGey6-0000GT-LE
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 22:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754582AbZFPUIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 16:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753962AbZFPUIo
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 16:08:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:54537 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753081AbZFPUIn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 16:08:43 -0400
Received: (qmail invoked by alias); 16 Jun 2009 20:08:39 -0000
Received: from port-92-200-104-104.dynamic.qsc.de (EHLO mail.localnet) [92.200.104.104]
  by mail.gmx.net (mp041) with SMTP; 16 Jun 2009 22:08:39 +0200
X-Authenticated: #3612999
X-Provags-ID: V01U2FsdGVkX1+q2XA3kk+qrY7jH8EQBMrG0lRmGJrIlj2QrAKF68
	GdC6Q0oivn4Jpw
Received: by mail.localnet (Postfix, from userid 502)
	id 89F3ABAB805; Tue, 16 Jun 2009 22:07:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.localnet (Postfix) with ESMTP id 830FEBAB7F9;
	Tue, 16 Jun 2009 22:07:34 +0200 (CEST)
In-Reply-To: <ca433830906151755t783fbf98k3fd09e4bdd6781e8@mail.gmail.com>
User-Agent: Alpine 2.00 (OSX 1167 2008-08-23)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121710>

On Mon, 15 Jun 2009, Mark Lodato wrote:

>> (However, it's a similar issue like the question whether the private key is
>> encrypted or not: Usability would be better if the certificate type could be
>> determined automatically (without having to violate the layering)).
>
> Just as with determining if the certificate is password protected, it
> is equally difficult to tell what type of file it is without calling
> OpenSSL directly.

Hm, thinking about the encryption case: Maybe I'm missing something but 
wouldn't it be enough to simply peek at the key file and look for the 
string "ENCRYPTED" in a header like this?

-----BEGIN RSA PRIVATE KEY-----
Proc-Type: 4,ENCRYPTED

I.e. a simple, temporary solution that does not depend on OpenSSL to 
prevent the introduction of the new http.sslCertNoPass flag?

(But now that you've also created patches for PKCS12 support this might 
not be feasible anymore?)

> This brings up a good point: Should we (I) try to implement (client
> certificate) usability features in git to work around deficiencies in
> libcurl, or should we (I) write patches to fix/enhance libcurl
> directly?  The latter would be much easier (though I could be wrong)
> and would benefit other programs using libcurl, but would require
> users to upgrade libcurl to get these new features, and of course
> would rely on the libcurl developers accepting the patches.  I am
> willing to do either, but I think the libcurl route would be better.
> Any thoughts?

(As a git user without libcurl insights) I think that such query functions 
about private keys (Is it encrypted?) or certificates (What type is it?) 
would make sense and belong into libcurl. (And it would be great if these 
queries could be answered *without* performing actual trial network 
connections just by looking into the respective key/certificate files.)

Karsten
