Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64E3CE7A8C
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 15:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjIYPh4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 11:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjIYPhz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 11:37:55 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2020.outbound.protection.outlook.com [40.92.23.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B90DCE
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 08:37:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecuNayCE+/F5rUwafi/7/HFbFuzDVIEY6SENfQus8Y5p0OC74SiE4zMLKsIDdT/uEsgDhkzl7RFh7D/tdXpVLK8kPENIod1MzSyubhjARJKhlS+hSe9wT5+hfJ5an3Jtb219+7bgJylLwiHthw9yMV9JThY7V5Iw/mx8s88QnPtt58JoKYNHR3G91eTRjqyilAoSPBXOGFOcDhrxmb2BXI2HytbUlYpquk8KKXmD0Ohb+qQM2pOVTt1vrAorw5nJUdZl7EvINMaU+GCLn9VXNh2rteBIX/u5I/rXcqbAGqMOmKpMbvTAIBASpLVuSHzP7gM7K+/+g3bSQsO5FkJwqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYOrF9GYbgyQofk5imrldCxXNEZaWe9Sw4Fwq6CO9QE=;
 b=dg0HjmPSZJKxhCH3CoM6R66yoLglu2Eda3iimKavZJ169KcL8pOXwG50A/ZLqEsc1wb9zaLLWx3CbSnT9OyU+YLyd8qfXAPseIWXPeu7phPiBn4mWOM+o5klBCZDqgzNqMFgYsjm6VVxt8YOJOzWa6wAFOcgg77GBBoZX5V7MYpK8sauCjLt9lIHfxVVtlWtVVV58u3Q12NAQX6Uh8ohGtp0CKSaAuGxYtH9dfyC3w2JFd+mfUhB17bVDs3Ut4usAkw4SLOcDMd3i7zct1K/phmT48cEdOAKbfPRjbCN8J3iSC4vT0BIFNYT3gWBfUet6VOjf2WVU82wxXzIT4xQRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYOrF9GYbgyQofk5imrldCxXNEZaWe9Sw4Fwq6CO9QE=;
 b=XHpbWGDLNChPYjSVfIA5NOHhJEqikz7dFz1OHdrOcrnCSPS2//D7Bv/ZDxczu1DQbUoO6zsqIQJdMh2l9sVDSIGjIPZv7TA4nhdyBaKZ3Ruz1BNQkFOls+pU/KYqZDRURXqUzCez6KgHbvoxx5rCxHZjgjdvms4vsxYCZXIPQiDIWXO9d3eyfu16W3Sj1IlYRvBnaKioqGrrciu9hzzThDAkBYLwk5gK/tMXi4PPJCe2SlxXUpyoRwTkyJrTOsz5WiSUxZ17SJrnnwiJey/CiMJA3pHymTaDX7ubx01oWvp9lVtWLjPpr+yD71oVILnlEVTeCiLQCjKhYBzp9aVi9w==
Received: from IA1PR02MB9088.namprd02.prod.outlook.com (2603:10b6:208:418::18)
 by PH0PR02MB8811.namprd02.prod.outlook.com (2603:10b6:510:f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 25 Sep
 2023 15:37:46 +0000
Received: from IA1PR02MB9088.namprd02.prod.outlook.com
 ([fe80::ec20:4fd7:715e:ec40]) by IA1PR02MB9088.namprd02.prod.outlook.com
 ([fe80::ec20:4fd7:715e:ec40%4]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 15:37:46 +0000
From:   Robert Smith <robsmi_ms@hotmail.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Request for Curl.exe update included in Git binaries
Thread-Topic: Request for Curl.exe update included in Git binaries
Thread-Index: AQHZ78XVqOuWMU4TgE26IeadwNZV/A==
Date:   Mon, 25 Sep 2023 15:37:46 +0000
Message-ID: <IA1PR02MB9088F7E0AB55FE03CF0C38B186FCA@IA1PR02MB9088.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [0gXVG0vcEkhFYB613LvAKP4R0ujL7mdB]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR02MB9088:EE_|PH0PR02MB8811:EE_
x-ms-office365-filtering-correlation-id: ba7f6e66-d764-4450-35d8-08dbbddd5dc5
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tvia1qVGY6YJtYjlrkqovfoskI96+AunovGPZmIXQprq5rPCKzUWX/szzs92PrjmifNWz8MY0IjoSzrF9oZj7VkEv4/inDQV1SPt/WZqMkMcrhQRz9F7E7g0Yitekgz89bJZ9ZK5KdH1CxT+Jll4ltS5+zvahPP8i3VH25uKlsw0wcGPMta7mvzbK0wkldGaBTDUliTp3GZ0/iy4wGutEUQodSj9pu2bKOSK32yuK+podC3hexfTk0tO1YmSoSK/tSHWXzr9VaB2Dfy3b/mEMPYWcIptRDJv0cJGv3qXfZuwCrkboh6tNvb6NxW/fd9MqmNghUyHThMj9qWqiAK4EpWhMYLKinqyM2c6T56djX6AbEU00vzBGzWIBzPWnv3n375Vmn+Ejbg5cZPzpoODDDkyEyU8fcSRXfswoWy+d0bG1qGg9HxLUDc3bFdX8ha9qBahMHdD35KEtHDvTju2fyJlZgYvYHVq2nwmgB/YThKSBzEWKCQfnlp7alM0cJxJ2uFrYJv181xs4WCPpyFRkyS5WajunFuDy2jMsbDOjJA=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?K45UsMdGXLbYPkMKsblJxyk6xebHnY3BfMVV/qAPsmzqAS06dWXFPg/Hy8?=
 =?iso-8859-1?Q?wvOurnh6e5b4KIfnse9nJ+zMLRTmJF/d1VUge7NhwIVuAMH3UhbkrUwMsP?=
 =?iso-8859-1?Q?enJ3m2KxYbhHX/Sa3kmtkJJ4gFzHVFHH3ebqniCntwUgOAPBzlNAw7NKVk?=
 =?iso-8859-1?Q?B/DrbmXKs2DlU1Wy7dYxNenFZEV5IXZuASIjM0w0R4vCrw7HjbfKH/Mbnv?=
 =?iso-8859-1?Q?EZVGE+fEbsMiikz2Dut8MSYojWISAf+ECSdNQG19k/cQX5viZVNM2o5Skx?=
 =?iso-8859-1?Q?wNlZx04Hdbqjr47OGPkIWkqnNVc942RsipWW5ZOKViD23kRRAFMw1XDNOP?=
 =?iso-8859-1?Q?CkRyVPsKzjZrVjn+7y2f8yaiJq3ycFGIS55GTeZVzEoWVepqOI1Zeaocrx?=
 =?iso-8859-1?Q?t9nQXxN+DZI08jvclNuJ4doFd1H7XF/CMlLfCgfrJTCBDNWkRmotyj8Qtb?=
 =?iso-8859-1?Q?fXU+Oa3dReLKa40b/lO76rHI0YA7MLV+zsZZUPw3z7iYGzixVkEKCZtSHx?=
 =?iso-8859-1?Q?BsyJ+MCzpPYZqfbgGZk9smo467J20VyiGt/zh48u9mXc08A2ft66hoDyaK?=
 =?iso-8859-1?Q?i9XOtlBHjiZXsGNpOLzTxTftHnEDhreC6P5ykCiXU57JpjoxjH/CuE8Niv?=
 =?iso-8859-1?Q?jIy0erqso4XVzRXm7lvnbqpjS9f/WwEjncnAszSB1OqgqidAn5jiTQ4Rje?=
 =?iso-8859-1?Q?tJU98iZ75eSdKjcyUJYuLR1GPIkLHWjBM0J1VCT7XmUR5vTWmTnk27CFP0?=
 =?iso-8859-1?Q?u68w64OfpcObJPAAQ6lT7HtZ+zZ5g4DwgijN/mKfF7wJB4vRlDA4NJ27p1?=
 =?iso-8859-1?Q?kfRVo1mazAc8RkfkyEgpHXno7XxGdLKgOytUq72Kk82icuw6cOtfpgVXrR?=
 =?iso-8859-1?Q?1BeLk42DQAcjOQU8IL0NjiSRPNP5tMq74cgG7Toe/KXBl3rOT1q/jJx+48?=
 =?iso-8859-1?Q?PAD2NmDPOh3j+kH46iLMKp3o2mIeEFF8cGm8ULezWTizzbWFIx/2fI9XY9?=
 =?iso-8859-1?Q?leNRoK4YCgO/vnkR4ShFG/T8i/Okw3AkwzLBCLlNLhLz2gDePjFqE2f84n?=
 =?iso-8859-1?Q?tQEne4C+1pWAiKZlih3vAK719fUT/ZL7qbOb42eX0Ym2T2of3DPqmUpjDt?=
 =?iso-8859-1?Q?4pqq6Hfxn73tX2ZyXSMbArqWMLlhjKsyHP2MkCdzz1d3PCD/TGH+TSTyhS?=
 =?iso-8859-1?Q?IMI0k1siiRm5RDGac/h2xaRs0jlP5wUO3UteVUtBfF05KCdBM/Zq8L9oM6?=
 =?iso-8859-1?Q?a1+p5FuCI6yzA3EmmE0A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3d941.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR02MB9088.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7f6e66-d764-4450-35d8-08dbbddd5dc5
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 15:37:46.1205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8811
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,=0A=
=0A=
Regarding this CVE:=0A=
=0A=
https://curl.se/docs/CVE-2023-38039.html=0A=
=0A=
Is there any plan to update Git for Windows to include the updated 8.3.0 Cu=
rl binaries?=0A=
=0A=
Thanks,=0A=
=0A=
Robert S.=
