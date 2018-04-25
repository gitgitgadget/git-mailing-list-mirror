Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A52B1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 17:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755803AbeDYRoz (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 13:44:55 -0400
Received: from [195.159.176.226] ([195.159.176.226]:45780 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1754618AbeDYRox (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 13:44:53 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-3@m.gmane.org>)
        id 1fBORC-00088D-Pw
        for git@vger.kernel.org; Wed, 25 Apr 2018 19:42:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Beat Bolli <dev+git@drbeat.li>
Subject: Re: git https and github
Date:   Wed, 25 Apr 2018 19:44:36 +0200
Message-ID: <f1f59f0d-711c-f8e5-8bc1-13db49f7101b@drbeat.li>
References: <20180425023208.5e76e93d@jive>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
In-Reply-To: <20180425023208.5e76e93d@jive>
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25.04.18 02:32, Lev wrote:
> Hi list,
> 
> 
> I'm struggling with git connecting to Github.
> 
> The problem might be SSL/TLS related.
> 
> https://githubengineering.com/crypto-removal-notice/
> 
> I suspect that my setup still uses tlsv1 or tlsv1.1.
> 
> I've tried to explicitly set git to use tlsv1.2 in my .gitconfig file
> like this:
> 
> [http]
> 	sslVersion = tlsv1.2

This is the default, so this setting should not be needed, unless it's
overridden in some higher prioritized git config file. Have you tried

    git -c http.sslVersion=tlsv1.2 clone <URL>

? This should override any settings files.

> I've tried to re-compile git with OpenSSL and GnuTLS. All give the
> same error.
> 
> git clone https://github.com/OnionIoT/source.git
> Cloning into 'source'...
> * Couldn't find host github.com in the .netrc file; using defaults
> *   Trying 192.30.253.112...
> * TCP_NODELAY set
> * Connected to github.com (192.30.253.112) port 443 (#0)
> * ALPN, offering http/1.1
> * Cipher selection:
> ALL:!EXPORT:!EXPORT40:!EXPORT56:!aNULL:!LOW:!RC4:@STRENGTH
> * successfully set certificate verify locations:
> *   CAfile: /etc/ssl/certs/ca-certificates.crt
>   CApath: /etc/ssl/certs
> * error:1409442E:SSL routines:ssl3_read_bytes:tlsv1 alert protocol
> version
> * Curl_http_done: called premature == 1
> * stopped the pause stream!
> * Closing connection 0
> fatal: unable to access 'https://github.com/OnionIoT/source.git/':
> error:1409442E:SSL routines:ssl3_read_bytes:tlsv1 alert protocol
> version lev@jive:~/git$ unset GIT_SSL_VERSION lev@jive:~/git$ git clone
> https://github.com/OnionIoT/source.git Cloning into 'source'...
> * Couldn't find host github.com in the .netrc file; using defaults
> *   Trying 192.30.253.112...
> * TCP_NODELAY set
> * Connected to github.com (192.30.253.112) port 443 (#0)
> * ALPN, offering http/1.1
> * Cipher selection:
> ALL:!EXPORT:!EXPORT40:!EXPORT56:!aNULL:!LOW:!RC4:@STRENGTH
> * successfully set certificate verify locations:
> *   CAfile: /etc/ssl/certs/ca-certificates.crt
>   CApath: /etc/ssl/certs
> * error:1409442E:SSL routines:ssl3_read_bytes:tlsv1 alert protocol
> version
> * Curl_http_done: called premature == 1
> * stopped the pause stream!
> * Closing connection 0
> fatal: unable to access 'https://github.com/OnionIoT/source.git/':
> error:1409442E:SSL routines:ssl3_read_bytes:tlsv1 alert protocol version
> 
> 
> I can connect to other git servers without any error. This is a debian
> stable system with the following components:
> 
> 	git version 2.11.0
> 	libcurl 7.52.1
> 	OpenSSL 1.0.2l

This OpenSSL version is certainly recent enough to support TLSv1.2. Are
you sure you ran the newly compiled git binary?

(Sorry for asking stupid questions; it's sometimes difficult to get to
the root of a problem)

> 
> 
> Is there any way to know what is the exact protocol used? Are there any
> workaround, fix for this issue?
> 
> Any help welcome. Thank you,
> Levente
> 


Cheers,
Beat

