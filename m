Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5830920281
	for <e@80x24.org>; Tue, 12 Sep 2017 20:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbdILUUK (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 16:20:10 -0400
Received: from mail-bl2nam02on0099.outbound.protection.outlook.com ([104.47.38.99]:47546
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751311AbdILUUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 16:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9h+EAMffDXr22Bte8tYINDQVttuLIjxFvW8UIXwo8aw=;
 b=iSMpNz1P4MyNS9ObgEi4YIdQMTXK67jW/CQAStwlHTs/itDDbbm4Jchu+PdPq2Rmjz3J7sqbBm0+0FAhM5v2bTgn261n6xwDPlYsm1TVrZ3ftRZ1pSS3+eFIyeqosye96dxe5NE8vm5MAZeFxfzxhV6cb8qYI9+IJpmrT+Ik3PE=
Received: from SN1PR21MB0014.namprd21.prod.outlook.com (10.161.254.12) by
 SN1PR21MB0016.namprd21.prod.outlook.com (10.161.254.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.4; Tue, 12 Sep 2017 20:20:07 +0000
Received: from SN1PR21MB0014.namprd21.prod.outlook.com ([10.161.254.12]) by
 SN1PR21MB0014.namprd21.prod.outlook.com ([10.161.254.12]) with mapi id
 15.20.0077.004; Tue, 12 Sep 2017 20:20:06 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "pclouds@gmail.com" <pclouds@gmail.com>
Subject: RE: [PATCH 1/1] reset: fix reset when using the sparse-checkout
 feature.
Thread-Topic: [PATCH 1/1] reset: fix reset when using the sparse-checkout
 feature.
Thread-Index: AQHTKMyCASx4J5FrG0SFSfVy0yz4a6KrWy30gAAJb7CAAH5jR4AAB2mQgAMpW3CAAHk5AIABF7AQgACzS9A=
Date:   Tue, 12 Sep 2017 20:20:06 +0000
Message-ID: <SN1PR21MB0014435A97BCDA324FD55B46B7690@SN1PR21MB0014.namprd21.prod.outlook.com>
References: <20170908180050.25188-1-kewillf@microsoft.com>
        <20170908180050.25188-2-kewillf@microsoft.com>
        <xmqqvaktxawk.fsf@gitster.mtv.corp.google.com>
        <SN1PR21MB0014638E5D9CBFD0D9D85F10B7950@SN1PR21MB0014.namprd21.prod.outlook.com>
        <xmqqr2vgy2yt.fsf@gitster.mtv.corp.google.com>
        <SN1PR21MB00140C84DC02F3491F4E8469B76A0@SN1PR21MB0014.namprd21.prod.outlook.com>
        <xmqqh8w951ek.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1709111259430.4132@virtualbox>
 <xmqq4ls836z3.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqq4ls836z3.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Ref=https://api.informationprotection.azure.com/api/72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=kewillf@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2017-09-12T14:20:05.0685554-06:00;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [174.126.250.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR21MB0016;6:w8VU3w1IvUlro4XkhrktzDR7KDtkqLNJBzZ4N2O94HyzP0UKT0N/cInHI/z7EHhj+5yKEJsPLfBKrvn49rtZ1DCStKctO6aYVbDdtDMZRXHsVQF1De+dw3t7ArB8dRZKzcLPPntQ7MfFUhAY5ri4GBPX3k3D1N8wfCfvJZecEqv27Keaq5FUa5p5O4v/p66HqRD4BR9y6bxJQ09h6teDzvNCmrdxBYdE3AvPnF9lHYWT1r0CJ5USKZjCL28rvp2OzQSE9bq4h7TkHfguqvUQDqek1HcCoJ3q6SnsoKcYiE/3L9fT7Zjpur3q38IhUVEgPn22ctJff38VJM8nhphOEw==;5:sepmJzWxI7dA3GjnuyE5Pri+afoK4QCUKhABejKQowFK14moen4LoNe1bK2o24JhjgJtEtCSG5UkM5yZSK3z+fFksLRnVPPzdZqrVVk1PYUoKmbVN4PUf8Yi+/j0V/X5tcKeekhWkBIKcmOXvxOcMA==;24:qSMP2J6Mr0Idaw9OKc6gkgk/yarN6eeGQJzNCRqsUVdLWC/vuAYpAqdcFZ9JzdsTAXPRmOQX41hLIlwOZP07prhYGILRqtZXOSVOtWqqo4w=;7:CuEkF6ybie/KhquYiqsjw+9Zh+QbczUVfppdTZh/z4c0yWrn7AR0tIAHCrQVlNBmvIzc1bBxgZ9M074QOoES2nAefbfpqMDRKnCzSuIqfqjI3mihWPMifFbtUTBEUa+lZLedr+t/XNPs+PZNdY7WqIQtIZ0KtoqUFUMzaXrNVTeMMh96VlhO3VjiSJFUg2lBD3YzuuLmFYzoTb5eg1scvXlRKVn+XIDCMpeil4dtwOY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ff913019-5fcf-4e04-ca00-08d4fa1ba8d0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:SN1PR21MB0016;
x-ms-traffictypediagnostic: SN1PR21MB0016:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kewillf@microsoft.com; 
x-exchange-antispam-report-test: UriScan:(100324003535756);
x-microsoft-antispam-prvs: <SN1PR21MB0016EF9D57CEAA14D04CAA6EB7690@SN1PR21MB0016.namprd21.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041248)(20161123564025)(20161123562025)(20161123555025)(20161123560025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN1PR21MB0016;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN1PR21MB0016;
x-forefront-prvs: 042857DBB5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(376002)(366002)(346002)(47760400005)(199003)(189002)(377454003)(3660700001)(8666007)(316002)(189998001)(86362001)(8656003)(2906002)(3280700002)(14454004)(106356001)(2950100002)(93886005)(74316002)(101416001)(86612001)(55016002)(25786009)(54356999)(22452003)(8990500004)(105586002)(50986999)(7696004)(99286003)(76176999)(4326008)(97736004)(8936002)(77096006)(9686003)(2900100001)(54906002)(6506006)(39060400002)(66066001)(8676002)(229853002)(10290500003)(81166006)(3846002)(6436002)(81156014)(53936002)(478600001)(6246003)(102836003)(6116002)(305945005)(5660300001)(7736002)(33656002)(68736007)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR21MB0016;H:SN1PR21MB0014.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2017 20:20:06.7524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR21MB0016
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Monday, September 11, 2017 9:57 PM
>=20
> Let's imagine a path P that is outside the sparse checkout area.
> And we check out a commit that has P.  P would still be recorded in
> the index but it would not materialize in the working tree.  "git
> status" and friends are asked not to treat this as "locally removed",
> to prevent "commit -a" from recording a removal, of course.
>=20
> Now, let's further imagine that you have a checkout of the same
> project but at a commit that does not have P.  Then you reset to
> another commit that does have P.  My understanding of what Kevin's
> first test wants to demonstrate is that the index is populated with
> P (because you did reset to a commit with that path) but it does not
> materialize in the working tree (perhaps because that is outside the
> sparse checkout area?), yet there is something missing compared to
> the earlier case where "git status" and friends are asked not to
> treat P as "locally removed".  They instead show P as locally removed,
> and "commit -a" would record a removal---that is indeed a problem.
>=20
> Am I reading the problem description correctly so far?  If so, then
> my answer to my first question (are we solving a right problem?) is
> yes.
>=20

I think this is where I need to do a better job of explaining so here is a
simple example.

I have a file "a" that was added in the latest commit. =20
$ git log --oneline
c1fa646 (HEAD -> reset, master) add file a
40b342c Initial commit with file i

Running the reset without using a sparse-checkout file

$ git reset HEAD~1
$ git status
On branch reset
Untracked files:
  (use "git add <file>..." to include in what will be committed)

        a

nothing added to commit but untracked files present (use "git add" to track=
)

Turning on sparse-checkout and running checkout to make my working
directory sparse

$ git config core.sparsecheckout true
$ echo /i > .git/info/sparse-checkout
$ git checkout -f

Running reset gives me=20
$ git reset HEAD~1
$ git status
On branch reset
nothing to commit, working tree clean
$ git ls-files
i

file a is gone.  Not in the index and not in the working directory.
Nothing to let the user know that anything changed.

With a modified file no sparse-checkout
$ git log --oneline
6fbd34a (HEAD -> reset, modified) modified file m
c734d72 Initial commit with file i and m
$ git reset HEAD~1
Unstaged changes after reset:
M       m
$ git status
On branch reset
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   m

no changes added to commit (use "git add" and/or "git commit -a")

With sparse-checkout
$ git reset HEAD~1
Unstaged changes after reset:
D       m
$ git status
On branch reset
Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        deleted:    m

no changes added to commit (use "git add" and/or "git commit -a")

I think we can agree that this is not the correct behavior.

> But this time, I am trying to see if the approach is good.  I am not
> so sure if the approach taken by this patch is so obviously good as
> you seem to think.  A logical consequence of the approach "git
> status thinks that P appears in the index and missing in the working
> tree is a local removal, so let's squelch it by creating the file in
> the working tree" is that we will end up fully populating the
> working tree with paths that are clearly outside the area the user
> designated as the sparse checkout area---surely that may squelch
> "status", but to me, it looks like it is breaking what the user
> wanted to achieve with "sparse checkout" in the first place.
>=20

I don't think that we are trying to "squelch" status so much as make
it consistent with what the user would expect to happen.  If that means
not resetting entries with the skip-worktree bit or resetting the entries
but keeping the skip-worktree bit on, okay, but I would argue that is
not what the user wants because if you are now saying that sparse
means git will not change files outside the sparse-checkout entries,
what about merge, rebase, cherry-pick, apply?  Should those only
change the files that are in the sparse definition?  If so we would
be changing the commits from the original, i.e.  cherry-pick 123 would
create a different commit depending on whether or not you are using
sparse as well as a different commit depending on what is in your
sparse-checkout. =20

I see reset being a similar scenario in that if everything is clean, after =
I
"reset HEAD~1" I should be able to run "add ." + "commit" and have
the same commit as before the reset.  If this is changed to only reset
the sparse entries, there will be staged changes after the reset because
HEAD has changed but we didn't update the index versions of the files.
If we do update the index with the "HEAD~1" version of the files and just
set the skip-worktree bit then the next commit will not have the original
changes outside the sparse-checkout for the commit.

> When we make a sparse checkout that places P outside the checked-out
> area, with P in the index and not in the working tree, what asks
> "git status" and friends not to treat P as "locally removed"?
> Shouldn't "reset HEAD~1" that resurrected P that was missing in the
> commit in the state before you did the "reset" be doing the same
> (e.g. flipping the bit in the index for path P that says "not having
> this in the working tree is not a removal---it is deliberately not
> checked out")?  If that is the right approach to solve the issue
> (which we established is a right problem to solve already), and the
> approach that the patch wants to take is quite the opposite of it,
> then my answer to the second question (are we solving the problem
> with the right approach?) is no.  And at that point, it is moot to
> ask if the code correctly and/or efficiently implements that wrong
> solution, isn't it?

I agree that we must determine if there is a problem, which I hope
we can agree that there is a valid problem to be addressed.  Determining
if I used the right approach depends on how you see reset working
correctly using the sparse feature.  Should it match a reset when not
using sparse or should it reset only sparse files?  I saw issues
if only the sparse files are the ones reset, which is the reason that
I went with this approach.

Thanks,
Kevin  =20
