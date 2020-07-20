Return-Path: <SRS0=kUNO=A7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF74AC433E1
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 07:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A60FE2073A
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 07:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=metaswitch.com header.i=@metaswitch.com header.b="YehcCplx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgGTHhX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:37:23 -0400
Received: from mail-mw2nam12on2098.outbound.protection.outlook.com ([40.107.244.98]:11777
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725845AbgGTHhW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 03:37:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHUnFXSdUyGlBrqPMkEEQ6sF9g229Dgd5aCccuFYGfzRt8fi+VnTCasi8TAoAEc69+tTx/jy0DBlB89WQv2Q+7dSdhImzFziIY+pnqPWNjhqiGMl61i8mPqKN9i0Yyx6rEZk9h1f3Je/aWzV2lJ7MNW277fEcIszZUdr4n7EFwjMa54EjaWiNFij59nfnbxzgXDHaVrNVkHKoW5BHF8tOadSFxGP5tkUG1OEyd1vZ95HiorsC07q+Fpkit/E1GZrtyggVZUJlByG1CJ5G3/OH7HMtJSkWGLCq3YLiGKHNv2rHdkdl73wx5hAL2k+8E789WPsWk03bsZGaWL87SMWpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myi2uZ6/cxRHr0JrVcdcVgY3645IXC+fIlnNPR8WIBE=;
 b=H3oYHz/9UtU7h3sdc1oT62r9jgFfcQAUwG+yAG2b+2dRxjfRk8LCL5X3wbfHpHofh4n4UpydQ+uVaf7D0P2+zEeavTIuvvJPxatthTK7t+0qqv5r+dduslekmZEGBTYbfRHYlq9ZE04IHr6lu76GlMw9VNo9uns905UW/Mstv39JBW703maylAKQCkokD27KaQ/pQSEzH41lRkocvYje9f6vb6N0UN8jaan47h8XrGKIWHwgh3wCLvwC1iJtgNXKD7Cpqs70tuw8bUYf8gKyH/+8qWyqumch8ll2Xdarw4FYdQ4vDz4K88in/R9ctzXhFDgepbKDdO7qXFEvMDo01g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=metaswitch.com; dmarc=pass action=none
 header.from=metaswitch.com; dkim=pass header.d=metaswitch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metaswitch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myi2uZ6/cxRHr0JrVcdcVgY3645IXC+fIlnNPR8WIBE=;
 b=YehcCplxL1PLlymQBBCwhC2VZFGCqYVUgSXLvuKrkQStzCncm0wFbjrqiIvougcW7RDARh0kKWuCnx0TJZPpC7AzMQCJko3WiJSems/ecZqb5jb5xnSH+48eFAzKaoUHlCpN9+dGwevMyem7mjrZFBfhu2byih8kgfxUsffE6UM=
Received: from DM6PR02MB5276.namprd02.prod.outlook.com (2603:10b6:5:46::19) by
 DM5PR02MB2378.namprd02.prod.outlook.com (2603:10b6:3:51::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20; Mon, 20 Jul 2020 07:37:20 +0000
Received: from DM6PR02MB5276.namprd02.prod.outlook.com
 ([fe80::71c3:8bab:da9c:31bc]) by DM6PR02MB5276.namprd02.prod.outlook.com
 ([fe80::71c3:8bab:da9c:31bc%3]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 07:37:20 +0000
From:   "Paul D. Smith" <Paul.D.Smith@metaswitch.com>
To:     =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Git bug - Windows subst/net use, Windows drive letter prefix
Thread-Topic: Git bug - Windows subst/net use, Windows drive letter prefix
Thread-Index: AdZbYEo84lY55Xt6QpSyzl9Qqa3e4AAACeYQAAAMVOAAjWpHAAA0fB8A
Date:   Mon, 20 Jul 2020 07:37:19 +0000
Message-ID: <DM6PR02MB52762B22764F080837CF971FBD7B0@DM6PR02MB5276.namprd02.prod.outlook.com>
References: <DM6PR02MB52762B49AFBA042B541CE039BD7F0@DM6PR02MB5276.namprd02.prod.outlook.com>
 <DM6PR02MB52769C88FFC893FE3D44E901BD7F0@DM6PR02MB5276.namprd02.prod.outlook.com>
 <DM6PR02MB5276FB15B1E9E66E98A0B7AFBD7F0@DM6PR02MB5276.namprd02.prod.outlook.com>
 <20200719063156.rm6tr3m43enxsxg4@tb-raspi4>
In-Reply-To: <20200719063156.rm6tr3m43enxsxg4@tb-raspi4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: web.de; dkim=none (message not signed)
 header.d=none;web.de; dmarc=none action=none header.from=metaswitch.com;
x-originating-ip: [88.104.138.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b106e630-47f4-4f83-a48a-08d82c7fbc12
x-ms-traffictypediagnostic: DM5PR02MB2378:
x-microsoft-antispam-prvs: <DM5PR02MB2378E3F2564221EB55C4344CBD7B0@DM5PR02MB2378.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kc1QYtzQV8ji486OI+bafxfs1xdaoHS93yAmP6JFqiSmDyJiFsOnh40WVXrmQOApXX0ILkKfX3lYLT2ubCq/UeWHLiugGIcTzR+Nqh2CB5k9AlTDnDqRHkdHk0Vj5yz2cCh8L/cx8gVwa4lHjFCa89zKy0Zh06fitRxGLWAuI+79fZlowLqIGVwb3DeIGGO0ojrUNc5DEr5/GaQ03DclOkzkWXcxhZMGDmuNSZ1zLbQ1Ju1HFYiEK8vq/5JEV6P1QGG03NMm4gGtn+Dp6OBA1GNXExQTzthLIKn1bF1+1x9so4Pr+NGKSPod3ypK52M8tpkKOUeHUySU26MK6T8wgmLDIr8wdogeeehhAEYUrlXYYKioH2C5xX4MjW/aix73Ji2E8dqrBUVSxNId+5NMfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5276.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(136003)(39850400004)(366004)(346002)(316002)(64756008)(66556008)(66446008)(66946007)(66476007)(76116006)(83380400001)(45080400002)(7696005)(4326008)(33656002)(26005)(186003)(8676002)(53546011)(6506007)(66574015)(55016002)(966005)(2906002)(6916009)(86362001)(9686003)(8936002)(5660300002)(52536014)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: oK8y4UHtYm0AVUR4wa0e+bSiFTdnSpVy4MRBAqsF27Bjuc0697zTcuxGqFt/LFvaMqGkFg5s5q2DtkxXJ1Ew4LGRjCQgExww/6EqACKVDM5A6F5I447pKS/3X1dgm4MZPmmmwsnqYgdHBShhou3GNjPoBsJ+SkB+m6aFxwASqu2zBRuGg3niyr/xMHagVJ1ooSbLqFF+VFgKoQUoQa8J7rAKRlk1WetlT6sS0iWyXU1etWggwW3XuPjJv4CvlBquiY5FvLPirVJ4pwR71bJ8UtQt976m/eTHicqTgny7odh7/6MfotHsjdsaVbD+AV7f7Y/g34StkCV9S/BrphDvdyRC467ti99TDwsp8gg6BeHbWTp/gRLCiX1WJOMFp+1k3PbtO/SQeLidbxAwHUVWhw9ctSCgOJLQQar85E1acPwP985FwB/e7eL4ijtznhsN3PL+AJTMPBRrbhKWTHFRBy8Hl7MeSagZTD65eLzkneXQQFTGFL8LrG+cUBNZ63GB
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: metaswitch.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5276.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b106e630-47f4-4f83-a48a-08d82c7fbc12
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 07:37:19.9073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d9e56eb-f613-4ddb-b27b-bfcdf14b2cdb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uDVeb1EMQB+OzKDNYxXPMZ/le/7qG83L2i6pwe/xJ2arsZDK0sTSA6g/A5dnipe2H3MZg+38kYeViW4xAifidw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2378
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----Original Message-----
From: Torsten B=F6gershausen <tboegi@web.de>=20
Sent: 19 July 2020 07:32
To: Paul D. Smith <Paul.D.Smith@metaswitch.com>
Cc: git@vger.kernel.org
Subject: Re: Git bug - Windows subst/net use, Windows drive letter prefix

NOTE: Message is from an external sender

On Thu, Jul 16, 2020 at 11:03:22AM +0000, Paul D. Smith wrote:
> I believe there is a subtle bug in Git that can mean that a "git add" fai=
ls, complaining that "fatal: <filename>: '<filename>' is outside repository=
 at '//<server>/<share>/<directory> /'
>
> It may be possible to reproduce this with simpler steps, but this is what=
 I have that fails.
>
> 1. A Git repo on system <server> below directory <directory> that can=20
> be reached via the Windows share <share> 2. On a second system, perform "=
net use z: file://%3cserver%3e/%3cshare>"
> 3. Now you can "cd /d z:\<directory>" and run "git status" quite=20
> happily 4. At this point I can also so this:
>       a. "cd /d z:" then "git add <z:\some-changed-file>"
>               i. Note the drive letter prefixing the full-filename 5.=20
> Now do a subst or a net use as follows:
>       a. subst v: z:\directory
>       b. net use w: file://%3cserver%3e/%3cshare%3e/%3cdirectory>
> 6. You can do both of these
>       a. "cd /d v:" then "git status"
>       b. "cd /d w:" then "git status"
> 7. However both of these FAIL:
>       a. "cd /d v:" then "git add <v:\some-changed-file>"
>       b. "cd /d w:" then "git add <w:\some-changed-file>"
>               i. Note the drive letter prefixing the full-filename 8.=20
> Performing the above requests WITHOUT the drive letter prefixing the file=
name works!
>
> I assume that this is supposed to work and there is some subtle error mer=
ging the repository root and the filename-with-drive-prefix.
>
> Regards,
> Paul D.Smith.
>

Thanks for reporting your issue.
It's good to get well-written reports like this.

As a general note, this is specific to the "Git for Windows" project, and i=
ssues can be reported there:
https://nam01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.=
com%2Fgit-for-windows%2Fgit&amp;data=3D02%7C01%7CPaul.D.Smith%40metaswitch.=
com%7C62bef1d2ef71432c41da08d82bad70d9%7C9d9e56ebf6134ddbb27bbfcdf14b2cdb%7=
C1%7C1%7C637307371245564042&amp;sdata=3DqFq0Fqg5Vjx1w9rYk55fcwYcNvEP0Z5W0MX=
vFrMuuys%3D&amp;reserved=3D0

More specific, I could reproduce the issue without using a network:

C:
cd Users/tb
mkdir 200719-git-test-subst
cd 200719-git-test-subst
git init
echo FILE >FILE.txt

Now I can use
git add C:\Users\tb\200719-git-test-subst\FILE.txt

That surborised me a little bit, since an absolute path name was given to G=
it.
However, Git is able to figure out, that

C:\Users\tb\200719-git-test-subst\FILE.txt
is the same as
FILE.txt

as you can see running
git ls-files

The file names (and path components) in Git are always tracked "relative".
Relative to the root of the Git repo.
And here Git translates
"C:\Users\tb\200719-git-test-subst\FILE.txt" into "FILE.txt"

In that sense, drive letters are not trackesd at all, you can clone that re=
po to any drive letter, or even to a network share.

If I now use
subst T: C:\Users\tb\200719-git-test-subst

I can use the same repo under T:\

file/path names are still relative, so if you change into T:\ and run git l=
s-files you will still see FILE.txt

Now mixing those 2 does not work.
Git is unable to figure out the "T:\" is the same as "C:\Users\tb\200719-gi=
t-test-subst"

In general, different drive letters host different file systems, so Git ass=
umes that they don't point to the same directory.

Adding this functionality may be possible, I don't know the Windows APIs go=
od enough.
But:
That will cost sone time (in terms of development) and give a run-time pena=
lty for Git itself for many Git invocations.
It may even open up for security issues, since the "check if X: is the same=
 as Y:"
needs to be done in one step, and the the operation needs to be done in the=
 next step, opening a small timing window, where bad things may happen.

This was my limited view on how things work, there may be details missed (o=
r wrong).

----------
Torsten,

Thanks for the response.  It's not an important bug for me now that I know =
what is going on; I was able to rewrite the code I inherited slightly to av=
oid problems.

If there is a sensible place to put it, it might be good to document this e=
ffect; I don't know if there is any way that it could be mentioned in the e=
rror text when commands fail as a "Are you doing this?" hint to users?

Regards,
Paul D.Smith
