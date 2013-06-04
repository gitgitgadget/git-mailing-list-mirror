From: Janusz Harkot <janusz.harkot@gmail.com>
Subject: Re: SNI (SSL virtual hosts)
Date: Tue, 4 Jun 2013 12:19:54 +0200
Message-ID: <8B7A2C3A8CC346D6B34D153F591F878F@gmail.com>
References: <DC851F5EA18E478DACB62178624BF5B7@gmail.com>
 <97F8F367D27D4B3E93439FF8D0F121FA@gmail.com>
 <alpine.DEB.2.00.1306041142200.16303@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Tue Jun 04 12:20:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjoLU-0006dX-R5
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 12:20:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927Ab3FDKUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 06:20:01 -0400
Received: from mail-ea0-f178.google.com ([209.85.215.178]:58658 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299Ab3FDKT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 06:19:59 -0400
Received: by mail-ea0-f178.google.com with SMTP id q15so18132ead.37
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 03:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject:x-mailer
         :mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=ZS+Ycn0hUDpYv+UvwiELaVeWIS82UOlzz3b0iTIZG4A=;
        b=TX2hBmVyQjHS2rmnsrDI8oMW11dJKO23RWlKUWPNGY34ls0zJcEG9/kTPcqz9uOP6H
         5avXuuMYoPm2ooCkUO1JE+e8XKq+5bHcyJvQujn1gRNXQI+5oN8sjUuISUccRMEmCm33
         /MnBRoVSMBUXSUBKrgye3Nc8PNqaMfxVKsmyKkxmrPf2ZrmraM/R9gC+ITAooI2bKESD
         LAXMO/oGEIM/HrYNGhY6TiHYf99cBgF2WSPMlIivigp5Rg17EApU9qT+1sWRh393tI74
         FqkMeDy969CbricMApeTRrCdBQSp8n8go5lbfAj/J+vH4U8NFFn8JCPcEZ6SZOmU8Sz0
         wBbw==
X-Received: by 10.15.64.66 with SMTP id n42mr25516230eex.148.1370341198077;
        Tue, 04 Jun 2013 03:19:58 -0700 (PDT)
Received: from [10.0.1.200] (77-252-124-82.ip.netia.com.pl. [77.252.124.82])
        by mx.google.com with ESMTPSA id a5sm90813181ees.6.2013.06.04.03.19.56
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 03:19:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1306041142200.16303@tvnag.unkk.fr>
X-Mailer: sparrow 1.6.4 (build 1178)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226339>

> It does. git uses libcurl for the HTTPS parts and it has support SNI for a 
> long time, assuming you built libcurl with a TLS library that handles it.
> 
> Which libcurl version and SSL backend is this? (curl -V usually tells)
$ curl -V
curl 7.24.0 (x86_64-apple-darwin12.0) libcurl/7.24.0 OpenSSL/0.9.8r zlib/1.2.5
Protocols: dict file ftp ftps gopher http https imap imaps ldap ldaps pop3 pop3s rtsp smtp smtps telnet tftp 
Features: AsynchDNS GSS-Negotiate IPv6 Largefile NTLM NTLM_WB SSL libz 

$ otool -L /usr/local/bin/git
/usr/local/bin/git:
/usr/lib/libz.1.dylib (compatibility version 1.0.0, current version 1.2.5)
/usr/lib/libiconv.2.dylib (compatibility version 7.0.0, current version 7.0.0)
/usr/local/opt/openssl/lib/libcrypto.1.0.0.dylib (compatibility version 1.0.0, current version 1.0.0)
/usr/local/opt/openssl/lib/libssl.1.0.0.dylib (compatibility version 1.0.0, current version 1.0.0)
/usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 169.3.0)



> If you made it working by disabling certificate verification then it sounds as 
> if SNI might still have worked and the problem was rahter something else, as 
> without SNI you can't do name-based virtual hosting over HTTPS - but perhaps 
> you wanted to communicate with the "default" server on that IP?

here is a log (with GIT_CURL_VERBOSE=1)

https://gist.github.com/anonymous/8f6533a755ae5c710c75 

Initial connection is correct (line 10 - shows that it reads correct certificate),
 but then subsequent call to the server (line 68) shows that the defat server certificate is used.

It looks like the second call was without hostname (?).

Thanks!
Janusz
