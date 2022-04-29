Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58554C433FE
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 15:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378656AbiD2P4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 11:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378630AbiD2P4l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 11:56:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54E4C8A83
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 08:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651247599; x=1682783599;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=lHVadIrGxXDDJ37VgkX+HXzWBQXSmUOj1IV7xvCiVNc=;
  b=ZAsd0pGf8EP+jCiGN7CFFLRjIveXL/LlcpBf1tteR2CRqLy1+tdjrR68
   fiwDkuN3GrZT8uTC9anvbkNsxo0U/QRWnrHmmPeDs96JnnMhgG69n7tbi
   4zi6o3yGMUHohyq7lxER0Fu2xssWycukILFxjh+G61cp0fJLfWpXAYH++
   /oFfVJtU0F7+RNN1qJNa9mKDgUP+4wBCDjN4CrADvBo/wLYjy7ukOK7yY
   +WcliL3qJMVi7Zl98F5k9xW3yyrsri/pqyom5jN/W8E39SO5gm9ap396I
   9gj0ertVDlvhhkJEDEDKe0/PI40SvcWCVOzXeFE4WQ7xXzyL9CSuRZLy1
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="266836452"
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="266836452"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 08:51:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="597385610"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga001.jf.intel.com with ESMTP; 29 Apr 2022 08:51:02 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 29 Apr 2022 08:51:02 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 29 Apr 2022 08:51:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 29 Apr 2022 08:51:01 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 29 Apr 2022 08:51:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekuNNmMxVlcmBoXqY8h/NzOJi585y++dpyxcPj/ZpMYoQzoVlXNvOSX/8EvZeVSuV0XCyTa5BTYzC/WU1jtYnCFJTQ6EEjt5nFdBOWEq7fKsXZbW6657YfzEzdM5K9OBIcPwRNMzqvRdYnV1VEbawOHJDJlvAICOdI0wDCWZtpr8tZb7othvI2RJrE3ew0N91w2lfk4VvCO3j5bGcgo+8pyh89MeJyxn3mWxteObOVlbu6jSBnnh7Ur2XoGzaQ5gfiurdEEXaRS30nVrwIka5FQEi2nD5dEpSFpFw4tKpGTxHifyI2bh2Qkk9NIbxl/OOUdQHb+B34MV2r6ve1k3Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHVadIrGxXDDJ37VgkX+HXzWBQXSmUOj1IV7xvCiVNc=;
 b=EPFzvltKj9WoYq6FTQwN4nUbue9j6AtxD2U1HZnP21tGZjJhIqHXPQJ4gykFjHF6AnezKYav7G1dGDjrSJVQXM44rcpCI7vQcg7MzsPgT5tJXerDWSzaBnNWNwer6cbdijVWVELVEkoLawlwe6akf8v32q+XAsxinjfnD1beOxCqyr/UxWcZK9n1bC4BEdnCaO9SihjByiMrPCwy3gJhtNx+d0EQlrEtOlF7b7txIc4qIPN/c85V/uggu3PGDZLIwkqWuMTtKGHiUZlqcxWDQ/zFmN9aKv5evYB6L9SEnbk3mnay0JpUSiApaxbEdKUv/fgan5y3t3QqoixJUamxDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6089.namprd11.prod.outlook.com (2603:10b6:930:2f::20)
 by SN6PR11MB3343.namprd11.prod.outlook.com (2603:10b6:805:ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 15:50:59 +0000
Received: from CY5PR11MB6089.namprd11.prod.outlook.com
 ([fe80::ed8d:a362:4a6d:3bd]) by CY5PR11MB6089.namprd11.prod.outlook.com
 ([fe80::ed8d:a362:4a6d:3bd%3]) with mapi id 15.20.5186.014; Fri, 29 Apr 2022
 15:50:59 +0000
From:   "Mirochnik, Oleg V" <oleg.v.mirochnik@intel.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git reset --hard can leave modified files
Thread-Topic: git reset --hard can leave modified files
Thread-Index: Adhb4MMAQOnQgyaTQG+zXJEHEdwbng==
Date:   Fri, 29 Apr 2022 15:50:59 +0000
Message-ID: <CY5PR11MB6089858FD6FCC971D6F216DDC6FC9@CY5PR11MB6089.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e06252c-bd3d-456a-51d5-08da29f80e8c
x-ms-traffictypediagnostic: SN6PR11MB3343:EE_
x-microsoft-antispam-prvs: <SN6PR11MB3343A518EA5D431070AB6520C6FC9@SN6PR11MB3343.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8q720D/bFukP+Yx1e/Hk3n+TK9O9hqm4rh/U/Q/CHxsm0JA/OyY/AXgBCDoASpMNXuUFkdkOmU5DzHQ68guY0cXPUaKhaAMw5Vr0Le9Xo8YCOH161oNWGTwyk//WRjT3sO2Sfjn48Tg4GGvssygvt/YFYS3SSIB4hOKMhfrcWkdFHdBTALmcGXXNGAjXKcM5UFdhOp1z3tbGpqmvfAMJzz6/OmcGbf1TBGdPxb4W444GL3NhN6K7QXoW3sOeg9nQJGRA7+n8fKG5N59ThwO8mLLthRUci71UHGh0onMA9FPCPcE7IA13R2Vz9vsuD28LYKoo5+7VscSeaocxxomgfWRbdli/i2QHX4nlVs2E7/8sJ2b86Gwz9mcNo7V9mFzMcGSaGxGigkj5kWW1WHnuA75T/82GMaJFfIeDLuKEJh7GrmDDJ2ogyZtvaXtpI59+J2RcIN6Kk3zFMVC1AjBqNudAXS13WsHRS8vkWTg0Zi2SZtkW33UvFTKBZt2RLGwsriIRuRbU0TEgcQiU7FqSEoMluiypsar+lL12ActXMLQcYmSDok88OFrx2zx4cBehJDBFnJB5aJpZ7VfOvsxH0qxUu0NhZsyXdvm35tKLdRw+vysI503zvyJw3xnc7OLiOVxgM29R4S+82b9/sRmbDC5s5h231XOx0CMZgRfMbSaYere1OsPUv6/X0F6r+wxzMnOGKUqTn/OEe4uuh3PnLUZSrD+AaqGxRjCWvQIVdV7H0MBwAfU5ce9zE3DcRkUJ0IgTo0a8CimBJHWgH0//nlTk+WqFz/7kEdurdeWObZI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(8676002)(76116006)(71200400001)(122000001)(66476007)(66946007)(66556008)(66446008)(55016003)(508600001)(38100700002)(6916009)(5660300002)(82960400001)(52536014)(8936002)(6506007)(9686003)(2906002)(26005)(966005)(86362001)(33656002)(7696005)(186003)(316002)(38070700005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bYXbJoxtrJvaaKuXE9Jc5/xZlFj7+6XL3UnuMAcWbp09lDcSoPQzAuhcYs4I?=
 =?us-ascii?Q?iqNXfbfMWva3HQe7f38u6Z9acdM4Ip0IwqR0s1yuElOGQbOn44oRL+DW23ec?=
 =?us-ascii?Q?6IoiGewsBq85Er3cDhkJDstMEIljBBFbdnepJZPypWdPYupOeDbABPckHMdy?=
 =?us-ascii?Q?+GUqO7N2swiy754HTjdGZ8wmJNVeylFb/b6Z1KaHW+iWw05yPXo0ec+T0p4V?=
 =?us-ascii?Q?VBR+q26+fyFbWKpeZgcfJybP2lKNemJnyZqjvEGky8l677Af8iDtDx5Br5Gt?=
 =?us-ascii?Q?40XFGjd1w/3M1WeAgLkPfNncMwVO9Gey89vPAvZx2Rj76hD7HiVSueM0f5Gf?=
 =?us-ascii?Q?dWkA+ATyzAxUTD7yNV/mEUgAh5BJTKjvY2Q+NO1X77JfpTGaqu90vz8l73kM?=
 =?us-ascii?Q?G+5n8Zsr4IH3y4wNajPJm8PYmQ+feeLWBsjIXuPKPz18y1KnKT3zywjjOycc?=
 =?us-ascii?Q?H7rHMBOr7MxMVZGZv6EpRF6jGAKqJqvAGZamizMcmqtxngh7nwWdWMcoC+TH?=
 =?us-ascii?Q?ymLMJ698XJywtZMbuzaCA0dzmnDIPeKmThvn2K46gKSuNnnLXkeJIWnDVsUY?=
 =?us-ascii?Q?F8B3JVqPluTQ6cE9m3W79lFrVl/6I+Q3Ej5NLPutGg/AmXPEmzjjDx4dQQ8j?=
 =?us-ascii?Q?5Xthmvh6EiSDm7tIq+fcZKEHStcZ78EgL18W+8bGGu4RVaRE3IT9ctwPlZ6q?=
 =?us-ascii?Q?Gucf5ghjwzy5vyJBLonIe6lExA4V+jILB8iENYPOGIZ1XEfYPVCsfeaQRhe1?=
 =?us-ascii?Q?AQCuGrEeoXQ48ni4e/XIv2m3ljC3fpM5j90okJDL2lJPsVoA9h+BSSu4UCda?=
 =?us-ascii?Q?CDGMeSaZ/FISxUpcMG2diJfMxeUCmdIyYA0EfsBwckb78alh4NCLlBetd4PI?=
 =?us-ascii?Q?nQT1RvKUG6Uhr1Nty92DvC7Ay2YaNhQrgJIpJuuf2K1Rd+mEv1QYr7qhifNG?=
 =?us-ascii?Q?2DYfay0G3CvXkoiiNfFqyebIw+/nt/4QZ3awGhVoZOaC+EBX49L9Wwg/e+So?=
 =?us-ascii?Q?DUkKq08o9oWLsDHR/dsBo9Avjm4axKCaEI1wqw+tNxOiUf9Hr1rBE6173Nif?=
 =?us-ascii?Q?4TaiLdhlJOKbJ02K795QJ/hB3/Us2dYZ9GV9jJZLHfKdVW9eeq+zjKdKOWH1?=
 =?us-ascii?Q?NI+5mqox39DMAabuZH0Q7I343C7L9clOWloFl14bQki3oWZGcusWU/z+GMsd?=
 =?us-ascii?Q?IUspKrIgT/Bd5/Z3xT3MJxo1fo+Z6DEIwUhXr6+lvoQ3EmhbgytJVnjfBm6d?=
 =?us-ascii?Q?oy14QRCaqG805O9t0bzkyoUNgW9YB+3KgSosQyfqcBAjAt31bokhRrHqxVf9?=
 =?us-ascii?Q?e3on5epsNbhmFjtIR/7lLJu2tOS/fDc6gQ9msO9N4fiduT1fwpEA8zzOnuWz?=
 =?us-ascii?Q?SfuzXCObdxSrvkAve/578qk6TodvCCDJ64HOKTa2uGEW+GxaJjf5/vWzWmHg?=
 =?us-ascii?Q?+nnmYyoKiwH8tPssiNXoP+RX8L2W38BHkTpuh7E1qD+PcXeiTG5ommp1eCHt?=
 =?us-ascii?Q?94oYCGvBBqREDdylYxOIevf7AyBaqqExK1mgpeGOOS0rWHF2d3ZzPLGnrUR5?=
 =?us-ascii?Q?o6FtHAvCOSzuIqe9yYYhNuiotYlkq99SXWwTjiBYo7G9Z8doeF0EqaPykh/o?=
 =?us-ascii?Q?ZdR3Ogr2s59MMatzUX0pt+JDGZVAmvRiwOuXjPCTlwNWYvoyTlWPHkCQycRf?=
 =?us-ascii?Q?Ya7lbrb3NXmEk1lVtTm+c8Oa8A9Q1/WRlrIG5bRJzBU0p7VbxIQNdTPhSwRq?=
 =?us-ascii?Q?AqFzdnTcELUNjH9HiR4X6yauotiEOmc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e06252c-bd3d-456a-51d5-08da29f80e8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 15:50:59.8738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EsYyYep8W2yonvKG2vHnMemmv9mZ4v9jJxx3yGv0Kui+RdLHtm9TIk7S6r2TtPzHEfy0Q2/Lo2WmvTVELgk10+DWhMNY0zHesjPrCW2RAjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3343
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
git clone https://github.com/intel/llvm
cd llvm
git checkout git-bug-reproducer
git merge 38df0bd4fccd1067f3abe078d42e94c740748628 -m Merge1 --no-ff
git merge b6b8d34554a4d85ec064463b54a27e073c42beeb -m Merge2 --no-ff
git reset --hard HEAD~
git status --porcelain

What did you expect to happen? (Expected behavior)
An empty output from the last command

What happened instead? (Actual behavior)
 M clang-tools-extra/test/clang-apply-replacements/Inputs/crlf/crlf.cpp
 M clang-tools-extra/test/clang-apply-replacements/Inputs/crlf/crlf.cpp.exp=
ected

What's different between what you expected and what actually happened?
Obvious

Anything else you want to add:
The issue is flaky. First found for v2.29.2
Multiple executions of the "git reset --hard HEAD" can help.
I ran a simple script to get some numbers: 100 attempts to get and fix the =
issue with up to 100 runs of the "git reset --hard HEAD"
Got max number of runs - 45. Most of the cases (63) required 5 runs. 5 case=
s did not get the issue at all.
V2.36.0 built from sources got similar results:

The script:
(set -e; for a in {0..99}; do echo ++++++++++++++++ a=3D$a; git reset --har=
d origin/git-bug-reproducer; git merge b2d4d67d5e34c345cb6a3cf725b2e26a15a9=
dfe5 -m Merge1 --no-ff; git merge b6b8d34554a4d85ec064463b54a27e073c42beeb =
-m Merge2 --no-ff; git reset --hard HEAD~; for b in {1..99}; do git status =
--porcelain | grep . || break; git reset --hard HEAD; done; echo ++++++++ b=
=3D$b; git status --porcelain | grep . || continue; echo FAILED $a; break; =
done) > ../logg 2>&1

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.36.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 4.18.0-193.el8.x86_64 #1 SMP Fri Mar 27 14:35:58 UTC 2020 x86_=
64
compiler info: gnuc: 4.4
libc info: glibc: 2.28
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show=0D=
