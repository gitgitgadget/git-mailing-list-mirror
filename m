Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4E9CE7B1F
	for <git@archiver.kernel.org>; Fri, 29 Sep 2023 09:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjI2Jfk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Sep 2023 05:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbjI2Jfh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2023 05:35:37 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2090.outbound.protection.outlook.com [40.92.41.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B551A8
        for <git@vger.kernel.org>; Fri, 29 Sep 2023 02:35:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTy6PRH66SN5W8B3pd4PMQuXKBMVC5X8h5S+FxRK1NTQM+CmnNQwCEVYrPa6t8hBG9wIHsRmFykOwnjVeUWJVWyFaQ3U3oEpbE36z37aWaCsDKjf25oQDxxwLijDMa1qqeQkwLvINJt+UZMjF7DKV9+7JjLESvWcfNynfLAL4FsQT24ebmp6iMnEx6DT4lbj70TiAzFsAzT63lrp6Q29OcIPiswvsklFZiNIAvQaechByn0cf3RNUK+iL5HwxqwyrSnmHh0hU2fUlCmvGSnB45gI8FArbf5zu2yc/4jNNYUFmd6XQoI3R/PRsVHmAmtEEjsJGfuG2Hk5Rs9pq32pxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tC7rkKD79TIs6ooz1TP/rzguCUtJ2IyYxAwRxjwpWHU=;
 b=dqKRixifHBDAmyMe787qDxqFSxvwOhsyHA/CEnBJNH2gjyIxkdGlVC/tcybpCkcVyxrUMDFIyl/7W1GmESqRJL1E8cUOI+AJdkA8MO1roPWuCxPeK5TM9AFFKG8H7qt85bRGM6aIsvxOYVbcvtXLQIWF/w3PtmkepSIpw29Ue67TMx5OVqNhXgBBZqIq4hFWHAyNUFoFhcmWhm2qzY/bnbNW5v9YCXq2GvHHJnhNAxCWwyAmhcpfIWTD/Dw3pLm27VQJRuY5cnMz/zGr2x+l885YaG387vuq+hr5IdjIvWX99zv7QL4AlbtOcvyk5UIXCeS2z73dyFBG1SvQEIsjOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tC7rkKD79TIs6ooz1TP/rzguCUtJ2IyYxAwRxjwpWHU=;
 b=CRowKvvsFaGBTFBR+9Sw7wC2/7iNYU0rxkArbJoKc6ZPRI/MxG9TLW+Ax8hTG+hIvYTgblJFmY8MQ+pne8039xu36Id500IuRAMcMEQOUIPC/6m+XvH9L7PA3spP+5iz4gF0k8O+vcOWcAMuEjunaqap+RlRIpzh/2/E+STs7Y5IAe4quR1W0EbfEyoaVgV5qR0NFB2yaCOMj0FkgKWcCvffU+9Vp5Vavl1G8vbsOyL0unIYPnGh1+Ra23a4cw1UKSd2K0akYXpmqhtCligmysYCyV3O8x3nG4iUYPw2gVXP81YOBCi+25lfqDzuo8kb73eTMMKBH9ZnyYRgy22SGA==
Received: from LV2PR19MB5767.namprd19.prod.outlook.com (2603:10b6:408:178::7)
 by CY8PR19MB6940.namprd19.prod.outlook.com (2603:10b6:930:5f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Fri, 29 Sep
 2023 09:35:34 +0000
Received: from LV2PR19MB5767.namprd19.prod.outlook.com
 ([fe80::e9a3:a685:b7f6:6069]) by LV2PR19MB5767.namprd19.prod.outlook.com
 ([fe80::e9a3:a685:b7f6:6069%6]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 09:35:33 +0000
From:   liangxiong zhu <lxzhu@outlook.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git log bug
Thread-Topic: Git log bug
Thread-Index: AQHZ8rg29J+Gc5Jul0+yLaMIquMQYg==
Date:   Fri, 29 Sep 2023 09:35:33 +0000
Message-ID: <LV2PR19MB5767BB3F887CDB46F571656DAFC0A@LV2PR19MB5767.namprd19.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [7QG+tGfG3BEPfxcKBMiuVdmz676L63PI]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR19MB5767:EE_|CY8PR19MB6940:EE_
x-ms-office365-filtering-correlation-id: 278dee02-c5e3-470d-518c-08dbc0cf6e04
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IbDAcp0v4N/uWdJ5gleerGnocdnz2Khiftbxy9o+oKzjX9+HinzSzhbFm7h69RcUbDgeGJmQ4qa2WYRlvCvmxdLBzleXThspCPhUCluaIkvPfrNBSi3bA6k089/YdIE+j+ulh9+f8JQ+00CA0vDrdk9STi4KhQGmxv3eIgr+GFYkIy4flQbQAJ+nrcpUAeiAyBF/7brsztl116W1vOahlOuJqGgO5n5Wd4w30xF8WqXiatVkgezVVE2aSHl+L/XKz72IPS5AdGJMLj3fz5lMaXog0qKxg+MpT/8v9EVKESkskVTTPh1YsT+PilRh4APk27tN0PDQ5Zte/cSyA1dQGpaG2HxQN3oYHcVwCZPPRIwl89UyQQCvEd3ebhddQBG6nTdpkkJdBRmKaWmpKCQCMszCSXePcjYLlxFh9kfPjjqME5cXXAfoPfRDNB8sBZCKXk4tjfkiLTDU761SrYz9VooBvu8Yd++xm/3rfJCCBdPunxKuLrLS0F/4tNj51Lv917djTPuApFxInOhBzz2OcdJRPsvweQpn3CN/DoJ7MqSnYZpgkg1Xo9Kko4eJsphx
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DQB2ut6lRJeIE+64mEtD5FYjpp8pOmWDkVmm9jG0xdpG93Pj4tXBM4zIkE?=
 =?iso-8859-1?Q?yiMxwojXlEiGC2rLu9+hA0phmNwP1r4DSffbTKZ+p2ukwlHGaETEOrZRV+?=
 =?iso-8859-1?Q?bFW62DoLYSPDZIQ6pCkO/d6d4mGbUtqysNioRlewYKhssmwiZizgyAu2WF?=
 =?iso-8859-1?Q?NEgmfQvVKhtQ7wQVGL1e7OcUtUOK/PHjmpA3mA6HrgsflUQyD2VT+zdw42?=
 =?iso-8859-1?Q?nnnMeD0ZBE4W9et0icdIexcjLGqpxF6XMGNZkM6XlZPH5WIyyKbAh1m9d5?=
 =?iso-8859-1?Q?j63coNogYFt+IZvNbn50ax1QRirTov/InbQ6oGu4EzMS0ajJ3g5O95J+Ns?=
 =?iso-8859-1?Q?8/qNjJrk+ErzwWGXOKsH/UKPi/PqQPfVq6cbdJ8Szp8OX/SGBxPQdx4QD6?=
 =?iso-8859-1?Q?PtGfcDLAiNo+rR6LQjXJRl8IdI4JQZC9pJcQ80c++4mW9B2kUe2v1/LY3Z?=
 =?iso-8859-1?Q?LbacPO8B/kjYBLzIpeNBjQdNtvtJpCapocd0Ser5FR5s+EIee0ce4SXNIo?=
 =?iso-8859-1?Q?RkUaPFYD+YZCZocQ60+SsCfmntsw7PpxUNHIEnUrDQxw+Xy4PCkb7i5eEY?=
 =?iso-8859-1?Q?MoMcZ5stMSdkvaAhF8dtjDX497BjTFvL8KwF2bXApCTwv/tiZB8idcDZ55?=
 =?iso-8859-1?Q?HdYSFQ/NVtdDlTEI6Fwo72o+na6jTT6JeHZeicw3bESQc0ak5A62kh6fI8?=
 =?iso-8859-1?Q?bNw8REpva61wl0Zu5js0Q3ILFynHihHVCFNbS1m65jF56eQqu2Y4SR4LAO?=
 =?iso-8859-1?Q?N8/czxJA+WeC2mm5PpHYqOM045vnXB/nSLfQZbEaZjPtSlCgX0hw2VwjVy?=
 =?iso-8859-1?Q?BXJSx+Ffk5kS7ec+wkxXfcDXMWZp6wUM6dWJ2ybOQj74vyG1vvCkPSqD2N?=
 =?iso-8859-1?Q?ejOqIieTyQhN1hpzKakUNpEGx+4HQeZgwVzfwm2gdZflnBxA8kKKISiGXP?=
 =?iso-8859-1?Q?mgqoouu8sc753VVDlZaZ7OupPi2CZB5BcanwZQRQU9eWP6A25l+gpUPCNa?=
 =?iso-8859-1?Q?HXwNALPeejJpLh0usOkXZlp+tYuEOj2KQscuqIFCc1HI2rVnsA2Q/1B5QS?=
 =?iso-8859-1?Q?YBwYnODdZ60pXoPJROlUR6TBDPXCUICi7vCr9T+ZnLZ9j5EQyte8NdbOc5?=
 =?iso-8859-1?Q?b0D1c/YIwiGsVieclhJuKhZ+YTcsgSjuaDhS/cwGDeauuXMIm7uSJiIJ/+?=
 =?iso-8859-1?Q?xYq8F5ySdsCi+AteUDC4V9Y4zXozvz+zzwyILeEWlIjwlYI4GKoKZxU5?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR19MB5767.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 278dee02-c5e3-470d-518c-08dbc0cf6e04
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2023 09:35:33.9253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB6940
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!=0A=
Please answer the following questions to help us understand your issue.=0A=
=0A=
What did you do before the bug happened? (Steps to reproduce your issue)=0A=
=0A=
git clone $repo_url $repo_name=0A=
cd $repo_name=0A=
mkdir dir01=0A=
mkdir dir02=0A=
touch dir01/file01.txt=0A=
git add .=0A=
git commit -m 'Add file01.txt'=0A=
git push=0A=
=0A=
touch dir02/file02.txt=0A=
git add .=0A=
git commit -m 'Add file02.txt'=0A=
git push=0A=
=0A=
git log -1 -- dir01=0A=
=0A=
What did you expect to happen? (Expected behavior)=0A=
print out commit with message 'Add file01.txt'=0A=
=0A=
What happened instead? (Actual behavior)=0A=
print out commit with message 'Add file02.txt'=0A=
=0A=
What's different between what you expected and what actually happened?=0A=
=0A=
I would like to get the last commit to a specified directory in the repo, B=
ut I get the last commit of the whole repo=0A=
=0A=
Anything else you want to add:=0A=
=0A=
Please review the rest of the bug report below.=0A=
You can delete any lines you don't wish to share.=0A=
=0A=
=0A=
[System Info]=0A=
git version:=0A=
git version 2.42.0=0A=
cpu: x86_64=0A=
no commit associated with this build=0A=
sizeof-long: 8=0A=
sizeof-size_t: 8=0A=
shell-path: /bin/sh=0A=
uname: Linux 5.15.0-1036-azure #43-Ubuntu SMP Wed Mar 29 16:11:05 UTC 2023 =
x86_64=0A=
compiler info: gnuc: 11.4=0A=
libc info: glibc: 2.35=0A=
$SHELL (typically, interactive shell): <unset>=0A=
=0A=
=0A=
[Enabled Hooks]=
