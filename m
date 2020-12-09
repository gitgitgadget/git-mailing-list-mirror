Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F64BC4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 20:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 040E023B99
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 20:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387747AbgLIU5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 15:57:18 -0500
Received: from mail-dm6nam11on2068.outbound.protection.outlook.com ([40.107.223.68]:61888
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729686AbgLIU5R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 15:57:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLGMGbMlCWTZtqzf25bt+NhrXoT1jua1HGrKJc/usdDx8DhtaxZM5OkLiGVbyiWEQdBTFVt4NFZYySTxOuqEwOSML9BnCQLvJjFNs2PbrgDMrte12raYM8DARWHY/OU1jI0K88ywR9cGLpNqMn8YMWYQxIU8+3U6mnV7sE+XQSZqh5bZeABxKTzD/SvjRseUiuGMl+eIhOvozxrQks60/RTxjf2xi1Pu+5yisx83srkZKLO6QRpNt9yAfJHsOgbvJ8F35MFpb2MsxiToyB2bUMsmLQxWJnQnCkw/iDlET/c1EunPek7sH1UzXiHphcrrEbKPiLcBhCCPOY4KWo98pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWVNgUWAtQHW3JszwWHA/onRS+CviOg7g9JhwKF/vbM=;
 b=lzPeRr6WZ8ApThQRoId/rvERCjsaqEW1MqlSYerGsnuZ6g0FPPgFstIQ06dIlXPL/Bo3Odz+DhqfPLQpbgE79RhTuTG0/LUlDbb12UMtqeh4VWVXadQ8cKYkQVvs7Y3wJELaNnRCFOBHQUBL0QHNKzeSQQYVK+g4aA7wkqGQ7uWjZOQf2tfS8JvOsWWTLHLja5M+qJMihpy0Twc73eoDGW+DSlmi1rTwCRIup+zAl4LpLL3MRJOVBHdD15FNIL/R+5gAakpv8Vs1shEtuSqt3hJ/qjNMIqmwg4CxzyA0boQwLl/XJfNeD9YfUpvtEhYZZQNEC8+tBVnvguoVAxcFQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ubisoft.com; dmarc=pass action=none header.from=ubisoft.com;
 dkim=pass header.d=ubisoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubisoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWVNgUWAtQHW3JszwWHA/onRS+CviOg7g9JhwKF/vbM=;
 b=dnSIeo8awgRCdfzJrMlx6PoxIfohqB/Z2w6hoNDc36zR+dTR0MtgNSPdMXyRGyPwrwgc45FCJSUL/h6pfj9FN2IP7oN7UPfpxWG52Lu3Vapbpz6hIIjhTpO+V//oVczTxtfVHS2o61Gctayp+AqvGl3LCKClX2VH82ZGAPSQ+y7A2TVv8FepUtAVW0D+Dd59IsPgzwnIzyziCqgd3NkH4uubc6xkmIitMXu23aWSpvxDl6rPYfcWl0jmY0Rp/HbED3uWtNxX8g8wIuaqNvaZXRuUwckV3xbaBTj2jACoj3aMuCeC0UQp+PmQTMKCDqcYlT6QEMamP6kZ65PQSDzW2A==
Received: from BYAPR17MB2646.namprd17.prod.outlook.com (2603:10b6:a03:8a::22)
 by BYAPR17MB2072.namprd17.prod.outlook.com (2603:10b6:a02:a9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Wed, 9 Dec
 2020 20:56:27 +0000
Received: from BYAPR17MB2646.namprd17.prod.outlook.com
 ([fe80::9cf7:d8e5:d393:debe]) by BYAPR17MB2646.namprd17.prod.outlook.com
 ([fe80::9cf7:d8e5:d393:debe%6]) with mapi id 15.20.3632.023; Wed, 9 Dec 2020
 20:56:27 +0000
From:   Julien Richard <julien.richard@ubisoft.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
CC:     Julien Richard via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Julien Richard <jairbubbles@hotmail.com>
Subject: RE: [PATCH] doc: 'T' status code for git status
Thread-Topic: [PATCH] doc: 'T' status code for git status
Thread-Index: AQHWzgM0m6dCtOtQ3U2GJdYa7cI3FKnvB9CAgAAvUauAAAWLoA==
Date:   Wed, 9 Dec 2020 20:56:27 +0000
Message-ID: <BYAPR17MB264673B29978D31681D5B3119DCC0@BYAPR17MB2646.namprd17.prod.outlook.com>
References: <pull.930.git.git.1607501616914.gitgitgadget@gmail.com>
        <X9ELRf7s9sBcs9CD@coredump.intra.peff.net>
 <xmqqsg8e20b8.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsg8e20b8.fsf@gitster.c.googlers.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=ubisoft.com;
x-originating-ip: [90.113.108.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 268707d2-0127-4865-fe05-08d89c84e591
x-ms-traffictypediagnostic: BYAPR17MB2072:
x-microsoft-antispam-prvs: <BYAPR17MB2072605CF087B1F2E78154F79DCC0@BYAPR17MB2072.namprd17.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WHhAcIDb6p7Jnn+HDBIybxirS7PzaS56v6b9dCUwHF1uLB1KNhGcxDC8uvHiDE0rHYBkdPz2TTwVGxbu+r1mqaEk3yaMQS4WYbsH0Zd7o8Z5tUmbcyDqf2Gbx+pgke4a0oPLthS1rfMAFwPzqotP52ipQuxNqI4Pm2pnomO0UnLycbBPIVAzzD1oGg/cYsLA7f6IJ03PFmON1OoP3+t48zxwAw77TPitaHT+X0lpOo/a9D+7a94oYokSXmIq+yAwNAcXiwXLGbqRqAgNXyDiKK/v4zRXLYk+h7/qtgy0B1KVKYalkt0SOlr0ZiWSgeHXDf1Uu0nK86oA1+tBMZcs3dle10I2n0VqPEDv5SJL03Vt51GOtvLknIJPSZuVXax3aNCusk9AYUaiKZIWiZ9b/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR17MB2646.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(346002)(52536014)(966005)(71200400001)(55016002)(66476007)(4326008)(66574015)(8676002)(44832011)(66946007)(5660300002)(54906003)(7696005)(76116006)(66556008)(9686003)(33656002)(66446008)(6506007)(508600001)(26005)(86362001)(8936002)(2906002)(110136005)(64756008)(83380400001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?8Ue8RuI0fntuz6QNambzIDgeaVKzjyiWXvNLnZPszH0AVBOMa/ebvyQzGu?=
 =?iso-8859-1?Q?f1N9AQ2g56v8cTLtRqMmGGHn3BpHwQs6ZOC37tE4c6p495zB6YkSu0kyLm?=
 =?iso-8859-1?Q?s1uC54aQa0mbpBc9spi2sWsmT4+La09HNcOfboW+TPVVhYE6PXztpvhvg1?=
 =?iso-8859-1?Q?gzCp70y5aFDQuEIe/MAHQ9Zx0ZSCRPT9j+Jzru8mYzQajRY55ClqQQO+Fl?=
 =?iso-8859-1?Q?kLC1R32GVaG0CxN4wKdegcTH7iGWvDiFzK0rQPKLWMQpXI/GBMtDxDToep?=
 =?iso-8859-1?Q?4q3oUIognViDWsTEN65NOPsmSWCctBick76FBj6g6L0L+Y8R7Ke3Iaz9d/?=
 =?iso-8859-1?Q?XDZbwjzn6Ran0PTGjNDLTIxtl718TKFjFgm5WVTFJIWCOmYf0R/oA2CkzG?=
 =?iso-8859-1?Q?Th0kLfLibySDd+jTC6XyoxzW3gauKVFUdRKM34j2IpTvawDLl6k1RdR8cD?=
 =?iso-8859-1?Q?JEznE5Eefm3BsQh5JTRtMyRdGIUSMReUQxI/mlGJr75UD0ICMBaDT42CcF?=
 =?iso-8859-1?Q?yM6ih8H8tyLpbY+4a+56qPZQC4Zgs4uMI8eLUni2et1pZB6/vY4wHHf0aP?=
 =?iso-8859-1?Q?S5wdGndl1i9dqHY5LtYxaMb4iKf8kYc/F7t0SQIsEDVG3H95kD59Ncx2dS?=
 =?iso-8859-1?Q?tB+aE87iR16p1sHjZpOK0RjzgVDI2jJrbBXCzpR1qzjFr9sRlMgHqRP04r?=
 =?iso-8859-1?Q?QSieid/WeF7YVI2mYesACRXD0dJqUMm0+ksmXmEQ/Exf1oNNxwLXikZQ5q?=
 =?iso-8859-1?Q?kXTdnVq8F2pkNZW7dEH+4k8SQSjzvhDg7XDdFixEJwb1XzhCeaen7l/2jR?=
 =?iso-8859-1?Q?OtJsmBlzBBq1C4bSxRjuhGhofrJYZ3h+ccP2FDqrRavy6BE5XCqNLRh0rq?=
 =?iso-8859-1?Q?llAbLDC6fkFxR/jxEQ3tAbBYgt+ZCMsfcFM4Okh7YnPhKNJ2lrJirOH3jr?=
 =?iso-8859-1?Q?fBaYShOjOQ/xPvgwRtDnqQYOz3BIzyyj2CRTed7mLyKIEEsX/CCZCaFXou?=
 =?iso-8859-1?Q?f9roDAMiAEvqc+4OE=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ubisoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR17MB2646.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 268707d2-0127-4865-fe05-08d89c84e591
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 20:56:27.2962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e01bd386-fa51-4210-a2a4-29e5ab6f7ab1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lBoUsghrF6ChwRbW4+dlugk9Dpwf3FsaBAKTcCPvZ6WFjUuSiuQj6QKW+LMcYBLiI+c7dEujGWagRM+V8H8fv9T+oYvKo6OdfSVGPqHYPc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR17MB2072
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I investigated a bit more my case and it is indeed a file which is modified=
 and is now a symlink. If it's only the main case I think it would be nice =
to add it to the documentation as the 'typechange' can be quite mysterious =
otherwise (internet is not much of help on the subject appart from https://=
code-examples.net/en/q/849dff ).
=20
I don't find the table very explicit, for instance I don't understand the [=
]. Is it all the possible statuses in the index / worktree for a given stat=
us?
With the T added the table becomes even more complex. As the T status seems=
 like a corner case, mentioning it in the doc briefly would be sufficient, =
at least for my use case.

Thx,
Julien

-----Message d'origine-----
De=A0: Junio C Hamano <gitster@pobox.com>=20
Envoy=E9=A0: mercredi 9 d=E9cembre 2020 21:26
=C0=A0: Jeff King <peff@peff.net>
Cc=A0: Julien Richard via GitGitGadget <gitgitgadget@gmail.com>; git@vger.k=
ernel.org; Julien Richard <jairbubbles@hotmail.com>; Julien Richard <julien=
.richard@ubisoft.com>
Objet=A0: Re: [PATCH] doc: 'T' status code for git status

Jeff King <peff@peff.net> writes:

> I wonder if we need a little more, though. The list here:
>
>> --- a/Documentation/git-status.txt
>> +++ b/Documentation/git-status.txt
>> @@ -197,6 +197,7 @@ codes can be interpreted as follows:
>>  * 'R' =3D renamed
>>  * 'C' =3D copied
>>  * 'U' =3D updated but unmerged
>> +* 'T' =3D type changed
>> =20
>>  Ignored files are not listed, unless `--ignored` option is in=20
>> effect,  in which case `XY` are `!!`.
>
> is followed by a table showing the meaning of those entries in each=20
> slot. Should there be some "T" entries there, too?
>
> I think it could basically show up anywhere that "M" could.

Meaning something like the patch attached at the end, perhaps?

> It is correctly documented in the diff manpage. There we define it as=20
> "change in the type of the file". I'm not sure if that's really making=20
> anything clearer than "type changed". ;)
>
> Perhaps "type changed (e.g., a symbolic link becoming a file)" would=20
> be more descriptive, but I'm not sure it's necessary. (And if so, it=20
> probably would be better placed in the diff documentation).

Sitting next to existing copied, renamed, and updated-but-unmerged, the ext=
ra explanation in parentheses looks a bit out of place.  It does make sense=
 to have it described in the diff documentation, but I think it already is =
covered adequately over there.

Another thing I noticed while looking at the context is that "updated but" =
is misleading.  You might be in the middle of a merge, and the path may hav=
e been modified in their history as well as somewhere in your history, but =
the change in your history may be far in the past that you do not even care=
 or remember.  As far as you are concerned, you didn't update it (e.g. rela=
tive to HEAD) at all.
It simply is "unmerged"---if you take a look at the conflicted contents, sa=
ved it and then perhaps "git add" it, you may now be able to call the path =
"updated", but at that point it is no longer "unmerged".

Thanks.


A few things about the attached.

 - it drops "updated but" from the explanation of 'U' in the list.

 - after that, everything in the list becomes a single-word, so
   instead of "type changed", it invents a verb "type-change" and
   uses its pp. form when adding an entry for 'T'.

 - it updates the table to add 'T' next to 'M'.

 - "work tree changed since index" in the table was awkward; it
   rephrases it to "modified in work tree relative to index",
   because (1) these entries are not talking about the working tree
   as a whole; it is one path in the working tree changing its
   type. and (2) using "changed" and "updated" for the same 'M' in
   different context was unnecessarily confusing.  Instead, it uses
   'modified', which appears in the list before the table.
=20
 - The "not updated" line was using a leading "\t"ab, and that is
   why the preimage appears unaligned; the patch updates the line to
   use 8 spaces (i.e. ' ' for X and 7 spaces to align).

 Documentation/git-status.txt | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git c/Documentation/git-status.txt w/Documentation/git-status.txt in=
dex 7731b45f07..2e4b761ecc 100644
--- c/Documentation/git-status.txt
+++ w/Documentation/git-status.txt
@@ -196,7 +196,8 @@ codes can be interpreted as follows:
 * 'D' =3D deleted
 * 'R' =3D renamed
 * 'C' =3D copied
-* 'U' =3D updated but unmerged
+* 'U' =3D unmerged
+* 'T' =3D type-changed
=20
 Ignored files are not listed, unless `--ignored` option is in effect,  in =
which case `XY` are `!!`.
@@ -204,15 +205,17 @@ in which case `XY` are `!!`.
 ....
 X          Y     Meaning
 -------------------------------------------------
-	 [AMD]   not updated
-M        [ MD]   updated in index
-A        [ MD]   added to index
+        [AMTD]   not changed
+M       [ MTD]   modified in index
+T       [ MTD]   type-changed in index
+A       [ MTD]   added to index
 D                deleted from index
-R        [ MD]   renamed in index
-C        [ MD]   copied in index
-[MARC]           index and work tree matches
-[ MARC]     M    work tree changed since index
-[ MARC]     D    deleted in work tree
+R       [ MTD]   renamed in index
+C       [ MTD]   copied in index
+[MTARC]          index and work tree matches
+[ MTARC]    M    modified in work tree relative to index
+[ MTARC]    T    type-changed in work tree relative to index
+[ MTARC]    D    deleted in work tree
 [ D]        R    renamed in work tree
 [ D]        C    copied in work tree
 -------------------------------------------------
