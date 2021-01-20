Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD73EC433E6
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 15:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74A9923382
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 15:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbhATPXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 10:23:24 -0500
Received: from mail.pdinc.us ([67.90.184.27]:40708 "EHLO mail1.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390801AbhATPMe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 10:12:34 -0500
Received: from lovegrove (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail1.pdinc.us (8.14.4/8.14.4) with ESMTP id 10KFBbck021621
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 20 Jan 2021 10:11:37 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mail1.pdinc.us 10KFBbck021621
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1611155498; bh=REm3Yt8l+G6eTfIV0mnPWUpzQh/eRhdWBJNP7QSkZBw=;
        h=Reply-To:From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=JjCwJrz78PUBwmfggHIbLsmHTtQx7YeqwTWeZUe2UDxCSySZoXtPYDxrilJCF/VEY
         YHm8dZGptEq1uBdPyV2Gdkq4hgas3q+I7EYuDhxXvUqWnM/p7GvUCViox4rc7ejRNi
         uIcx1BFM349Gpl7YQY6oNZ+L5BTrVlSPBSvySGO74qgP/mV0ScUHcRDMIxTfs63wPV
         8J8gcwDfzjwV0VtC4CK+T/4UcD0Gvve9RJWzM6DH+8zAbc76rvSO6rQWr2trOZ2wtN
         zcdTFsFe9ahl0ZC028vbEHiBNURXkJ36QxgNdM2ncaPREPlXFgzsoB4NMUwC37apSP
         407gubzt+8Dhg==
Reply-To: "Philippe Blain" <levraiphilippeblain@gmail.com>,
          "Junio C Hamano" <gitster@pobox.com>,
          "Kyle Marek" <kmarek@pdinc.us>
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Cc:     "'Philippe Blain'" <levraiphilippeblain@gmail.com>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Kyle Marek'" <kmarek@pdinc.us>
References: <196101d6eab6$20714550$6153cff0$@pdinc.us>        <20210117110337.429994-1-kmarek@pdinc.us>        <20210117110337.429994-2-kmarek@pdinc.us>        <xmqq7dobmfrq.fsf@gitster.c.googlers.com>        <e0264a29-2112-f8c8-f066-2be445654d8e@pdinc.us>        <xmqqwnwajbuj.fsf@gitster.c.googlers.com>        <xmqqr1mij88k.fsf@gitster.c.googlers.com>        <237aeef3-239f-bff4-fa17-5581092c8f51@pdinc.us>        <xmqq1reginnq.fsf@gitster.c.googlers.com>        <460257a2-478a-eb4c-f6fa-b1cc55384cd5@pdinc.us> <xmqqo8hkgl4h.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8hkgl4h.fsf@gitster.c.googlers.com>
Subject: RE: [PATCH 1/2] revision: Denote root commits with '#'
Date:   Wed, 20 Jan 2021 10:11:47 -0500
Message-ID: <01fd01d6ef3e$92e43b10$b8acb130$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQJHGJacgXqgwI3Z8mKvOOtpVC9QaQIPWPTxAWqKtJ0CjS/zDwIOmFXbAj4EO1oBSKUeLQJMhZdkAgqPsIIBueaIOAHxr5jOqLNMv8A=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Junio C Hamano
> Sent: Wednesday, January 20, 2021 1:48 AM
>=20
> Kyle Marek writes:
>=20
> > When graphing C..Z, git produces output like:
> >
> > *   0fbb0dc (HEAD -> z) Z
> > |\
> > | * 11be529 (master) B
> > | * 8dd1b85 A
> > * 851a915 Y
> > * 27d3ed0 (x) X
> >
> > We cannot tell from the above graph alone that X is a root and A is =
not.
>=20
> I actually do not see that as a problem.  In the past several years,
> I've never needed to see "log --graph" output that goes all the way

I respect your needs, but they conflict with others' needs, while this =
enhancement to resolve an ambiguity does not impede your needs and =
solves others' needs. Please do not impose your exclusive use cases upon =
everyone.

> down to the roots, unless I was playing with a toy repository in

I brought this issue up because several repositories in use have this =
issue. Two repositories immediately at hand have 35k+ and 2500+ commits =
each. These are repositories used by professionals and contain actual =
source code. ( I know your "toy repository" tone was not meant as an =
insult because I read your emails daily, Kyle may not have )

> order to tweak and/or develop a feature in Git that draws the graph.
>=20
> Besides, such root commtis in real life projects would not say "X",
> but something along the lines of "my very initial commit", which

Here is where a fundamental (feature) issue of git rears its ugly head. =
You cannot fix the commit meta data (e.g. message) after the fact. =
Humans write the message, and it does not always write a message the is =
easily recognizable as such, no less easy to search.

> would be much more "/<search>" friendly to pagers than "#".

Here are some messages:

bug 2252 test case (e.g. for tomcat 9 with unpackWARs=3Dfalse)
Add migrate-from-blackfat.sql
Initial commit from Create React App
parrent pom
initial commit
Base applet
intial
Initial commit
initial
import prod=20
import prod sql=20
import prod=20
import coop/dev=20
import prod CMIS.zip


Here we have commits without the word initial, initial misspelled, or in =
different case.

Let's not bike shed this issue. The left/right issues are a great catch =
from a peer review point of view.

I'll ask the following questions, besides the left right and test case =
issues:

What quality issues exists with the patch (e.g. bugs, strategy, etc)?

How can the proposed additional features be captured for future =
implementation?

Do we want to continue discussion on option naming?

Are there other questions to discuss?

Respectfully,

Jason Pyeron

