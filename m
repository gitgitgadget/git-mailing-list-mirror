Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83CEC43217
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 13:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352917AbiDSNyC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 09:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353464AbiDSNxX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 09:53:23 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2139.outbound.protection.outlook.com [40.107.220.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C3D37BD6
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 06:49:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjjqtOWXm28QSTxObRBjD7pod/TqIBM8SfTp8/PYJfiekb1GSNngTa91F7jgJu6jrxpgRyAiRQ0bGwSsrJgT5rtvdInw7qsdfi1NLqriHSxkCiv25ocU/H+kROLaE1qQC9MZTYLCZUxOprk5hwmOwvjujDdyvOnNy3ng5MfgFOgKZiKDkFzUpDGypHRNjHpnWAuDgR/V1Zqd7kjG/nRN0YB9+TazIpa+fAhELunNMGGe+boTCeAxZ11oBk1hJUJA5pgV5qcXH3jhvMCgMpnXM/bFSIPQfv4RXJjZyVGq2/lM6H3sJp37C6YonE+3GkbChXvGuz/NLbFMh6WChiFZPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Ol74GUkb+BQL6mazrVW16shx0OPPFS7MMG/EfwyW68=;
 b=aGs2MzkpNqgUiPChfLP3oMjIAETiGdJ85rPR9LvmEnU3RKXX1xFezH6JS0dbug0SzywI/UDFl/qv8N6tGKny8dMtrPm503ksW5VkF+8WK3cr1LdxcmNJiDuU6lUJUNJMtpQ+4OozCoizB2YrLfpQvc4Msh/B/k5aPsn4zA2xJlDlRGrKjwi3ggOb167imqt8hlO55JjJjyALH5waY02v+r1D/S5PSSCqNs551eTPGYBKq6Aw3LyRv7MakTOU0Ot+T38QUsCxWU7fEokjXzswyM+q1UblWH+NpDdOwZlDVWWVPzpxx7QsvLlQ/TXLtb7JWTWGc8PORHJBsRUdEt+U6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucmerced.edu; dmarc=pass action=none header.from=ucmerced.edu;
 dkim=pass header.d=ucmerced.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucmerced.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ol74GUkb+BQL6mazrVW16shx0OPPFS7MMG/EfwyW68=;
 b=LtmXX/dOnANULTmsHl/y5xx9zsxDYB49pZVjHDR0f0PiSD43fuTfK5QZPYK3PQaijWn4L7QpdDF7zQMBUfoq7uiv76KjeKXOVdYW05GJQsrQ+RMnmC4qonpASAVUhspjfTEON6mUwh3B5TvFEEz5bUqVdw11uVLV2Tb90Hbswb4=
Received: from BYAPR06MB4517.namprd06.prod.outlook.com (2603:10b6:a03:49::15)
 by BN8PR06MB5748.namprd06.prod.outlook.com (2603:10b6:408:c4::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 19 Apr
 2022 13:49:05 +0000
Received: from BYAPR06MB4517.namprd06.prod.outlook.com
 ([fe80::48bb:88c4:a53c:af06]) by BYAPR06MB4517.namprd06.prod.outlook.com
 ([fe80::48bb:88c4:a53c:af06%6]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 13:49:05 +0000
From:   Jack McGuinness <jmcguinness2@ucmerced.edu>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [GSoC][RFC][Proposal] Unify ref-filter formats with other pretty
 formats
Thread-Topic: [GSoC][RFC][Proposal] Unify ref-filter formats with other pretty
 formats
Thread-Index: AQHYU/Od+Ps8NeuxtUiUBV0McXoTtaz3QGzc
Date:   Tue, 19 Apr 2022 13:49:05 +0000
Message-ID: <BYAPR06MB45178AC5D8E81525F8528725E6F29@BYAPR06MB4517.namprd06.prod.outlook.com>
References: <BYAPR06MB4517C164C76C68394411C023E6F29@BYAPR06MB4517.namprd06.prod.outlook.com>
In-Reply-To: <BYAPR06MB4517C164C76C68394411C023E6F29@BYAPR06MB4517.namprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: dd067348-0c89-d873-1b79-2b842aab4a48
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucmerced.edu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b11491dd-5620-42bb-2cb0-08da220b5eb1
x-ms-traffictypediagnostic: BN8PR06MB5748:EE_
x-microsoft-antispam-prvs: <BN8PR06MB5748E950BADBE21BE13EE4D7E6F29@BN8PR06MB5748.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IsR94OdCY0ypWDjl+0J4sgqojUhav2UhsNOOQahHIFj9RhP8o+FXH9+4oOtXQ/aS07m1KpPtRLnmXqHYPWSdfoBqge5rjGmviPC7ws2vtZRWFzeVfJ2KnHvSRGXGZL2Mvy0U9HUmnyIGRRSqdkJcb9uimqSsEybTEt21mVwygkXhCHerPnjZGOpqVAX4rM9b9pZv0DLr2MtgVtXizAkAVHv6WG+uLXrc396DsyyYuJbpYdOTBGaWI/ZuiG7d4Z7S9231yjXRCCG1qfbExLhN1Lyk7UKb6vq2/Gu6X1ovZiWVfH1eG+L/1ITMAj3Jj3nC6pEDZgHmNkcSeBGrs4VYThw6a6W7+UYwY0d/Coutrp2rEwFAuBWxuBsoOsiqXv3JunNw+N3WIVgjb9+77XgDbgGU0Ds9OsatsY4XVCieJyBq5ld4+hE2F9y7xj5ogU9GcC4qsTF5PNf633dTuJcxwyJeewN8P65pF52ckzry9EzocICFVKLMK5avatp6jarmzlyS9sxZszssHdjVFu/IJIFmoz50i4kHM3LxrCb/atgMcTZOhn8B+7MVuipciwxoDhQ2uowBDq7NCsJ/KNzGkRfIMLMqihQ8JO98BmaN9ZdXHQ9ggA7O4LWfu+kahg3s1hMdhtdnoZ3C48kTN8NJdTNbfP2NKbE2QwLfZOhDRdTVqAMeRAth/sE7pIFZllIUZ1CVmdeQCsNG4DCVEZ6hStOaxwHRZ4bbvDTnqbJVdYVgEor9u3a/AUv2Wd3HCwCXcqQkEacHAAyltX0O3pTpcvC3Erlmt/RTP8OrU0BxfJywY3pOM1uVMn7BcjzneUE3C+fK2M6W7MkWdY+S/tSWuY2kEQY1lDzgX6OnqihCkzM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4517.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(8676002)(76116006)(66446008)(40140700001)(64756008)(66556008)(66476007)(5660300002)(30864003)(52536014)(33656002)(8936002)(66946007)(2906002)(786003)(316002)(122000001)(9686003)(55016003)(71200400001)(6916009)(53546011)(2940100002)(186003)(26005)(86362001)(75432002)(38070700005)(38100700002)(7696005)(6506007)(966005)(508600001)(160000002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?mBjN6OR4jSJk2W5uhH04bseA6WB0Zce5eJh/ZCJENjPtJHFD9q7Ea3l/?=
 =?Windows-1252?Q?BbuJtmpsZZJqiDLRpEAfJ2UqV8J/ZFiI5G0FfKtT38E0PtIwKegNgm1+?=
 =?Windows-1252?Q?aH6ZKrx8lOfu8bnPGkfQdKwxo8xG/invcfdsP39a5zShPczHiUhiUULy?=
 =?Windows-1252?Q?SsUj7Imd8fDeWe027IqaOe/GzDwIczX3R4IsxOF6yzWHcBOt0ybAMiSR?=
 =?Windows-1252?Q?drJz6OrS12LTpu6tP1wXvhtT/LGFTcFUXZojXArB+34u9qCvFqNRhTW7?=
 =?Windows-1252?Q?v4R0hYqRj9F6dFUUQ9bS6mYjQO1R6duLX1zul/1LQCUm4tKA9soV+fwt?=
 =?Windows-1252?Q?o3lVlcE2rylfXVX/ETd82++Zhd/d+kQTV3hMysv6UPo4d2bYaGGt44XO?=
 =?Windows-1252?Q?hz8dd5zKiSMTUkIZ/MoYVwAKllU8MlRxkiC7mdqVPEtRPvLjJCPIiNv2?=
 =?Windows-1252?Q?ns+1YJNSwvMVeNgoeCWH0q0FFj/wJxSgMLaOrFiX8UbX/62K5Y4iKQzA?=
 =?Windows-1252?Q?Zgw2rP+0xVzGtgtJrQXee+ae8xTM+hNjm8KtHTANYa7HpE7Rhlvi2HUx?=
 =?Windows-1252?Q?PRXV2iDg7QY/y4q6n75x0Podx3mn8cyFPNPWQVp/oMWRg30pfcgzaVbR?=
 =?Windows-1252?Q?3zj4gjudiEhQYbvSwhQAeFyV5juzvKPpb7/5jFfM79cvDSmanvO0IIsX?=
 =?Windows-1252?Q?msEr1Wj7s3zDSzRqiT9Z3MecT2KfOhKhMgfyRInP6Udy7/3HPm78OPTE?=
 =?Windows-1252?Q?VD6WkYtbQPbiZKNGsvEcV8X9UQm2kYlZJda7nvTzfIWQRsV9Zn5KJYBJ?=
 =?Windows-1252?Q?RK30FW6JTUZzNv/NSl5oftAp0Hb7y0s5RWqGISUcUIpc/nTRwAfdZF6K?=
 =?Windows-1252?Q?V5aAbGodCH+R9gw9n0/jRv2WkHr4s1wQQdVqosrEb7jXEwwtHSUrzKNK?=
 =?Windows-1252?Q?B3USn/YIYY2PB0zQuMdkG8CLEfhjsOCfhhcJq/X1rswSnOy9J/jOuBQV?=
 =?Windows-1252?Q?+oxqoIxsOLZzRC1ng2hterr5eGNHTU7OHG+B4fLbAAIdabL/V9XlA1ay?=
 =?Windows-1252?Q?YmfNNSRH28ZjLmZewanSrthVqJf/y9WAp5Eos7smjbUkeg+lfQEPckfS?=
 =?Windows-1252?Q?f6NPxJopy+iLfy9ZWAN6dbHMl8dToWPNt7EOmpozDFm7NhLv/6jVnCoY?=
 =?Windows-1252?Q?7vdRBeSgSO1nVjqR+O2rYvkPnYiaM/hiyryB4kk+6W5rUphPfRQ5Zvw0?=
 =?Windows-1252?Q?gqcKkc+A3uU6srZDTTve+TkDA6rhEMlU+FxBh8g62x7V2Ft/9rDg2N4e?=
 =?Windows-1252?Q?fyCX9aD9W2SuMMRbhU09spiq2u5ShJSudIcSG2UM7o0mZV/Uo7XSAiQs?=
 =?Windows-1252?Q?J2X9yel6SX+J6RNf65CVJGhL6QFL8CFcSAUFPbJfxvx65Rjb+IxnBza6?=
 =?Windows-1252?Q?Q/iIq08Mr+3BQ9wAo64y9mbrbCjXAitBbHx4VJxsjqq8PqD9giexFcgV?=
 =?Windows-1252?Q?Tq+3wY3cqhHu/MIa0jcQkcNtBpC+LBwls+TZezOQAxpoC2bCj0aaZ1lL?=
 =?Windows-1252?Q?3HsH8eML9/MFiM+C8rFZqfXOzgI6lqc9+Q1JEJqDJq3fMYw/RZMrUM07?=
 =?Windows-1252?Q?8u0cHYInCRnyW9pqnY24wiSU/8y2fuFxVjBDeOL5SOINZHhQ96xZPK24?=
 =?Windows-1252?Q?j85G3KzPPfhj4XDLQCPXR1tIYB4iNS6lcip1tMSurYQ8zgnd5lhFFJEd?=
 =?Windows-1252?Q?39C/aEv1WgHiu6Bj+yS2JkQCPBhIqu3Zw7Gp8di9fGLv9biRmgR5O75K?=
 =?Windows-1252?Q?SOIUPgBpyvOzo/IpxUqdD/QkB+xtKEkqf1ncbeuV/OursnlBLFlkc/fZ?=
 =?Windows-1252?Q?f/p1iKdSj02Ewg=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ucmerced.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB4517.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11491dd-5620-42bb-2cb0-08da220b5eb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 13:49:05.3594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f4dfe9a3-ca78-4998-b7a7-e6d0692eace6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0mNHi09+XKgx6fIRtob49iTpGbNHuvlgKsr04xofgAptDbzkkrr4Z4m8LqsZGfQa3xeeG+bFU+9Re4tcpiO/24HfHfSgyM9Mz6+uUVaZgmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5748
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unify ref-filter formats with other pretty formats, for the Fourth Time

Contact Info:

Name: Jack McGuinness
Email: jmcguinness2@ucmerced.edu
University: U.C. merced
Phone number: +1 714-855-9339
Github: https://github.com/JackMcGu
Time Zone: PAC (GMT -07:00)

About me:

I am a computer science and engineering student from sunny California, stud=
ying at U.C. Merced. I have been using git at a surface level for years now=
, but recently with my classes, I have started to use more features of it. =
I have experience in using a few various programming languages, one of them=
 C, which would be useful for this project. Over the past 3 years, I spend =
a good portion of my time working on personal projects, normally some sort =
of simulation or creative graphic. I have wanted to contribute to a public =
project for a while, but I never took the leap because I didn=92t think I c=
ould bring something worthwhile to the table, however looking at GSoC and g=
it, I think that I could make a good contribution. I also spend a few hours=
 each week teaching my underclassman computer science concepts, which I bel=
ieve is a skill that would be helpful when writing blogs to explain what I =
was doing.

Personal About me:
If I'm not doing something productive, then I=92m either biking, reading ma=
nga, or playing Magic the Gathering. While working, I=92m normally listenin=
g to a music playlist that is an amalgamation of Hyperpop, 2000s rock, indi=
e pop, and some hip hop. If I=92m writing something by hand, I use a founta=
in pen, because I just find the way the ink flows soothing.

My Microproject:

For my microproject, I chose to Modernize a test script, specifically t4202=
-log.sh

I will admit, I had a bumpy run completing my Microproject. Going into this=
, I had no experience with open-source, and due to this, my first attempt w=
as done incorrectly. In response to this, I went back and redid it, however=
 as of right now it has not been reviewed by anyone. I believe that I corre=
cted all of the improper syntaxes, but it=92s entirely possible I missed so=
mething.

Note: I used gitgitgadget to submit my patches.

Patch
Purpose
Status
Link to Email
[GSoC][PATCH] Applicant Microproject - Modernizing t4202


The goal of this patch was to update some of the basic syntax of t4202.
Reviewed by Derrick Stolee - Done incorrectly.
https://lore.kernel.org/git/pull.1218.git.1650096550631.gitgitgadget@gmail.=
com/
[PATCH 0/3] [GSoC][Patch] area: t4202-log.sh, modernizing test script
Cover Letter for following three patches.
Unreviewed
https://lore.kernel.org/git/pull.1220.git.1650331876.gitgitgadget@gmail.com=
/
[PATCH 1/3] [GSoC][Patch] area: t4202-log.sh, modernizing test script
Removed blank lines in test bodies and replaced indentation with spaces wit=
h indentation with tabs.
Unreviewed
https://lore.kernel.org/git/0c6aa4e9103b301556437d35acefa535a90e6a1e.165033=
1876.git.gitgitgadget@gmail.com/
[PATCH 2/3] [GSoC][Patch] area: t4202-log.sh, modernizing test script p2
Removed whitespace after redirect operators.
Unreviewed
https://lore.kernel.org/git/e5c29a12df61d0f587594664f50ec025b934fadf.165033=
1876.git.gitgitgadget@gmail.com/
[PATCH 3/3] [GSoC][Patch] area: t4202-log.sh, modernizing test script p3
Split up multiple line commands to have one command per line.
Unreviewed
https://lore.kernel.org/git/4f0f4619806b383f280e8f0d0b9000c189a3b540.165033=
1876.git.gitgitgadget@gmail.com/


History of Problem:

As most open source projects get developed, git has been built up over time=
 by many different people, working towards a common goal of improvement, bu=
t all with different ideas of how to get there. While this is a great thing=
 that is the reason open source software is such a brilliant idea, it can c=
ause confusion within the project.
A prime example of this is formatting command output, where different comma=
nds that overlap in what data they would output have different logic for ge=
tting said output, which causes people to need to know separate systems for=
 each command.
Git has had a history of having mentored contributors work to amend this, s=
tarting in Outreach Round 15, where Olga Telezhania mainly worked to migrat=
e the logic in cat-file.c to the logic in ref-filter, but unfortunately nea=
r the end, she was forced to scrap her solution and restart, and her main w=
ork was never merged to master.
From what I could find, the next person to work on this was Hariom Verma du=
ring GSoC 2020. He started his project by looking over the work of his pred=
ecessor Olga, and deciding to take a different approach to the problem. Ove=
r Hariom=92s summer, he implemented a plethora of formatting options in pre=
tty formats, implementing all formatting options in pretty-lib.
After Hariom, ZheNing Hu carried the torch and worked on the project for th=
e 2021 GSoC. His main contributions revolved around refactoring cat-file, s=
imilar to Olga. However, he also made the notable decision to spend time op=
timizing the performance of ref-filter.


Proposal: Unify ref-filter formats with other pretty formats

My proposal is one of the ideas provided by Git-SCM, unifying the logic of =
ref-filter with pretty formats. What this means, is that I would be rewriti=
ng the formatting logic currently used in ref-filter, to be used in pretty.=
 However, alongside doing this, I also have the goal of adding some small n=
ew functionality to the formatting, and possibly optimizing the logic as Zh=
eNing did.

Benefits of Proposal:

Completing this would improve the quality of life of people contributing to=
 the formatting. The erasure of duplicate logic would make it simpler to un=
derstand the logic being used to format, and therefore simpler for a prospe=
ctive contributor to implement a new feature, or alter a current one.

My Plan:

I looked over the proposals and blogs of the previous undertakers of this p=
roposal, and with their work and struggles in mind, I have compiled the fol=
lowing plan.
Before I start working on the formatting logic, I want to learn to a usable=
 degree how to use the following tools:
Valgrind
GDB
Tmux
Possibly Gprof and perf
My reasoning for this is that reading Olga's blog, she commented how if she=
 had started using the debugging assets earlier, she would have been far mo=
re on track. I want to go into this already knowing them so that I can appl=
y them when needed, and not needlessly waste time.
After this, I would focus on understanding the logic behind the formatting,=
 by studying the relevant files and working on small contributions and patc=
hes, to better understand the system in place. From what I can see, most pr=
evious contributors took around a month before they started coding their ma=
in project. If possible, I would like to figure this out in under a month, =
but I know that that=92s easier said than done.
After I understand, to a well enough degree, the formatting logic, I want t=
o start implementing the formatting options from other files. As I understa=
nd it, major progress has been made in unifying the formatting logic, howev=
er, there are still implementations that work separately from what we want =
the standard to be. Ideally, I would like to spend the majority of my time =
doing this, along with the debugging that goes along with it.
If I have misjudged the amount of logic left to be rectified, then my plan =
for my time would be to work to erase the current problems with the formatt=
ing logic.
Hariom mentioned that the following problems persisted after he finished GS=
oC:
30% of log tests are failing
Pretty-lin.{c,b} does not have apt handling for incorrect formatting
Olgas work needs attention
A Lot of what ZheNing worked on covers the third problem, so I would like t=
o tackle the first two.
The reason for the first problem was due to the branch it was tested on not=
 having mailmap logic, and also the second problem influenced it. Because o=
f this, I think If I go this route, my first step would be to implement inc=
orrect formatting handling. A simple form of this is already implemented, h=
owever it currently causes a segmentation fault, which would need to be deb=
ugged.


Prior Commitments:
To be completely transparent, over the summer I already have a job, however=
, it is a part time job at my local fair grounds where I help out in the mo=
rnings. It doesn=92t take too much time out of my day, I just want to be tr=
ansparent about it.
I also will be spending a few days attending my cousin=92s wedding in June,=
 but I will be able to work on the project during this time, except for the=
 day of the actual wedding.
Projected Timeline:

Week
Goal
Prior to work start
In the time I have before the official start of work, I want to get to know=
 the community better, and gain a good understanding of the workflow. Along=
side this, I want to look into the aforementioned software tools, and also =
read Pro Git Book, as Olga said the later chapters were invaluable to her u=
nderstanding.
1 - 3
During the first three weeks, I plan to spend a majority of my team looking=
 into the formatting logic. It is an important step, and If I start working=
 without knowing exactly what I=92m doing then I could make a mistake and e=
nd up costing more time then I intend to. During this time I want to make s=
mall patches and contributions, to keep me in practice and help me develop =
my relationship with the community.
4-9
At this point, I want to start my actual work of unifying logic. At this po=
int, I=92m unsure of what file I would start with, but I believe that durin=
g the time allotted previously, I would be able to figure this out.
10-12
I am leaving this time period for debugging and optimization. It is inevita=
ble that what I make won=92t work in some unexpected way. In order to best =
improve my chances of having a master ready project by the end, I want to m=
ake sure I have the time to take the work I've done over the summer and tur=
n it into a polished final product.
After GSoC
After GSoC ends I will go back to school, which will limit the amount of ti=
me I have available. However even so, I plan to stay connected to the git c=
ommunity in some way. At the very least, I plan to watch the mailing list, =
and provide commentary to other peoples patches, and at the most I would wa=
nt to keep working on a major part of git, and finish what I started.


Blogging:
I am currently a stranger to blogging, as I never thought of any reason som=
ebody would want to read my thoughts. However, I do keep a private journal =
that I use to remember what I do each month, and plan out the next month, w=
hich I think can be translated to a blog.

If I am accepted, then I plan to have 14 total blog posts over the course o=
f the project. 12 of them to summarize what I did each week, 1 before I do =
any work to provide a reference point for me at the end, and to help me col=
lect what I am going in knowing, and 1 at the end, to be the summation of m=
y experience, and describe my experience and work in full.
Motivation:
My motivation for participating in GSoC:
I have always wanted to participate in an open source project, but I never =
knew how to take the first step. At times I considered contributing to some=
 projects, but I was worried that my commits would get ignored, I would do =
it wrong and waste the time of people. When I say Google had a program to c=
onnect people to mentors and help get new developers into open source, I th=
ought =93Wow, that sounds like exactly what I=92m looking for.=94 I didn=92=
t even find out about the stipend until later, which is an obvious plus.


My =93Why Git?=94:
When the list of organizations participating in GSoC 2022 came out, I went =
to the list, and compiled my own list of organizations I knew and would wan=
t to contribute to. I ended up creating a list of around 10 organizations, =
but when I looked at it, I just knew that Git stood out among them. It=92s =
something that I use almost daily, and that I have always wanted to know mo=
re about the internals of. At that point I started looking into how to appl=
y. To me Git is a backbone of all other programming projects, and exists as=
 a testament to what open source can be.

Closing remarks:

I would be more than overjoyed if I can be accepted, but even aside from th=
at, I think that I have already learned a lot from GSoC. The materials prov=
ided by Google and Git have given me a lot of advice and ideas for how I ca=
n personally contribute to something open source. In the case that I don=92=
t get accepted, then I will still spend my summer contributing to open sour=
ce. I may branch out a bit and focus on more then just git, bit the idea of=
 contributing to a public project just excites me, and I know I have to fol=
low through with it.

________________________________________
From: Jack McGuinness
Sent: Tuesday, April 19, 2022 6:48 AM
To: git@vger.kernel.org
Subject: [GSoC][RFC][Proposal] Unify ref-filter formats with other pretty f=
ormats

Hi, thanks for checking out my proposal. I know that I really couldn't be a=
ny later with submitting this, but due to some time constraints I had to ma=
ke do. Included is the plaintext version of my proposal, along with a link =
to the Google Doc version, which is what I am submitting to GSoC. Well I wo=
uld love feedback, I waited way to long and I am just going to turn it in a=
s is.

Thanks for your time,
-Jack McGuinness <jmcguinness2@ucmerced.edu>

Google Doc - https://docs.google.com/document/d/1KhVGkSgBaya8Q6X9z7tUwVJegm=
urwMS0xmzYj9DRMMY/edit?usp=3Dsharing

Plaintext -
