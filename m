Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63F2C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 07:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbiLTHiA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 02:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiLTHh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 02:37:58 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2137.outbound.protection.outlook.com [40.107.21.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F79F2BE4
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 23:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpp.canon;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iAc/IWLF7Z8WQlWq3N3s+W0Hu04Iih3VUM4GCgcknw=;
 b=kCpNhdqhg3azHmpWO7H8PmbyhkGF2Q/sLVox8jhFeshXt9su6rh4wzEomUOcjd/MXIx7NClq5eSj9S5VVW/7s2gubVrdc+I96/509fhZumSDjoiGLTFFmR43kafY+SvFaoNQhnudO9F5lLitcaLHQvqJyZHQVn4tXfyCEs0/nj4=
Received: from AM6P191CA0081.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8a::22)
 by AS8P195MB2385.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:631::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Tue, 20 Dec
 2022 07:37:55 +0000
Received: from AM6EUR05FT010.eop-eur05.prod.protection.outlook.com
 (2603:10a6:209:8a:cafe::2) by AM6P191CA0081.outlook.office365.com
 (2603:10a6:209:8a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Tue, 20 Dec 2022 07:37:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.138.15.33)
 smtp.mailfrom=cpp.canon; dkim=fail (signature did not verify)
 header.d=cpp.canon;dmarc=pass action=none header.from=cpp.canon;
Received-SPF: Pass (protection.outlook.com: domain of cpp.canon designates
 193.138.15.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.138.15.33; helo=smtp.cpp.canon; pr=C
Received: from smtp.cpp.canon (193.138.15.33) by
 AM6EUR05FT010.mail.protection.outlook.com (10.233.240.157) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16 via Frontend Transport; Tue, 20 Dec 2022 07:37:54 +0000
Received: from oce-exmb03.oce.net (10.95.6.32) by smtp.cpp.canon
 (193.138.15.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Tue, 20 Dec
 2022 08:37:54 +0100
Received: from oce-exmb03.oce.net (10.95.6.32) by oce-exmb03.oce.net
 (10.95.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Tue, 20 Dec
 2022 08:37:53 +0100
Received: from oce-exet04.cppinter.net (193.138.15.34) by oce-exmb03.oce.net
 (10.95.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13 via Frontend
 Transport; Tue, 20 Dec 2022 08:37:53 +0100
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (104.47.13.55) by
 smtp.cpp.canon (193.138.15.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.13; Tue, 20 Dec
 2022 08:37:53 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQnkvWcElQ+lBvZg7DjdCy+CEfQhyVdODOZ9e7tH5jdD/m0Mxho/MsjJnerwxPHyhnLW7AbcSVSEKWxcypmPOmV5lqcjoRPMRQr7B4NwvYh4cU/TmAXATztev1/sBWHbNkJD+v5PK+84iJb+TYEV5w0Hu0nnz6E+0noIQ6T7tCxekhOQ45j1u/5hydpZCX0bhkihxf/Hag/uIX/DEA2/oSINdqxn9guzIhi0awfs2SyEL5HS38qvYCpHVrzMxkKyojUQdsbnjzj0eYd3KGmr/NU0NBPrqwoU9uJTP98dNKMAz6ULdOMH01XucIYZFDUtEGfgVW1mCYlub+jR5tLyWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5E2nPhCiHL71KQCOPVZk8ftN7/OJNdJcEFu5CcMERBA=;
 b=ES7Yz6yuKkADms/dr1Va9v5sk7JJoBB6fiIKyT0fnPcgAkaXKDUwu0Eue8PNUoL4/UZThruxJhNSFbvbC7X32aYwT0l+HgRCzg1/vnChmi4Z/Dj/se9p2SN1lTuv29Ue9m03EtEkFRnq9UGfdUS9Rt/gdeQ2kVQTBd3tbkBQPBdTTozCQfshWJpu/FVNNfL2bYhmPratxo3GUmtErwsKwFORrCbDY8I8c3+R2+dgC30OZq1FSE0Ont4heaytCD06WsI2fBmARPwgcXQB6Kc7hnTjqG6er2xx1wNbfbqIY5smxhwpy09WuBMvGV22f3nulvgQMrL6Ej2nXPCnR5j/dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpp.canon; dmarc=pass action=none header.from=cpp.canon;
 dkim=pass header.d=cpp.canon; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpp.canon;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5E2nPhCiHL71KQCOPVZk8ftN7/OJNdJcEFu5CcMERBA=;
 b=NSgFEIDnSDhgtYSucfbBl6dYKT18fI7QfLKUnDBO6yTRwQPNDjme+wadgaetWrSzuEBfhyYwWJ5USMgrHKSlD4iQirO/ojxtGI/9ZiN4593geaIvvZTAy+5L7Lx9Q0TgqrauSzZKMBIGqNDL3QnX/ky8GSBtI6lROqsqdEMOOic=
Received: from AM8P195MB0820.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1e0::9)
 by GV1P195MB1975.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 07:37:52 +0000
Received: from AM8P195MB0820.EURP195.PROD.OUTLOOK.COM
 ([fe80::7cd8:8bb1:6d72:6219]) by AM8P195MB0820.EURP195.PROD.OUTLOOK.COM
 ([fe80::7cd8:8bb1:6d72:6219%4]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 07:37:52 +0000
From:   "Nemmaier, Christoph" <christoph.nemmaier@cpp.canon>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "rsbecker@nexbridge.com" <rsbecker@nexbridge.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: AW: AW: PROBLEM: "git pull -v" fails with exit code denoting a
 submodule syntax error
Thread-Topic: AW: PROBLEM: "git pull -v" fails with exit code denoting a
 submodule syntax error
Thread-Index: AdkRKEgzislgucz/T6+rKojgCV9oPwAAgZyAAANTMA4AHu4mgABycSiQACEW7owAER+lsA==
Date:   Tue, 20 Dec 2022 07:37:52 +0000
Message-ID: <AM8P195MB08208FD53904EB540312854480EA9@AM8P195MB0820.EURP195.PROD.OUTLOOK.COM>
References: <AM8P195MB0820A54FEA04231D440F74D780E69@AM8P195MB0820.EURP195.PROD.OUTLOOK.COM>
        <000b01d9112a$541c4de0$fc54e9a0$@nexbridge.com> <xmqqcz8jmz4e.fsf@gitster.g>
        <006a01d911b3$57e0d1b0$07a27510$@nexbridge.com>
        <AM8P195MB0820F8606B7B7A2B91442C4A80E59@AM8P195MB0820.EURP195.PROD.OUTLOOK.COM>
 <xmqqzgbj2cvi.fsf@gitster.g>
In-Reply-To: <xmqqzgbj2cvi.fsf@gitster.g>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpp.canon;
x-ms-traffictypediagnostic: AM8P195MB0820:EE_|GV1P195MB1975:EE_|AM6EUR05FT010:EE_|AS8P195MB2385:EE_
X-MS-Office365-Filtering-Correlation-Id: e33cbbbd-69a0-4172-358d-08dae25d1b7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: FLbvmXhTelpKh+LSsNQPN3+rlqXGARkly0PDBhkJVwqWyWBGaQV2ZAM3o7E0Y6Jb2dBl9CXK0afFUBGJ+6pbchs3a6o347Qloc9yRb4ASudSXwPS6QY/lmSury4Pemto7mm9Jn8SYl+LNZ4reqhL4xNvXbb0VPskAdpUs1xjWVXx+Yf2ULEFzfZSNIdAw+Ix8jKJ4W9yOW32nbc3jYLnpw7wryM/5SR3Ufm1RqpE7H2a368RsqhN2r3Jn+oEyg4KEz82EDRBrybFV7Oucm9AdPebGLCqdWe9D+epDZMRB7kjNkbZRIoCJWuUTlb0j6UrOZmxtbyZFE2w+47pXKPMT2Mn7R67X8KRgs20HsZyC9JnlV9Sea5ab+jjLI5wbWzOfvkB9l7Z+bmcSOv19Ai2rxMqIRSEHwynfHUUV+LxcNNjc402hO3rx5uBpeDdBJdG3oKGTf6nYQH9PkIoTO6RhPI4gIqGYNIJ++z/fVVOrJI0F98t74gqtzGmP/R6vWMq5eAtBK8goL4N/QPyhpF4SEeTfff5Uei1LVLtwj70hzah5rbelNWqchcYXCNRHg4BgUNiqDUi5Fr1ow9CcTgnuG/a+3kIWeUkitjm+DmU5U+z7YPV7Du4SP/ESLdVVogZ7q/dumTLJKAEwthiRgaRLQWPNiUcKyh9SPuzX27SWVcnIHIUhf1wgZdFSNUkfgnOEuOAjeX2CdCj0ZfrZY37ArsDxINo8g7btuIMxbBhXvokHeyzqSSAVRUapnMsyNWw
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8P195MB0820.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199015)(66574015)(6916009)(4001150100001)(2906002)(316002)(38070700005)(54906003)(478600001)(83380400001)(55236004)(6506007)(33656002)(86362001)(55016003)(7696005)(38100700002)(9686003)(186003)(71200400001)(26005)(52536014)(8936002)(122000001)(82960400001)(41300700001)(66946007)(64756008)(76116006)(66446008)(66476007)(5660300002)(8676002)(4326008)(66556008)(46492015);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB1975
X-C2ProcessedOrg: a6a72299-2f6b-49c6-b092-048da1ac2e4b
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM6EUR05FT010.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: fbda1ad5-a350-4790-c5b3-08dae25d1a42
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7JM13tmO47gbs1hLn62rdez3HMZuSqVhPB0+sP/1blf6IfXZkF1q5eqCzs0H0iYCZ34xjbYbp0veBie/rbe6C6Iwse5dlBl6zbE4OaOpjCSB8vPm2oszJUm5XKHCheSM2q5vvYJwAQYS89iTCLofVfkD0kRaCvknwSDPuZ2ZyHAD4ypH91pizZ36/8VzRwyhMdkmE/reLXLS+nTE0W8wT/gcSBYJgd8qDYCnZ6xXqb0b0IQphUgzGd35LGQZc9HUrSCF2CY2rM1MvvhiKAdokK4+d9zqX11lkNy3s6YkVpootmenPa6OhyroVq2VvnhL0EbwtfHwTSq/713xuunL5Yg7ZKr255R5s6aKPJMvc3s31JIGoGlNxbxfe55BUj3/TfhUz4b+1AR+1nGAYAdeyxgJ5BDPGvc8w5Sau0Gn0f6KczVVlVWm5k7i5QEptkTI1Iejd2CrIwVdHvk81lnHHU0zK2FkxE2uVfx8avfrtQe3ZWwr9iou5YesAPOBxSI1cJg97H4BFWXRAZGHZkMLUV2Yqexg+xPOgKFeOwNORV2mb1UhxfW2AtT35+vu+LVZSgFZMe+D0SckuYwVuU0DxIz1LsHONbSFAx6dX90pbM1zA13V70SxQqK/MmS9DxTsep8Ug4U7PQLar1bzip4YtekmthI35QDuiaYugKD2sjD+pbES3DJp2D3a0nMCZFrHWtDfSkfL07LoymarLTBGueseJG2GnTLs4/xUwp2o3/me0NkSsWoYl/oGkzv1AcJ6
X-Forefront-Antispam-Report: CIP:193.138.15.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.cpp.canon;PTR:oce-exet03.cppinter.net;CAT:NONE;SFS:(13230022)(136003)(346002)(396003)(39860400002)(376002)(451199015)(46966006)(36840700001)(40470700004)(7696005)(70586007)(15974865002)(70206006)(478600001)(81166007)(82740400003)(33656002)(316002)(40460700003)(6506007)(47076005)(36860700001)(82960400001)(186003)(26005)(54906003)(6916009)(55016003)(8676002)(9686003)(4326008)(40480700001)(83380400001)(336012)(86362001)(82310400005)(52536014)(8936002)(5660300002)(66574015)(2906002)(356005)(41300700001)(4001150100001)(46492015);DIR:OUT;SFP:1102;
X-OriginatorOrg: cpp.canon
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 07:37:54.6369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e33cbbbd-69a0-4172-358d-08dae25d1b7c
X-MS-Exchange-CrossTenant-Id: 9c30c788-860c-43db-b7d7-e8337f2f0238
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9c30c788-860c-43db-b7d7-e8337f2f0238;Ip=[193.138.15.33];Helo=[smtp.cpp.canon]
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT010.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB2385
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Great, THX.



Canon Production Printing Germany GmbH & Co. KG
P.O. Box 1260, 85581 Poing=20
Siemensallee 2, 85586 Poing=20
Germany | www.cpp.canon
Canon Production Printing Germany GmbH & Co. KG.=20
The company is a limited partnership with its registered office in Poing=20
Trade Register HRA 100955 (Amtsgericht M=C3=BCnchen) - WEEE-Reg. - No. DE 8=
88 05 443

General Partner: Canon Production Printing Gesch=C3=A4ftsf=C3=BChrungsgesel=
lschaft mbH Registered Office: Poing
Trade Register HRB 206480 (Amtsgericht M=C3=BCnchen)=20
Executive Officer: Johann Meyer
=C2=A0=20

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
-----Urspr=C3=BCngliche Nachricht-----
Von: Junio C Hamano <jch2355@gmail.com> Im Auftrag von Junio C Hamano
Gesendet: Dienstag, 20. Dezember 2022 00:27
An: Nemmaier, Christoph <christoph.nemmaier@cpp.canon>
Cc: rsbecker@nexbridge.com; git@vger.kernel.org
Betreff: Re: AW: PROBLEM: "git pull -v" fails with exit code denoting a sub=
module syntax error

"Nemmaier, Christoph" <christoph.nemmaier@cpp.canon> writes:

>> ...
>>>
>>>I suspect it is the same issue as the one that triggered
>>>
>>>
>>https://lore.kernel.org/git/f805f2da-a7e1-9fde-cc0a-04a30f79c9af@cs-wa
>>re.de/
>>>
>>>which came out recently?
>>
>>If that is the case, perhaps the -v needs to be documented in the online =
help if/when this condition is fixed.
>>
>
>
> Good morning,
>
> it pretty sure is. The doc goes like:
>
>> -v
>>--verbose
>>
>>    Pass --verbose to git-fetch and git-merge.
>
> Intentionally or not, git-submodule is not listed.
>
> Anyway, I think the doc is correct, as git submodule doesn't know=20
> '-v'. So either the internal call should drop '-v', or 'submodule'
> should ignore it.

Yes, <f805f2da-a7e1-9fde-cc0a-04a30f79c9af@cs-ware.de> cited above is exact=
ly about doing that.

The resulting 6f65f847 (submodule: accept -v for the update command,
2022-12-10) is about to hit 'next'.
