Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841DFC761AF
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 14:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbjDDOLA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 10:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbjDDOKy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 10:10:54 -0400
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2080.outbound.protection.outlook.com [40.107.115.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695452D79
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 07:10:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aej4xnWf86CCH8SG3qmn9nwwwRDpXTp1dLnGoucFdyp+cGVC0mUMPP90qXpZYSLxK7JCCGeF3tEHiDJ6UpHIGKyMIhY60lwUw0b/5e4TwfxtRYmj/D8g1HM1Y4xHo3qTPDuiQXT1yH/0ZmdwGEumniRfTuclgMnRLxdrkgwdIP0VWdWTD8/pr7kspmv3HStjySgYJVWGMRpqrXX+KL5SJW0mER7P+R2u8iRMlSh2/536loozL7TE2z1SK20gr+im238YfhjkE7X7G6vASo8AVDxpjAZc9ptwap+2r5wAt1okb03ANKSzFd1RsStO26B/OzzeHg4z7IY4L9iuEWyHBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43Ftpnn5vBaMruoFIdqZ0scfEWT+5Gezh8HzJHuZUYI=;
 b=mbenTAGbK0HApnDVnNauVdiDrm4oJizxvytyuYejPtaNJ1LPleHAXI4vmQHcB9rvL+/qvhwd5xE33u4VVgCXQk7LKrjNKuh1LlSq5o9xkg10LlvlYlZ1a33p5+7bpr/hs/ZG34l82CPnICK9BgpMF27cgIMCK8GRlVCeMBU4vxikwS2cbvXtabQxeeBXYOb36g+nzdFQXktMZsR1JF0pRkbRy9vqgyxNjfkrKvq9intTq6NoONKRvc8gvWcK8/FFY6DVO+gW8+tqCjwyX258mw69NLYlDnVAjVTmViDdPix7prF7qgAtuIiLREsth/Ry55PcYLPCV9s8HC7XUT8fJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pqm.net; dmarc=pass action=none header.from=pqm.net; dkim=pass
 header.d=pqm.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqm.net; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43Ftpnn5vBaMruoFIdqZ0scfEWT+5Gezh8HzJHuZUYI=;
 b=ZYKMlCsE/Vj4Ld8xaffuWVy8u27n+qsH8OLypBTeUaZbWuVOfoz5VX4N7fN2QkSio1hgk4ioKc26w1QIcB0mA2P+yKoiT+AwFtILPwapKngSyBwStMCT9M/scCYXjvqGMOTSp0bKLfB4t1pSgy7NACXMNAHula6GxM0KH+R/83c=
Received: from YT2PR01MB9874.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:da::5)
 by YT3PR01MB5842.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:66::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 14:10:51 +0000
Received: from YT2PR01MB9874.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5cd3:5a92:347f:73c0]) by YT2PR01MB9874.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5cd3:5a92:347f:73c0%5]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 14:10:51 +0000
From:   =?iso-8859-1?Q?Fr=E9d=E9ric_Landry?= <fred.landry@pqm.net>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git fsmonitor
Thread-Topic: Git fsmonitor
Thread-Index: Adlm/sv4v3lJVuUFTSS72doHUgizPgAAFr5g
Date:   Tue, 4 Apr 2023 14:10:51 +0000
Message-ID: <YT2PR01MB98749C01D9FE7D040F80A51DF0939@YT2PR01MB9874.CANPRD01.PROD.OUTLOOK.COM>
References: <YT2PR01MB98744AB0A168B729E89D57AFF0939@YT2PR01MB9874.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YT2PR01MB98744AB0A168B729E89D57AFF0939@YT2PR01MB9874.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pqm.net;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT2PR01MB9874:EE_|YT3PR01MB5842:EE_
x-ms-office365-filtering-correlation-id: 807d2ac6-f0ac-4b66-37c4-08db351665f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pSP/oSmUkeGxzm7OT1D/+/a01vLNjivsqUOEg5qMvS4Z3ETBO4ZqnWkxWnAeLD+M5sUuMGWjR+BNocJQlhnQqOEyNie/plyU1hRgBr5+/rZHG5RGxEvRBblVhtSzkJkTZHBPE0hujkNUVqP7IOC/5Rfq4LL9jltwkU1/ltDoQbVBtT4zhHGnn3A/KCjKTQoZHJ4VOFC2YKxTzuYS3Oe1iyYkBrkIrJ6lAppLL4Xzk9KaYOEMjFjFVX85EbcAo8JkwibAnZZExaK6SBDOzpfGRRajq3JSJc0vul2vbF8K4Gazm9iM8HOJgtJkczbBKav7L1q+mMHy+RkE/hJE0IT3YiSc4scyZSwS2HmnJjcgHpnfyaOGg8oUmM7E2K8pgS/AUhO/qZiCzItei5E4/F7OLhSqFSde4O7fpJDdtkQxJu0XkyyCU6AE56cxZddjmJnpx8sQScG/PZJ3RJTvLENwsfWbOiJtw1OlhPMO3AZ6fyLbcaOrTQDBU5M1QCRvlDpPSw4PNBuE1oA2I29k3dum0jZSuXfhorzlJz6sf4Gj4tC6PwmIRGngEtNn3+5L/7xb9BPgZOwEnkN9OtdDjhmy4gVDSVF7XG8pBPwEtbjv+MsBYavb2lBGSjVfuSGFTJw5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9874.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(39850400004)(136003)(366004)(346002)(396003)(451199021)(3480700007)(38070700005)(7696005)(71200400001)(64756008)(66476007)(66556008)(66946007)(76116006)(41300700001)(6916009)(8676002)(66446008)(478600001)(316002)(86362001)(38100700002)(6506007)(9686003)(55016003)(186003)(2940100002)(122000001)(8936002)(7116003)(2906002)(558084003)(33656002)(5660300002)(26005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0rxU/UDVRDmAjaBtLGh64+wnQ4GTZrr86JSVbEiACeK7MUlIkdD8CmSxjk?=
 =?iso-8859-1?Q?KsbgUSiKdksDSXpdfpX9UKbpzpXpG9xfIT8cNC0WfsrHCllOXYPeCGv5iX?=
 =?iso-8859-1?Q?wgCM69QPg8V78EdqNPO+fJLyU0pJ5/hWIghjcBlMTb6DxCVyOkej85ewb+?=
 =?iso-8859-1?Q?VbXASuXFMwtlmpX/AI+O4B0fnNbbWiKLp14X4Rs+qQ1yhJfGVR0M1/VOlo?=
 =?iso-8859-1?Q?aTffpa+el6pa1/nd/d1CNVLlXz9vwQHY9gJfronR1GFbYYiY9Gse+XRjym?=
 =?iso-8859-1?Q?c5H9zQYIPK9NQ3FwIzW6W6DMgeQotKWVeV23f6VV9TPuJQ+drSSvbeQV1a?=
 =?iso-8859-1?Q?oOVxMl+IQTGB0iPkAtQ/GL7LiIBWIOwcUqkr/OYeDaBRNVUh0Ic3knEDk1?=
 =?iso-8859-1?Q?A8smBFujf7KNJpQRitQfVBHCsZRfEwa0xGI0xqNs+zEnMbSdi81JdtpML/?=
 =?iso-8859-1?Q?5grw/YXJW4sYWgtqh2OPuyDucPv8z7ktkShvj4Q2rOoIGpXBYbWZJa21Ks?=
 =?iso-8859-1?Q?RFL3t8p8Guar+BiIWOzbd+WaDrqwqog9cRE0jQiAYDq9DyPRjbOUSStRec?=
 =?iso-8859-1?Q?KfSP01TO/KGb5BHpisgWVb4vjtGX3AKiirCBWOY5xSqHodHXCyNwpz6faw?=
 =?iso-8859-1?Q?IZdBs2JaBMYcdC9OQ3Son+qIqqBVR+v9OFDatNTOxzmNkA7HnLAWmdYW9+?=
 =?iso-8859-1?Q?K4UtLA10PqW+CyBm8e72+7ZXLWbZ3JK84e2LtST7BEWohHcSKuoEug4TUu?=
 =?iso-8859-1?Q?mjQlz2PxR9aTpOQtq1odOWO1513DgOsLDK5SxcUUWmZlGz/OLpgDh7Tq04?=
 =?iso-8859-1?Q?PvRipEbwtDs7HrjU49WYezbTWZ2Jlp6ARiKZ4rjjSis9cy3ntn0dDTeVw5?=
 =?iso-8859-1?Q?fS4j4l7BTqJNiOiGIiGLMaRSL3JSYSj5jWZBlddRyz9L7i4sJZ3FnjAoLG?=
 =?iso-8859-1?Q?Jv88HWfLZaYT6ijcQWP8GNkxBDWaztBZ0enG/Nkfiam0ICp1Vg7ddEGf+A?=
 =?iso-8859-1?Q?jGx9jZS8VJjgX9fS6tbhlM6HvUzR8mq7Uzhv4K9acWSDRPEj9tcEQnuVoL?=
 =?iso-8859-1?Q?iK/cqYMZHfMNJdb695Qo8r4qGiHaegbK36Nh3YKAi0IXs97JyewibICjTs?=
 =?iso-8859-1?Q?AeIkhFsQ2ZU0WTomJl09+NeC10O0/j1E34xrImQrW7pkBUsQBdz4EQ4Ajz?=
 =?iso-8859-1?Q?Nvljj4b31mg+0dhjX0/U/mJ5VbaN3Hr+g0VHAySUDonu4ivujBRGZi5IVV?=
 =?iso-8859-1?Q?Dm1wDjwoDWvJhqJAn/gGGVxLno9u5cOU7kkccMIOApa00kuFXzcSxlvNLy?=
 =?iso-8859-1?Q?zPMngjPvPP7X+0T1JhA2KbyVJoFwMXB50yVAxbNi6iZ0THvq/t0PniSB15?=
 =?iso-8859-1?Q?wbJwADCgcaHMqBvFNiU3L0Rt3N3flL6w5/omu50yDD2KQUWAPkZ0BVJJzT?=
 =?iso-8859-1?Q?xdcHGwuh4FvsmFcjpu303jSuYNs7Y3287B+1jxrKE+MbQV3U2Odn5ugjlO?=
 =?iso-8859-1?Q?jktY7YtEq9vLwQz7z/sb/YTmIRfonNUvc6jcSsEtSLjnzd+4DNLRIUJsLO?=
 =?iso-8859-1?Q?mNaq4wBX9byQda35a7unlMzuNTTGQw4EiJQXT27gkMzj/xtdiQqybhBf/o?=
 =?iso-8859-1?Q?pvowxXWL1Xjlw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: pqm.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9874.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 807d2ac6-f0ac-4b66-37c4-08db351665f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 14:10:51.8914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e3b41ca-ca79-421e-8e11-8dba90c2f296
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 34dgQpY6QVdOWmE53G5djbKVRYwxgHwANOGpstYy9ODyFtsnncRZuKlfB3hdzUTtIjrK5xkb6LUCzTxYM0VTFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5842
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I could not find details about which platforms are supported for the fsmoni=
tor feature. I am running debian 10 servers and git-2.4.0 and I am getting:

fatal: fsmonitor--daemon not supported on this platform

Thanks in advance.

Fred
