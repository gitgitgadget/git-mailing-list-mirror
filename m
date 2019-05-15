Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E82E1F461
	for <e@80x24.org>; Wed, 15 May 2019 21:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfEOVGr (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 17:06:47 -0400
Received: from mail.pdinc.us ([67.90.184.27]:40696 "EHLO mail1.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbfEOVGq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 17:06:46 -0400
X-Greylist: delayed 2287 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 May 2019 17:06:46 EDT
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail1.pdinc.us (8.14.4/8.14.4) with ESMTP id x4FKSbOS022323
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 15 May 2019 16:28:38 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mail1.pdinc.us x4FKSbOS022323
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1557952118; bh=3OtAmA9G3HcPHZ+N9/qr0jy2oil5+gU2HhCLpGmkLKc=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=C1xPdf+Rf0q+AQ/2iiMNmZABNbbAbK44X8ii5X0/ULv4RAHHSJQgYGCvteNJybesk
         Ycy1UaIgp9ch7S8s0gwJqgF9eH2d9R/x6pvTLJ3ZkWXdjVOH8sMzL+Gvdywfho8IRX
         lF5MPlqs1U7BMGFk9npzI5SDEAGLcg0Zq16iSlwGuohrfaWGoymd+SVtGYEsp8mmWc
         F+n1oJthbcWKwgKqQpb04j4FhNMEgMDIu7W1RHkiMG/mUJl6gcMasAdMvVy1cezUC5
         ykXNEoFvRCoMkQfmOwLVFTAfaZd3yRVk8n20oHB7YNw+TTP3IElUVVoFxWn6/hqXxG
         CI1bhQUHxBKXA==
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Cc:     "'Derrick Stolee'" <stolee@gmail.com>,
        "'Eric S. Raymond'" <esr@thyrsus.com>
References: <20190515191605.21D394703049@snark.thyrsus.com> <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com>
In-Reply-To: <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com>
Subject: RE: Finer timestamps and serialization in git
Date:   Wed, 15 May 2019 16:28:45 -0400
Organization: PD Inc
Message-ID: <023b01d50b5c$cbd3cd90$637b68b0$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQCcJah6NyivE3xeIdw96BsgzJQEIwCENLMPqNpJlZA=
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(please don=E2=80=99t cc me)

> -----Original Message-----
> From: Derrick Stolee
> Sent: Wednesday, May 15, 2019 4:16 PM
>=20
> On 5/15/2019 3:16 PM, Eric S. Raymond wrote:

<snip/> I disagree with many of Eric's reasons - and agree with most of =
Derrick's refutation. But

>=20
> Changing the granularity of timestamps requires changing the commit =
format,
> which is probably a non-starter.=20

is not necessarily true. If we take the below example:

committer Name <user@domain> 1557948240 -0400

and we follow the rule that:

1. any trailing zero after the decimal point MUST be omitted
2. if there are no digits after the decimal point, it MUST be omitted

This would allow:

committer Name <user@domain> 1557948240 -0400
committer Name <user@domain> 1557948240.12 -0400

but the following are never allowed:

committer Name <user@domain> 1557948240. -0400
committer Name <user@domain> 1557948240.000000 -0400

By following these rules, all previous commits' hash are unchanged. =
Future commits made on the top of the second will look like old commit =
formats. Commits coming from "older" tools will produce valid and =
mergeable objects. The loss precision has frustrated us several times as =
well.


Respectfully,


Jason Pyeron

