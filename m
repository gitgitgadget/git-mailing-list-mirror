Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91B2E201B0
	for <e@80x24.org>; Thu, 23 Feb 2017 01:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932456AbdBWBFN convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 22 Feb 2017 20:05:13 -0500
Received: from mxo1.dft.dmz.twosigma.com ([208.77.212.183]:37273 "EHLO
        mxo1.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932197AbdBWBFL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 20:05:11 -0500
Received: from localhost (localhost [127.0.0.1])
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTP id 4DEFB100152;
        Thu, 23 Feb 2017 01:03:40 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XxBSizTOWL4R; Thu, 23 Feb 2017 01:03:40 +0000 (GMT)
Received: from exmbdft6.ad.twosigma.com (exmbdft6.ad.twosigma.com [172.22.1.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTPS id 3BA1D80035;
        Thu, 23 Feb 2017 01:03:40 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft6.ad.twosigma.com (172.22.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Thu, 23 Feb 2017 01:03:39 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%23]) with mapi id
 15.00.1263.000; Thu, 23 Feb 2017 01:03:39 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>
CC:     'Junio C Hamano' <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: RE: [PATCH] http(s): automatically try NTLM authentication first
Thread-Topic: [PATCH] http(s): automatically try NTLM authentication first
Thread-Index: AQHSjUkLCk8cFwxeyUi81jfhwIejKqF1d7vggAA2E4CAAAH0cA==
Date:   Thu, 23 Feb 2017 01:03:39 +0000
Message-ID: <b152fad7e79046c5aa6cac9e21066c1c@exmbdft7.ad.twosigma.com>
References: <20170222173936.25016-1-dturner@twosigma.com>
 <xmqqpoiaasgj.fsf@gitster.mtv.corp.google.com>
 <97ab9a812f7b46d7b10d4d06f73259d8@exmbdft7.ad.twosigma.com>
 <20170222233419.q3fxqmrscosumbjm@genre.crustytoothpaste.net>
In-Reply-To: <20170222233419.q3fxqmrscosumbjm@genre.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: brian m. carlson [mailto:sandals@crustytoothpaste.net]
> 
> This is SPNEGO.  It will work with NTLM as well as Kerberos.
> 
> Browsers usually disable this feature by default, as it basically will attempt to
> authenticate to any site that sends a 401.  For Kerberos against a malicious
> site, the user will either not have a valid ticket for that domain, or the user's
> Kerberos server will refuse to provide a ticket to pass to the server, so
> there's no security risk involved.
> 
> I'm unclear how SPNEGO works with NTLM, so I can't speak for the security
> of it.  From what I understand of NTLM and from RFC 4559, it consists of a
> shared secret.  I'm unsure what security measures are in place to not send
> that to an untrusted server.
> 
> As far as Kerberos, this is a desirable feature to have enabled, with little
> downside.  I just don't know about the security of the NTLM part, and I don't
> think we should take this patch unless we're sure we know the
> consequences of it.

NTLM on its own is bad:

https://msdn.microsoft.com/en-us/library/windows/desktop/aa378749(v=vs.85).aspx
says:

"
1. (Interactive authentication only) A user accesses a client computer and 
provides a domain name, user name, and password. The client computes a 
cryptographic hash of the password and discards the actual password.
2. The client sends the user name to the server (in plaintext).
3. The server generates a 16-byte random number, called a challenge or 
nonce, and sends it to the client.
4. The client encrypts this challenge with the hash of the user's password 
and returns the result to the server. This is called the response.
..."

Wait, what?  If I'm a malicious server, I can get access to an offline oracle
for whether I've correctly guessed the user's password?  That doesn't 
sound secure at all!  Skimming the SPNEGO RFCs, there appears to be no
mitigation for this.  

So, I guess, this patch might be considered a security risk. But on the 
other hand, even *without* this patch, and without http.allowempty at 
all, I think a config which simply uses a https://  url without the magic :@
would try SPNEGO.  As I understand it, the http.allowempty config just 
makes the traditional :@ urls work. 

Actually, though, I am not sure this is as bad as it seems, because gssapi
might protect us.  When I locally tried a fake server, git (libcurl) refused to 
send my Kerberos credentials because "Server not found in Kerberos 
database".  I don't have a machine set up with NTLM authentication 
(because, apparently, that would be insane), so I don't know how to 
confirm that gssapi would operate off of a whitelist for NTLM as well. 
