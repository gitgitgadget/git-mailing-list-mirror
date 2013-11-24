From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: error: git-remote-https died of signal 13
Date: Sun, 24 Nov 2013 17:13:26 +0100
Message-ID: <529225A6.7000802@googlemail.com>
References: <5290D994.9040505@googlemail.com> <20131124065400.GB5535@sigill.intra.peff.net> <5291F70A.7070508@googlemail.com> <20131124133356.GA3507@sigill.intra.peff.net> <529214D7.1030203@googlemail.com> <20131124155439.GA8047@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Daniel Stenberg <daniel@haxx.se>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 24 17:13:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkcJg-00054S-AE
	for gcvg-git-2@plane.gmane.org; Sun, 24 Nov 2013 17:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703Ab3KXQN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Nov 2013 11:13:29 -0500
Received: from mail-ea0-f179.google.com ([209.85.215.179]:46292 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644Ab3KXQN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 11:13:29 -0500
Received: by mail-ea0-f179.google.com with SMTP id r15so1830638ead.24
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 08:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=kifzLtnEo7kjDNUVdcKCD+V5RhBrghoKT3iIFxaTViM=;
        b=qye5C8iD5EylHBfvjh8fcXmW1kBsf2pKH39OuLRmosjRbcuqs4630aT6vtH/6aTYOb
         nFYOPPYZary2l/3h1oj8WwyRAMQ3kbHWqyEpjJi0wPdr/oocvunzmlFoUcRMvdjRaCfP
         uiBHaIeeLKm+X6cUIiQQ3bPKFbO40/j8Ydiv4gcfi7vFBHbPn1C7JkRChgpTmKwXx8Ia
         9a/KJIpo7gGNyp8pYaMziX501J8yxhi57wW1VQo/9ySAEL9t1fVzlI5FKl9gFFZj3rPD
         Im3wBbMnJMODphn2LwXKwrNZc++JsluGmaGn1t6ab/cN4c9nSqrXrmHxzaYaREloU7zK
         CedQ==
X-Received: by 10.14.179.130 with SMTP id h2mr2985758eem.34.1385309607443;
        Sun, 24 Nov 2013 08:13:27 -0800 (PST)
Received: from [192.168.1.9] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id g47sm93268043eeo.19.2013.11.24.08.13.26
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Nov 2013 08:13:26 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <20131124155439.GA8047@sigill.intra.peff.net>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238263>

On 24.11.2013 16:54, Jeff King wrote:
> Hmm. The fix in curl's 7d80ed64e435155 seems to involve strategically
> placed calls to ignore SIGPIPE. I wonder if there is another spot that
> needs similar treatment. It looks like curl_easy_cleanup is covered,
> though, and that's where I would expect problem to come.
> 
> It would be interesting to see a backtrace from remote-curl when we get
> the SIGPIPE. Doing so would be slightly tricky; instrumenting with the
> patch below may be enough.

Ok I'll test that now.

> 
> Another thought is that the curl fix seems to only kick in when built
> with openssl support.  I'm not sure I understand how ubuntu's packaging
> of curl uses gnutls versus openssl for the shared library. That may be
> related.
> 

A better information would be the --version from curl then:
curl --version
curl 7.32.0 (x86_64-pc-linux-gnu) libcurl/7.32.0 OpenSSL/1.0.1e zlib/1.2.8 libidn/1.28 librtmp/2.3
Protocols: dict file ftp ftps gopher http https imap imaps ldap ldaps pop3 pop3s rtmp rtsp smtp smtps telnet tftp 
Features: AsynchDNS GSS-Negotiate IDN IPv6 Largefile NTLM NTLM_WB SSL libz TLS-SRP
