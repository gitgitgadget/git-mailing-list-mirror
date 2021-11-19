Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72486C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 14:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FD5B61261
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 14:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbhKSOM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 09:12:58 -0500
Received: from mail-eopbgr00082.outbound.protection.outlook.com ([40.107.0.82]:62318
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235201AbhKSOM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 09:12:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsfY+PiBOIjCxmrLlRigeV1JXoe44FcjhQOw++zymR/T3gbWrvm2/IwfVhLeQUyWxOAnb6iu39cirIB45Pmwm2pP72Y3aoTUZpzswS8yKvAH41gknVRl3to0iZGvdva/2aR6eqGf/ad8BsOJugZTEwEQnR1LAHfc4igliZ3W+r/4ityRejwDgC+Oe2uHGsLIdGarBw7HfQ94TQ+8k9+48ZwIPZGGn8gfysSYEclVs4mFravoxgfp45I6B3p9GCKInEq4O94htL49CKrwFYjwFa6u7e3J9mDX0ua3bLAEv3o0IOW1d57RtzMe5ah2AvmMDn12OWx1PSkmAPYP15GlMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7MsES/stF8g2arIZyXfKo5/bXors+dT5MSCVK2c7jQ=;
 b=daMD0+fwRxtOrHWsPmcvinyrlOaRZZiGEBw0y6FK3cFS21RzFLJiZ5Z8jmYz+TtaiMBs0lEJHjE1DUwgkUysVGwSkgi9dfGQiSxNkNf1/DNs2Fn1Kc1FLsfv/IZo99o9S4BmwBuSZKfbfCj7cQml8h+JcKW76q1AaOcWlZVSyhZT1h93xZR7rwylAcI44/R27uSfsQyMGSYT+ckHSA/KDPKJVckX/rd4jcH44fXMFeSCtAaVwqRNEXjxw3ke4W2Bro4g7GnrbD+/YB1q6FofeNXCVLEPb6MuMOYaet/wxgDbFtAKvpYi6S7n/+bZhRQG2ODGD558bZfA7T8uKmlsHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7MsES/stF8g2arIZyXfKo5/bXors+dT5MSCVK2c7jQ=;
 b=Nxak3r9sxxu55wCRSNF8dNfFojrjacufrGj4RIjGrXYDz7xAlYx9QcL9r6xupvp2uaYQO/t5W/xiwGIhmgXokb5O0gLgZ/SVsRvTWh95JHS3J5WcG3jnd8WWjcMH6ltecieRuu8UcWfZBNk9pkGKY/btEStjZlq9NC1m5zyf+vQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4735.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:157::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 19 Nov
 2021 14:09:53 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.020; Fri, 19 Nov 2021
 14:09:53 +0000
Date:   Fri, 19 Nov 2021 15:09:53 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] test-lib: introduce required prereq for test runs
Message-ID: <20211119140953.cgdppgv3f64hqbdx@fs>
References: <20211117090410.8013-1-fs@gigacodes.de>
 <20211117090410.8013-3-fs@gigacodes.de>
 <211119.865yso4a9y.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211119.865yso4a9y.gmgdl@evledraar.gmail.com>
X-ClientProxiedBy: AS8P250CA0024.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:330::29) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS8P250CA0024.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:330::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend Transport; Fri, 19 Nov 2021 14:09:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26a1539b-183d-4c71-34bb-08d9ab664233
X-MS-TrafficTypeDiagnostic: PAXPR10MB4735:
X-Microsoft-Antispam-PRVS: <PAXPR10MB473531046443A6FDF0624221B69C9@PAXPR10MB4735.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zr5Xzy6KzI0LYY+GwL6JMZYkkS3ADI+fzyHOibmdvx6opXORlVAgby3JzP0DfQXwBIktwqNaJgvpIRGLjeiWiUZnLrEFdo4HXdMjVU+NT/nNNvaBaEroGl8NssHwWlG9Qt9qV/TsGqmYKY601HC6+QC0LN6ICoecasl++RJl3hw5dHFM9eJi9JJbruxAd8VDrVTOSeJBkV5MZnhl+/rytUUYJFb2eXWoYF1g7eJZufjHMekm7u8JWIeujtatCQwl+GXKlJ/QPuQYijqwP4S12j3nGJaw14GMX8UdCp+qzzSMt4hs4/7U1B0XLGlSWE0izm8oxY+fji5fuMMJUi2pOJ/YIw+8iOsNUxO+LOugyjU+XwaS7tQbpz8nXb/k4OiKe5xPMXyUBNxPTcy0tPUHq36qffPYjLeTwOsH5Kl4CXpsMeOBAUfR9afBX82/By8wnoSK4PQvcHAjQfcjG0LG7M4SHdoeJVopvxPFvPbyTMPtugcnxOCveYWFDcw7Z4YoN5H1lBqPr/DTFeBkqokHvy7Ect6bABuGeGsYZKZSkLRccUiUkQUl/eMW3Yz0MLc6IZYSM3LyPTT5nCxAnXoDBldk8S9AtMu+It4oJGJ2Ryf4hFPzI/0L1deVPuTHcNc48B6XVMKdtPPPNUiBpuVkVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(376002)(39830400003)(366004)(136003)(346002)(396003)(5660300002)(83380400001)(66574015)(66476007)(6496006)(33716001)(316002)(66946007)(2906002)(52116002)(53546011)(8936002)(66556008)(8676002)(9686003)(6486002)(4001150100001)(6916009)(186003)(1076003)(38100700002)(508600001)(4326008)(86362001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkJvOGdwcmdaN081L0RzWUVZZlVQeHB5WWZRRTRUSmJhaWJ3MmlxTk8yU2Zj?=
 =?utf-8?B?dWVKZXBlNnMzdTFzTEY5bHlMMm5nMkUyVVNqTE51TVd1blRLQWJ0elBHUHM0?=
 =?utf-8?B?alEzTDhlTU1hMmMxNlN3SURMcTdIcmR2YnVTck1aSVExekJFUUZMNEMyMWFS?=
 =?utf-8?B?R1BXQ2Z2R1pvVkE2YXNhdjJLQ1pYak03THZjNXJkWXBzOUpBTDRXTlg0cmRL?=
 =?utf-8?B?bzJnd3p0c0JadlpoTEpVQThrYVhrb1FNeWVvZHFlc2p2UitaSWhvc2UvV3lJ?=
 =?utf-8?B?OFRoMWdHcWFXVUdtaUdsVjBURjhaZzNrRnVaa3JkSkVEMG80UnRmaTd6ai9I?=
 =?utf-8?B?ckxYTmNtSkNqZkRFRGxRWnc4VUt5QWgxdUhzek9WN0JkM3prTTBtdnNESEpr?=
 =?utf-8?B?b2JRekdxelgyZU1oMEZiSC95ZUJDQ00vZlV0RThnN2o1a0dMSW5RaHBuZ24r?=
 =?utf-8?B?QlFCemlaUHpzNEJLbzdnYmVSNlFvdHM4Sm9Ra0lVbWpMSzlCUnpRMWdvNEYr?=
 =?utf-8?B?Nkc0ZXhnamlZNG5mQTUrSUJCZ3BvaXNTREZyTHFwZWFZclhpd1Y2K0NkVHZ5?=
 =?utf-8?B?OEovZFVVQUo5MDVuazhZZW5nRDQ5WFBjbFEvS0EyZnpmOE4raVlGMWhKVkVa?=
 =?utf-8?B?ZG95SmRZekhmM2Zvb0h5bENMdHVKS01USFl5TC9lMWFCUDlHZ0U0RWE0Z0J3?=
 =?utf-8?B?VnVTWWVVVWtvbU1xam9YM0lQZHZnRHFUUTUzeXhqbWJkL0VRazNYV21tb1NX?=
 =?utf-8?B?cmxCbXllb0VpK1hJeVhqVHJZWUR5NG1pSDVaT3pXSmxZMFovbCs2aXZleVA3?=
 =?utf-8?B?WVN6WFFLbSs1cDFnakNNUi92eWFjY1BuK3hPOHJVN1NkQWppalowdU5KR1dE?=
 =?utf-8?B?U0lWRFRxYWFpTGZjbUM2ekVOZXlON1hHckRDVE51TXlqTGdlVEdNZU9MTjZ1?=
 =?utf-8?B?czhnTDlpSWFIRXloaEttNXU1UHk1dVJmREtYamwxTXBGdFRwUER2R1hpcjN3?=
 =?utf-8?B?S3dXZjQ3SGNtSm9oeERGVVBnMTRtR0UxZTdwOFdTQlJocHl1Ymo1dFozWlRW?=
 =?utf-8?B?Wjl2WTFmMWYwTytTVjBXcGxuOXBuMjNYMnFBQ0lnWmZwUy9RNGk1SEF3SE9R?=
 =?utf-8?B?ZTJPSExUUFRLWG1jblpaaXNmZ0tEc0dqb0ZDZEFlUEp1V3RJUmNIK0VZb1lQ?=
 =?utf-8?B?ZmJzNXlVYTgyYmRDa2t3T21CdHVKcUJOTjV6TnE3MzBncnJsMzUvZ2ZBTG5a?=
 =?utf-8?B?MzJiN1RiT3Z4R1dtdjVSY3poSW5Na0o4ZFRsSW9mWHM5TXBRRkp3K1I2c3RD?=
 =?utf-8?B?QnhIYklINTI2T0kwTlJJaisvdjNwZFNNL01WWGRtOW5CcHphazN5aGp2ay9T?=
 =?utf-8?B?OFREVThicUxhVDFBZUJ1R05rczZkVUlSR1hpQ283QWIycVVVQXRBM2FKMDBE?=
 =?utf-8?B?VWRIS3BOZ0N6Y0E5NlJEMlk3ckRHdUgyVEtuQlIrbDlGQ0pNZmdmQXlheWty?=
 =?utf-8?B?MUkwUythazM3VkxqRnAvNEZGZzJFLytOYWtFT1VBY29SNTBabUVrb1VmQ3Bp?=
 =?utf-8?B?MU5GWUdkTm5wckFpQU0yUDFNUm5YQ2c3Q0cwU0xSMnpMQ2Q2ZWpMamFoVnpQ?=
 =?utf-8?B?RVlNaGJvRmZHcWljVUEzM25leTNENndIKzlrZE9BV1VaZUphN2tSaDI2TC9o?=
 =?utf-8?B?YUFqaGExcENzbVE1eUJiK1RhOGRjWlNvVnh5Qm5sRE1oS3Nab2h5TmZkZ1h3?=
 =?utf-8?B?TWZMUFFFNSt5TVRZVm56K3ZUWnFKVFBkU1JteVVXL2hOMlR0M0JEZVVPd21v?=
 =?utf-8?B?OXIvWTFaNlZ0dHpmRWJQbUJ0V3VpMHl3dTc5UDhOWlkwbmJKdlp3SHpFc05a?=
 =?utf-8?B?OGJPK2FvekowQVhyS0ZXZ3RCN2hKL0RnUktFNHNDZThhd3ZYL3duamFxZlUw?=
 =?utf-8?B?Vk9EMmxNQ1FLNGIySjhZaGZkM3prVmNVYlR6STFWWWQwd2xmY3dHZ3FQb244?=
 =?utf-8?B?dlE4Rm9wS1hRUXFhZTh3YWlQaXhJNEx2eUF0dG5tREd3ZG5LRkJaK0hwZjJM?=
 =?utf-8?B?LzMxZ2dGdy9vWU0xQnl5Yk11a0NtOFd6MVRFNlRrWmxCS2dDMW1aZGhPWVRV?=
 =?utf-8?B?RFdwbWtENitHSmNrQjdXcnpoU2xSaTdKN0s4SUJ1YzJvWmhUd2Z5U2xJM21E?=
 =?utf-8?B?ckhMVmg2c2VmWWdyNEVJMkVyTFN1SE9CYzZiNVFYY2t1c0pDS3FGWmhsM0VZ?=
 =?utf-8?B?cDFPK1BCVFFRaXVuKzBjOU9SZ2RvTzJVQWtXOVB4dWNDQ1NoNGJEQ1NnUUpU?=
 =?utf-8?B?QVgzQkZ5Yk1tdlJ0L1RkclRrOEV3ckhGSnlYVkVKWWxYUmphNDlDL0VlcFZV?=
 =?utf-8?Q?3jkamtbaxVqvsl6k=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a1539b-183d-4c71-34bb-08d9ab664233
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 14:09:53.6267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWsgPREW8jVOLaJyKECvZzqKDSCLFuT4PEL+kfOAHf2VTG2rIvW18JxgltqER+wdw8MOnvn3Huw78yoPMYxDYggRi1c0M80G8JP0Dv8QiX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4735
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19.11.2021 12:13, Ævar Arnfjörð Bjarmason wrote:
>
>On Wed, Nov 17 2021, Fabian Stelzer wrote:
>
>> In certain environments or for specific test scenarios we might expect a
>> specific prerequisite check to succeed. Therefore we would like to
>> trigger an error when running our tests if this is not the case.
>
>trigger an error but...
>
>> To remedy this we add the environment variable GIT_TEST_REQUIRE_PREREQ
>> which can be set to a comma separated list of prereqs. If one of these
>> prereq tests fail then the whole test run will abort.
>
>..here it's "abort the whole test run". If that's what you want use
>BAIL_OUT, not error. See: 234383cd401 (test-lib.sh: use "Bail out!"
>syntax on bad SANITIZE=leak use, 2021-10-14)
>

Hm, while testing this change i noticed another problem that i really
have no idea how to fix.
When a test uses test_have_prereq then the error/BAIL_OUT message will only be printed
when run with '-v'. This is not the case when the prereq is specified
in the test header. The test run will abort, but no error will be
printed which can be quite confusing :/
I guess this has something to do with how tests are run in subshells and
their outputs only printed with -v. Maybe there should be some kind of
override for BAIL_OUT at least? Not sure if/how this could be done.
