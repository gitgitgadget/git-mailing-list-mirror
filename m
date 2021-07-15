Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDCCC07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 08:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC566128D
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 08:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240526AbhGOIv0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 04:51:26 -0400
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]:9794
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229620AbhGOIv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 04:51:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+roG7LgYJT9KoiZHn54Uo3DlZd4u+BfvROJ+Xw31yODBkScNrRu0hZY8pCnlwHZI7i6fVyO9GRpWlH1ExVYREhjCPijwUZ86wfa8MOA+0dHLRQrZT3Hb/3d5I4S8RU0BCmnpegSR1D5z1nlrCvR9o3f1O3X5uCA6y8C6OV8xUVndPSFILcXpwzwZC/kYv/GA37MWHVaB7QB8qT88hONLbfTXTPAVZ451CPgBpMWMiqbR2NhgK1bqGseerwk6B0B9/xv28J3haUeuSolVL3aTmIcTU5LsdNyjLLe2EiiYNNx1bi+xZg9Izl8iCqH1I8hHoOwKKDEkJ66ItDxBw0ZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffoujuX42VVQvUCnXC9T2VfsRsUbdPfNEgc61Ra05Jo=;
 b=eldhRxi/o92WfdBUoMDZos182rqLfj2PCQ9skllxcT+z8iR25T/tAjd8hQ41h4HrfULHcLDzmaUxNbffsTdcQFri6j5Pf7M2qx5GUVH4kr84dquhCIfvZD66sguEzgxcIajvjLdyMNTHf/ZobOMinz5Mh2BmrUViGgftNesmvp0+jfsqzo9BviSeoKrL6ro96CPE8atIJzENRqMwUsPNrTzNudoQKjb6m4HOkZGbBAQRERyjRKU0ASdRNH/+E4gBNK7vTYYbuRZNfpyFtcY8zYToqlO930qzZdgbPVhQLn+OMFOjoLY/rLzdWBOqAZI8zZyvPQKg8Z0ucaVahrVdHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffoujuX42VVQvUCnXC9T2VfsRsUbdPfNEgc61Ra05Jo=;
 b=KXtAc2Dxxhr+qLdG8ASJ5cD+8I82jG8qJ9i1CuMHXdFrvOI8ZcWXNU1WtWZFlBYX20/J79Txq2SpuP95LCUVIoVWjfqep+HtTfBn9M5V7DeItApttodTiSIQ6yg9Zwk7gyfRk+AvUoSOF2mUqZPPXxIZH96WdRa74NH+SOsMd+o=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4126.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 08:48:31 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa%4]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 08:48:30 +0000
Subject: Re: [PATCH v3 2/9] ssh signing: add documentation
To:     Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
References: <pull.1041.v2.git.git.1626092359713.gitgitgadget@gmail.com>
 <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
 <2f8452f6570b1811682863441020a6e43fc556c7.1626264613.git.gitgitgadget@gmail.com>
 <xmqq35sgwtga.fsf@gitster.g>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <cf9aaa48-ea49-e3c2-9909-486d9a3f7aac@gigacodes.de>
Date:   Thu, 15 Jul 2021 10:48:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <xmqq35sgwtga.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM9P195CA0029.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::34) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8] (2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8) by AM9P195CA0029.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23 via Frontend Transport; Thu, 15 Jul 2021 08:48:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a30a279d-2c3d-4c21-ce97-08d9476d5234
X-MS-TrafficTypeDiagnostic: PR3PR10MB4126:
X-Microsoft-Antispam-PRVS: <PR3PR10MB41268EFC737AD064B5B06F4FB6129@PR3PR10MB4126.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WGiiXpKOzaLaQ7kFzLPLebWFzDsIENnE+487A975eIjO8oXwM8owLJEgbrudHvmYdHjY2tDtGb5cjckmEg21NhmHn3N74GaPGaioxfHILzwJG93MYtAhAmTNp6pei6vYsORzopY1rXtxCX9kB5rHLaSG3qIgW8vQpsqHoF3Uos53v9gNJ+5JhgExTHWsZxQvPek1YtfTeYoLKH1HTw2rQi40cyW+3iWCgaHFQ76kij7H72ySdz24Ye8jEYX/BjFsAoc1dOspbG09z6jjnrE94brnPFitsJxrAH0149/2xLpJJcV/LF6P8Qcm5TxUW21sfuR6UAkUCiwUtmIjDf2t9i13y7LtIuzfFWybVI/lH4eN4qoL6iVbJtca9CR83FQ8/29vYrp4QQ2f32d9ILvNEtLX4DBXs+O22mLPlrCsUmhnuuG7CdcuhDX5MNnFHawVtFIBM35HJsswC//4wSBHjp07yd0ki/6CPIB7EHIzkdYzsY8Ic/FP+q4S6iwtCA513BjlPxfSMhKfNVuB8ms6qnXT16UuJ9DQP8psKzlcTzoAjbgoNloU9eX1xQymcY7iUdFumZWiH2nnBcKtZJImjxfnW5BA4MGhhKdFBdbu/c+BqwI7f2Vo4Akgb5yian1s9zynowEVTFeJUH3ZNc4l5tEdc8l4b1iny7bV8Xw2hfYX++SxeDclYulzb8141hacScdWGrqOvhxE8Ed8TK2pZUumSKYm5i0LrSuIhPJe/subc8b4VmWlz2E2W+5iEOknRfmYbQ+gBQu053FQmiPp0d8sS0vu03dxMOcFhmNFBO4mNfa8LgojsgP/aULyleZECjpwP4P9+3kz5XGqUusAzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(39830400003)(136003)(376002)(366004)(396003)(31696002)(31686004)(83380400001)(36756003)(7416002)(2906002)(6486002)(478600001)(8676002)(316002)(2616005)(66946007)(38100700002)(66476007)(186003)(86362001)(5660300002)(52116002)(66556008)(4326008)(54906003)(66574015)(8936002)(15974865002)(53546011)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVIrVlZNV3IvbnhaSzlZcVNMcVRFMFJYNGhBWXM2UGswbmQyc2l6Y0lXYy8v?=
 =?utf-8?B?WGJyZ1FtWXNjOVZ1ZXA4ZU9XeVN2ejdQK0JLOWNncTFWMUdCUks2RWo1OWNP?=
 =?utf-8?B?c0ExSVpJUTVaK2M2b2NNRFUwd29xM0dFbEU5TmJWSXlEUzFOeE90TGxLMkR4?=
 =?utf-8?B?ZzVoODl1ZWw5RFJYcSt0WEh4bmtrZGtNbDBQZ2xWS3lvbWt3cjJSVlpGTkpF?=
 =?utf-8?B?ZGY1WXpnV3c0RzVFTDBOMUJyeitFZ2tzMnpTdFpYaUpweUNCNG1KSDNUVmRY?=
 =?utf-8?B?SUNaYTlybDRSdkdiNkgxSDh1RDhKeEdyRm11N1ZzcGxKRnVKSGprM3hkRHNR?=
 =?utf-8?B?ODFQOVQ2RHYvZzFhY1R1d1JNbzlsam41Z3lZbnBBWlZzODFFMVdPWkc1c1R6?=
 =?utf-8?B?b2VUWFJWNStRTGxsc2R0NDF5SndQc1VnZUdKK2xGOFBDMG1CR3c3bGZzV0Ry?=
 =?utf-8?B?L2ZSVGJXMy9iYmI3aG5MOEpvc1pzSnE4b3phVTN2M2hSb2lvZDhjOGIyS1pR?=
 =?utf-8?B?OHBWV0lPRjdXY1VRMVNuL1E3Rm9HZzUwbFNjRmtJYjNHUTR6b3FvcisyR2J5?=
 =?utf-8?B?RUJoTWlHVnBhOHNQeVljbUZQdEs5NWhWclFBenBmQnlvbHA5ZCtFRkt6b0Jz?=
 =?utf-8?B?KzVTdzZPRmxZVXBhNHk1MUJMaVQwYzFCNXRRQWRXODFpczRiQlZWRE90M3g4?=
 =?utf-8?B?R3NBRjBTWTBvRTEvMjNmVmlMN25URzZPZmphZzlSYmlFVVY4RUsxWXBrL0Vp?=
 =?utf-8?B?S1BabkpwZDdSWHRDN2cvSHQvVG1aOVZTeGx3UllFd2xOTUl4T01LRHlEM2xI?=
 =?utf-8?B?alQyRGxLRlUrU3N2dnJBenJydFpmM2RJUDBDZlM1TndpM1QvNElpVGhQZ0RB?=
 =?utf-8?B?eXMzanQyVkFyaVJQSDJHRi9TQk5VdlY0Tk9FWHlidXRLbkY1clBjeEFQeXFl?=
 =?utf-8?B?azdjK1pHMkhGRFU4ZTdISXJ1SVUrOVI0amIyMXBrZ0N4eTdNd0NpeHdiL1lv?=
 =?utf-8?B?endyYStDdHlYWmw3SnhzSE85SVh2amlsbVc2bFN5cUtzVHNaSlEwdkVDSUFZ?=
 =?utf-8?B?Q0xFR3lhQS9ibGUzQ1RqbkRRaFExaXdhVkNrZlp0ZGIxVGNaQm9SYVE2VzZ0?=
 =?utf-8?B?czFpMEdRRUlmYURqeHZZR2J6ZHlCZlBaekkvbzJ2TmsvTWhOSU0rUk5za3gz?=
 =?utf-8?B?c0lwcnhicVg5eXRKWU9EMGFmR1dQd3BaK3VOM2RiQXp4aWJROVR0Ty83V1N5?=
 =?utf-8?B?bHpQM0NRbXZmR3UwTk8zVFhxU2x3d3lQTjV5SUFaK0tuOUdBdWF0blYyM0Ra?=
 =?utf-8?B?bm10L0JIblBqeUlDMTk0R3ZOTlNXUXhRZGFqcVo2R0RsRVprNk0wRGtBWm1a?=
 =?utf-8?B?Y09zSVlzVTRVdytTSzlUSEVtOHBSM1p1YkNPdHdRU2JqU0lGOU9ON0xwTW5Q?=
 =?utf-8?B?UFN4b2Y1aW00a01udFpNSkZOUmozWVcwYjU2ckVkcS9xWWRIZnRnbjlPdVVa?=
 =?utf-8?B?dDJiZVd6UDIrb2dkMHdPOXh4SDNPMWpnN1J6TVVXZ1JsMVZnSEFtYm8xL0tm?=
 =?utf-8?B?ekhGb200ajFXZ0RDdWhhMy9VbnBKVTM1bTd1LzExRFNqL1ZocDVjaE5VV3Jz?=
 =?utf-8?B?UDJyM21CQTZQOFlBeFhNOWNvWitKdmtFWjJ1MGpRVmgxWUk0NjQrMUJMaStY?=
 =?utf-8?B?TUs2WXhGUGhiaVAzRHAvK3gvWjRnYXVyRHVYZWdpajAra3F1ZHROVWJEbnps?=
 =?utf-8?B?UGUxc2wyUTVvQXJjSXF3UWhhMlJuamVsUHdIanNRN0tyKzh2YU1uMHhhL2Rn?=
 =?utf-8?B?UkMyN042b1puaGIrYkhLalg5UU50STY5WTd2ZHdKb1hNeHoxNFhiaTRDYVNP?=
 =?utf-8?Q?AieKP5sNxpAUo?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a30a279d-2c3d-4c21-ce97-08d9476d5234
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 08:48:30.8344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdSLU6ekd4ilcN/ZUeN08P7oNKiqBdFCt/aM2dnzLsXJo6Hok9+NUFyagFspDfeHCG0RZtH27qSmVsxtww+5PfA5+/fQ1vuzwyBQLdWn7hI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4126
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 14.07.21 22:07, Junio C Hamano wrote:
> "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Fabian Stelzer <fs@gigacodes.de>
>>
>> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
>> ---
>>   Documentation/config/gpg.txt  | 35 +++++++++++++++++++++++++++++++++--
>>   Documentation/config/user.txt |  6 ++++++
>>   2 files changed, 39 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
>> index d94025cb368..16af0b0ada8 100644
>> --- a/Documentation/config/gpg.txt
>> +++ b/Documentation/config/gpg.txt
>> @@ -11,13 +11,13 @@ gpg.program::
>>   
>>   gpg.format::
>>   	Specifies which key format to use when signing with `--gpg-sign`.
>> -	Default is "openpgp" and another possible value is "x509".
>> +	Default is "openpgp". Other possible values are "x509", "ssh".
> Makes sense.
>
>>   gpg.<format>.program::
>>   	Use this to customize the program used for the signing format you
>>   	chose. (see `gpg.program` and `gpg.format`) `gpg.program` can still
>>   	be used as a legacy synonym for `gpg.openpgp.program`. The default
>> -	value for `gpg.x509.program` is "gpgsm".
>> +	value for `gpg.x509.program` is "gpgsm" and `gpg.ssh.program` is "ssh-keygen".
> Again, makes sense.
>
> Once the dust settles, we might want to move the hierarchy from
> gpg.* to a more neutral name, with proper backward compatibility
> migration plan, but there is no need to do so right away.
>
> Below, I'll ask many questions.  They are mostly not rhetorical and
> questions that you should anticipate readers of the documentation
> will ask (hence, you would want to update your documentation in such
> a way that future readers will not have to ask for clarification).
>
>> @@ -33,3 +33,34 @@ gpg.minTrustLevel::
>>   * `marginal`
>>   * `fully`
>>   * `ultimate`
>> +
>> +gpg.ssh.keyring::
>> +	A file containing all valid SSH public signing keys.
> Is "SSH public signing key" the phrase we want to use here?  At
> first glance I mistakenly thought that I maintain a bag of my keys I
> will use for signing, but from the mention of "authorized keys", it
> apparently is the other way around, i.e. I have a bag of public keys
> that I can use to _verify_ signatures other people made.
>
> What do we exactly want to convey with the phrase "all valid" to our
> readers?  Even if I have a valid SSH key that I could sign with, if
> you and your project do not trust me enough, such a valid key of
> mine would not be in your keyring, so the phrase "all valid keys" is
> not all that meaningful without further qualification in the context
> of this sentence.  A file containing ssh public keys, signatures
> made with which you are willing to accept, or something?
maybe keeeping the name "allowedSignersFile" like its called in the ssh 
manpage will make this clearer without needing a lot of extra explanation?
The keyring name was suggested earlier to make this consistent with gpg. 
But it really is something different from a gpg keyring.
>
>> +	Similar to an .ssh/authorized_keys file.
> It is unclear what "similarity" is of interest here.  Similar to
> authorized keys file, meaning that presense of this file allows
> holders of the listed ssh keys to remotely log-in to the repository?
> I somehow doubt that it is what you meant, but then ...?  Did you
> mean "Uses the same format as .ssh/authorized_keys file" or
> something like that?
I meant that the format is really similar but i see the problem. I 
wanted to explain the format (which pretty much is just one ssh pubkey 
per line with a name prefixed to identify the key with) so that users 
don't have to look into the ssh manpage for a basic example. Maybe just 
provide a short example of the file contents?
>
>> +	See ssh-keygen(1) "ALLOWED SIGNERS" for details.
>> +	If a signing key is found in this file then the trust level will
>> +	be set to "fully". Otherwise if the key is not present
>> +	but the signature is still valid then the trust level will be "undefined".
> I tried to look up the "ALLOWED SIGNERS" section for details, but
> failed to find what "trust level" is and how trusted "fully" level
> is (is there higher or lower trust levels than that???).  Or is the
> notion of "trust level" foreign to ssh signing world and the readers
> are expected to read this description as "listed ones are treated as
> having the same trust level as 'fully' trusted keys in the GPG/PGP
> world"?
SSH has nothing compared to the gpg trust levels. Your key is either in 
the allowed signers file or it is not. However even if it is not in the 
file then the signature might still be "Good" but has no matching 
principal to it. To be able to differentiate the two "Good" cases i used 
the existing gpg trust levels. This way if you set gpg.mintrustlevel = 
fully then the signatures with no matching key in the allowed signers 
file will fail to verify. Otherwise they will verify but show a message 
that no principal matched with this key.
>
> I suspect that the section is only useful to learn the details of
> what the file looks like?  If so, perhaps instead of saying that the
> keyring file looks similar to authorized-keys, be more direct and
> say that the keyring file uses the "ALLOWED SIGNERS" file format
> described in that manual page (i.e. bypassing the redirection of
> authorized-keys)?
>
>> +	This file can be set to a location outside of the repository
>> +	and every developer maintains their own trust store.
>> +	A central repository server could generate this file automatically
>> +	from ssh keys with push	access to verify the code against.
>> +	In a corporate setting this file is probably generated at a global location
>> +	from some automation that already handles developer ssh keys.
> OK.
>
>> +	A repository that is only allowing signed commits can store the file
> "is only allowing" -> "only allows".
>
>> +	in the repository itself using a relative path.
> It is unclear relative to what.  Relative to the top-level of the
> working tree?
>
>> +	This way only committers
>> +	with an already valid key can add or change keys in the keyring.
> OK.
>
>> +	Using a SSH CA key with the cert-authority option
>> +	(see ssh-keygen(1) "CERTIFICATES") is also valid.
>> +
>> +	To revoke a key place the public key without the principal into the
>> +	revocationKeyring.
> All of the above unfortunately would not format correctly with
> multiple paragraphs.  The second and subsequent paragraphs are
> preceded by a line with single '+' on it (instead of a blank line)
> and not indented.
>
> Mimick the way the entry for "ssh.variant" uses multiple paragraphs.
I'll take a look, thanks.
>
>> +gpg.ssh.revocationKeyring::
>> +	Either a SSH KRL or a list of revoked public keys (without the principal prefix).
>> +	See ssh-keygen(1) for details.
>> +	If a public key is found in this file then it will always be treated
>> +	as having trust level "never" and signatures will show as invalid.
>> diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
>> index 59aec7c3aed..b3c2f2c541e 100644
>> --- a/Documentation/config/user.txt
>> +++ b/Documentation/config/user.txt
>> @@ -36,3 +36,9 @@ user.signingKey::
>>   	commit, you can override the default selection with this variable.
>>   	This option is passed unchanged to gpg's --local-user parameter,
>>   	so you may specify a key using any method that gpg supports.
>> +	If gpg.format is set to "ssh" this can contain the literal ssh public
>> +	key (e.g.: "ssh-rsa XXXXXX identifier") or a file which contains it and
>> +	corresponds to the private key used for signing. The private key
>> +	needs to be available via ssh-agent. Alternatively it can be set to
>> +	a file containing a private key directly. If not set git will call
>> +	"ssh-add -L" and try to use the first key available.
> Thanks.

-- 
GIGACODES GmbH | Dr. Hermann-Neubauer-Ring 32 | D-63500 Seligenstadt
www.gigacodes.de | fs@gigacodes.de
Phone +49 6182 8955-114 | Fax +49 6182 8955-299 |
HRB 40711 AG Offenbach a. Main
Geschäftsführer: Fabian Stelzer | Umsatzsteuer-ID DE219379936

