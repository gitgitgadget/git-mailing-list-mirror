Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B4AC433B4
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 12:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 761BC61131
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 12:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhDNM3k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 08:29:40 -0400
Received: from mail2.pdinc.us ([67.90.184.28]:33386 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229765AbhDNM3k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 08:29:40 -0400
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 13ECT9vp018709
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 14 Apr 2021 08:29:09 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 13ECT9vp018709
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1618403350; bh=SjqkN5q83jjhmR+SqxFaM1nxbaJ1BthnrGbxXGqtHpM=;
        h=Reply-To:From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=YhFmbyZKouxvgqfnS7Xd88g7o1gOjVoJlUoGHL4qdKvCWPIViAhFfuE3ILOoQJR7i
         PR1Cz+P/9BnmF8uXLyhydgPrlMaKY2jdk8i60UIHVsF8HP9S3a+AGmYNFh023tKxoR
         jXEwZGaCBGnoofc07OcQoFpmgfgE8JHAXqHF+DbPNFB6ysF7yyekLR+BstNw1XSbzc
         /eiFCmBi5VNM4m951cRBuU+FBpzkERows8xpelytL+FmbjdXnPHbD7n4FUj2Wpo75k
         5sHh8+Vibf8QOO8mskg353LmIgThTJeS9kuf+hL59GQcQaxa9RsT0u35/OkOIx33iF
         67G+cgkKn5LuQ==
Reply-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
          "Vitaly VS" <strikervitaly@gmail.com>, <git@vger.kernel.org>
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Vitaly VS'" <strikervitaly@gmail.com>
Cc:     <git@vger.kernel.org>
References: <CAEaE=iyUGiPK-HX850mEgC=X6atEhbjJ0dCK0dci0nOCahPhgQ@mail.gmail.com> <YHYxtvKgKz+Uv2xO@camp.crustytoothpaste.net> <CAEaE=izSNyxRcvMd5bArHnmi0F2G83nouge9e_qxiQmA0AsWog@mail.gmail.com> <YHbWtlJDSyuAO+vf@camp.crustytoothpaste.net>
In-Reply-To: <YHbWtlJDSyuAO+vf@camp.crustytoothpaste.net>
Subject: RE: Git via MITM transparent proxy with HTTPS Interception
Date:   Wed, 14 Apr 2021 08:29:20 -0400
Organization: PD Inc
Message-ID: <2a8d01d73129$cb798d40$626ca7c0$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDlxBwNP23Ku96GJAPzlDR02d0dDgCbHmSqA6pGwToBoo6dIKxniGfg
Content-Language: en-us
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: brian m. Carlson
> Sent: Wednesday, April 14, 2021 7:49 AM
>=20
> On 2021-04-14 at 09:35:48, Vitaly VS wrote:
> > Thank you for the fast response.
> >
> > About our network environment
> > We are Cisco WSA(Servers SW, ASA, ISR) that proxies http/https
> > traffic. Client requests a website, network device redirects traffic
> > to WSA using WCCPv2, then WSA proxies the request to Cisco ASA
> > Firewall and internet.
> >
> > Yes, that our transparent proxy is not completely transparent =
because
> > HTTPS Interception.
> > If network guys turning off HTTPS Interception for github.com "git
> > clone" work well through the transparent proxy...
>=20
> Yes, that's because you're tampering with the data.  The output you're
> getting clearly indicates something is modifying the data.  TLS =
normally
> protects the data from accidental as well as intentional errors, so
> there's no situation in which this could be an accident but for your
> proxy.
>=20
> Git will work in this case if and only if your proxy does the things I
> told you, which your proxy doesn't.  It isn't a transparent proxy, =
since
> that by definition requires that requests and responses are not
> modified.
>=20
> I do appreciate you mentioning the proxy you're using so we can =
include
> it as a known broken proxy in future versions of the Git FAQ.
>=20

This is a non-supported use case for Git. That being said - you are =
going to have to trace out the communications. This is going to start =
with GIT_TRACE=3Dtrue GIT_CURL_VERBOSE=3D1 on your command.

You are going to need to invest in the time and knowledge to identify =
why your Cisco WSA is modifying data.

> > Disabled https interception for github is a security issue for
> > us(corporate risks, code leak, etc). That's why I asked about can =
the
> > git client working with https interception.
>=20
> Many major companies manage to avoid these risks without introducing
> security holes into their network and breaking common applications =
that
> speak standard protocols by avoiding using TLS-intercepting proxies.  =
In
> fact, I've worked at a company which was very diligent about these
> matters and had strict policies on them, and in no situation did we
> intercept TLS traffic.
>=20
> > Proxy didn't alter any of the contents of the stream(that says to me
> > our SecOps), but I've not received decrypted traffic yet to be sure.
> > HTTPS traffic caching but we are also disabled this feature for =
github.
> >
> > Common downloads with curl or browser from the same sources from
> > github or gitlab working well.
>=20
> Git sends data that is compressed but not using a normal compressed
> archive format.  Thus, if you do anything that inspects the data to =
see
> if it is "malicious" or "inappropriate," your technology will likely
> flag data that just happens to have a byte sequence that collides with
> something that you think is bad.  For example, if you flag the text
> "sex" because you think it is inappropriate, then the probably is =
about
> 1 in 2^24 that sequence will appear in the stream and you will break =
the
> protocol, since compressed data often appears random.
>=20
> This is, I suspect, why Git tends to break in situations where other
> programs do not.
>=20
> If you want Git to work reliably, you can never modify the data of the
> stream, no matter what.  You also can't buffer the stream (for
> example, try to turn chunked encoding to non-chunked).  This is
> something you're going to have to accept; bargaining isn't going to =
work
> here, no matter how much you want it to.
>=20
> I can't force you to listen to me here, but I strongly recommend that =
if
> you don't, you clearly communicate to your users using Git what you're
> doing and that you know this will break Git so other parties don't =
have
> to.  I'm sure that the support teams for GitHub and GitLab will tell =
you
> that it's your proxy and that you have to remove or disable it just as =
I
> am here.
>=20
> > Brian, really thank you for pdf but we haven't Client-end TLS
> > interception on our clients.
>=20
> Here are some articles covering hardware middleboxes as well:
>=20
> https://blog.cloudflare.com/monsters-in-the-middleboxes/
> https://jhalderm.com/pub/papers/interception-ndss17.pdf
>=20
> I should point out that this problem is so pervasive that TLS 1.3
> includes intentional countermeasures against some of the worst =
practices
> of TLS middleboxes.  I'm certain that most of the TLS working group
> would prevent TLS middleboxes from working at all if they could find a
> way to do so, and many of those people are at the vanguard of Internet
> security.

While I agree, I work in environments where I do not have the luxury to =
change their minds. As a result I sometimes have to develop (very =
expensive use of time) test suites to tease out the secret sauce of =
security appliances. Sometimes we are fortunate that there is enough =
money to get the vendor to care and share.

You are more likely to be able to setup a local git mirror, within your =
security perimeter and enforce a review (think peer review software) of =
outbound pushes on a non-MITM connection between those two points only. =
Security management are much more likely to approve this bypassing your =
security appliance.

[I set the reply to header, don=E2=80=99t email me directly I am on the =
list]

--
Jason Pyeron  | Architect
PD Inc        |
10 w 24th St  |
Baltimore, MD |
=20
.mil: jason.j.pyeron.ctr@mail.mil
.com: jpyeron@pdinc.us
tel : 202-741-9397




