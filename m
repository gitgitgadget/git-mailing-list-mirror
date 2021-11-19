Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2447C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 09:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFA7E61A86
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 09:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhKSJLA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 04:11:00 -0500
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:26113
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230526AbhKSJK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 04:10:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6268t3D363KYm2YuemOodqIBdn7ZcPFcvvFnNu4huTwAM+y9gNrybZo2AUhVbGbi1t/7TfpSDm8pm0BykmovdpWrGK8l2fqiL+ZxKuifWIq6uWbZVM0GcT3LBZYFuQB+S/Llw7FQMFMQMN8gSHAqGNF6qpFG9ujTp0wryxnlCr+YLh4JKc+9PKBRUi8zoyFs0LOoGdJFEcVWC2A+u3TdZxiMKgYWpgUOvDJtiucQ63ZYDL8sjsj2pWvG9WIgYMNYP4SFj9zucdHu6nqsbNJ0O3Fl7l/XP/VN6xVr9T1iJGhX/cCVogwb2frJbAH/xjag8ARb91GLmOSLfRTQi8yQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfWo8GFat6Re9jO5eigJTlH4Y5pTi1vB6AiGzv27r/Y=;
 b=lHmnmesV2It7gfmMPltUPB6I6FFT52Yey3NZ6t4183dXCiR78wqyeiRxbXsULi2QYbsc5ulnG19Dh15ds6uRxBlz1ppDlzxk8sBtry6sfMkVDtLJnK1XrbEuAQarm/EoFb+6do61OsSxeVOxewCopA2MhWWbY6q2cgmnVtFFsPC7SeUmD7DOLpvJrm8JmnMuBGWyngljzfdgK7aIlO3VlifZQ7iP6RukO8G12cSLG155jCjnxKbt/CeoNG64Igzx67s/cbwePKe8w7wBwQBqkIFg+SO1lEogo6ZlfMzSdA0wXS9SRuMaRhnbQlWfSyQvhSpqHhvQkesVKN2CpXD/bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfWo8GFat6Re9jO5eigJTlH4Y5pTi1vB6AiGzv27r/Y=;
 b=pD5qi/9LBgb+DyL/uBI7Xt68PRIwrOVvTk3C4dUGboUrpJwB0xn95SOdHJ57W6fPEBgmIYZdMWURYD1UvyaSyYCew9mnBIk8Aw08Xil5icFyN2mvBgrCUGST15Mrwj4d8jA5kNYH9+HC6cLrizNGGLzn5GiBtspoSxoRTPJ5cdk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4733.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:158::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 09:07:56 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.020; Fri, 19 Nov 2021
 09:07:56 +0000
Date:   Fri, 19 Nov 2021 10:07:55 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] test-lib: introduce required prereq for test runs
Message-ID: <20211119090755.6noeyarhc3rpzwzx@fs>
References: <20211117090410.8013-1-fs@gigacodes.de>
 <20211117090410.8013-3-fs@gigacodes.de>
 <xmqqpmqxuj3b.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqpmqxuj3b.fsf@gitster.g>
X-ClientProxiedBy: AS9PR06CA0016.eurprd06.prod.outlook.com
 (2603:10a6:20b:462::23) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS9PR06CA0016.eurprd06.prod.outlook.com (2603:10a6:20b:462::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Fri, 19 Nov 2021 09:07:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d96e47a-8f84-48c8-78fe-08d9ab3c1338
X-MS-TrafficTypeDiagnostic: PAXPR10MB4733:
X-Microsoft-Antispam-PRVS: <PAXPR10MB473350C69DF6DB21A055AB21B69C9@PAXPR10MB4733.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z22tcGD3IcQbPai9uzew5EbkeJbDkhtfaZMfNdlELm9+ZvM1OQNO1EvUDK8uRkV1iU8nlyN4JOl7XwhkL7FT8mjhqvU+TrkybZsVIZNn4sxZHQ3Xv0a5mWn9N/IAHFNjr2efye+Tfezxq+f7eaVcXJ30dmiUFds+FvEbqyHyIbnFr6wU8zFhZNCi+dxJYrpShq82ZHWDXUxqScdjcs4fHy2bRQBgNrmpDq8j00Os3yK+X6ClfavPj048m9rCqPQBXsP0g6QZuCzWRIoHx2FgnFKhWclUlvewI2uk77Bf5SoTkIpOY+G7NVYdURl4+yTS0/u6gVotD3dbpGFJ4LZ2xR0YZ0Ny8Ei2YGtIDbsKjBLCeiWIrAW5Ek+rqCDWWYych3TtNSM0nn6a2ppZ3Xo/7SYBUOppEYSTN12uoeMJ9Q+tZUMO+QhFVgODhkrskfQQnCvoNwbqS861EmGqjtiGfaUxNYu82VZBNCud6sGOVZAF9yRytoPC6ug/STziPpqtip5nwugVgQamGs0KxOuK6GsuhRTvDl7EpoH8Xi31cfALesEN5LXK96UVLuRGEy3Xrqrtscw9tylsOutMkkmi64auXEjunMIHK14bVu+P/Ycntcr7Ns2F0yXUybvx1JoPS4Nfim3lVwFy8rmTsENFSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(376002)(396003)(39830400003)(136003)(366004)(346002)(4744005)(8676002)(66946007)(186003)(316002)(8936002)(508600001)(6496006)(86362001)(9686003)(53546011)(66556008)(33716001)(66476007)(54906003)(6486002)(38100700002)(5660300002)(52116002)(1076003)(4326008)(2906002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTRla2F3SmdKV0Q4ZGdwMFNKb3NDbDgrRkhhU2VYQVV4YUEvaHNZOVo3bHk4?=
 =?utf-8?B?MVVxVDgrWHFDUjVZQWtsQWtMcUVSVTZ3Tkh6M2ZlUVF1SjdMVlVLR2JjTC9Q?=
 =?utf-8?B?amVmR2hJamhoR2s3UVhlOG5sWkh3VHN3SHVWVm1uOGV1NjRxL2FMY3ZlMkdi?=
 =?utf-8?B?YjA1bnJYT3ZSdzE5ZlZkRmFMMDUzWUk1YjdMRC9jSXp6RUU4R2EzV1Q1Ym5r?=
 =?utf-8?B?M25FNmRTcTNIa29OU29ZU2YxMWMzQzltWmdhZUhyUG9laE80RTAwNTRpeVpw?=
 =?utf-8?B?b2Z0OFJaYTlSZ2JDbWorOXU1TjRzNXIvazZUVngybGF6bzg3bXhZcFlMUFVj?=
 =?utf-8?B?V0JnVW02ZWJoV0kvd0hVQjErMk5Xb0ZEMXk3ZlBxZUZWa2Y1QWZmQ2Q1c0JC?=
 =?utf-8?B?eUp1UWZieXViaG1ENDVJaVlVUVEvOW11ODhmQll2U2ZUTm9rZ3E4aTVYV0R6?=
 =?utf-8?B?T3pBVER3T0cyZWhwNTZDOThWc2NyRkoyNjYrYms4SG9OeVZvZVEwSkRsY2pN?=
 =?utf-8?B?YUk5MUdOUWFWaXF4cll0NkFrNEQvODhKQzdoVWp6b0R5MHA4eFQxejA4VVg4?=
 =?utf-8?B?c0ZQUnBMUWtYUGtqUHBubFNwYXI0b25zeS83bktOcjRhUk85THN0ellnOFRU?=
 =?utf-8?B?Yyt1cCtidEJYcmh0SUFSQXRWaVM3cnh6WC9mc0JJbVlwaHpFTTJOVzUrQUpO?=
 =?utf-8?B?dXFFd2V5Q2d3TlpaZVFDVjF1S3ppSXd5elpwdk5TNlgrTDl3WWVHQlhackFS?=
 =?utf-8?B?UWFPbC9acmpadlNwME03eG00U0QvTndIbUJkSmkzaHBOK0xZQzBhaW5VYy9D?=
 =?utf-8?B?YWNOdjhGaVlQWWgwREpNaGNxSTZPMTdmZGNpTnhoMWhoamZ5b0R3Q0ZFRmN2?=
 =?utf-8?B?Y2xuQ3ppMG55Q1pjeTNJWE92USsvNVRGdWdiMC8xSFB2RVpmbVNXc2RHd29m?=
 =?utf-8?B?amNkNU9YVEZZeDJ4L2Y1T2FZbHdJSkhGbzJGNEFkenJkWXh4allYRzA3UTlk?=
 =?utf-8?B?dDBjdGRyZmwrWXZ6aTA2WCtGSk95b1djWmF6MEd4K3JqMERlVU9zcHhwRXhK?=
 =?utf-8?B?emoyOW9yRExyMEpuaGhMSmltdU0zZjZMZVVPMU9pMnhWNjcyQXl3RDV2NW5R?=
 =?utf-8?B?UUcyTDBQNDliUUFlc0VXN3VQb0luVDZrZmpMSER0NHNlZzJyWGdCVXNXKzFo?=
 =?utf-8?B?eVdZQU14eFhqaUd5a3pwSFQ0Q2I0bFVpT0FaRjZZQ2p5MnRFem5OakdEQzg4?=
 =?utf-8?B?RUpJMS9Hc1hEWFZGcXdIOHJBdnp2UHU5VW4yc1didGNKSWtQa3VOT05ONEI2?=
 =?utf-8?B?bE5WeDJQMjN4TXdZcUt1MFZwZldUZ0tLUXhIVklhbFZqU1p4clVvOHpIS3Rh?=
 =?utf-8?B?ZnUzdGpuOWFNdFJoaktuajRkOHZnNmJuVnNkdHQ2NW9CbDFSRnYxNGlzQStG?=
 =?utf-8?B?UzJDWVVpWStzNVF2UkRNVGRUOVJ4ejZHUzQ3S0poNiswTHdHd21ZYmRJOE9n?=
 =?utf-8?B?QTVOUFBkdWN1Y3VmRitjRzFnNDh2YmRRbjBENlVRc2xuNjBTWGVoempubW50?=
 =?utf-8?B?dEpZOFpldVpVUkFlS2haSVFhM0pBOUVDM0VlcE5TNHU4MDJQR0VCeXA1UUYv?=
 =?utf-8?B?bGhtT0pvUGEyakZKWE4xb2xOTmZMYUdNUlFyejcrcDdPNlc0bmIvMXltajVL?=
 =?utf-8?B?UzQrSW9VNXRoYlZyeHdCRWtpOGZ5RzArMmlScEd6cDV5NkZqYWNxNTFmMTBa?=
 =?utf-8?B?WDc0dk1oeHlVWGJ2c2ZGVFBMS1lsRjZQZ3U5V1puU2VaMlMzNnRqVEpsNGlk?=
 =?utf-8?B?ZHBOKzVEamJjaDBydlFaaEhseXp2blBVaVlXaVVEbXVsdnFyZHV4SGRTL29r?=
 =?utf-8?B?bFJwaXovSGlxMXg4WkhzTThOanROeFZNS0pJd3FCRkFVaVZTWCsvWU5zZ2JW?=
 =?utf-8?B?T0xJQ2s1SWZmSWpRUGY4dGFOUU1Bb1JXMVZFbzdTMHJCWkE4NVZtMUtnNU9R?=
 =?utf-8?B?bGpmV3JBQVBnNjl6bUVTM01xQTkyb0FOTVdubmVtRTNVTkQyK1FnNjhRUnV6?=
 =?utf-8?B?RmE5Nm5hMVZ6ZEhHNEN0Y0I1dWhENnNvUlZFWkRNM2ZjaWgzeFhrSVFsWkZh?=
 =?utf-8?B?bjlQeFpKL1o3RDFIeVVuUWpGQThIaXhhTE9KOVJmdDMwbmV1MWJ1YXNPN3ZQ?=
 =?utf-8?B?b0FqSkdEd2FkSjlUQ0JFcmdzL3EzUEFzUHlVYXZKK010S0xQWHoyb3VNby80?=
 =?utf-8?B?OEpZWTdqQzV3QVpwSHZLL29JVHBwSlQzRjlMZjF3WE53aGd6ZE1UbXBhNklY?=
 =?utf-8?B?NGlHcFlrWTVLZ0ZwaE1TbjdQaEp1M3FjNGR1V1hiQU5RK0pWejBINDNiamlV?=
 =?utf-8?Q?64mE5F+qtJW+krDc=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d96e47a-8f84-48c8-78fe-08d9ab3c1338
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 09:07:55.9905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOBSeOglBWJvkGRLEKV7btuuiSI72lRK8tiLju3vo+rAWTRQLQMYmpt+nWN5BGFeZnCq3sSeQx5CMpaQyngJ/VUvlW69arOrVR404sQf+ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4733
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18.11.2021 15:42, Junio C Hamano wrote:
>Fabian Stelzer <fs@gigacodes.de> writes:
>
>> +			# Abort if this prereq was marked as required
>> +			if test -n $GIT_TEST_REQUIRE_PREREQ
>
>If GIT_TEST_REQUIRE_PREREQ is an empty string, this will ask
>
>	test -n
>
>and "test" will say "yes" (because "-n" is not an empty string).
>
>Let's surround it with a pair of double-quotes.

Will do.

Thanks

>
>> +			then
>> +				case ",$GIT_TEST_REQUIRE_PREREQ," in
>> +				*,$prerequisite,*)
>> +					error "required prereq $prerequisite failed"
>> +					;;
>> +				esac
>> +			fi
>> +
>>  			if test -z "$missing_prereq"
>>  			then
>>  				missing_prereq=$prerequisite
