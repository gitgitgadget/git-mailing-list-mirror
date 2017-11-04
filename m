Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EF6720450
	for <e@80x24.org>; Sat,  4 Nov 2017 00:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754036AbdKDAqa (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 20:46:30 -0400
Received: from mail-by2nam01on0091.outbound.protection.outlook.com ([104.47.34.91]:45335
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751805AbdKDAq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 20:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=w1Ce4lQGw9UzzRUmujwGSakhThyjtA8p01aIPp250l4=;
 b=AyfPDPPd3LpiamlkVWfaj9jqw0uobajF6v5X9dPuP4TDh/HJ5/j7aGJRL/opFnOsDtBnfNebtdF9dNiOZrNhu1QoeRujsOKzy/P6s6dQsD7rhsw5PGkG7u7tORWPs4F3aZ1s79jhX/T61hvf4Xd6713GWVkDtfB8yvMIjbZwCFo=
Received: from BN6PR21MB0114.namprd21.prod.outlook.com (10.173.199.140) by
 BN6PR21MB0116.namprd21.prod.outlook.com (10.173.199.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.239.0; Sat, 4 Nov 2017 00:46:27 +0000
Received: from BN6PR21MB0114.namprd21.prod.outlook.com ([10.173.199.140]) by
 BN6PR21MB0114.namprd21.prod.outlook.com ([10.173.199.140]) with mapi id
 15.20.0239.000; Sat, 4 Nov 2017 00:46:26 +0000
From:   "Billy O'Neal (VC LIBS)" <bion@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Stephan T. Lavavej" <stl@exchange.microsoft.com>,
        Cody Miller <codym@microsoft.com>
Subject: Bug report: git reset --hard does not fix submodule worktree
Thread-Topic: Bug report: git reset --hard does not fix submodule worktree
Thread-Index: AQHTVQWYrZ3IvwcUiU2/W/51w87YVw==
Date:   Sat, 4 Nov 2017 00:46:26 +0000
Message-ID: <BN6PR21MB0114B8ECD6E8A158FB4A6FBFCB520@BN6PR21MB0114.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:e::32a]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR21MB0116;6:kik8K8yLYxsXEYSgQzP+xnr/FFmJuLCn4xegXGlv4mMf50MQuLe11cay+GD6Pdq6o99RAQEljFfk4qZuJ6SSpzdDMDt+zf6DA3LOS/Xihjiu9kZfM/+hJ/GfYTKF24t8XdHasdaP+NrONmTKppTZRpe8Sfx+sZi8cUJj+ElBsHozfADzDNdkiHJJcdVU/bfT1h7rLR710Jz2LFlzM5IcfKAn/89Q01E1t8nuyODZ+fveFAF/c/hg80wL51+5oRGoCeyJ6+8ztcFol7ImITT4Qv60MBPHLX/wE3IFeQ6KcYEIZtxF6EIRqwRbkZjrgkACVwP3Z/hEktlqY3WXE/pkQPJVvzBJ5k4fjup8OYg3OSc=;5:DCjTOZ/WkN4k7ZJDJcQZRKo55el2J7v5WBmY3L7vVcmdHF1J2zfBtgAT+dI2A4S23MAlIE493Nul6+vs/senq+uA4t77Cnl5ps8JIV8He94Y9XTA0qzHYF+/foeHxHZi9QMlVQQ6GlwtplCIot9N4FZ6cbVntrkpNAtlt4aWTZM=;24:FBPi8T+5xq9jN/A8riv45BRIfKRnUUsrGuvnDpnvwT+Go+L8qIjbj+G7FEoHrGTgYGl8Kg3k9216tIdoWumyR+/JbGo67sPWj6lz76jrCWE=;7:klgeJKXcdOYehTO0fdEIFhLaKUQJ9mXokyfP9iAjKKVmOFJH3FBAamiMC8/I5XwfxJ0fKPHD2y2vLdeZLsH+lNuvK3JnAqBCiLjVkrbFhFfFdXV8cAJQlBKHuDbaWimnY7OIiDv+LbY7LadBCHXzwfj8iU4Ur5ZeXdeK5wSLDAAZ+O8INKnInUNJCaZLujF0bu442NX+fPoKlMNJoKcbSxlwNDVNj82Xra0U0rhjotD7TV6H9JhSqRzMD9ZKFz3V
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(6009001)(346002)(376002)(39860400002)(47760400005)(199003)(189002)(74316002)(6916009)(7696004)(8676002)(86362001)(305945005)(77096006)(2351001)(6506006)(2501003)(7736002)(102836003)(4326008)(86612001)(99286004)(8990500004)(68736007)(8936002)(81166006)(81156014)(1730700003)(5660300001)(97736004)(3280700002)(3660700001)(33656002)(54356999)(50986999)(22452003)(106356001)(107886003)(2906002)(54906003)(316002)(6116002)(2900100001)(478600001)(5640700003)(25786009)(105586002)(9686003)(53936002)(10090500001)(6436002)(14454004)(10290500003)(55016002)(189998001)(101416001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0116;H:BN6PR21MB0114.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-correlation-id: 8bc074dc-c375-4921-45c7-08d5231d7af8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(48565401081)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603243);SRVR:BN6PR21MB0116;
x-ms-traffictypediagnostic: BN6PR21MB0116:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bion@microsoft.com; 
x-exchange-antispam-report-test: UriScan:;
x-microsoft-antispam-prvs: <BN6PR21MB0116922F886A2D0F267F7BAFCB520@BN6PR21MB0116.namprd21.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(3231021)(10201501046)(93006095)(93001095)(100000703101)(100105400095)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123564025)(20161123558100)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BN6PR21MB0116;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BN6PR21MB0116;
x-forefront-prvs: 048111149A
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc074dc-c375-4921-45c7-08d5231d7af8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2017 00:46:26.5814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0116
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, Git folks. I managed to accidentally break the our test lab by attem=
pting to git mv=A0a directory with a submodule inside. It seems like if a r=
eset does an undo on a mv, the workfold entry should be fixed to put the su=
bmodule in its old location. Consider the following sequence of commands:

Setup a git repo with a submodule:
mkdir metaproject
mkdir upstream
cd metaproject
git init
cd ..\upstream
git init
echo hello > test.txt
git add -A
git commit -m "an example commit"
cd ..\metapoject
mkdir start
git submodule add ../upstream start/upstream
git add -A
git commit -m "Add submodule in start/upstream."

Move the directory containing the submodule:
git mv start target
git add -A
git commit -m "Moved submodule parent directory."

Check that the worktree got correctly fixed by git mv; this output is as ex=
pected:
type .git\modules\start\upstream\config
[core]
        repositoryformatversion =3D 0
        filemode =3D false
        bare =3D false
        logallrefupdates =3D true
        symlinks =3D false
        ignorecase =3D true
        worktree =3D ../../../../target/upstream
[remote "origin"]
        url =3D C:/Users/bion/Desktop/upstream
        fetch =3D +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote =3D origin
        merge =3D refs/heads/master

Now try to go back to the previous commit using git reset --hard:
git log --oneline
 1f560be (HEAD -> master) Moved submodule parent directory.
 a5977ce Add submodule in start/upstream.
git reset --hard a5977ce
 warning: unable to rmdir target/upstream: Directory not empty
 HEAD is now at a5977ce Add submodule in start/upstream.

Check that the worktree got fixed correctly; it did not:
type .git\modules\start\upstream\config
[core]
        repositoryformatversion =3D 0
        filemode =3D false
        bare =3D false
        logallrefupdates =3D true
        symlinks =3D false
        ignorecase =3D true
        worktree =3D ../../../../target/upstream
[remote "origin"]
        url =3D C:/Users/bion/Desktop/upstream
        fetch =3D +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote =3D origin
        merge =3D refs/heads/master

Is git reset intended to put the submodule in the right place? If not, is t=
here a command we can run before/after reset to restore consistency?

Thanks folks!

Billy O'Neal

