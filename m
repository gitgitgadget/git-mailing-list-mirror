Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D42C4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 08:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiLPI2A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 03:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPI17 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 03:27:59 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2092.outbound.protection.outlook.com [40.107.15.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828761F9C2
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 00:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpp.canon;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wus2ciDYpOurdfTQMGA2vAEL4ML1oezOYMKm4g/xEGU=;
 b=TAeTJ54UUOmrgSXqML8UGg9uDdBf9N9bptibgMAOjitjfeWIok+ezXdSWn17erdfka3noFeP1xvMYW9fHDz3fzdUibYoeF3rVg9nBBxzJ9amxkltgL581UgrHfqEeEuKTih92+2UpwNGit6b2rYUECfSdfsQm+hVYvNEtezhfCQ=
Received: from DB6PR0202CA0004.eurprd02.prod.outlook.com (2603:10a6:4:29::14)
 by PRAP195MB1531.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:296::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Fri, 16 Dec
 2022 08:27:54 +0000
Received: from DB8EUR05FT041.eop-eur05.prod.protection.outlook.com
 (2603:10a6:4:29:cafe::19) by DB6PR0202CA0004.outlook.office365.com
 (2603:10a6:4:29::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.15 via Frontend
 Transport; Fri, 16 Dec 2022 08:27:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.138.15.34)
 smtp.mailfrom=cpp.canon; dkim=fail (signature did not verify)
 header.d=cpp.canon;dmarc=pass action=none header.from=cpp.canon;
Received-SPF: Pass (protection.outlook.com: domain of cpp.canon designates
 193.138.15.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.138.15.34; helo=smtp.cpp.canon; pr=C
Received: from smtp.cpp.canon (193.138.15.34) by
 DB8EUR05FT041.mail.protection.outlook.com (10.233.239.195) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.16 via Frontend Transport; Fri, 16 Dec 2022 08:27:54 +0000
Received: from oce-exmb04.oce.net (10.95.6.33) by smtp.cpp.canon
 (193.138.15.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Fri, 16 Dec
 2022 09:27:53 +0100
Received: from oce-exmb03.oce.net (10.95.6.32) by oce-exmb04.oce.net
 (10.95.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Fri, 16 Dec
 2022 09:27:52 +0100
Received: from oce-exet04.cppinter.net (193.138.15.34) by oce-exmb03.oce.net
 (10.95.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13 via Frontend
 Transport; Fri, 16 Dec 2022 09:27:52 +0100
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.177)
 by smtp.cpp.canon (193.138.15.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.13; Fri, 16 Dec
 2022 09:27:52 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rj3ZJhIhGgonK5k1nWsnD/Jt7l/W21mlkJ02vG8/sUCvYO5tubcIA/7AIkhUafk294FkJ4mPdO66Cm29/ziXywFqJrhjuXvw5XcZG4R2yXZ3ZvlRD10Tg3xMJbYjGC/WLQ5Pm5ckhDftuhHmUOu6YAbxieD9PbEj77j2uNpM0AEz/4tj4Qln+Esk0wPOl+9nPlsRp71fK/zstpBtbxbWgEi/HNTBzuDehpOlpLRKFJIeX/z0pSLALXmVh7cHE+saD5NiQKQBuJkI8c2Nuzxw1U7Q6la1nD8m3u3Gqy97IhObuhWSQGCMqxYDpJk9MVrZyPz39sg27JDQx8gwf0S9HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xk3rd34u2FRUnOFHbylEaExC1uXpQGrmSYLbZhtEmjw=;
 b=mcspp/318COWruG7TijiKd4dhImWHxkieMgISTgLmJfXVceUE7ixoi2O/oviZVR2ElJmRqwMk5WilFbbGID7tphPoaIPQsoisYiRR5xbX8wDdqVkIjziV70/WGmbWKh67/AnQfR+ouRPETARzHr/ay3sVCKKhYUF4xmnlbXwfoOK0QjCXTwzf4kAh4eP4erUlmAetW9mcMFsP8IT+jCKNtKmfeEQFQNdrbxoQ3gV0rBrV0NAW6A1ggV5JQni10hRH7Vvlsi0JIIPYkaC/h3qesK226Lr844HjEblZv+cNOZUL7k5wGBqq0dA6d2sLAvxIjV/+AwAVA1HK5xJj7CI/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpp.canon; dmarc=pass action=none header.from=cpp.canon;
 dkim=pass header.d=cpp.canon; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpp.canon;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xk3rd34u2FRUnOFHbylEaExC1uXpQGrmSYLbZhtEmjw=;
 b=VV7RNZnzFdYV0jqvKsU2y/rLLNA6ZK2PjWQ7DVldqyHxSH28j8G+gcLw5olCIXXby1DgQUzuwpPr0l8ZC4KPra2Zvg6ZrbNbA7yEgZHbD9itGp0BTIvDRRfxJ6VYzOB/nmu5rZVhwuAgKugEI32YmDq9FpcMGS442MLACz0HGIc=
Received: from AM8P195MB0820.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1e0::9)
 by GV1P195MB1692.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:54::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Fri, 16 Dec
 2022 08:27:51 +0000
Received: from AM8P195MB0820.EURP195.PROD.OUTLOOK.COM
 ([fe80::7cd8:8bb1:6d72:6219]) by AM8P195MB0820.EURP195.PROD.OUTLOOK.COM
 ([fe80::7cd8:8bb1:6d72:6219%4]) with mapi id 15.20.5924.012; Fri, 16 Dec 2022
 08:27:51 +0000
From:   "Nemmaier, Christoph" <christoph.nemmaier@cpp.canon>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: PROBLEM: "git pull -v" fails with exit code denoting a submodule
 syntax error
Thread-Topic: PROBLEM: "git pull -v" fails with exit code denoting a submodule
 syntax error
Thread-Index: AdkRKEgzislgucz/T6+rKojgCV9oPw==
Date:   Fri, 16 Dec 2022 08:27:51 +0000
Message-ID: <AM8P195MB0820A54FEA04231D440F74D780E69@AM8P195MB0820.EURP195.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpp.canon;
x-ms-traffictypediagnostic: AM8P195MB0820:EE_|GV1P195MB1692:EE_|DB8EUR05FT041:EE_|PRAP195MB1531:EE_
X-MS-Office365-Filtering-Correlation-Id: b1908dbd-f799-49be-7d07-08dadf3f6db6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: adYzzumBSoHYfeS52zE/LkymA8Sz/c17FIqriladkAYA53IuNgcp/hMh/Ztn6vGJBXdGKxO2CNxyUN+QzVJxlYtLHKUekwF2eVf9kdJutDf18R0gvhplNezoZs5yzbNsDdp85BvXRuRgttomqxGKIDk5SXvXchZQCktNlUaGkTmfEy12yWpSoDG1SC8gnShDY9MlcAEF1pARoULfQpHeQ5yH8rAzThKNWi8x3ZYeY+6VM/Zv06wZ28O6Uy5AzBvgiQkUyctgf3jy8OwlpjKtpbOG0mAypypCxeGWsxox9L3igGxI4NwfQJYp+75KxOVR9GK+gMh2FV4ngm6I81/7FLi9SV6ke9zecwbQ/z5xc7a/iDa7Ihvmka5QswLnwW0MtXv9y89I7et5L8rKCQ1WVvDH4PHd1s+XzrdZ06txReRDjtC5N63230DvjNWyc/QvQc30oZIHU12WMAouSP4Z5Rkr9JpmMVu6mtH/TctDawrrRnrkTaHJ/M3cfGMqO3dyfonJlD4V01+OBYu5INTJW9qsPRWY8Yw44gA+A6WJafO3G0X3xIbyowN/4TfVlFTegs9Vfy5Ny46s4EoxIAfCf27JFhz7Wz/59tdDkXxBPObglzMepIHcYCD4Qrto6X23psiGR21HWwUi+wee2PM8zIjMnjEKC54j/SIbPLyBpDRuwJv0toMdWfl5jKb7Snze552aqH2pkRqGbM0zX+XtVtQrBxtCRLenLrb4BqDTaDc=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8P195MB0820.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199015)(122000001)(82960400001)(38070700005)(33656002)(71200400001)(6916009)(478600001)(86362001)(316002)(8936002)(38100700002)(2906002)(6506007)(64756008)(55016003)(66446008)(66476007)(83380400001)(76116006)(41300700001)(5660300002)(8676002)(66556008)(66946007)(52536014)(9686003)(7696005)(186003)(26005)(46492015);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB1692
X-C2ProcessedOrg: a6a72299-2f6b-49c6-b092-048da1ac2e4b
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB8EUR05FT041.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 716fc317-0b4e-4655-21e5-08dadf3f6bcb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wsYpdfk0j/sNOto8lZzk2fFSZvwKga1iZUEewJ2dNcLMKUavKN456/X2zJK4vlD3oUfjtNf2/LWn4s4/Lo7r9CP9sRO3fhlrcJmasVb1hl+CN4H6gZFQEfvklcxY4NKtyPoffOZZCPDjtpUi0hnDoMLZpUrqoQeE9YClxV3d6zfAV6mre4y0VIHPr9Rp3dXEgz1Q5F3P4AlpRb+fSrLgI2vMeasje1yUZnOq3W9rjh7lP1I+kG8nQj9cJDIUBq56ixVXoOEd01mqTcEUYOCdagOyjRSWa7WUw29kYsAjxybCJbJb9uKl9ENBw6X0ELqMFElbUQLfObLWFkEjxKW48Hl078dKb+R3lbz+EzOnQ0YwIj5nQC4DBQEvDqurtqZckiDBU5YZ3i5ZEhyI91u7l1LfiSdbHAbgOdaAzza1GAySYodbcSGYZ3U61o/5lFnzXcC5kf4gC0k+H4qqd7hiUO3ZeSnW5Ryqk7f2f35t6IJlqVzMQIUM7n4YGQR1feBlBS0gXPX6AZnHvwt6lECBI99EuSMElIttMP0aquAD3zVNGuwrFRxaRz4udSqHb9HQA5gpNXLrX6dnFU7sphpj4HFYLBgt3aHUzr5q8EEcNyX0BlKIIyKbLTRunt1heyDIzFgG+EYpIcMnlWr8J6K3Icn24mqWNN2Oy0oEkY2o4E1YGnmSeuvFyZiN7tgmwFWVpSoJIDUMRUFgFoJUtsvOfUUwhhrtNo8CkILuc85cnuoVsRmWTRZyP8lkZJ6Cwj2C
X-Forefront-Antispam-Report: CIP:193.138.15.34;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.cpp.canon;PTR:oce-exet04.cppinter.net;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(376002)(396003)(451199015)(46966006)(36840700001)(40470700004)(86362001)(55016003)(478600001)(47076005)(40480700001)(7696005)(40460700003)(33656002)(8676002)(70586007)(5660300002)(82310400005)(8936002)(52536014)(70206006)(2906002)(41300700001)(316002)(6916009)(82960400001)(336012)(186003)(26005)(6506007)(82740400003)(9686003)(15974865002)(81166007)(356005)(36860700001)(83380400001)(46492015);DIR:OUT;SFP:1102;
X-OriginatorOrg: cpp.canon
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 08:27:54.1706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1908dbd-f799-49be-7d07-08dadf3f6db6
X-MS-Exchange-CrossTenant-Id: 9c30c788-860c-43db-b7d7-e8337f2f0238
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9c30c788-860c-43db-b7d7-e8337f2f0238;Ip=[193.138.15.34];Helo=[smtp.cpp.canon]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT041.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP195MB1531
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

I upgraded Git to version 2.38.1.windows.1

What did you expect to happen? (Expected behavior)

I expected "git pull -v" to simply work and exit correctly without telling =
me the syntax of "git submodule".

What happened instead? (Actual behavior)

This:
> From gitlab.ops.oce.net:nemmaiec/cpposa
> =3D [up to date]      develop/1.0 -> origin/develop/1.0
> Already up to date.
> usage: git submodule [--quiet] [--cached]
>    or: git submodule [--quiet] add [-b <branch>] [-f|--force] [--name <na=
me>] [--reference <repository>] [--] <repository> [<path>]
>    or: git submodule [--quiet] status [--cached] [--recursive] [--] [<pat=
h>...]
>    or: git submodule [--quiet] init [--] [<path>...]
>    or: git submodule [--quiet] deinit [-f|--force] (--all| [--] <path>...=
)
>    or: git submodule [--quiet] update [--init [--filter=3D<filter-spec>]]=
 [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[=
no-]recommend-shallow] [--reference <repository>] [--recursive] [--[no-]sin=
gle-branch] [--] [<path>...]
>    or: git submodule [--quiet] set-branch (--default|--branch <branch>) [=
--] <path>
>    or: git submodule [--quiet] set-url [--] <path> <newurl>
>    or: git submodule [--quiet] summary [--cached|--files] [--summary-limi=
t <n>] [commit] [--] [<path>...]
>    or: git submodule [--quiet] foreach [--recursive] <command>
>    or: git submodule [--quiet] sync [--recursive] [--] [<path>...]
>    or: git submodule [--quiet] absorbgitdirs [--] [<path>...]

What's different between what you expected and what actually happened?

The text I quoted above, and an exit with error code.

Anything else you want to add:

The '-v' parameter is used by TortoiseGit and GitExtensions, which now both=
 croak on pulling.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.38.1.windows.1
cpu: x86_64
built from commit: b85c8f604d375d4d773a36842964e8a7ec056aae
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19044=20
compiler info: gnuc: 12.2
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]


Canon Production Printing Germany GmbH & Co. KG
P.O. Box 1260, 85581 Poing=20
Siemensallee 2, 85586 Poing=20
Germany | www.cpp.canon
Canon Production Printing Germany GmbH & Co. KG.=20
The company is a limited partnership with its registered office in Poing=20
Trade Register HRA 100955 (Amtsgericht M?nchen) - WEEE-Reg. - No. DE 888 05=
 443

General Partner: Canon Production Printing Gesch?ftsf?hrungsgesellschaft mb=
H Registered Office: Poing
Trade Register HRB 206480 (Amtsgericht M?nchen)=20
Executive Officer: Johann Meyer
?=20

=0A=
This message and attachment(s) are intended solely for use by the addressee=
 and may contain information that is privileged, confidential or otherwise =
exempt from disclosure under applicable law. If you are not the intended re=
cipient or agent thereof responsible for delivering this message to the int=
ended recipient, you are hereby notified that any dissemination, distributi=
on or copying of this communication is strictly prohibited. If you have rec=
eived this communication in error, please notify the sender immediately by =
telephone or with a 'reply' message and delete the message and its attachme=
nt(s), if any, from your system(s). Thank you for your co-operation. =0A=
