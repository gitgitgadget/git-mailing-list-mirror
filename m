Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C71C4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 10:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiLPKtp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 05:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLPKtn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 05:49:43 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2109.outbound.protection.outlook.com [40.107.8.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C82FDE93
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 02:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpp.canon;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSzUSjCqj6w4aVaE3Zd+gpM6xEYQhmy/5c72OL1ma2I=;
 b=KjwJKtEgydUUxjLsnp43jA06GAu9Xcx9eIp2OBp+swk3Yyb3zwhIwP3wZkY5BuSg0aN4xNHrKCeQAud94SiClStXdR3krNLwv147vapH91LvQhP3aKz7AX0DoAYkclRUKDKd5Unys+exwfRvKGgI2XXsySqn7yd0jm6wr9ZnRVk=
Received: from FR3P281CA0084.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1f::20)
 by AS1P195MB1495.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Fri, 16 Dec
 2022 10:49:40 +0000
Received: from VI1EUR05FT048.eop-eur05.prod.protection.outlook.com
 (2603:10a6:d10:1f:cafe::e1) by FR3P281CA0084.outlook.office365.com
 (2603:10a6:d10:1f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.5 via Frontend
 Transport; Fri, 16 Dec 2022 10:49:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.138.15.33)
 smtp.mailfrom=cpp.canon; dkim=fail (signature did not verify)
 header.d=cpp.canon;dmarc=pass action=none header.from=cpp.canon;
Received-SPF: Pass (protection.outlook.com: domain of cpp.canon designates
 193.138.15.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.138.15.33; helo=smtp.cpp.canon; pr=C
Received: from smtp.cpp.canon (193.138.15.33) by
 VI1EUR05FT048.mail.protection.outlook.com (10.233.243.188) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.15 via Frontend Transport; Fri, 16 Dec 2022 10:49:39 +0000
Received: from oce-exmb04.oce.net (10.95.6.33) by smtp.cpp.canon
 (193.138.15.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Fri, 16 Dec
 2022 11:49:38 +0100
Received: from oce-exmb03.oce.net (10.95.6.32) by oce-exmb04.oce.net
 (10.95.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Fri, 16 Dec
 2022 11:49:38 +0100
Received: from oce-exet03.cppinter.net (193.138.15.33) by oce-exmb03.oce.net
 (10.95.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13 via Frontend
 Transport; Fri, 16 Dec 2022 11:49:38 +0100
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (104.47.51.174)
 by smtp.cpp.canon (193.138.15.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.13; Fri, 16 Dec
 2022 11:49:37 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+3RnM0mjTIJlS4eUEFXSkVgdlD9QLqhvDxAZcdVD8FP8xdh9wz6dRrakxViCaV2wSEvNkyx46eVTHv+XftMK7nvusuySv00sfjh2tb4bC63VNn7bsxvWThelFAJlOePjBBQGoDT4hHdDbMjcMZg6BxOZVXZjo+rfuEilmU61tLg/NmjyAiIvbUw3nJ5q5NwVc11dIkKjJ5FitLe/QRNqNx7SYRN+5Sf4dCh44dHdHGW/m8WBswA4J9yIhYMnVoD+LUt7E5wdptkZMTXyaOxCwzvDBkHZUg509Bjv9G9YkqfP4nymqpuWCGK7PnDRU3VeKjxH/nrj+uMMSoGTJyd7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQEwR9VcQbB1dhoMRBvHzhFOuTZbFfYQcgk9x4+5XR0=;
 b=imfVDhm8qP2Dhs31BKD3bC6ZD3OpQ9+vpQcPR2TdCxNDplhBsRoUW7azVcE7amWjKmy4MV32yhjZe2FJmwQPjIFDUJgk0FkNJr4eonbHzCaW+DdcuthtIREe+mfKP3PKQiqhzOqt/PDGTb68RUwOx2/1iqdBgeb6eyBiYaWgdtYoqnkPUdcIZ6PkisdC04+pICet3CF+iMoimDJi9kwYgngUUKJdS6gkUDuJAPHCLB/7HcCil86YmUSnLXYTg/BtBUf65HThQ6Bp5pMA1WIFKH2B8hwpyhJnmpmlJ0JmKvklIK3aOCwsb6tQ7LfIs9Euw+9kcfqA2RJJLSqaO2GvWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpp.canon; dmarc=pass action=none header.from=cpp.canon;
 dkim=pass header.d=cpp.canon; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpp.canon;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQEwR9VcQbB1dhoMRBvHzhFOuTZbFfYQcgk9x4+5XR0=;
 b=KGnkVS3sMg8DZIidRnUy0RpEePcAvSD36YLHqDOnR+pAWe70pxZcymIf+779idsqGWWf+iRypN4GDcazhAiQtURyBp2jliKsYLJYrpjEwxrXtHWHJzCKYsG+QwTFrev4QF/jfAtKw4h/Z1gXBcUrO2677HB0BS0GjuFSBiSZcik=
Received: from AM8P195MB0820.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1e0::9)
 by DU2P195MB2375.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:497::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 16 Dec
 2022 10:49:36 +0000
Received: from AM8P195MB0820.EURP195.PROD.OUTLOOK.COM
 ([fe80::7cd8:8bb1:6d72:6219]) by AM8P195MB0820.EURP195.PROD.OUTLOOK.COM
 ([fe80::7cd8:8bb1:6d72:6219%4]) with mapi id 15.20.5924.012; Fri, 16 Dec 2022
 10:49:36 +0000
From:   "Nemmaier, Christoph" <christoph.nemmaier@cpp.canon>
To:     Junio C Hamano <gitster@pobox.com>,
        "rsbecker@nexbridge.com" <rsbecker@nexbridge.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: AW: PROBLEM: "git pull -v" fails with exit code denoting a submodule
 syntax error
Thread-Topic: PROBLEM: "git pull -v" fails with exit code denoting a submodule
 syntax error
Thread-Index: AdkRKEgzislgucz/T6+rKojgCV9oPwAAgZyAAANTMA4AAQYSUA==
Date:   Fri, 16 Dec 2022 10:49:36 +0000
Message-ID: <AM8P195MB08200A28914B0D5EAFE8CB1A80E69@AM8P195MB0820.EURP195.PROD.OUTLOOK.COM>
References: <AM8P195MB0820A54FEA04231D440F74D780E69@AM8P195MB0820.EURP195.PROD.OUTLOOK.COM>
        <000b01d9112a$541c4de0$fc54e9a0$@nexbridge.com> <xmqqcz8jmz4e.fsf@gitster.g>
In-Reply-To: <xmqqcz8jmz4e.fsf@gitster.g>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpp.canon;
x-ms-traffictypediagnostic: AM8P195MB0820:EE_|DU2P195MB2375:EE_|VI1EUR05FT048:EE_|AS1P195MB1495:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dfa68af-80f4-4e02-a735-08dadf533b15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: quejfPkEt/as+dSmbJQHho3vsdMklXGzm8xUZnOn6YQSARt1CCWEyPzuN9+63+TfCKVTFfzg0Ufml3rN4A6TW1W15kvZgV65YuQBq5WlqCyRP5TjFAwz9/NCbFNJH0cRasFjdxcneundZXgXvCZQjYJhH6bZic50wPp58xr5k9VL00Y4jGJZc92Sdebz/19CBxk/pwORwGIYaHbN9dY+hdSxtE1x55wPLiRqQAI02cTXNQeVAKpHJ3kifg0SxtOiOkO9wpXi3wkJ54yrTZL1fVswTa2cDpGYqtGcD7Wk3lO11R5f0WS4OZk4OXCSyCymESrrU1oEAcTNXZpQUy9xkqDHc7dwsR26/pPpnjYfJG5ckEmBHASmJ1qI1fe9mkDKuWTr89/gz3OAl/eH5wV9K/R9BIO9GyOxtF87bP1kXQVMle/RTKlZR52jvruciT+kD6CmSNT337WLhlTOI7f67HCbOYcQpjoVrn8HKcsZ6KlJSFNcu7FNLJ6OydzrLhzQ/9nhYkYAGaNnneWDDEKVYY7j+HzVzijbu2C81Zy+Y11HjGG+TovucKnJG4IWWAes21MMs4MB7tEx1czvmktEEFbfFaatLwMnMkKzW+C5+OCpGW4aRIVw7ngY3pJKVKzQa0tP0iCK9A/SAHv3eY0RfG40cT0sD3w2nCFSuBuxWSi/wSFW1Adw6ZLpZsIFFmVpp2EWoFdyXeZ17zysUeXvq6rJeZbK5E9KrtIsrkbf0fHrPqI6hWd1OB5QCiF378NJ
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8P195MB0820.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199015)(83380400001)(316002)(110136005)(4744005)(38100700002)(122000001)(8936002)(41300700001)(5660300002)(52536014)(64756008)(66446008)(76116006)(66556008)(66946007)(66476007)(4326008)(8676002)(82960400001)(478600001)(966005)(55016003)(26005)(9686003)(33656002)(86362001)(186003)(71200400001)(7696005)(6506007)(2906002)(38070700005)(46492015);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P195MB2375
X-C2ProcessedOrg: a6a72299-2f6b-49c6-b092-048da1ac2e4b
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR05FT048.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7f8d937e-a11c-4426-6282-08dadf533961
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KUZ680mFE8INYWQ6UH2uX54SFxMq1bjE1NTCZQzYAY4MGfV0Y7RWDA93scaUwg951oHfrdCNq9pzl2eILxgeOt9PW4dcOSW0K7U/zuMWrLdYHPTlhil+PQXOtFlPC9d/G080cS0xOSGRfQGyya7pE7Yp/D0EHlXylgU+0+AEP6PCWaaPFlbZ2g1edogkSVJ2rK0EK+Yu39671hfijGa34Y45K12eSg5KYwfl3nA7AJ9vuKbGJ2K+F1O3TyatOqB1TvM5wLiodi2BULsQGaS9OGXviEDJpuZ1rYz2wW51L8j7KDRlhf9/QaO+CjUCGXy4pWF5jtxAbG7TGzn7dBQpiqx49JW6T0g08dRhbX/JUz36LwwHK1mCknWyBqlxjoJ/swdOXbP4zNo5eCaOkZFenFIfiCY+U9Tmg83Izq6LFQj6iEuQqRjUs1mXJ8/9aB9bSdi0Ql8RwY9NZhdrprX/DFKmSnvl7SZfHfANnnatMOtx7PLIA8t7kvL7JXAYKu91/iB4MCXfESbP2aEwj8ZdKXHHgqp8G+m2kdJFyiIqEIb8GOspXVU8f0xqSRcOgDfKRlLWxCfjrgHIqABPJwCqAkPiBd/dkDrO163Aldd25bRLaq8Ey+zL9K1KpuqFTWvBY1JLkCyhFQuWK+RmefI1z+gGQPyPcCsrNZkQjl3ukech1mkUal3BDj/NHgLdiqoobvoBWR1y/L6fCJ/fG+yEraTjDZYtOo45K4pSUOl98fYWmwghwD0BOf7NeRhqpVPz
X-Forefront-Antispam-Report: CIP:193.138.15.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.cpp.canon;PTR:oce-exet03.cppinter.net;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(396003)(39850400004)(451199015)(46966006)(40470700004)(36840700001)(478600001)(966005)(26005)(186003)(7696005)(110136005)(6506007)(316002)(36860700001)(40460700003)(47076005)(55016003)(82960400001)(356005)(81166007)(40480700001)(82740400003)(9686003)(33656002)(66574015)(83380400001)(82310400005)(86362001)(336012)(15974865002)(52536014)(8936002)(41300700001)(2906002)(5660300002)(4326008)(8676002)(70206006)(70586007)(46492015);DIR:OUT;SFP:1102;
X-OriginatorOrg: cpp.canon
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 10:49:39.1807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dfa68af-80f4-4e02-a735-08dadf533b15
X-MS-Exchange-CrossTenant-Id: 9c30c788-860c-43db-b7d7-e8337f2f0238
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9c30c788-860c-43db-b7d7-e8337f2f0238;Ip=[193.138.15.33];Helo=[smtp.cpp.canon]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT048.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P195MB1495
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

this indeed seems to be the same problem. As I already added, my problem oc=
curs when submodule recursion is set in .gitconfig.=20




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
Gesendet: Freitag, 16. Dezember 2022 11:17
An: rsbecker@nexbridge.com
Cc: Nemmaier, Christoph <christoph.nemmaier@cpp.canon>; git@vger.kernel.org
Betreff: Re: PROBLEM: "git pull -v" fails with exit code denoting a submodu=
le syntax error

<rsbecker@nexbridge.com> writes:

> On December 16, 2022 3:28 AM, Nemmaier, Christoph wrote:
>>I expected "git pull -v" to simply work and exit correctly without=20
>>telling me the syntax of "git submodule".
>> ...
>
> Hi Christoph,
>
> I have gone back to git 2.36.0 and cannot find support for the -v=20
> submodule command parameter. At what version did this last work for=20
> you? Do you have a git alias in effect that might be adding -v?

I suspect it is the same issue as the one that triggered

  https://lore.kernel.org/git/f805f2da-a7e1-9fde-cc0a-04a30f79c9af@cs-ware.=
de/

which came out recently?
