Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35338C433EF
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 08:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiBIIeP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 03:34:15 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241572AbiBIIeG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 03:34:06 -0500
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10068.outbound.protection.outlook.com [40.107.1.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E323C050CD5
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 00:34:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdtoLa/pWyXKYBVN4PUf0o5M+wXewCivbyjEXnYJW1UcIrAf8MwzPD/VQFOiz8i5zebVFVRsJWtl1egmAX3md0RNs0NUrUSHqB52Jr+7d6V1HXu0nBjwpGPlENKTbZhcPkevtgnNXWbZjEsZ7ihkB0zPHwNC7Navoi7jLTTAOjHxup92Xlkmzo9zR0upjVltQSl7qTEscIsS2UlXFQ3D8fo51Gn49LQlPNJr41jkVhdGntr+rl4E6hpos+oRSWqX7ihEt/is21idKaYZZFdM8GPW2DggDpuKd2J4IFT3xnnuu3aYq7ivM7xe545+xNg707A52kxDCRQQJ0POv1p/nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1xMh+zh6gGHDu/60RPM8fP5VbPB5AzN7qb/2kPf6xQ=;
 b=Ym+uVjTW46k6aUyYGMQJYfaZMHWt0hv1F7Nt/OHZCtoBXDBAJ4zcaLiMO0PY2DDu3QVDz9Q1sfBrfbpSaCXmCy6OiFU5lbPVZjG9UEfyLr+sRf7wX2sulzgJ8BA7WnlUyBwgCzwRPaoS5Qt5bcuYuHVUzRPGUOFMGTsNNlhzZhVSqv8h+Cwijo9cs4VvIsqhbqFKRFj8H7NjyXt0upDGTDRPZm20s9hM/A5oQWocXFUWNw4AZgGzxMFSQDWQta0+ZJrClUolS5QMi3Y62HMT3PfKDU8EHfL71mNNBAHwXkJAwE6sO0jQ4GYVEEGtDwc0qSSOoclrWzMNsQJjllOOFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1xMh+zh6gGHDu/60RPM8fP5VbPB5AzN7qb/2kPf6xQ=;
 b=IM09j3DYv5juUVN33uNnu93po37LA96mlNaWxBn6jIzFIAqCp1mcndCLuYh8Kl0ET0ZvrImvMn3/zLKKjxcfN8XfAKzMNjsvaN19DWr8dLmARmtKV2dCNSw1LyeRS927z6LXEK6vmPuNiJ9YZcEyCtaVqdgXjT/Tz9gK1Xk7FbY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:259::19)
 by AM6PR10MB3000.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:e6::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Wed, 9 Feb
 2022 08:33:52 +0000
Received: from DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5014:44dc:e7d1:3e85]) by DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5014:44dc:e7d1:3e85%5]) with mapi id 15.20.4951.014; Wed, 9 Feb 2022
 08:33:52 +0000
Date:   Wed, 9 Feb 2022 09:33:51 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Henning Schild <henning.schild@siemens.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gpg-interface: fix for gpgsm v2.3
Message-ID: <20220209083351.dsoxnhhme3lracck@fs>
References: <20220203123724.47529-1-fs@gigacodes.de>
 <Yfw0kapgSSWO3Pyx@pobox.com>
 <20220207105240.dk443kcozynlonpp@fs>
 <YgFK+F6Ks8FnN5Q6@pobox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <YgFK+F6Ks8FnN5Q6@pobox.com>
X-ClientProxiedBy: AM5P194CA0008.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::18) To DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:259::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd591225-c2c1-410b-f4b9-08d9eba6e718
X-MS-TrafficTypeDiagnostic: AM6PR10MB3000:EE_
X-Microsoft-Antispam-PRVS: <AM6PR10MB3000F343C905BB0F1515C3E5B62E9@AM6PR10MB3000.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z2gY0Pf5Q5fDM0+6jzzSF5RN0h+BxIRspW6aPdTdHri2//Zsg49zlAqy6aP7ZSWLuTeG/j+oRnacKEYvrDCdfN4azyoXGP+qJHVTS9Xw9CjDXlafoGxvqpIDgrGkjCvxZBCtk9cL3t7baDqLZxrnItCSYzTjRnS3TIQlBfTR/88cDvOhisKXEmjZxp9WDLX/Ah5UuwAzFQT5yfHxfmKol4jOOu/1FJGaUCymlYFE5/GoY8s7HzexGIr5vsaP8OWT/dsxIoeYRV9n2h3oZk/SaLJGwSDYIq5hPjCrpYLOhxzJxQ4i+TIXLmkEQeWbNsglsZ36ivjQttzU708VaISp1qZ1XE8DrpZ7QLR0o/q8zYsgMHOBubTPBJzkX+9bnqY1oXyGbkdDkvW+RREy9b/R9Q5lnZKd2WXS7q35Xbr9iy9909PnXNPE9LZx4kjKFu17KWZEnPw4ChHKOTApZ6uZ5h6OzDmD5NXTR84IAb6IQPYttGTZy82Z+b+qcikf8ThczWL4vd7oS71C+iBpkOywcXgvcn+7QcmifrtWQOK5dvn6bpyvzaUv/VnVpmHNSyUnWEXGkAoUnnsunbDnI3VEOMbGsV4FX5skamWS9zb7e8r7PSkqgx78SWJZVQD2/bFs9NcKm6bcTMOgsiFY8+7zhP9O9FKuAl1paui43k+6LUPcoR2t7YAQpWZ4hUonlHysnjvg3re4X5auUIpXYGiK6YLVH8wBj22C9fn0KA6tIeo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(136003)(376002)(346002)(366004)(396003)(39830400003)(6486002)(66556008)(6512007)(316002)(6916009)(508600001)(53546011)(66946007)(54906003)(86362001)(966005)(66476007)(8936002)(8676002)(4326008)(38100700002)(9686003)(6506007)(1076003)(4001150100001)(186003)(2906002)(5660300002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0tNbWVCRVFFYlNoY0haZDdlQU9WOHNIbUthWXBhVHZNbXhka2c3WUNMUmMx?=
 =?utf-8?B?U1pjVXZvdVdaRU9lVENrNnUwK2FqMHIxbE9jakhOU2VTODhndDhjYTkwQjBq?=
 =?utf-8?B?TDJ5eDRKRzhTZkVCREorYVVCL3FEbjhFSndJK2xCUWc0OUdPZWgwOVFnRGRE?=
 =?utf-8?B?RHlDRTQxQU0vaElTMGhubzlma2R3R1ZFd0xJbFNub043YUU5K1g2YjlnQ0xH?=
 =?utf-8?B?QXhzc1RSd2wwQk5MWEdYdnd2K3pYVFJzV3RNRGtrTlBSbzdwV1NKOFhVbDM1?=
 =?utf-8?B?RHZzL2YxR0Z0eGNiMVVld0FVUjYwdXJ1NkZyNWZIQmtKOGJqUlZtdEJFcDZX?=
 =?utf-8?B?TVZFa1J5TFpWNS9qbnpRVzlaMmYrWFdtZTdaWVI0Q1VzQUxQa2dJOXd1d3dG?=
 =?utf-8?B?QVdva0tsNmxjbFN4MGd5WnFFcHZJWTlZdnpvOEgwOXlKQ3NpQ1NNdzZvMUlv?=
 =?utf-8?B?ckFtNHhDVFRwQm9MWC9BVEhoSENUNG8xNnpzcWMvNUxCSnpjYTdkR0p1ZVRH?=
 =?utf-8?B?Z1dXSjlCdCtOYXpqT1hkTWphN1R5WmVNTnVHZnlPY0IydXVwQThsMkdlSHE1?=
 =?utf-8?B?MkhVdmpMS0NkMG0zY0xGdStkM1k4M3NpUmcrVHN6VTU5OWJrZDRiU1FDVjFJ?=
 =?utf-8?B?bjZiY2svMGs0b1Vkc1o2VG92MjMyWHNYSzdCbHdvQ2thalM4WllUNXdhT1Z0?=
 =?utf-8?B?ZFVDa2hSMlJxai9MUzYzNDNHRHJ0Wko4Qk9aeDVEb3k0eXF1TFFURWhJWXJz?=
 =?utf-8?B?WWZBM2tWNXA4ZVFReGtQZ0Q4L25HYWlrTnk1OVRGU3dqMFFIQnA3enh4RnVu?=
 =?utf-8?B?R1hPSlJzWHozQUl6MlV2ZE9wUlp5eFFKWVJ6cExwVmZPVnZTSTQzNHlEWVE3?=
 =?utf-8?B?a3JwNEZWaFd0WGZHQW90QWIxZDAxQUsxU0NmNkVHaUY5RlJYM2tBMkp5R29Q?=
 =?utf-8?B?cWFNZmt2dEJlVHpHWmxIanVzQlVJcmRtSXdhd29kbkt6aW1wcmtzeUtQbll3?=
 =?utf-8?B?eWRjak1aUzVkM1d6SnI2aTE1NjRLc1QycGRjcDh3czJlVHY5MXJaVXdnS25H?=
 =?utf-8?B?MkNlL3dhdmFYU2dkanp6TGNKTk9TeUJIbTBCZTVSNkJGY0VEbFQwRjVoaEMy?=
 =?utf-8?B?eTJUc1IvKzZlSXIxNXV3ZnJRdW9zU0twdEhtREVLN3V3Y0RoOGpKekQyS0k0?=
 =?utf-8?B?OUVzK3hMazdQa2ZzRGtwdGJOQkI4SWdFUytocDZTRmZZbnNrTUhhK1ZmVTNh?=
 =?utf-8?B?eWdaM3ZzVDBSaTNuaDNVMDBrQUtKWE9nSXdORFlZYzFSMld1YndVL1J5USsr?=
 =?utf-8?B?Z2VKSXR1K3RqQkt2NEw1RytzQlUzRDB2bjJhWWlXR1oyMVptckwrc0dQbTI3?=
 =?utf-8?B?cVl1RFVySENqd2lKalUwU1NxUXVqcWc2WGs1YTJiYk9wWkRGWjRNamsrRDJM?=
 =?utf-8?B?QXZLSHdXODBvUEd0QkFqbkEvamNYeDlwTUVwZE1nbWRDUENZSVFxT3UvbnZr?=
 =?utf-8?B?YUx2SGFvbE5xT3BucFFTWEdXVVdjblVxZ2F5bEdtWnhHZGdsc1Z4UVVJYVU2?=
 =?utf-8?B?SUlJM3JvU1YwWkplZVZwL3J6Mnd6dzdHb3dNLzF5Y3I3VUhjbW5SbW92MGwr?=
 =?utf-8?B?L3djQmh2T2o1cXE2aktNM2JqNTF6bTVmdlJPelRhY3ZkNEw5Y21GVW5QTDFz?=
 =?utf-8?B?L3BNUi9rcnB1RUVRWVJLeGZqZGRVKy9oV3hPZ2l1WGYvcklYUUdMMy95TmRE?=
 =?utf-8?B?VGlrR0gyRVVnN0I1TWJaS3Q0Vy9tbkNBLzF4UTNuLzkwRzBhb01XekovU3BI?=
 =?utf-8?B?UWJIdm1lWmJabzdxYXdzd0cwRlFQbWRXMHc5cjE5Ti83ZHc0MHZKSE1scFBw?=
 =?utf-8?B?T3I5bWYxS2xxbUJ3dGl0b2h2NnREbklncHdEalZwUEc0aTRMVjByVStRd1Jq?=
 =?utf-8?B?RWlUYjZhdG1yMlpjSTBVUkxIeDBodEphbSswRVhKS05kV3FsSGdmVjVnK3FD?=
 =?utf-8?B?QUUzNlRqUy9YMi9KMnVUelNpa2o2UXNmQ1U1MU9uWTh2S1g5Qi9WZHFwblN6?=
 =?utf-8?B?dTdEWXZVRlNKNlVRUU9keS85S1BES05vM25JUHhBOWo2Zit5YnRSVFV3Y2dv?=
 =?utf-8?B?UHBUVmMyYUJ5c3llVzZjRzBMWTFXbzlDOHpJWXdlREFSeHJkN05odEpSUXNs?=
 =?utf-8?B?dWVBRzZ2dy93YUdOVFBsQ1NMblVBdTI0eUlsYXQwcWJvTTBEbmZ2TVVUeEE3?=
 =?utf-8?B?S3pvK3pIL0JnTURTbmxxaDhHWWliSEIrVkFLeWg5YjY5NERoWjFKbVBlc2J4?=
 =?utf-8?B?cUdjMUkzZXU2cjVkSHZIcVpyeGwxQlBET0xlcFByM3RDSDNjMWhNbmhvZ0xO?=
 =?utf-8?Q?PoMQOAEZk9CoCjVg=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bd591225-c2c1-410b-f4b9-08d9eba6e718
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 08:33:52.7968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qqFaEhgXiUgXeUuGFg1/qg+QAVIAwbQBCQqWxQ9P6/dCcx2GMcPSgzT4arw3hwN5WZs5KhFAKifMUjRPr92pO5vBxJyrqFJL2fh/N9KQuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB3000
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07.02.2022 11:38, Todd Zullinger wrote:
>Hi Fabien,
>
>Fabian Stelzer wrote:
>> On 03.02.2022 15:01, Todd Zullinger wrote:
>>> (To be clear, I mean "clever and wrong" in regard to my use
>>> of the string list API, not anyone else's code.)
>>
>> string_list_split seems a bit like overkill.
>
>I have little doubt that the string_list_split() method is
>far from ideal. :)
>
>> I looked for sth like this but gpgs --help does not list it so i didn't dig
>> deeper. I've checked the blame and it seems like this was introduced >19
>> years ago. So i guess we can probably use this ^^
>
>Indeed, the --with-colons output goes much further back in
>the GnuPG history than Git will ever have to care about.
>
>>>    --- a/t/lib-gpg.sh
>>>    +++ b/t/lib-gpg.sh
>>>    @@ -72,12 +72,10 @@ test_lazy_prereq GPGSM '
>>>                    --passphrase-fd 0 --pinentry-mode loopback \
>>>                    --import "$TEST_DIRECTORY"/lib-gpg/gpgsm_cert.p12 &&
>>>
>>>    -	gpgsm --homedir "${GNUPGHOME}" -K |
>>>    -	grep fingerprint: |
>>>    -	cut -d" " -f4 |
>>>    -	tr -d "\\n" >"${GNUPGHOME}/trustlist.txt" &&
>>>    +	gpgsm --homedir "${GNUPGHOME}" -K --with-colons |
>>>    +	awk -F ":" "/^fpr:/ {printf \"%s S relax\\n\", \$10}" \
>>>    +		>"${GNUPGHOME}/trustlist.txt" &&
>>
>> This does not quite work for me. It will add the fingerprint without the
>> colons into the trustlist which is not valid :/
>
>The colons are optional, and have been documented as such
>since cb1840720 ((Agent Configuration): New section.,
>2005-04-20).  The text in the gpg-agent docs from GnuPG 2.2
>say:
>
>    Colons may optionally be used to separate the bytes of a
>    fingerprint; this enables cutting and pasting the
>    fingerprint from a key listing output.
>
>Source: https://dev.gnupg.org/source/gnupg/browse/STABLE-BRANCH-2-2/doc/gpg-agent.texi;8021fe7670c79d5c698ec3fb600b02a9e5afb415$756?as=source&blame=off
>
>How did it fail for you?  It passes all the tests when I've
>run it against Fedora and RHEL-based hosts.  If it's flaky
>on other systems, that would put a damper on doing it this
>way.  Though it _should_ work.

Sorry for the delays, I'm a bit busy with other things at the moment. I did 
get an interactive popup asking if I would like to trust the key when I ran 
the t4202 test. This never happened with the old variant.

>
>[Note to myself] We don't just generate the key data,
>trustlist, etc. and store it in t/lib-gpg like we do with
>some other files per b41a36e635 (tests: create gpg homedir
>on the fly, 2014-12-12).  That was because the gnupg home
>directory layout changed a bit between 2.0 and 2.1.
>
>Thanks,
>
>-- 
>Todd
