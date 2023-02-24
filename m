Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F35C61DA3
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 15:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjBXPVU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 10:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjBXPVS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 10:21:18 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2025.outbound.protection.outlook.com [40.92.22.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795D8E397
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 07:21:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csmRowpaA5/YaAV6tB702UbOU1G8reiW+9kOGfqzapsKXyOBqguvSeF/r97RHZHBFzlVZWFsXhcVKp2bmBCAHFAj10cyIGqcnLevp55wnkGk0+Siy1v6WP0z2ik/mPyIgsn/s3amHBvqcAoL2EZAkfOuF0AYIlsyIdtPEg5FDhTzhNyuxGBkYYzfmOuBwPDALKymXzudF6asLgRKXKFNWmVhtng/1WN2zghdzTR1At16jorNGUczQj5UYtBFWv6MfRzWWglB13CK6kpu3lcjRb4gob5XX40Iz7LBolZW73i/dKdk+bxN0U2Jtv5sSlP0vUP+eygbvk7y1Db4hf4ZPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6XlNNJStN4zM1wRQXz9p/ly4bJ7XybPq9TbQ/VD3+Q=;
 b=hyOrNesLhh0W/0htZh7STZQMIR+i/tnLldyMu1Qtf35rMuW3O42+qhRt+64MKA3I80VKbPrC43iX6moG4ieswLrgp6GfnBSMPZOdt7YNY/dLOGu+Zmvw2iiehynyrJ/JLpmKQIWSYjC8lXy7HR+dE+7dEOW+Qnq3trnJJMBKerEn8cG5C1Iqo7EOTuwp/KJYFaL/6Cy9hHmniKWBOaEEzJiql4Ufa71eGUrho53lAJfKLwrq+CFOvlXfyqaZeoRrduEKtMkmtNfXuOeHds5KD2I45OaSKt+ZC9JkD5aE5KipDQU2pc27v7BdHxjb3+ENvroEIsVKNY+An7wFWcGvog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6XlNNJStN4zM1wRQXz9p/ly4bJ7XybPq9TbQ/VD3+Q=;
 b=EXob0GqnkLv3It56YykVelWeITslk2EGs2d82Ov9Zd6usof6E68mwqAeM3SBK06luQ9juF8vD9Ffh4juIrR+xwv3LYhvue+q1BLhrMaCWiT7ykM0Ip8+kU8fiAMh62hQsiYW5JEbSEdzlrnh1okETWU2U+QwZjJGHqIeYdb+M7FJqs5xNkGhVMG2xFHAGG15QaYxbhE78SPXzRRTSj6fc/Lxg5j5lkQO+9qqAYu7/T/6/gxZ39kCICnQVZFJnsYShzzvj2e2n2PhS/lyrKm0r5lTFk4PeMuIl4x/JIExQ1L6LImR7N2tCIJ05sohe3MDwsEpgtdVzBesYalBqldRrQ==
Received: from IA0PR17MB6275.namprd17.prod.outlook.com (2603:10b6:208:43b::7)
 by MN2PR17MB3821.namprd17.prod.outlook.com (2603:10b6:208:20a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 15:21:14 +0000
Received: from IA0PR17MB6275.namprd17.prod.outlook.com
 ([fe80::854b:a77e:3ec2:ac0d]) by IA0PR17MB6275.namprd17.prod.outlook.com
 ([fe80::854b:a77e:3ec2:ac0d%9]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 15:21:14 +0000
From:   Adam Horshack <horshack@live.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git-stash docs state --patch only valid for 'push' and 'save' but
 it's also valid for 'show'
Thread-Topic: git-stash docs state --patch only valid for 'push' and 'save'
 but it's also valid for 'show'
Thread-Index: AQHZSGKJ1aHqqiHbOU+ezkVjIVcjsQ==
Date:   Fri, 24 Feb 2023 15:21:14 +0000
Message-ID: <IA0PR17MB62755FD715B044E14AAF0A8FA4A89@IA0PR17MB6275.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [oh6w3eQbS7K9R+OJo390HM3l8FbzGc4n]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR17MB6275:EE_|MN2PR17MB3821:EE_
x-ms-office365-filtering-correlation-id: dfdcb2f8-69a5-4fdd-120e-08db167ac47a
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cL05dtOY0M+jrzIdLj2MGVDNAoPH3Az6MvlGVRYchYNxz5zfddbD9Rr4Ce20j0/VMKgER+Pq13gN4RAlHuqIY4whe5SdpmyJpf42VvNypr4ewz1eZJi3JM+ZEZ4se0TYdfvLcG8UJmIUyLIx9UFcms7NQcoHHp827yLE5yBy5WFn5by56lL9w9SWKiuSFzAw60yhRAr8MpTmczv3Y/hJ/S0vC7cazIkVzhoqa4yS/3GdWdML8sGm1zYnO+ek6e8GJW+aELXl4KJTm8zY1+xu4KfpiaVVWEnuVMntWG9PIUHQpKqYktPRf3kCu8TRNOOLhRdXafxiDkf3+ebA8OQ7JgdLO+yv0GT8U7SCS42LX1rm89lV93Y5GRr4/LNuNaTb80oACE3/MADjvwWuNg0ZztUfK3IWXgju3BGI9EP5lc40EKoHcsyoV+Gw4uzPjRBh/qE99Eij/mSS7v4iletWiXoqODpNRWWIEgOX8SHz1IqSSvLFGA3RoBOB21CRXR4+Nx/ZHGwHuuuGuFqd/0f2geYCTYW5xgpQnrnvmaemRhyrE9peQgKkiOsWb5LRcT1lTcxy8e7p1ecyhLpJytHGI/FVqIHJDax6ah9xtwsIZvsWu3A8Gam3r3i0F1Gb87pn
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QdGqpZPtR+npefMoyK2kfbJSOktF1lKlXlij5hyNnWv6nfe12aAqSsZ4CR?=
 =?iso-8859-1?Q?Aiwfzy6mykjDWZhnnPIBXGfWotgsAm1JUNKQF5VpSuNtPA0Xz4xXWyib0O?=
 =?iso-8859-1?Q?mc8Ni+guxAsXBN0zzSitf30fJGFhpakqyo/VeUwgcQYcDyOdWVOH0Detju?=
 =?iso-8859-1?Q?04dItZ/yLAlwTbsoKXROPF2xg8dlYJtGOnngLKZBkBYGT8KAunB1gJiXNS?=
 =?iso-8859-1?Q?jzQNKPJ5gNa2K0ITtFN0mXGrHzrg7hxJNBWMYN8eiUujsopZnxsdnuMrjx?=
 =?iso-8859-1?Q?9ndsz3d6zJsxK3WyZtdXYSPdSXN93Lx6AxVSAMJKk4ioVbWCe1ZExKuf98?=
 =?iso-8859-1?Q?ndVx6CZGqPIIWfbBILuRIE2MaSukfGtguXVNcejzvcudgDiLSc3aIUyuRH?=
 =?iso-8859-1?Q?gmKYN3+8VdloKxGrMuKbfVaJU2EnuzuQCSGpJjfNQaL5L/zfVjdiDFhsZP?=
 =?iso-8859-1?Q?GvRe0cZUAiGloP6dsuY5rlNJvTdxzyPpgZXX8KBS/4bkoAdzh8WjtXFZTf?=
 =?iso-8859-1?Q?SwVPT4z9jlIrw/ExrfzdaRX3LhtKJgQBvXcNUik6vNYM+megg6SArplPSB?=
 =?iso-8859-1?Q?l6YwFt5ks47UyI5cWeJqkNImBV0sjGi+8yVA61cAx5BkgxZu7MIv/EdeVA?=
 =?iso-8859-1?Q?0u7E8lCvceKOCJR8KLBqh40rOpCYwotxYoMx6FNcvYrqDvPVbWGmAT60Rg?=
 =?iso-8859-1?Q?6t9Bu/+pvMSKFcpEOzJY6NJz+F4KNRJrkUd5WgPsLjEPASI9qVWs1vlXcf?=
 =?iso-8859-1?Q?TYDIvy5Ml81CsSiSC0dnmjQ1yNF/CoM5u1BmgLXlACg7BfcpoJxsdHePLG?=
 =?iso-8859-1?Q?IXGzT58i0hpCfpRyQeMoucTxpjy6DcwXQKAREYIW+CcPB+Q0JrzGYh9G5u?=
 =?iso-8859-1?Q?ZyQwZzodkCpkx0NoP5uxoy9xHm7assXJNUNyULuDcyLkp8CulpYLLi9ueO?=
 =?iso-8859-1?Q?hxhZO/zA3ekHLbdpYIJZuwx9UK/RGNLM9ZsWUOgMt4q6KIom+iquHVgIk/?=
 =?iso-8859-1?Q?l2z/U7yn5BZu3BhE3DJMx0Q+55pKvGZpwWPFU6C7DKwcIUSFosHpf/Vlzf?=
 =?iso-8859-1?Q?BG/RrgrWNkeTTxtgoH2ZWvprQ7KR3YzOZFnSrEQrgz4cEegwPh21bra6Xy?=
 =?iso-8859-1?Q?x8z//XTEPc+MZzX5LqR1k4V965LEnQMH39ToTKWRKg2iYDPPbQlS7oAqQi?=
 =?iso-8859-1?Q?f2Big7XKyakkajjnbK7gNfNxTGVgiVzg2XwsHum9ooocUof1iPdBd5kRoD?=
 =?iso-8859-1?Q?g+DprIupL1ni/xLC/Mjteu5Lor55R3iRzP0NBtN+oBnczi2RF0IFeB1x8F?=
 =?iso-8859-1?Q?ViDG?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-c704e.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR17MB6275.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: dfdcb2f8-69a5-4fdd-120e-08db167ac47a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 15:21:14.0743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR17MB3821
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also, --patch is not included in the list of available options for 'show'=
=0A=
=0A=
Reference to --patch:=0A=
https://github.com/git/git/blob/06dd2baa8da4a73421b959ec026a43711b9d77f9/Do=
cumentation/git-stash.txt#L196-L198=0A=
=0A=
Reference to show:=0A=
https://github.com/git/git/blob/06dd2baa8da4a73421b959ec026a43711b9d77f9/Do=
cumentation/git-stash.txt#L89-L100=0A=
=0A=
Adam=0A=
