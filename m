Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C997C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 15:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1512D61C1F
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 15:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhGFPsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 11:48:23 -0400
Received: from mail-eopbgr50061.outbound.protection.outlook.com ([40.107.5.61]:10213
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232145AbhGFPsX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 11:48:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7li1G03hi2Rh4tPZ5dh59IHgoverPdjQV/SdpvlTTgmiJ3W+8n7JQ8DRRcl+4FNE45ZJE3IpySyymCitBeb+UoL4wfTv0aglrQ+BJc08si6ZlzZM7nHJAyJC8LNnR0Xx3WjVEyRlVKlpEcym0C6ezelzP7Pt+Pu0UOQFG2Q66/YMR+bcdUOcUjEbSXMafjr+BylM+5oeghd4BNxe6f0NXMIMTGd6PNvcfPtrTK1dBetqUmnyoBZ46IxVwKQ/ScqWS7Xmr2YdRyPge7YyAMmJvp5zqFRo8nyXB/aw5xTVoyIReLsQdVjT+H9NFXGI4pCvisNBqqJn649BepnOmzGuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=td6gTGK+94VC4XWOL7hl+r8DtZ1YzyxJnXAhD00AcMk=;
 b=B81wwhwzNIW7O3FRfRHmYF76Asae7QAx3iti2eMWvvrRNIzs1fXArPlhFGnV1e/dxx+tzaqAuZO+/HAUF1OBBvLOcj+wN9UDwIjFQwVzJOlVFJ9B8i+pWK7auUfNQc0hq50agQhyOZ9cNjXuKsN8m/2CF6VXhrnM1NEeRH411hpp8SSNpWWxshEG2dIjsESFIz3Zwt2WFo0dKsuz4GhjwR6cmDSytLHuOX1BWZ0sI6hJkhJ34mtTIifIumTRRd3NRfVKAUbOcsXfjgZLOhv7k9g5tt4DFPnabV7avumLjbmXbuouCabQL6+5MGqddliitlPU0U3TYHeJSeghyRNIrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=td6gTGK+94VC4XWOL7hl+r8DtZ1YzyxJnXAhD00AcMk=;
 b=dgCSeUVUca0ol0zZBNY+R90F+AmCtaFOUvthYVSxMl8hhx9Vm1SQc+7DCk2a9KgNhntfYhh9Qp4q1tqCb7W9maYLkuhRybRsnZKF6sFDHv9mkRP71x5qCB4CLbMgI8RC9A2PIObObHbGZ1rPpOo8L80Ismhv7Hen2Dzft02mWw8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3999.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Tue, 6 Jul
 2021 15:45:42 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa%3]) with mapi id 15.20.4287.033; Tue, 6 Jul 2021
 15:45:42 +0000
Subject: Re: [PATCH] Add commit & tag signing/verification via SSH keys using
 ssh-keygen
To:     Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1041.git.git.1625559593910.gitgitgadget@gmail.com>
 <xmqqzguzlc03.fsf@gitster.g>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <fffd8c26-f3a7-b074-f4ba-e8552ca1d7cc@gigacodes.de>
Date:   Tue, 6 Jul 2021 17:45:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <xmqqzguzlc03.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FR3P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::16) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8] (2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8) by FR3P281CA0030.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1c::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.8 via Frontend Transport; Tue, 6 Jul 2021 15:45:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4eb8f08e-a434-43c1-2c6d-08d940951ccf
X-MS-TrafficTypeDiagnostic: PR3PR10MB3999:
X-Microsoft-Antispam-PRVS: <PR3PR10MB3999870FF7D3D3ABA0B8B3F8B61B9@PR3PR10MB3999.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9TwJ5hTA+wvXJEbVpkMjPQ/xce7wTlbMCfCQHBcOQF3axWcFRTV2ksNsLNl1ai/Xtd4K/zuc0krX+DxejsP5dMpFGBsypvvZd+QTiagrxoUMz3gFdc3x0IsOyVFf/wEY0o1qjXQUoOw5V/D9N9A72pY24pSD4djks/5iNdrISsIPrMGhrOmG8GT/EHtbM2c6QV9JJNWthEdVuNnZby6eQL/UuGChd02IN6tdit2mxbKMnR9je12wMe+fKEFFi3jG/K5aOXDcbKtxjfvIamPa9ihz8QfaqUbXyjL/eUtvA/n3mjT6kKAvOrrjf6x4eVFjTr6lg84llSk2iD4mH8F5tHWVMV1Ao1pHIeaX8DYklPuQZkY/Nmim821ni5JTlBI9rtIwRFA5A+KiCKN45foFgdfpvaBXKhPySojwDK9g2jH4i6ozOMGIpL1So7nMI2nJehoF1zE/SoQUCH3H5wEUdIvQ9t64s4EKTYW9z17bn57dB6XH98s+AOJ6R9MEg9ivNWyCNFzBb2TnKN/Rr+taR1DCSjI79YrH5lg70YdsPGnRBt5L/iIKO3V9aKYi5wXml6gmaJICS9KyyJfs/8Tj01pVt0A/uq3hfeHOWIMFce5NLrfJ0EnInOB4hrac4Bpz9GmsgJWaHbkcazdhDPV9yOEa56YN6wlL/wnNMJnJz+CNNq8cRVenvg6BsJAz8OvVPE1hDhh0BIKDIXe7bWDOUJfbpgsFZBb23GwcdR5Pp3Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39830400003)(346002)(136003)(396003)(110136005)(316002)(8676002)(15650500001)(2906002)(66946007)(52116002)(8936002)(86362001)(5660300002)(2616005)(478600001)(66476007)(31686004)(186003)(31696002)(83380400001)(4326008)(36756003)(66556008)(6486002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUFUb1ptMkNYMS9MYXhDbmdkQmRzOWRSRExSN1RqTUd6M0Nxb05TM0J5cXU0?=
 =?utf-8?B?THo2ZmZXekVrRDlMM0ZKZ1hrdUZLekxFT3JHTGdHK0JvSmtoWlJRWFh4djJ2?=
 =?utf-8?B?TjA1N29jWDJFQWt5WStxaHNDakUrNXdnbHJudzVWTm9aU0N5UEJFckdjM2Q0?=
 =?utf-8?B?N0lhUzhFbW1aTmN3ek5XNGZDeEhTOG5qdDRaTk9tWnpoNjE4anM0WFBKcThD?=
 =?utf-8?B?RDBnNmNEQ01ZTStHa0kzMnhDalQ3M1VXbDJhcUZFaXk3N2ZlTmZseE8wSVUw?=
 =?utf-8?B?bnhQdVR3OE9nM3BwODJxcVh3SDkrNU9ySHR0L0xYREtJWEZmMS94MW1JdkF1?=
 =?utf-8?B?eFAyL0lGTVpUb0QzRFR6Ry9XRVcveTVNQThDd1RSWXE1cnloSTlHc1FVV0d4?=
 =?utf-8?B?T3RTVGFqUm9mQm5hMlVhU3VTQzFEdjlXT1N6UFN3dHV0YnNVWjdhdU4vNDNn?=
 =?utf-8?B?amIzc0pSYnFDakJxRmk4bGhlazYzS3hEQUNOUEpIVHVIbWh3amp1Rktaenhx?=
 =?utf-8?B?OHk4YndrZlNrc1ZCL1dXeWRic1Q0d1g5OTNaZlN6YTBMcjZCVVdtWEZSckZj?=
 =?utf-8?B?RUhBeHhrUGdIRjZEMnpZS1FuQnFrVWhiS2NGWjQ1UGZ3K3lPdjFRcmtOaDVr?=
 =?utf-8?B?NisvUkoveXg5S1ZWVWR6Mnk0aHRRbXNWZWhUeW5YQ0RWRFdhbVdFUTdrSVBD?=
 =?utf-8?B?dWVlVTRlb0FmYjRURFU4YzBzd1BWZEVuTjRGT2ZDWG0wREVjcFR2ZGVibldm?=
 =?utf-8?B?RS9zTzBBZ3MxbVFJTVZzdGFib3VEUkNTVzU0dTRyNHBNRVBnS0VqbjhteUVY?=
 =?utf-8?B?Wnh0cHhaME9NMnJ3RUF1REQrTndNTnBjOXIzQm9ZS0RQUVI5bEpWb0IxQkd6?=
 =?utf-8?B?U21jU01hd25iUVNCMXFtczNzd0dTK0xkMEVVbzRZOTNCU3F2ZmcvRTVVeWdo?=
 =?utf-8?B?dkRIMHloV05VSzFmYnErZ3VVQThBVXNBR2IzTGZCNmpGWGpuY2xxVEt1THBV?=
 =?utf-8?B?bUVTWGRJTEVyQWl6R0MyUkp4QmNjeHVTMVQ4SDVnaGhGVDR5anNDVC81dVNL?=
 =?utf-8?B?cXl5Z3BReDN5L2NhQk51WHNzK2JURmVRcVJnTUY5N01ZQkVxU1dhRmJnWWFv?=
 =?utf-8?B?a3VCOUNETmI1bTBJR2pYY0hhSnhFWWI5OTQzK24xSDBGd2pUcVFYdTFuYnRy?=
 =?utf-8?B?eXBtSldKVTRTaW5JUXAzRlF2M1J4MXdQT3BtU2pvSkU3UUQxLyt5dkovbTF5?=
 =?utf-8?B?bGpkN2xaN1cycWxGVElrZEYwcVNCK2VWMGdrR0hicXRuWjZoYzJvUHVWeEhh?=
 =?utf-8?B?YUszR1F0ckR5ZU1NaFhpdTFtYzVGOENNY0NvcUxZMHkvQXhmdXhSeTRYQ0Ra?=
 =?utf-8?B?RXJsa3BJLzFBQ0dUem1iYU5OSlBSTUpmR0JNT1JuczAzcXlsY2pFalp5THNW?=
 =?utf-8?B?L05VMWthbFdEU0Q2MzhIa3kybWlPWFRXdU45WHU3QmRnanVKUFIvYURyN3Y3?=
 =?utf-8?B?T1BxT2Vla3NXclJUTG0wQ1ZLKzFFNE5EcjEzclA1Wis4ejVKWmhabnBYcVpP?=
 =?utf-8?B?aWtIOE5ETGQxSUVoSlp6eWxtU2toUWdlcGNrQXkwYTY4YXlLRlcxL2o2dEcv?=
 =?utf-8?B?TmtDNFIweFozbjlmcy8rZEdZVnMxd2RuaDBMVS9ZV0QvQTdydVNHbnl2VUcw?=
 =?utf-8?B?anV0cHo3bWVEeVFKYUwzYjJtTFRIbnJzd0JhMHdweTBKaysrZjlkRnplWGFC?=
 =?utf-8?B?UDdCR1dRZGRFQUZNRWpZcjZzWUxYZlZGTGdqMVA3MnZ1QXRTTE42ZWZoY1Nl?=
 =?utf-8?B?eWhKcUVJTU5sRnNGNi9ndVNLNkp3Y0ZHWHJBeTJzTkFHeVFlbU4rNjFDeDlL?=
 =?utf-8?Q?EGdNtLq/MGGiM?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb8f08e-a434-43c1-2c6d-08d940951ccf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2021 15:45:42.8176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /vYZEJIzqeAMJdmfqnB0LgbMAZHVdKjkk6LGVM+LzhkfFHP3AFTYIMclGzFBK2N4y35pEne0ZzmKEjsghjWe88lYqZGs4TfpbgjivlwkaJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3999
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Fabian Stelzer <fs@gigacodes.de>
>>
>> set gpg.format = ssh and user.signingkey to a ssh public key string (like from an
>> authorized_keys file) and commits/tags can be signed using the private
>> key from your ssh-agent.
>>
>> Verification uses a allowed_signers_file (see ssh-keygen(1)) which
>> defaults to .gitsigners but can be set via gpg.ssh.allowedsigners
>> A possible gpg.ssh.revocationfile is also passed to ssh-keygen on
>> verification.
> There are probably style and coding-guideline nit people will pick
> in the patch, but first of all I have to say that I am uncomfortably
> excited to see this addition.
>
> One thing that is unclear is how the 'allowed-signers' is expected
> to be maintained in the larger picture.  Who decides which keys
> (belong to whom) are trustworthy?  Does a contributor has to agree
> with the decision that certain keys are trustworthy made by somebody
> else in the project and use the same 'allowed-signers' collection of
> keys to effectively participate in the project?  How do revoking and
> rotating keys work?
>
> It was a deliberate design decision to let PGP infrastructure that
> is used to sign and verify signatures when we use PGP for signing
> without tying any of these decisions to the tracked contents, as
> that would reduce the attack surface for a malicious tree contents
> to affect the signing and verification (in other words, "we punted"
> ;-).  Even though I am not sure exactly what you meant by "defaults
> to .gitsigners", I am assuming that you meant a file with the name
> at the top-level of the working tree, which makes me worried, as it
> opens us to the risk of reading from and blindly trusting whatever
> somebody else placed in the tree contents immediately after we "git
> pull" (or "git clone").
>
> Thanks for working on it.
Glad to hear that :)
I tried to keep the style with the existing code but the IDE sometimes 
has its own idea.

I think there are two basic options for maintaining the allowed signers 
file:
1. Every developer has their own stored outside of the repo and 
adds/revokes trust manually like with gpg.
     A central repo would probably verify against a list managed by the 
tool (e.g. gitolite)
2. Store it in a .gitsigners file in the repo. This would only work if 
you only allow signed commits/pushes from this point onwards. But this 
way a shared understading of trusted users can be maintained easily.
     Only already trusted committers can add new users or change their 
own keys. The signers file is basically a ssh_authorized_keys file with 
an additional principal identifier added at the front like:
     fs@gigacodes.de ssh-rsa XXXKEYXXX Comment
     a@b.com ssh-ed25519 XXXKEYXXX Comment

Where are commits usually verified at the moment? On every devs checkout 
or only centrally on pushes?

The signers file also supports SSH CA keys and wildcard identifiers. At 
the moment i look up the principal dynamically via the public key so 
it's just a text info of who's key is it at the moment.
The SSH CA Stuff is probably a niche use case but could be cool in a 
corporate setting. Thats also what the revocation file is used for. The 
SSH CA can generate a KRL (like crl) which you put into it or you can 
specify explicit public keys in it to deny them.
