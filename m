From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] send-email: If the ca path is not specified, use the defaults
Date: Thu, 16 Jan 2014 20:21:32 -0800
Message-ID: <E036CD5E-69B1-4ABD-957B-8E31D410A897@gmail.com>
References: <1389807071-26746-1-git-send-email-i.gnatenko.brain@gmail.com> <xmqqa9ex2gi6.fsf@gitster.dls.corp.google.com> <7AD1C6ED-6177-415D-B342-D1FEA9F810B4@rubenkerkhof.com> <xmqqob3d0w7g.fsf@gitster.dls.corp.google.com> <20140115215024.GM18964@google.com> <xmqqppnry0p9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Ruben Kerkhof <ruben@rubenkerkhof.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Igor Gnatenko <i.gnatenko.brain@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 17 05:21:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W40wC-0008Lx-97
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 05:21:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbaAQEVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 23:21:37 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:46823 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbaAQEVf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 23:21:35 -0500
Received: by mail-pd0-f175.google.com with SMTP id r10so3491929pdi.20
        for <git@vger.kernel.org>; Thu, 16 Jan 2014 20:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=cctKDpqnA5nmr4Cl7tIitKYMjNqtMDE0kj978ZSKs9Y=;
        b=g832ZBxom/UVpXwRug5bs4pehaNNonrGEnyq/LJY4jOdSWylRbR2EzjFbt+2+z7p+f
         wX5pxVM6lDm7STr5mWU0SxT30xR5CD0a3vzvY0C+jouiknVqHjxpKSn4Qwah9qXO3gvT
         gzVBilMM7ur6MJy6kitAsdYgAF52KXLlpzltWOVXdmn6caoqKIt8z72nO69at2QrId8W
         EBP8kYkwO6mF2JEXZBRR5b8dJ85/ypMZgvQLjOSVoF7ctMO4hl9STjOBgMwW+tboD3ak
         OimpA5TKVc7TKYwlIo8dCUtRxKyH+87NIhc+moBxRQyReEUcrHKlU5YFvEFRuGmSHOVz
         UiSQ==
X-Received: by 10.68.244.103 with SMTP id xf7mr14378896pbc.50.1389932495480;
        Thu, 16 Jan 2014 20:21:35 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id gw11sm7994647pbd.17.2014.01.16.20.21.33
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 16 Jan 2014 20:21:34 -0800 (PST)
In-Reply-To: <xmqqppnry0p9.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240571>

On Jan 16, 2014, at 15:19, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> FWIW this should help on Mac OS X, too.  Folks using git on mac
>> at $DAYJOB have been using the workaround described at
>> http://mercurial.selenic.com/wiki/CACertificates#Mac_OS_X_10.6_and_higher
>> so I forgot to report it. :/
>
> Hmph, is that the same issue, though?  That page seems to suggest
> using an empty ca file that does not have any useful information as
> a workaround.

I had written up this draft email that describes the situation on OS X  
and decided it might not be exactly on topic and wasn't going to send  
it, but, since you asked... ;)

OpenSSL's default location can be found with:

   openssl version -d

On my Ubuntu system I get this:

   $ openssl version -d
   OPENSSLDIR: "/usr/lib/ssl"

Then if I look in there like so:

   $ ls -l /usr/lib/ssl
   total 8
   lrwxrwxrwx 1 root root   14 certs -> /etc/ssl/certs
   drwxr-xr-x 2 root root 4096 engines
   drwxr-xr-x 2 root root 4096 misc
   lrwxrwxrwx 1 root root   20 openssl.cnf -> /etc/ssl/openssl.cnf
   lrwxrwxrwx 1 root root   16 private -> /etc/ssl/private

And that's how it ends up using /etc/ssl/certs.  From the  
SSL_CTX_load_verify_locations man page:

   "When looking up CA certificates, the OpenSSL library will first  
search the certificates in CAfile, then those in CApath."

The default CAfile is "cert.pem" and the default CApath is "certs"  
both located in the openssl version -d directory.  See the crypto/ 
cryptlib.h header [1].

On my OS X platform depending on which version of OpenSSL I'm using,  
the OPENSSLDIR path would be one of these:

   /System/Library/OpenSSL
   /opt/local/etc/openssl

And neither of those uses a "certs" directory, they both use a  
"cert.pem" bundle instead:

   $ ls -l /System/Library/OpenSSL
   total 32
   lrwxrwxrwx  1 root  wheel    42 cert.pem -> ../../../usr/share/curl/ 
curl-ca-bundle.crt
   drwxr-xr-x  2 root  wheel    68 certs
   drwxr-xr-x  8 root  wheel   272 misc
   -rw-r--r--  1 root  wheel  9381 openssl.cnf
   drwxr-xr-x  2 root  wheel    68 private
   # the certs directory is empty

   $ ls -l /opt/local/etc/openssl
   total 32
   lrwxrwxrwx   1 root  admin    35 cert.pem@ -> ../../share/curl/curl- 
ca-bundle.crt
   drwxr-xr-x   9 root  admin   306 misc/
   -rw-r--r--   1 root  admin 10835 openssl.cnf

Notice neither of those refers to /etc/ssl/certs at all.

So the short answer is, yes, hard-coding /etc/ssl/certs as the path on  
OS X is incorrect and if setting /etc/ssl/certs as the path has the  
effect of replacing the default locations the verification will  
fail.   Of course Apple patches the included version of OpenSSL  
starting with OS X 10.6 to look in Apple's keychain, but if you're  
using a MacPorts-built version that won't happen and still /etc/ssl/ 
certs will be wrong in both cases.

As for the hint in that wiki/CACertificates link above, that does seem  
odd to me as well.

A much better solution would be (if python simply MUST have a file) to  
export the system's list of trusted root certificates like so:

   security export -k \
     /System/Library/Keychains/SystemRootCertificates.keychain \
     -t certs -f pemseq > rootcerts.pem

   # the generated rootcerts.pem file is suitable for use with the
   # openssl verify -CAfile option (root certs)

   # Substituting SystemCACertificates for SystemRootCertificates
   # produces a file suitable for use with the
   # openssl verify -untrusted option (intermediate certs)

and then point python to that rootcerts.pem file.  This file [2] may  
be helpful in understanding what's in SystemRootCertificates.keychain  
and SystemCACertificates.keychain.  The intermediate certs may also  
need to be exported to a file and pointed to as well (a quick glance  
at the hgrc docs did not turn up an option for this).

--Kyle

[1] http://git.openssl.org/gitweb/?p=openssl.git;a=blob;f=crypto/cryptlib.h#l84
[2] <http://www.opensource.apple.com/source/security_certificates/security_certificates-32641/CertificateInstructions.rtf 
 >
