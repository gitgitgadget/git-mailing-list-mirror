Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4EAC433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 14:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C82E61175
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 14:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237331AbhKPOXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 09:23:10 -0500
Received: from mail-am6eur05on2058.outbound.protection.outlook.com ([40.107.22.58]:3328
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237340AbhKPOWi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 09:22:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGVQNrcXh6WSW9fLVVat77aH1dTtZfw1oY3iz+ghZ+kknQUnCRKia4/Vp7gIn3ko8GGpVMrrPvHgZDIWDasDvWTnwQ7j1XIWdC84O1FFDOUjxzI7iJLVj2dIhXiKAMBjfaYK1s+I8SSm0CzyySh4zWrlzU4jEwFKf9a39WTWxwsL6NrAWAkKmzhXk9AFL9ymLje+MN3GRj9rr5jwv4RckrClmEBreL5BqVfAqpHO8wBeDDOjbF1Ec8gfB4nCtNmMpzLxbk6XYrmeofMFLa6E4qBlSZkM9pKurZ4LO5+3gX2hzyyc+SSPm2zlbQQ/r+W8AiCZVU8Y8M5WZyP0Im6LKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E096sjSvN2GJDP+4COmt0bEKhIEf5ak/bfFnL1VGpZg=;
 b=gYP4q+IngFo5ckUM96gDwzR0QKtruW0GBqiWHoam52rKkyuPwYgUFg0M088e5zfkIZU+e0Yi1uEjkbYDSCNVVJPhGZ6IfgzrT5yGDv4k8p2Z4hpMZNwLru9CMX3wVTQnKngRnAHqLE9GWDgGsHXhGRTQpFI3mpKNZoekyVDJhquqd93F57EUFGmpChNw/jHTy5yRUBOCLUCitakv8OO6Ms/fIcYTGJUbEh4Zdp8C8GQY+rQX5F2t4eSQtIUHjD6R+UQtAWRuB8/8bisxvOEUFXYymeHD5+XgBk+QkXGDWODrzDqoq/Q4/kkH6Qg4exrP5U57VLUKFRbSzEZGDGftuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E096sjSvN2GJDP+4COmt0bEKhIEf5ak/bfFnL1VGpZg=;
 b=GFZKM9MWrIcqbd2U7kNkqFwGGLa3DZY5qSSsxEsucMuhW4VpmFFCN3SK5N2g4/20iKJNr7M30VXfxrKaPQnSQA/qzxtGIWB3uw5Iz0tRVE9zV0re1Zc63VG8IEt5brcICxFx1MlqnRYDcfcx0StgWwF+lfsHoH7R6CpdGacYSSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3868.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:47::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Tue, 16 Nov
 2021 14:19:39 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%4]) with mapi id 15.20.4669.022; Tue, 16 Nov 2021
 14:19:39 +0000
Date:   Tue, 16 Nov 2021 15:19:38 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] test-lib: show missing prereq summary
Message-ID: <20211116141938.gbaufny5o2boptvh@fs>
References: <20211115160750.1208940-1-fs@gigacodes.de>
 <20211115160750.1208940-2-fs@gigacodes.de>
 <211115.865ysts45o.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211115.865ysts45o.gmgdl@evledraar.gmail.com>
X-ClientProxiedBy: AS9PR06CA0247.eurprd06.prod.outlook.com
 (2603:10a6:20b:45f::14) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS9PR06CA0247.eurprd06.prod.outlook.com (2603:10a6:20b:45f::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Tue, 16 Nov 2021 14:19:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ce62f7c-f8f2-4fa0-847e-08d9a90c2003
X-MS-TrafficTypeDiagnostic: PR3PR10MB3868:
X-Microsoft-Antispam-PRVS: <PR3PR10MB3868C67999587709D11D805AB6999@PR3PR10MB3868.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZRKpgkRjed3akuq3N8ktuoUq+23QyNTKY82k9ub7PbE85dYMjzo1eEHqmmDcMjH3UEbtu6HA6kXLPkPwvW0VBu61wpRD3aeLnG6jfw8t9PwUcwoVKL8KZl7NVifTLThODY/Mi+vmYZeZTtg28V4dEQSHPeDE6Sa8X0yBh9hJudDD9K7wgDxFwALk5/bXmFdAftDo28oeaokTX0hOTBKQ35GkCdPpEuyJJPXp6L0aL5eaXDH/ZXckLdZU7wF/hQcZbBEEFC9VI3AhLx1zxz3331SUFY0uc6imGnxMf4+ajx7JriDU6oKSRQX8vk27DlxBVcCsWo067cbYDcKe9y7S9bcwpihCikFrwTbq+AsStETj48QEJW7lwzuo0eMVLG+mCbOq/uxUDylpTQJV9qbsoA6iwWE4v62QO4w2eX1zIUog/Oz9zsePmzt8GXVEFGJfMjC2N171EH/zoLJBU0m27+0dPIJEO9UAHyoGOQxjQ7XuhXBwV3LbIkjbTw/dk9tVW0eOZqq2csnBGV1knitulBqA6ovef5AR7036pXgLG/1RLaqidNTplnn8LsbbomOmUjknHCqLztTUtKfbkLDo0MP2EuZ2IqD6qvVkl8Is1PbxkP1N3G9aGA0ykzzn74CVusNP6vnchxeflE2GvgZEKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(39830400003)(366004)(376002)(396003)(346002)(136003)(66574015)(5660300002)(38100700002)(52116002)(9686003)(8676002)(86362001)(53546011)(6496006)(8936002)(66946007)(6916009)(66556008)(508600001)(2906002)(316002)(1076003)(66476007)(54906003)(186003)(4326008)(6486002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFpoNTNhdnBuaSs5bGdlYzltcjJUS3NyTk04d1d4VnRjTDNwSjBtOVZXUG82?=
 =?utf-8?B?ZlFmSkc4SXJxckFBaDU4QUhoekJ4QTBuZEFWbWJLanR1UTZmTHI5b2huL1Bt?=
 =?utf-8?B?QVd0dmZMVksxNmNLMUlCTTIyNTUzYVBZaVZ5SURDQXlwb2E2b2JlVWdBR1hy?=
 =?utf-8?B?NEtESTd5NGNVaHF5QmwvYVhFS1dmNk02emFFRTMwdDJLM0pCYjJJRTBMSWxS?=
 =?utf-8?B?UVo3R2l4cUJSTWoyTFVVOFplOUxxS1k2R1R0Tml0UVlOa0hTUG4xZUdqYmpm?=
 =?utf-8?B?YzloNUR2YTZEVktQZHpFVUVJdnRKSUQ5SUpyWkExcytVRkNjVlNUazUyY1F0?=
 =?utf-8?B?MjcyM2VlK2thNUlvRG4wT1VSSjVpQzBLV2lQemxvU2d6ek5OODd1d0RPK01i?=
 =?utf-8?B?clh0NUc2K0cvem9IWVY1OG5SempiVjVDellhRW84VTluN0Y1MEJvMUliZnN1?=
 =?utf-8?B?b1BNUHdkY1laRGF4M0haMTdXZmh3R3Z4aWE0S04xSVdicWhjNVFDVnN2VDlP?=
 =?utf-8?B?MFFzSmpLbmtMdm1ETU50VTMycmk3dyswSFJJc1lSdmxwbjJ1WlpVQVY4NDRa?=
 =?utf-8?B?azUxaW1XTlM0ZGxoMW5tNUk4eHU3ekhWMGNCM0dCRE5rU1lra1BtVVA4K1l3?=
 =?utf-8?B?QUJNQzl3c1IvdXFxZUkwbzhRNjlEN2lFcDF4NGJ6aDBCRjh4S1BUMXI0UVh1?=
 =?utf-8?B?NzkwQTc2Z2ZtdVNzZFRYUkplU0dPMlBkWEpnMGprV2tNUzU1SG80bVJvVCtR?=
 =?utf-8?B?ZklSV3hwRms5NXI3OHVibUdmcURtRmhtRTNKV2k4UUFDRno1SFBMVFJZcXVJ?=
 =?utf-8?B?dlUzNFVaNUhJa3o4TDlEdXQzVjdaYW1hRFdncXkzS05RaklKeHFObUFlc1hy?=
 =?utf-8?B?UjJBdWo5d1pOVmx1ZVYrbGhtb0lKZmJiU0pTZUMzZHY1dUh3T2Erb1BqRTE5?=
 =?utf-8?B?T2M3YnFQWW5seXdVN1hXNlBSWmRuRHFQVXEyVUtoTks2QjR1cXdoYWFpUzNH?=
 =?utf-8?B?dnJLaDJSUit0ZkZIc1E4QVJnMkVVdDJRbW9aQnZ2Ny9wZEdqVDd6N3duclJa?=
 =?utf-8?B?UktOOVNDSWFTOHRJeXVtbURFaVNwSDNjRGlPTUU4OUhUVnlLNk9pS3BmNmNK?=
 =?utf-8?B?bHNEdlZHeGtZQ1V2U0VLRWhsMXNTcXQ4UitaQk5jeHBzTFM4alM0TElFOGlX?=
 =?utf-8?B?YjJpQmdIQ0phekJoUnQxQU9hRnM3V1UyelJ0ZTdPY1RSeXpQQ2JWRXBRVGtP?=
 =?utf-8?B?ZHJ4dm1CN2Y1OFVpb1dBczREVFAzNFZ6dDdyR1JRKzJ6UElmcTBQbnZaR3ZF?=
 =?utf-8?B?eDhrMzkwRmxlcytYQVVNV2w5NkxCeVFvYWpOczFzMnI2MkFINCtoYWROLzRR?=
 =?utf-8?B?UitFem1qM1loN085YmpTdmFOWWYrWW85OEZuSkFuNVBDKzAvVGJDRHAyUndC?=
 =?utf-8?B?QU9ZTWc2MjBiTUs2V3ZVV3FjaHZkQUh5Nm83VVZpV2dNL01rTHZNSENjdnVq?=
 =?utf-8?B?bm51bWpNQ2VRTU5ISkFENjFyd1FaNVRYZ0hlVGJ0Z2MzdEl1R3hDeERtTWY2?=
 =?utf-8?B?bi81eHpzbWhoMG1rWVZiRHhFM0pMMkl6UzNhUXJ5T3Z1cTEzTDdRMkFmdkpK?=
 =?utf-8?B?cjAvRVFhdnd4MjlpUVRxT1VnQ1U1MUl3VmRaYUJCK2RyUXJhdzE5MWJMcENP?=
 =?utf-8?B?bSt5N29DaGNlcTB2cHBPT2EyalNkVFVrakliNysvZTRaVUE1UFNDQzA3MjRG?=
 =?utf-8?B?azVtbHFUdE9IMEtuOTY0OUJFeFJqeEFLTml2dWVrbFFPQklrcDJXVEI5RGRk?=
 =?utf-8?B?NzRBM1l6d0dZb3JrL1lTOHJneURTMVYzRnZYNkpuV1IzeFY0Q3JFMnlsYW1u?=
 =?utf-8?B?NG8zenZ2Mkc3cFFhUVE0a21DV3M4NXpkMXdIVlM5b0dVMlJMcTI3OVdJT0lX?=
 =?utf-8?B?Y1RDMko3N2VBbm8yM3psNmJwY3hJTnBTUzJiTDRrSDUvK2pVRnpFTXVkaEJh?=
 =?utf-8?B?UzJWL1BwK3RJeCtvVzViUVBRSVJtWXYwVTJuNmFFT1ZZUkJSV09Pdm9zRVFh?=
 =?utf-8?B?R2toVUlyRU9EaHBwTHVoUVYrTWFtcTdsUGdLUVJpVUlEOVFURmNSS3RWUng0?=
 =?utf-8?B?VVV6alAwRFFNVmZYZ2tlZW9xYm51ZHVGbGw1TlYvSTZDMUtQeE5hQUFhbjZF?=
 =?utf-8?B?SldpYksyS21YZkswWjg1cTVBcTJKVVR1YXNxWE1EZjU2SVVUQVlTNUtrT2c0?=
 =?utf-8?B?TzQ3dURyY2lZWGl6RXVSL3J2eVBtMHlrRjFTN1RSSDF4QU0zS2Y0VzFPQlNj?=
 =?utf-8?B?S3JuYW9wR0VxRmRGZUdxQzJPRSsza3RuNUVrNWhtMDlCUTRCMUFqQT09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce62f7c-f8f2-4fa0-847e-08d9a90c2003
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 14:19:39.3071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EnMD2GahNfOSCqHUzoBtts77N3ndmjEtMsYkYYUexTqzvoFDy6QggwS2EEPZR+3NYmPaKA8reKzpfI+UtMj61tjAEB3y+NQ0LG6qT0rpGP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3868
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15.11.2021 18:44, Ævar Arnfjörð Bjarmason wrote:
>
>On Mon, Nov 15 2021, Fabian Stelzer wrote:
>
>> +if test -n "$missing_prereq"
>> +then
>> +	unique_missing_prereq=$(
>> +		echo $missing_prereq |
>> +		tr -s "," "\n" |
>> +		grep -v '^$' |
>> +		sort -u |
>> +		paste -s -d ',')
>
>What is paste? Some out-of-tree debugging utility?
>
>I think you might find a better way to do this shown in my
>"ab/generate-command-list" topic, currently in seen. It removed most of
>the same sort of tr|grep|sort etc. chain in generate-cmdlist.sh.

I've looked at the generate-command-list code and TBH i still think this
is a better solution. If I read your change correctly you've removed the
sort and unique completely since it was not necessary for the use-case.
In this case i think it is. Since we call tr with `-s` the grep -v might
not be strictly necessary though. Also in this case these commands are
only called once at the end of the test run and not in any kind of loop
like in the cmdlist code so i think this variant is much easier to read
and debug with a negligible performance impact.

I tried writing a sh only variant and this is what i came up with. Not
sure if this could be much more simplified. It looses the sort though.

input="PCRE,JGIT2,JGIT2,,PCRE,JGIT2,PCRE,PCRE2,!PCRE,!WINDOWS,GPG,GPGSSH,PCRE,!GPG,GPG,JGIT2"

unique=
save_IFS=$IFS
IFS=,
for prereq in $input
do
	case "$prereq" in
	'')
		# Skip empty entries
		;;
	*)
		case ",$unique," in
		*,$prereq,*)
			# Skip over duplicates
			;;
		*)
			if test -z "$unique"
			then
				unique="$prereq"
			else
				unique="$unique,$prereq"
			fi
			;;
		esac
	esac
done
IFS=$save_IFS
echo $unique

