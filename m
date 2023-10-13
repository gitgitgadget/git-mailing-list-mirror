Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81412134CD
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 20:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PEy4vuv2"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2C483
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 13:26:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJcpt7A8oPKeNOofpkqWlts96BX4tcFWlTphnXWljAkF3ozE1gjTivmYVIBnmFSDFpJKmszFro8Xiygm1WAwmxajIN3SdsM+MLirLgWONz5eHuwlWTU7RxMsJqB7TYi1qehP8ufAGkN8G9C1wg8q3ucbPErVqaymwJbKTRSovFybbr6XYMVD9sON+BYv1KanDpMUoRABO53BBCLdxViK/4Q0LtvucdIDv6ItRWMqVm+NdCUx8El7OiuSc63LRfzdaPtRaAMhJ3+Y/zoIJmZKn0CSslS/vzqC6C5+ch7Uk21rtn3zg/4tXUcI/HR0p+IZYsnkTkcZabV5GZ4k88JG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSPYy5CTsoQMfXI7528XzSjBm6vTU6nyNSznEYkpo6w=;
 b=FwdxaAja398nUCoMpuyUja6pswu2bDawAk8A/0ZpzrIhv+Vadpke+0lsvC4Lr2ul8qRdpuUPKPRyGixMsgLiG3WMBXn1CsMMslg5m7tpQBWW4lSsid4HcO/SGXIM2tnffurLHBBPJhPcSpx9FA4JTrtPDZF3mJpJUokEXK8nSNpv7dxWGGnHTTi1UNmguFHUBI+ReF1YRhNl/qpfIZMuJZEXbwwsU+zCQekwRtU5LC89U1tqrWNYB3cLEt/4B3bB/4cQ4JZ9YLabed2VtG75Vz52MxVilM4Fyj9mH85RDuV/n3YCOPLedScgNp0sBl32FSIE57XxjaeGUKz17VgBHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSPYy5CTsoQMfXI7528XzSjBm6vTU6nyNSznEYkpo6w=;
 b=PEy4vuv2T6TdXLeXmKkMf+bDWqRv4xBhAzBp6A9FyMWRxbxmD0yTpu0MGyXCeP2kgwyPXQa5dK1vdcJWd+JYmWC7Y5nm+In52XNz8gc3/gqy9J/XxOlHTntKPW3Iw0aCE6L25SSa0VUhyMqwxh5E97tqSJqZiUtK/kEbOI+Ly98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 20:26:02 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::1cfd:3535:273a:8097]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::1cfd:3535:273a:8097%7]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 20:26:02 +0000
Message-ID: <b4385543-bee0-473b-ab2d-df0d7847ddf3@amd.com>
Date: Fri, 13 Oct 2023 16:25:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] send-email: move process_address_list earlier to avoid,
 uninitialized address error
Content-Language: en-US
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Todd Zullinger <tmz@pobox.com>,
 Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Taylor Blau <me@ttaylorr.com>, Git Mailing List <git@vger.kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
References: <ZRE6q8dHPFRIQezX@debian.me>
 <20230925080010.GA1534025@coredump.intra.peff.net>
 <ZRGdvRQuj4zllGnm@pobox.com>
 <20230925161748.GA2149383@coredump.intra.peff.net>
 <ZSal-mQIZAUBaq6g@debian.me> <95b9e5d5-ab07-48a6-b972-af5348f653be@amd.com>
 <7e2c92ff-b42c-4b3f-a509-9d0785448262@amd.com> <xmqq1qe0lui2.fsf@gitster.g>
 <20231011221844.GB518221@coredump.intra.peff.net>
 <xmqqzg0oiy4s.fsf@gitster.g>
 <20231011224753.GE518221@coredump.intra.peff.net>
From: Michael Strawbridge <michael.strawbridge@amd.com>
In-Reply-To: <20231011224753.GE518221@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN7PR06CA0063.namprd06.prod.outlook.com
 (2603:10b6:408:34::40) To DM6PR12MB4356.namprd12.prod.outlook.com
 (2603:10b6:5:2aa::8)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c0306b1-0ae4-4e2f-83d0-08dbcc2a9e70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V0qEEnjCkJFEJVcNKVbOIPQ75tZPCW1kOFADcIh57mY070Ii0YjeZvLgBcgTjbUo972O1+FRsw1CjhOCY+084KL3Y43egqYYqb+vlnGuU2ikefGivrG3WHMN43wNPwEYZ/0mKkrUxmR+Otv+udp2jttIWxhErhgYEbZl5NmOWbQp+yWYH/F3DcYPiziTdvVmpHpaTC4GvpKTB3BECgwOE0AnjM9kZA9fLM51kwMtar9fhCzzJWT2GDX7U3srW+QaqWu5JZToN75tUOjysu04NfHMD+Ev1UUqwq9RAln8q4RdiEfYEWKaaut4I3iFJtJVw2c/ns1P9lWWRABSpjopmw4qw3n9QGuJmv0dkZ8PoBZW4YZ9VGjvoPJ4Y8TmQZSJdTR0twM2y2ekw9A45qri65Iq0OtT0D3MgnpUdDAa+MVC7iqZ2D6b/XELegQsdzhksnHL5kX2HxAXkEK5TFVesWsuG4jC6VaN9/j625lBVrYQGWZas+1RJMQQ3XO0rJpyxvTi69iSw8YnU2BED4daTbVrPTy6CBz8NaAkj/kIKrJepnrHrCLo1HDF9ZGUfZtsTIu+uLiVrHtgOpuf+h1FAaJ+bLPE8wbZ6WoeBETE49qQXxbjXXDZsFZeo+Pi0yLC3FKpdJyxjeUo5qv4MbbjZA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(36756003)(86362001)(31696002)(31686004)(316002)(41300700001)(66946007)(66556008)(54906003)(110136005)(38100700002)(66476007)(53546011)(6506007)(83380400001)(6512007)(6666004)(26005)(2906002)(6486002)(8676002)(8936002)(2616005)(478600001)(4326008)(5660300002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkxZTjRIdjYySmJkZVlveWNGWWtvQ3FVbmJvQkRmUkQwNWlCQ0l1MVJKSkJJ?=
 =?utf-8?B?eDcrSy9IU3p0UHNWM2VQZzlNVHJHSDgxSGFUWHRjNzZTRjBJc2FXNFBSbVFH?=
 =?utf-8?B?b2QrTDBwQzBRdGp2NXhqRFZadm9XUDYxQW16bGtjQTNVK0d0aGxCNTJKQkQ3?=
 =?utf-8?B?RlN1bzYrZ25WYXFTL1dWT3d2Mkg2OXBoZnBHSVlGLzVzQ2Z3SElKNzF2RVYy?=
 =?utf-8?B?N0tjeDV4Sm5oS0VBdUhZeUtRcEMrYUtabmJaVVBpM2UvcVVLN1p0djJHdG4z?=
 =?utf-8?B?YXR6TGhmVkk4NWlXL096NGt0TkMxbmFNTzlJSlhmWXF4ekRNSEtnVExzQjZP?=
 =?utf-8?B?YXVobFNVanJMTlQrV0VUbWxSclZ4Z2twSURIUWFiVE1YNEsxL0tycHdLbnRp?=
 =?utf-8?B?ZUluODhNc0hRZ3dMZExjYmVHM0UraDVOV2g4U20zMThFWWFnbXc5VzhBd2FS?=
 =?utf-8?B?eW5DZWsvZ1piUjBySkQweFc4NGQ5TDNMSStiejlqSFNQN2lXVzI2ZjFhQU9n?=
 =?utf-8?B?dmxaZDZ5V0hBbHhFaVNIV2ZtbEhUTGt3MytJOUZ3bVdvbXk2RG9zVFdQZzFH?=
 =?utf-8?B?cTh4YytGaTZqWmtQQldGaXUwbXJ5Q2wweG93elluWjVPOGJtdWt2eTdjUFFT?=
 =?utf-8?B?QlBJU0ZLZmtpMVBVRG1GdXlzbG91MndLcnYxOGJKZDFBKzIyT0RyMlZRQ0lR?=
 =?utf-8?B?elpNa0RERTVORWFTdlNKeGpzWlNaMmVTK3V6NkRPeTJya1ZqWkgrbDVGS2Y3?=
 =?utf-8?B?ZUlLVU5GeCtNTHhmOTlwUmxYaDRGSHdHUTlDUXkxWHdad2RyT3hjaTR6a2dG?=
 =?utf-8?B?OGNhTXRCeEdVeXNPM1NESjNNanQ5eEVwNE1McjlEcFBUTS9qQW5Xd3hsenBZ?=
 =?utf-8?B?SEcwVy9zdEQ2Z01KMFluVEsvUmh3QWVEdS9JaGxxNFVEYndGSWZlTk5VejhL?=
 =?utf-8?B?TmdXd0oyNElGeCtRWE9VR2h1WFVFeFhMMk5HYXo2Q3pJeDJzRkxmQi9rWXgz?=
 =?utf-8?B?djFmeWcxTHpiSC9rTytNaklGU2VGNC9neHRsVXRzMEVWMmZSaDM4STNFV09z?=
 =?utf-8?B?c2FDS096ck1JUlk4U2pWWEh2Z3RwdS9EOWgwbU5seWFKc01KTnp3SFVFbGhG?=
 =?utf-8?B?aTZqUjkrOU1UZjB5NndmWW1aN2Npclkza0REWTZxVHc5NlF5MklCc0JwWnBS?=
 =?utf-8?B?Sit3VHhqaDUwRjlMQUlybWVmSmdsZkRBZXo1d1pFSTNZVEpqaXNQOUVnbGgr?=
 =?utf-8?B?UUt3NWY1aStMbHBqR0dhTGJMOWc3Y2R1Y1FoZWFWWTg0UDBPOW02QUkzL2Q3?=
 =?utf-8?B?a1ZqOEJKcXRnSFFYUnFhNG5GUkd3UVllc21sUFRsQkJuSVFtOThocHFjakJT?=
 =?utf-8?B?TzNLZG9XN1ZQajJYSlBjYkVCZWZEdDVxN01DQS9LQmJmdFBuODZHZDU5MjZY?=
 =?utf-8?B?VkVZOFNkczluWEdRR0JleGNBSnpCUk9qeEhnMUVSdlNLU25LUkRLYTZlUGlE?=
 =?utf-8?B?VTErV2d2STF2cDc2ay82a0FGeXBwZmJUQzVkcWRpci9MZXlpL2hIS05vQ1h2?=
 =?utf-8?B?SmE4cVhIV2tSTXpIdkVuRTNCSTE4eGZDZGNoamhPcGxQWnZrYTFrSVFWK2Fu?=
 =?utf-8?B?eCtXVGo4aUE1b2haMU1rR21UbDdhMUNML3c2UFMycG9OYzBoTlA1bHQ2dHVL?=
 =?utf-8?B?T3dXdjk3ZFFJMWpESm40aHMyN3p3dkhGTWMxVmw4MHQwZWMrYmhnckFNYkNW?=
 =?utf-8?B?alVrajgrUzgxMGRBanE0YjBSeFo3QzZmbGVWcTA0V1dENEdXZ0g0S3hqSER5?=
 =?utf-8?B?ZkgvNGJLemNRc3duVVFBSmUyM0hxRmRBYTNib0o4bjBlRTZ2bk5PcWY2MVlL?=
 =?utf-8?B?b1lNcEhNZ09hbHBkT2UxOEh5SHl2aEUwZUVzZ3RubnVtSTFOMDZLK0NybzVR?=
 =?utf-8?B?SmpwODFCekhXU2ZUZ0ltMEN4RkNhdXZOQnVpOTI0OWhVV3d4SUYwSHlyYnNV?=
 =?utf-8?B?dVU1ZVhFZDZwUHFSQ2JQSnIvd2JHOTdQdCtEb3psTEVHOUZ6OVZwYkl2MERL?=
 =?utf-8?B?Y0JkaUc3UG5lWXRpd2hRTDNWSkJvS1Y5OVFlYURIdTREOU43Mkh3S1I5NTVG?=
 =?utf-8?Q?GrUYUm9upKXnEcmu7Yp71hmVy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0306b1-0ae4-4e2f-83d0-08dbcc2a9e70
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 20:26:02.3827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TK+4+omJorbUMu5TzNBURCj/w19+fVpwk4d9pXUdoxNoTcrASSV+Ekou9XkB1M0vQ/VBRMV0pBocixtWw4AFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 10/11/23 18:47, Jeff King wrote:
> On Wed, Oct 11, 2023 at 03:37:39PM -0700, Junio C Hamano wrote:
>
>> On the other hand, I am not sure what is wrong with "after the user
>> typed", actually.  As you said, anybody sane would be using --to (or
>> an equivalent configuration variable in the repository) to send
>> their patches to the project address instead of typing, and to them
>> it is not a problem.  After getting the recipient address from the
>> end user, the validation may fail due to a wrong address, in which
>> case it is a good thing.  If the validation failed due to wrong
>> contents of the patch (perhaps it included a change to the file with
>> trade secret that appeared in the context lines), as long as the
>> reason why the validation hook rejected the patches is clear enough
>> (e.g., "it's the patches, not the recipients"), such "a rejection
>> after typing" would be only once per a patch series, so it does not
>> sound too bad, either.
>>
>> But perhaps I am not seeing the reason why "fail after the user typed"
>> is so disliked and being unnecessarily unsympathetic.  I dunno.
> I did not look carefully at the flow of send-email, so this may or may
> not be an issue. But what I think would be _really_ annoying is if you
> asked to write a cover letter, went through the trouble of writing it,
> and then send-email bailed due to some validation failure that could
> have been checked earlier.
>
> There is probably a way to recover your work (presumably we leave it in
> a temporary file somewhere), but it may not be entirely trivial,
> especially for users who are not comfortable with advanced usage of
> their editor. ;)
As I was looking at covering the case of interactive input (--compose) to the fix I noticed that this seems to be at least partly handled by the $compose_filename code.  There is a nice output message telling you exactly where the intermediate version of the email you are composing is located if there are errors.  I took a quick look inside and can verify that any lost work should be minimal as long as someone knows how to edit files with their editor of choice.
>
> I seem to remember we had one or two such problems in the early days
> with "git commit", where you would go to the trouble to type a commit
> message only to bail on some condition which _could_ have been checked
> earlier. You can recover the message from .git/COMMIT_EDITMSG, but you
> need to remember to do so before re-invoking "git commit", otherwise it
> gets obliterated.
>
> Now for send-email, if your flow is to generate the patches with
> "format-patch", then edit the cover letter separately, and then finally
> ship it all out with "send-email", that might not be an issue. But some
> workflows use the --compose option instead.
>
> -Peff
I have been looking into handling the interactive input cases while solving this issue, but have yet to make a breakthrough.  Simply moving the validation code below the original process_address_list code results in a a scenario where I get the email address being seen as something like "ARRAY (0x55ddb951d768)" rather than the email address I wrote in the compose buffer.
