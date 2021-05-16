Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFF3C433B4
	for <git@archiver.kernel.org>; Sun, 16 May 2021 20:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E16F61075
	for <git@archiver.kernel.org>; Sun, 16 May 2021 20:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbhEPU6w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 May 2021 16:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhEPU6u (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 May 2021 16:58:50 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A3CC061573
        for <git@vger.kernel.org>; Sun, 16 May 2021 13:57:34 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id m190so3290798pga.2
        for <git@vger.kernel.org>; Sun, 16 May 2021 13:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samuelsmith.org; s=google;
        h=mime-version:subject:from:date:cc:content-transfer-encoding
         :reply-to:message-id:to;
        bh=W7bY1/th0NLsxmpeeuTmGA6sasOLV9K4sf9bklHkvNU=;
        b=CoCZiCwgCiQo1vVi4ZFs4m28IcJH1AJ5Y77BDgI5aFOra+JuO2wlXrM3+Uxy0XGi7n
         /BB3n1S3bhvhtXpL8Txt97v3+0vsz3wxkxil0JbETcGyStitfHdW0ErbrBBsE8TVYYRK
         wEXpkcEpiP4/GKzcWGXOFHCmpzJkJYI1tkjKgqOCYVWSuC3qikxFm2FkoaN61rYd3sJ4
         1ZSWG78TgAFM7u6b1C9Iv4KLG8AtNgyavKfEiS9e6JkQCVhfDP+YXLrhGF5ib4fBayw7
         JmnIiWOR6J4IJZgO2oH17FgfIBnI3mLg8Sv2+xnVNFnOFYN/DyNoxlclR+OYl4WltBHb
         M58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:date:cc
         :content-transfer-encoding:reply-to:message-id:to;
        bh=W7bY1/th0NLsxmpeeuTmGA6sasOLV9K4sf9bklHkvNU=;
        b=OoSp9LTiwAC2dy3JlPjTK3AURyyCpK+cDo5u4njCE9kysdYMAb2zYpCW5Y5hRhWVGN
         ZglBHrxygetdI9RNZrZPIy8gnvSCknIhViwX0RiUlgeVdZaK5SfsKkTztT43uWjA0eEV
         Uk3hrqm9Pb4k1LVGWjUAHlWCl1o1NVUqJpUY8C0kOeA4DBc9gC0RyItBLG1I4emSPJ6g
         Rqbq8GWd6n2AxTvDNIr4c68W8u+zp/MxHmUlTJs0/XPLSy/M33mgQGavp2Oha7pJ/17m
         x2VPuOF3iQGcXFZHQgnFTa7BvwVafY9Na55WYUcrHI41bz4AZcZ7vH+OFUPoQoV/2bJB
         xA2g==
X-Gm-Message-State: AOAM532iKOYbL97F+4zsFLF4y3JqWt18Y2q92odSkqXsKUY9XndESeT0
        vM2HFp1i79O+CKMSbKmli+1DCSfK74G4x03+
X-Google-Smtp-Source: ABdhPJx0vGP8SNmRDXLfh8xVWKI4KntRMeBhlricESH4AuuR8WGF8Dhtv7rGWk5XF8fUWFIU+lyaWQ==
X-Received: by 2002:a62:ae19:0:b029:2d9:11cf:5da7 with SMTP id q25-20020a62ae190000b02902d911cf5da7mr7918964pff.18.1621198654037;
        Sun, 16 May 2021 13:57:34 -0700 (PDT)
Received: from smtpclient.apple ([204.228.136.175])
        by smtp.gmail.com with ESMTPSA id mj7sm1495189pjb.47.2021.05.16.13.57.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 May 2021 13:57:33 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.43\))
Subject: Re: Preserving the ability to have both SHA1 and SHA256 signatures
From:   Personal Sam Smith <sam@samuelsmith.org>
Date:   Sun, 16 May 2021 14:57:32 -0600
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Reply-To: 20210508022225.GH3986@localhost
Message-Id: <D433038A-2643-4F63-8677-CA8AB6904AE1@samuelsmith.org>
To:     dwh@linuxprogrammer.org
X-Mailer: Apple Mail (2.3654.80.0.2.43)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

dwh invited me to contribute to this discussion and I hope my comments =
are helpful. He referenced my work on the DIF KERI WG standard. This =
emerging standard has been adopted by the Global Legal Entity Identifier =
Foundation (GLEIF) as the basis for its new verifiable LEIs. These are =
required by many regulator bodies for participating legal entities.
https://keri.one =20
https://identity.foundation/working-groups/keri.html=20
=
https://www.gleif.org/en/lei-solutions/gleifs-digital-strategy-for-the-lei=
/introducing-the-verifiable-lei-vlei

This is part of a much larger effort to fix the security of internet =
distributed systems in general. The approach is based on the principles =
of what I like to call zero-trust-computing (ZTC) which is a =
generalization of the more commonly know zero-trust-networking (ZTN). =
Zero trust mean never trust always verify where verify is in the =
cryptographic sense of verifying cryptographic operations such as =
signatures or digests. ZTN is becoming increasingly popular for access =
control of networked applications. In contrast, ZTC merges ZTN =
principles with trusted computing principles to the architecture of any =
distributed software application. =20
https://trustedcomputinggroup.org
=
https://github.com/WebOfTrustInfo/rwot7-toronto/blob/master/final-document=
s/A_DID_for_everything.pdf
=
https://github.com/WebOfTrustInfo/rwot10-buenosaires/blob/master/final-doc=
uments/quantum-secure-dids.pdf

The core idea of zero-trust is end-to-end verifiability of all =
operations in the system. The type of operation is application =
dependent. The verifiability is cryptographic. One of the most important =
(and most relevant to git) types of end-to-end verifiability is =
authenticity via non-repudiable signatures. A signature is also a hash =
(digest) so it secures both the integrity of and attribution to the =
source of that data.=20

In trusted computing one starts with secure roots-of-trust that one may =
then build the rest of the system upon. In distributed trusted computing =
the root-of-trust is a verifiable data structure =
https://www.continusec.com/static/VerifiableDataStructures.pdf  =
https://transparency.dev/verifiable-data-structures/ =
https://www.bbva.com/en/on-building-a-verifiable-log-part-1-core-ideas/

The point is that a verifiable data structure provides an end-verifiable =
proof of some state. It becomes a verifiable state machine which means =
any software application may be made verifiable using verifiable data =
structures. The verifiable data structure provides a secure =
root-of-trust that satisfies the end-verifiability principle of =
zero-trust computing needed for distributed systems. A open =
end-verifiable system may exhibit ambient verifiability, that is, any =
copy is verifiable by anyone anywhere at anytime.

One of the simplest forms of a verifiable data structure is a hash =
chained signed append only log such as a provenance log (proposed above =
@dwh). A variant would be a hash chained signed DAG. The degree of =
security or cryptographic strength of the log is a function of the =
cryptographic strength of both the digest and signature operations. =
Unlike what is popularly portrayed in movies, a crypto system with at =
least 128 bits of cryptographic strength is practically infeasible to =
attack by brute force, i.e. are impervious to brute force attack. =
Instead the attack must be some sort of what is called a side-channel =
attack usually against one of three targets, key creation and storage =
infrastructure, data signing infrastructure or signature verification =
infrastructure.  =
https://github.com/SmithSamuelM/Papers/blob/master/whitepapers/IdentifierT=
heory_web.pdf

For the first two (key creation/storage and data signing) there are  =
many well known techniques such as secure enclaves, TPMs, HSMs, and TEEs =
as well as using threshold structures like multi-sig that may provide =
arbitrarily high levels of security. The third side channel attack =
targets signature verification usually is dependent on using secure code =
libraries. But the last two, namely, data signing and signature =
verification infrastructure, require secure code delivery of the  code =
as integrated into the application that consumes it. The result is that =
when designing zero-trust computing systems based on verifiable data =
structures, the weakest link is a side channel attack, the weakest link =
for side channel attacks is often the secure code delivery mechanism, =
and the weakest link for secure code delivery is often git.

What dwh is proposing is converting git from a software application with =
what the security community would consider antiquated security to a =
best-of-breed security system based on zero-trust-computing principles. =
This conversion does not come from imbuing git with its own security =
system for end-verifiable authenticity but instead layering git on top =
of a secure end-verifiable authenticity layer outside of git. This =
layering is enabled by using self-describing cryptographic primitives =
inside a self-describing verifiable data structure. Self-describing =
verifiable data structures are to the security world what JSON is to the =
API world. By using self-describing primates (such as a self-describing =
hash) in git's data structure, then those become end-verifiable data =
structures themselves. A signature on a secure digest is a convenient =
way of making secure attribution to the associated data without signing =
the data itself. But this requires that the digest be at least as secure =
as the signature. A secure digest also has the property of post-quantum =
protection. So a secure digest such as Blake2b, Sha3, and Blake3 digests =
can be used to protect non-post-quantum proof signature schemes from =
surprise quantum attack.=20

One of the essential properties of any good cryptographic system is what =
is called cryptographic algorithm agility. Without it the system cannot =
easily adapt to new attacks and newly discovered weaknesses in =
cryptographic algorithms. Self-describing cryptographic primitives are =
the most convenient enabler for cryptographic agility. One advantage of =
signed hash chained provenance logs is that the whole log must be =
compromised not merely one part of it. Such a log that exhibits agility =
especially through self-describing primitives is self-healing in sense =
that new appendages to the log may use stronger crypto primitives which =
protect earlier entries in the log that use weaker primitives. This =
makes the log (or any such agile self-describing verifiable data =
structure) future proof. It is the best practice for designing =
distributed (over the internet) zero trust computing applications.=20

It is my prediction that over the next few years there will be a rapid =
switchover to the use of zero-trust computing architectures based on =
self-describing verifiable data structures for distributed internet =
applications. It is the most elegant, most decentralized, solution to =
the security problems of distributed internet applications. Because of =
git's important role in code creation and delivery, it should IMHO be =
leading out in this space and dwh's proposal does just that.  Not fixing =
git in this way will eventually force work arounds for anyone seriously =
implementing zero-trust architectures. This will result in non-standard =
usually proprietary implementations of access control mechanisms in an =
attempt to fix up the relatively antiquated security of git tooling. =
This will be bad for everyone as it will balkanize git tooling along =
proprietary access control mechanisms, (which is already happening). A =
open interoperable zero-trust future proofed secure git requires that =
git be secured by a verifiable substrate such as dwh is proposing. Not =
some antiquated mechanism as is the case today.=20
















