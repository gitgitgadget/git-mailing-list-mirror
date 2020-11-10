Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070D8C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 20:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 882512067D
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 20:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QxwIKS+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgKJUD0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 15:03:26 -0500
Received: from mail-bn8nam08on2129.outbound.protection.outlook.com ([40.107.100.129]:11201
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727275AbgKJUD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 15:03:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VA+i3DmJ7ILUp5WYzusRSaJLNfKM7WA4RpDB/bXbxSJjWeDn3j1CuVwQuug2Eog8jzREzYAWMx6AGR3Xwuijr24tefSIXnshPuCTU59iOCQczcQcoptX/MwSHg8IfTkFLkKtExhoOSmt5pIi2CK1EfjE3vxud71q/WZHRXh59WPmLls8t7Xp2l5AD4xtU9IBT9n7g7CSywD6Mq3fydKLQQnVjvisHg/8Ui7veb0ONjpxEYnG+nQ9V4+IfctUxVGIqDMPC8gL3jNPEDlNoUOd0ys4dez7c660wEDiwoCvl5GMJWM11imNKVclol3bQiCKXuhnYKpe2UbTWTmA5TYyPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZnNEytweoPx8QKxh3xUB6OMTkhvEGVR8jjgceBpioE=;
 b=FXhf2tPSknfJwihoZFeeI7JUaLNBwt7PXfDgqnTLVxh992YS5sQrxEMFSdRZH8W3y22ueuZmki6XdODNNRVLOlyTQNfIFj6BAQYazBExNUKKdqy11fl+53szwSeDj6uqP2ioi8DQyMXXY++2O9iZOJtU1LPvQKjyZUSibHPSbWBejszcvHh7Ni/e3ypz9eSk69tqz/TnMds5OJ6D7BffdPgYaGAXBmkx1EgxT2suIXbevzFjpuMDt2hI6Jp/HCymw51LA4zZcQTImUWg9AfXgfC9o+3sTXszAlmAWnt8+YOHz2czlwtTUuWoHcXA+0OT0xSDnPoz+03vlM8U0NIpKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZnNEytweoPx8QKxh3xUB6OMTkhvEGVR8jjgceBpioE=;
 b=QxwIKS+5AJ/9odofDSlRJkrwWkBGRldI3+jkEwCyyvEqahzuonBkUgP5C8FfIdSa6Exlj1P0Qs5Ocs9nFxPNEUv3GKmYkHLMOvEauoqMOgJdhRAoArafAbeRLux+6gGDx0xBv9DxsVRzI5eV2/Xly0NHUz485Z3cbJWf6PJPAqI=
Received: from MWHPR21MB0143.namprd21.prod.outlook.com (2603:10b6:300:78::13)
 by MW4PR21MB1857.namprd21.prod.outlook.com (2603:10b6:303:74::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.6; Tue, 10 Nov
 2020 20:03:23 +0000
Received: from MWHPR21MB0143.namprd21.prod.outlook.com
 ([fe80::f95a:3a77:41da:50e1]) by MWHPR21MB0143.namprd21.prod.outlook.com
 ([fe80::f95a:3a77:41da:50e1%8]) with mapi id 15.20.3564.021; Tue, 10 Nov 2020
 20:03:20 +0000
From:   Ryan Wilkerson <Ryan.Wilkerson@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: BUG: Windows Color scheme not preserved
Thread-Topic: Windows Color scheme not preserved
Thread-Index: AQHWt5yJLxpR1twp9USEoaM7N2kQZw==
Date:   Tue, 10 Nov 2020 20:03:20 +0000
Message-ID: <MWHPR21MB01435E001D3B779017675B1297E90@MWHPR21MB0143.namprd21.prod.outlook.com>
References: <MWHPR21MB0143F3E8DA25D35AEB0DB92B97E90@MWHPR21MB0143.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB0143F3E8DA25D35AEB0DB92B97E90@MWHPR21MB0143.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=94e090ef-ef8b-41b9-910b-bd341c94f217;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-11-10T19:59:55Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [131.107.174.208]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d3200fc8-e77f-4649-4f5f-08d885b3ac30
x-ms-traffictypediagnostic: MW4PR21MB1857:
x-microsoft-antispam-prvs: <MW4PR21MB1857D0FACD1E3E7D39CBF02697E90@MW4PR21MB1857.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pMXWKnSq02TXPlrkxALoXaMbh2RbCFlDSnzZ2TDWaIz67FaacEWYrVRNyAwXgNu3Y3BJXoFcHC881PnNvYiM3N4J+VkvHuRKCvnfsctruzVPWQ7suOBSlshrktF7dpKnpYX6bj3DZhsObdqewLPvFljA/92AM3GWOAHaSp069RszJHMWHwH5vY3v8vlbABRrtFcMxWxaPcH+taysz3OHtX0cbEbyvIVWFde3zVmUyJAfEbYG/t2nnnkd/t5EN/Rm6iF5Z83N4UxVExgmRfWJ6QgtSkfEkarWvIPnrWuSpVS19tVmA+Nk0uJIjfBvKFwyAV2nfRLM+5i93AoyLaP6itiFWTxBR3SoobbZYi9d6O6nu1bvxNfB9ik1sjGyOf3b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB0143.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(9686003)(52536014)(82950400001)(66946007)(76116006)(64756008)(66476007)(55016002)(86362001)(66556008)(66446008)(82960400001)(8676002)(6916009)(83380400001)(316002)(6506007)(2940100002)(186003)(10290500003)(26005)(33656002)(478600001)(7696005)(71200400001)(8936002)(2906002)(8990500004)(5660300002)(460985005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: VzLSGvPwA2I4cqaPFrNl4C7DVmhFKPB75WVVm5Xa/+6V/LPDNDQVzN5RosqBULbdykE5ZVKai+wLGldAWQgaHniG3Dae+2XO28j6V4pV8GRpNr2UJ3lrYwotZTBykF9zjEm+AlwMBH1aHV/ycpz7ML3YOKWC7YtgOwxdFY5mPZLwpQLDNu+223QXMrvhWL/BtX4nQcoUmy++iBldZ6tiHfM4eiNOm0UMM5RWASBEhPO3MN9l67omxWNcw1lBgrprhEGkHDPktWEh7Rzw0s4oN7O4uTZJ/HgqnuvOMhyoEtbXQDYSMvjsGYDA6IWSKie/XpTxavRpwG4ZLNelRfhM1cuce1ZNCYG7aEkKtsp84a/GBEWZC6sFoinp8GFVT3A3iAfAIp3WFa2/Er/ZMeZ7hgB6ORbjjBRZWHWlBts3c0inNx5cCpDrph5FaXNP+B/mPNraWQNKzxeaDQwPRpil2gKQ8FnWMS9zkWCb+pgsn50RKjHhmdcWFf7IfLv6SyFE3scMdqpwJGIzENbhultqt1KfvWmpDVXugEiscqpJHYNyiArJTxrdVNPFvUwrSPiwPt0iqgeiWoW5/E9WQmoS4x+ZTAW4VR+KW0wNkb4y06rEchk1RCGnG04P8lVbFrgcsUwrx7SiAFwqoamgmtpb/bmbSVG9nJbxpmwKdao6449jkTjv8M/kPz2b8Fx+h/eXTyjeCgtoO8RpPIemPmL0HIv561jak8+3Dxrc4Oq8QQc6gkYm+0sv5y3cHNJAi2p+DxGhp+SpG6fkTjuzv78dm2Qs/KgcGvHltxVorAreFWOMn4u13u8ASrHGV92bYBUXRD+kE/dwn18lcYJyQmq/6YvRgXEHdY78rt9XhrZMbAB/NjUsVWObAZZ2WjmaGax25lLtfar6jIWi2GC4A5/3jg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB0143.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3200fc8-e77f-4649-4f5f-08d885b3ac30
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 20:03:20.6752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uLsTFMCL9Ix4lYDFeRwKX+J0q7cZt3zpGehd6vmYKGIO0bS7y7rs8iHvDGhWAE2wxJIuH5M32g9f64IYdzfmsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1857
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Besides the bug below - documentation on 'git bugreport' does not provide a=
ny information about where to share the bug report, or explicitly say that =
it's not submitted (I expected the bug report to be automatically sent).

---

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
I set the color in my Windows cmd-line window to something other than the d=
efault.=A0 I then ran 'git branch'; from that point forward, text is no lon=
ger in the colors specified by the color cmd; instead, it's the default cmd=
line color scheme.

What did you expect to happen? (Expected behavior)
see above - I expected the specified cmdline color scheme to be preserved

What happened instead? (Actual behavior)
Colors were rolled back to cmd.exe defaults

What's different between what you expected and what actually happened?

Anything else you want to add:
This is a regression - this behavior worked in a build probably 3-4 years a=
go.=A0 I believe it was broken (but unreported) in 2.29.0 or so; it is stil=
l not fixed after this upgrade.


Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.29.2.windows.2
cpu: x86_64
built from commit: 3464b98ce6803c98bf8fb34390cd150d66e4a0d3
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
uname: Windows 10.0 19042=20
compiler info: gnuc: 10.2
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]
post-commit
