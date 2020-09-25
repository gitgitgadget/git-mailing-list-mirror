Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293FBC4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 16:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B483821D7A
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 16:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=altairengineering.onmicrosoft.com header.i=@altairengineering.onmicrosoft.com header.b="n/GtAiGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgIYQo2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 12:44:28 -0400
Received: from mail-bn8nam12on2128.outbound.protection.outlook.com ([40.107.237.128]:4735
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728416AbgIYQo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 12:44:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3f/XCl+w+uPMu7lzW6Dj/nDVpuujbqFts2q1wX+/5C+zTiOO18rx76QLtJhEhtC/M1FnN2QMTCVP15mT2MohvtHkclNsrncYmoP8S8llvU2jH/zTWnC1E0CBTmzNq5MQdo31fE/8eidAfHd/nW0iLaiyFQWnlRG5wCZPwXgBUMC8uv/0G+aLgtbk8pR6zS9IdmtZ956svZXWLdCgjwtXsIC/IFO6+/hcRb8bA4iHigaBKuE9adumvna2wL0ZZLAtgosjaVaU+ToA4AWolEUkHhH9HrRAUeFFd7QUTD+1zqNKTpmHlKww1H15kucJW1h6lUvZnVAl6h7Im7RkWAJYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOQ+yHTs7J1eM+6QKAFcnnwrQ9ui3GDWdiYFjHRx4Zk=;
 b=CnYZXJEdZwbTHe8HWRHKhfDOSTCCM5rariANYBLSQdLX0wi4rGDPbOizIJIXy7UDgkkvnrmvam1BkdDwZr9vkgkQL6GPL8tH//FmIzHi/D8vBPdnJUZE7k/mCaWakBXajEiPNYjP8EU0xXGRJDqjRK4gOfrsuu/r56v+XIig6vaXlmKf8z7vpQMqiD2avGgDpB/kMAS0Eltwouh0GyUr9z0rzrwZccx4H0A9irZYxg6d4bR2Yh/TWbwvRkdpqsfv0MusC0tbj/MxKuogBkz4kF2irvK47d33ZCdcFIQ/jgm+7dc0aOHqMv4eZGMpqpSSRJtQjrw0IGhnXSq1ITBJcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altair.de; dmarc=pass action=none header.from=altair.de;
 dkim=pass header.d=altair.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altairengineering.onmicrosoft.com;
 s=selector2-altairengineering-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOQ+yHTs7J1eM+6QKAFcnnwrQ9ui3GDWdiYFjHRx4Zk=;
 b=n/GtAiGb4EoaHRXv4GL+gNAZlmzReXpTyqnBkDbZprwH0N0Kl/qWxJXp/UCn2JdxARe4STwiIvZOD3JME0HWsl8IjVrk1NTpBcCFs45XdfJtqtOftb0gtjWVIr5okvC/iHsXV2Zpx/wK30TH0415998LaZk/BWS3JD2koWHtN04=
Received: from DM5PR03MB2826.namprd03.prod.outlook.com (2603:10b6:3:121::19)
 by DM5PR03MB2603.namprd03.prod.outlook.com (2603:10b6:3:3b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Fri, 25 Sep
 2020 16:44:25 +0000
Received: from DM5PR03MB2826.namprd03.prod.outlook.com
 ([fe80::6c66:3392:3508:95e9]) by DM5PR03MB2826.namprd03.prod.outlook.com
 ([fe80::6c66:3392:3508:95e9%11]) with mapi id 15.20.3412.023; Fri, 25 Sep
 2020 16:44:25 +0000
From:   Frank Illenseer <illenseer@altair.de>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git Alias not working in worktree
Thread-Topic: Git Alias not working in worktree
Thread-Index: AdaTV73poiKNnKCUSXa2AlwjpbGP8AAAzTGg
Date:   Fri, 25 Sep 2020 16:44:25 +0000
Message-ID: <DM5PR03MB2826C04CC5AAF3B61BDDAFE2B5360@DM5PR03MB2826.namprd03.prod.outlook.com>
References: <DM5PR03MB2826A616AC30710E169B7237B5360@DM5PR03MB2826.namprd03.prod.outlook.com>
In-Reply-To: <DM5PR03MB2826A616AC30710E169B7237B5360@DM5PR03MB2826.namprd03.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=altair.de;
x-originating-ip: [195.145.7.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e24d95a9-9bd9-474a-4d4f-08d86172432b
x-ms-traffictypediagnostic: DM5PR03MB2603:
x-microsoft-antispam-prvs: <DM5PR03MB2603F30381B654379AA8A085B5360@DM5PR03MB2603.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 38RFKXwh3CBlmfBmA1hIyo8FpAHKgt6SeBtcYSAPSRpUYTidEGtS7nXUD8PspKwbHLgrr+ci+aPeVLIG/1LCTKaxDGXgNbA/5eCZGbm4pdzdvThJDoDgXC2kAwClvKSocKYT2jVb7rE6/eZ4FDp37A0eQA2upe/9snYhI7oKgDoycg0GNjXTdsRMZpciyZTIFsyQ3sadTE/tmzkYWmSAi8GV/DYp+WKd/x2fW9ZoliJX0d7GOs8OIQEQPpczirfZ3kPjQD7u3Q/6CwoPs8G/yhrtItyb5kK/tVX2KCc9gqyT1vDAFrNEgy5ER5gM80oCD0O4olZz7dW20VPlVzNXb1cGAVhzYCKPiXTv/KFtzkDp3PyWcUyw6o8phs3F+sUd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR03MB2826.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(52536014)(2906002)(66446008)(66476007)(66556008)(64756008)(5660300002)(8676002)(71200400001)(66946007)(2940100002)(76116006)(8936002)(316002)(6506007)(33656002)(7696005)(6916009)(186003)(26005)(86362001)(478600001)(55016002)(9686003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 5LtTkyYVYsiqTRUusEfArhgyUlTJtwNGvjmpkce0m7aPUIyndxuCjQOBSsDVf6eQqVE2FHH9aYRSEJgndpvQ6qAYd4FyfSYPB6N2L6QLpyINsPKGxukGuYd9qTf5vW9Y0P0nECDMAl2Byc+cyFBLYy7ltNd7VLi5Rpdr+X6gl2/sFCmya6bdcWp+yzTzrXBLg/2wqraF1DTpHcUyPNmisFd87h+ajU7MSCw2d1eCYvqrJUF/xLjH+VGoQb25x2Ny2duOPnG1zQrMrejvF6RjJ9mvDK7SBQ/RHENB1L1kbmNCvXWxKGbUzz8KByVAEBmDqIB1AjCdOe1MQsVcMf9a7LQek+FkYb+ZV7knYAAnDbzl2xgIX0kaxbkhr2ocNsuRfSvcGADYgg2+FoI0flccN87BKESuLs71lO6wytAzGMGSKP8KK+/MtZNwd6JwfrM6DB3toUJ7ORxP8KTVJ2yxu2D0zwrdy3IQhvvmuwagoMhOv2KrEX4a/o/tZfQEzPNvrXSL5r0zreU9ALZzgUZeFHpI7z9/XI0ojy/1P/0mGJRI3AHI3iLDBTdw1La/wSiMqIiAFHx3IYMIsi42lgXdO0TW8gMNjNoDfIJbhLebZjiup9iTebPmxEKjCQfH8vKKzcnmWEHoC3JT+auhQRT7vw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altair.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR03MB2826.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e24d95a9-9bd9-474a-4d4f-08d86172432b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2020 16:44:25.2683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2bae5b57-0eb8-48fb-ba47-990259da89d2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tJr5zwz4ptHMJ9VdusLGwQCmM2t08hqzYPGb4fVXoTFMkmJNcHIH4ypFZnNBF8NfHlxqf8Ngs1qmB+sLcKoDEdHCLGtqyv7DAjk6ASIb42Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2603
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git User-group,

I am having a setup where I use worktrees and I was now experimenting with =
adding git aliases to work more efficiently with the commands.
However I found that obviously it does not seem to work like I would like t=
o have it:

My intention is to have a ".gitconfig" file as part of the repo so that all=
 developers can easily get to the same configuration that was setup and als=
o to have the config tracked as part of the repo.
We are using Git for Windows v2.28 and also git 2.28 on Linux.

I printed my config from my windows machine below.
You will also see that I have two aliases defined now at two places:
-  The "sts" alias in an include file from my personal .gitconfig ni my HOM=
E
-  The "st" alias in the include file that is part of the repository which =
is included in the config of the worktree

Only the "sts" alias is recognized by git and works, while the "st" is unkn=
own.
But both of the aliases show equally in the below "git config -list".

WHY is the one working and the other one not!
HOW can I get both working equally?

Any hints or help is greatly appreciated.
Thanks and best regards,
Frank


me@MYPC /c/WORK/my_src/wt_KER-dev-B (Features/2.1/gitUtilities|SPARSE)
$ git config --list --show-origin
file:D:/Programs/GitForWindows/etc/gitconfig=A0=A0=A0 http.sslcainfo=3DD:/P=
rograms/GitForWindows/mingw64/ssl/certs/ca-bundle.crt
file:D:/Programs/GitForWindows/etc/gitconfig=A0=A0=A0 http.sslbackend=3Dope=
nssl
file:D:/Programs/GitForWindows/etc/gitconfig=A0=A0=A0 diff.astextplain.text=
conv=3Dastextplain
file:D:/Programs/GitForWindows/etc/gitconfig=A0=A0=A0 filter.lfs.clean=3Dgi=
t-lfs clean -- %f
file:D:/Programs/GitForWindows/etc/gitconfig=A0=A0=A0 filter.lfs.smudge=3Dg=
it-lfs smudge -- %f
file:D:/Programs/GitForWindows/etc/gitconfig=A0=A0=A0 filter.lfs.process=3D=
git-lfs filter-process
file:D:/Programs/GitForWindows/etc/gitconfig=A0=A0=A0 filter.lfs.required=
=3Dtrue
file:D:/Programs/GitForWindows/etc/gitconfig=A0=A0=A0 credential.helper=3Dm=
anager
file:D:/Programs/GitForWindows/etc/gitconfig=A0=A0=A0 core.autocrlf=3Dtrue
file:D:/Programs/GitForWindows/etc/gitconfig=A0=A0=A0 core.fscache=3Dtrue
file:D:/Programs/GitForWindows/etc/gitconfig=A0=A0=A0 core.symlinks=3Dfalse
file:D:/Programs/GitForWindows/etc/gitconfig=A0=A0=A0 pull.rebase=3Dfalse
file:C:/Users/myaccount/.gitconfig=A0=A0=A0=A0=A0=A0 user.name=3DMy Name
file:C:/Users/myaccount/.gitconfig=A0=A0=A0=A0=A0=A0 mailto:user.email=3Dme=
@comp.de
file:C:/Users/myaccount/.gitconfig=A0=A0=A0=A0=A0=A0 receive.denycurrentbra=
nch=3DupdateInstead
file:C:/Users/myaccount/.gitconfig=A0=A0=A0=A0=A0=A0 include.path=3D.gitcon=
fig.aliases
file:C:/Users/myaccount/.gitconfig.aliases=A0=A0=A0=A0=A0=A0 alias.sts=3Dst=
atus -s
file:C:/WORK/my_src/_MAIN/.git/config core.repositoryformatversion=3D1
file:C:/WORK/my_src/_MAIN/.git/config core.filemode=3Dfalse
file:C:/WORK/my_src/_MAIN/.git/config core.bare=3Dfalse
file:C:/WORK/my_src/_MAIN/.git/config core.logallrefupdates=3Dtrue
file:C:/WORK/my_src/_MAIN/.git/config core.ignorecase=3Dtrue
file:C:/WORK/my_src/_MAIN/.git/config core.symlinks=3Dtrue
file:C:/WORK/my_src/_MAIN/.git/config core.longpaths=3Dtrue
file:C:/WORK/my_src/_MAIN/.git/config mailto:remote.origin.url=3Dgit@gitlab=
.xyz.com:project.git
file:C:/WORK/my_src/_MAIN/.git/config remote.origin.fetch=3D+refs/heads/*:r=
efs/remotes/origin/*
file:C:/WORK/my_src/_MAIN/.git/config branch.master.remote=3Dorigin
file:C:/WORK/my_src/_MAIN/.git/config branch.master.merge=3Drefs/heads/mast=
er
file:C:/WORK/my_src/_MAIN/.git/config extensions.worktreeconfig=3Dtrue
file:C:/WORK/my_src/_MAIN/.git/config fetch.prune=3Dtrue
file:C:/WORK/my_src/_MAIN/.git/config fetch.prunetags=3Dtrue
file:C:/WORK/my_src/_MAIN/.git/worktrees/wt_KER-dev-B/config.worktree inclu=
de.path=3DC:/WORK/my_src/wt_KER-dev-B/.gitconfig
file:C:/WORK/my_src/wt_KER-dev-B/.gitconfig=A0=A0 core.hookspath=3Ddevops/g=
it/hooks
file:C:/WORK/my_src/wt_KER-dev-B/.gitconfig=A0=A0 core.longpaths=3Dtrue
file:C:/WORK/my_src/wt_KER-dev-B/.gitconfig=A0=A0 extensions.worktreeconfig=
=3Dtrue
file:C:/WORK/my_src/wt_KER-dev-B/.gitconfig=A0=A0 fetch.prune=3Dtrue
file:C:/WORK/my_src/wt_KER-dev-B/.gitconfig=A0=A0 fetch.prunetags=3Dtrue
file:C:/WORK/my_src/wt_KER-dev-B/.gitconfig=A0=A0 alias.st=3Dstatus
file:C:/WORK/my_src/_MAIN/.git/worktrees/wt_KER-dev-B/config.worktree core.=
sparsecheckout=3Dtrue

me@MYPC /c/WORK/my_src/wt_KER-dev-B (Features/2.1/gitUtilities|SPARSE)
$ git st
git: 'st' is not a git command. See 'git --help'.

The most similar commands are
=A0=A0=A0=A0=A0=A0 =A0status
=A0=A0=A0=A0=A0=A0 =A0sts

me@MYPC /c/WORK/my_src/wt_KER-dev-B (Features/2.1/gitUtilities|SPARSE)
$ git sts
M .gitconfig
M devops/python/modules/gitUtilities.py


