Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B13C282DD
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 16:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0B2206ED
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 16:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wolve.com header.i=@wolve.com header.b="YUjJP7nY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387756AbgAIQia (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:38:30 -0500
Received: from mailgwchi1.wolve.com ([192.243.218.119]:61344 "EHLO
        mailgwchi1.wolve.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbgAIQia (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 11:38:30 -0500
X-Greylist: delayed 575 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jan 2020 11:38:28 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wolve.com; s=mailgwchi1; t=1578587909;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1rOKirAouev6u27qInTtlTXJ9W/FyyJrn9U3fMGEvVE=;
  b=YUjJP7nYO+Oplvy0U3aMqke3yNXSzSySsdVth6Ilghiln9DaKWUb7lOn
   bu9upa3kdEMgWIT5TO8wqX+p8yMyPCuCaDgrbLbENK1eGNrBdbYm1yB+a
   uN7zQxojq7a24fneriwql7NPhiqyZl0unSIOCwPH8oDBHwIBPtQgQ8hFO
   4cKSJEB47ST4T3W9NND0lMOT9SM+4Paa3HJE4YqhWIwhikZkP/rnL13/7
   YCfoTwYAdeBoSY0T4FrEVtMewMJqPxf1jTkgSQZ4dDlOcK06WhHF7h/aI
   KYXlRizWnrjw9VUXLGI46GaqWivTs2m3NefLfd91maWHqQNwEwsug8C9g
   w==;
Authentication-Results: mailgwchi1.wolve.com; spf=None smtp.pra=rmiller@wolve.com; spf=None smtp.mailfrom=rmiller@wolve.com; spf=None smtp.helo=postmaster@mailgwchi1.wolve.com
Received-SPF: None (mailgwchi1.wolve.com: no sender authenticity
  information available from domain of rmiller@wolve.com)
  identity=pra; client-ip=10.8.8.120;
  receiver=mailgwchi1.wolve.com;
  envelope-from="rmiller@wolve.com";
  x-sender="rmiller@wolve.com"; x-conformance=sidf_compatible
Received-SPF: None (mailgwchi1.wolve.com: no sender authenticity
  information available from domain of rmiller@wolve.com)
  identity=mailfrom; client-ip=10.8.8.120;
  receiver=mailgwchi1.wolve.com;
  envelope-from="rmiller@wolve.com";
  x-sender="rmiller@wolve.com"; x-conformance=sidf_compatible
Received-SPF: None (mailgwchi1.wolve.com: no sender authenticity
  information available from domain of
  postmaster@mailgwchi1.wolve.com) identity=helo;
  client-ip=10.8.8.120; receiver=mailgwchi1.wolve.com;
  envelope-from="rmiller@wolve.com";
  x-sender="postmaster@mailgwchi1.wolve.com";
  x-conformance=sidf_compatible
X-IronPort-AV: E=Sophos;i="5.69,414,1571720400"; 
   d="scan'208";a="68298554"
Received: from exmbcl.wolve.com (HELO mailgwchi1.wolve.com) ([10.8.8.120])
  by mailgwchi1.wolve.com with ESMTP/TLS/AES128-SHA; 09 Jan 2020 10:28:53 -0600
Received: from EXMBCL3.wolve.com ([fe80::380d:600:105a:4832]) by
 exmbcl.wolve.com ([fe80::2044:4f7e:df33:3436%18]) with mapi id
 14.03.0435.000; Thu, 9 Jan 2020 10:28:52 -0600
From:   "Miller, Robert" <rmiller@wolve.com>
To:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: Bug report: 'git svn fetch' failing during parent resolution
Thread-Topic: Bug report: 'git svn fetch' failing during parent resolution
Thread-Index: AdXHCN2k/uk1h6dPQs6vuuDiaJKQxg==
Date:   Thu, 9 Jan 2020 16:28:51 +0000
Message-ID: <B5D49B7A94F14F4F94C605FAE07231FA1E218CE0@exmbcl3.wolve.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.26.2.104]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

While I've been working on migrating my team's SVN repository into Git, I'v=
e run into what I believe to be a bug in git-svn's fetching functionality. =
In particular, I'm getting output which looks like this (with the repo URL =
redacted):

$ git svn fetch
branch_from: /Projects/WORMS/Database_Schemas/TradeDb =3D> /Projects/WORMS/=
Database_Schemas/TradeDb/tags/v12/0.12.26.0
Found possible branch point: [SVN_URL]/Projects/WORMS/Database_Schemas/Trad=
eDb/tags/v12/0.12.26.0 =3D> [SVN_URL]/Projects/WORMS/Database_Schemas/Trade=
Db_Daily/tags/v12/0.12.26.0, 68307
Initializing parent: refs/remotes/origin/tags/0.12.26.0@68307
Found possible branch point: [SVN_URL]/Projects/WORMS/Database_Schemas/Trad=
eDb/tags/0.12.26.0 =3D> [SVN_URL]/Projects/WORMS/Database_Schemas/TradeDb/t=
ags/v12/0.12.26.0, 56925
Initializing parent: refs/remotes/origin/tags/0.12.26.0@56925
Found possible branch point: [SVN_URL]/Projects/WORMS/Database_Schemas/Trad=
eDb/trunk/WormsModelDb.bak =3D> [SVN_URL]/Projects/WORMS/Database_Schemas/T=
radeDb/tags/0.12.26.0, 54810
Initializing parent: refs/remotes/origin/tags/0.12.26.0@54810
Found possible branch point: [SVN_URL]/Projects/WORMS/Database_Schemas/Trad=
eDb/WormsModelDb.bak =3D> [SVN_URL]/Projects/WORMS/Database_Schemas/TradeDb=
/trunk/WormsModelDb.bak, 46608
Initializing parent: refs/remotes/origin/tags/0.12.26.0@46608
Use of uninitialized value $args[1] in join or string at C:/Program Files/G=
it/mingw64/share/perl5/Git.pm line 1635.
Use of uninitialized value $_[2] in exec at C:/Program Files/Git/mingw64/sh=
are/perl5/Git.pm line 1661.
fatal: Not a valid object name
ls-tree -z  ./: command returned error: 128

This output is from Git version 2.24.1.windows.2 running on Windows 10 1903=
 and accessing an SVN repository which is, to the best of my knowledge, on =
version 1.9.5 (I don't have direct access to the server SVN is hosted on to=
 check its version myself; I can follow up if the specific SVN version turn=
s out to be relevant to the investigation). The fetch operation had been ru=
nning smoothly up until I hit this error case, but now every invocation of =
'git svn fetch' produces this same output.

Based on the generated output (and my very limited knowledge of Git's codeb=
ase and Perl's syntax), I believe that the problem stems from the following:
1) Within either Git::SVN::Fetcher's delete_entry or open_file function (I'=
m not sure exactly which, but the "ls-tree -z  ./" construction appears to =
only come from one of those two places), the value $self->{c} is undefined
2) $self->{c} is only set in Fetcher's constructor, where it takes the valu=
e $git_svn->{last_commit}, implying that this value is also undefined
3) This value would have been set during a call to Git::SVN's find_parent_b=
ranch function if a call to find_rev_before had returned defined values

My theory, then, is that git-svn failed to find a valid parent revision, bu=
t doesn't have error-handling logic in place to handle this edge case when =
the SVN repository has orphaned revisions that appear to be related to the =
tag being processed. This would be in keeping with the behavior reported in=
 a Stack Overflow question from 2010 (https://stackoverflow.com/questions/4=
367460/git-svn-fetch-fails-ls-tree-dying-because-of-missing-tree-object) fe=
aturing very similar output to what I ended up seeing.

In my case, I believe that the issue stems from the non-standard repository=
 structure (with the 'tags' directory containing subdirectories rather than=
 directly containing tags). The tag named '0.12.26.0' was originally create=
d at the base level of the 'tags' directory, but later moved into the 'v12'=
 subdirectory;  it's possible that this move was somehow botched and result=
ed in a repository structure that git-svn isn't able to make sense of.

Assuming that my analysis is correct (and since I'm somewhat out of my dept=
h here, it very well may not be), I would propose some combination of harde=
ning the Fetcher against missing data, providing some sort of diagnostic wa=
rning/error message, and/or discarding orphaned SVN commits without passing=
 them to the Fetcher to begin with, perhaps controlled by some additional s=
witch for the fetch command.

If there's any other information I can provide that would be helpful for in=
vestigating this issue, let me know and I'll be happy to provide it.

Thanks,
Robert Miller
 =

---------------------------------------------------------------------------=
---

This message is intended only for the personal and confidential use of the =
recipients named above. If the reader of this email is not the intended rec=
ipient, you have received this email in error and any review, dissemination=
, distribution or copying is strictly prohibited. If you have received this=
 email in error, please notify the sender immediately by return email and p=
ermanently delete the copy you received.

This message is provided for informational purposes and should not be const=
rued as a solicitation or offer to buy or sell any securities or related fi=
nancial instruments. Wolverine is not responsible for any recommendation, s=
olicitation, offer or agreement or any information about any transaction, c=
ustomer account or account activity that may be attached to or contained in=
 this communication. Wolverine accepts no liability for any content contain=
ed in the email, or any errors or omissions arising as a result of e-mail t=
ransmission. Any opinions contained in this email constitute the sender's b=
est judgment at this time and are subject to change without notice.

