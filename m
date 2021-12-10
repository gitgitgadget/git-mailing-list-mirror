Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716D6C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 09:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238895AbhLJJmK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 04:42:10 -0500
Received: from mail-eopbgr20062.outbound.protection.outlook.com ([40.107.2.62]:53262
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236660AbhLJJmI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 04:42:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YROehXVMCbFc0PvMFQyM5/YVcupDJ9l7e7+nBnDREjWPpZq1NmYbJx64YaRX5WZskjQhxG+yM5N1EihJ6yNnYyA/Px1eRVzVBxzyEvA7WgNGts5avshDat0Y3mypyDPWglmqYPJGHVDqnGGvWA5CGMfQKYHyji8suMaoZIg+d/spA5DflHt9WCMdLOnZdoaBeL94Y1yTGb1+1NIMPMrK9HVASTVwDkcCBid2D3geXV2WXLO/nPCgn7Yx6iQtHNZ1n0b7pkD3rzebAziBlebBpHxuSs0yXOciEDGceB/f1NtpLeBb+6Ih3818ZAFEKtMS7EVBtJzqhIYxQ/7yjGUakg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7NQxyHbFAQLfBUymOl8UM0FpQ19scPM1pwvU+5/RKU=;
 b=fDWGmfJbzjszugRcvE/kGaPVhSyyv+Yy3AtQ5qu0V3qdTg0V7WNBc0xWL/1/RPJKxtQezgGeLuYECiqWyIjUnsMHMSR7YuUFKYaP8HAA0cFDohl5guOlmOeom/qziz/eeClKJBKO9KkrVZT592KX3OwBCklqtovhxB2EmQbgPyalI3k8cxXYCyb0zSB7H/InQzSt4RLkI1ETxOGyK+SsGXc92TOFymFUsXJpYBEwSnIkxNDwKj0gtREhJHkMroAqgrFdQDe/NRnrP9SgpiWOULgZx9tljkz596jHAryaAurCPJTABJ1qr0CnAAb+4C2f14/qYRA85oWazbp+scN1Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7NQxyHbFAQLfBUymOl8UM0FpQ19scPM1pwvU+5/RKU=;
 b=OzPbW3SblNbKbjG/bmHR76zjmJPnFiwkl4QNxO8/RrU33ymGhjYTQJw5QCWaIT7xuGUJDgVnqB7RFft0hilcq8H93sOkbtCZHvRMuCRoQFgffu/GhjdS7Gt17/7si/bACSa+LRhvEHJ5q318RRlk3GUs52NRgL3V6JxzGNq3ZNw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4640.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:15b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Fri, 10 Dec
 2021 09:38:28 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Fri, 10 Dec 2021
 09:38:28 +0000
Date:   Fri, 10 Dec 2021 10:38:27 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH 12/19] tests: fix broken &&-chains in `{...}` groups
Message-ID: <20211210093827.a5s5mby3if5f7a4u@fs>
References: <20211209051115.52629-1-sunshine@sunshineco.com>
 <20211209051115.52629-13-sunshine@sunshineco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20211209051115.52629-13-sunshine@sunshineco.com>
X-ClientProxiedBy: AS8PR07CA0052.eurprd07.prod.outlook.com
 (2603:10a6:20b:459::13) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AS8PR07CA0052.eurprd07.prod.outlook.com (2603:10a6:20b:459::13) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Fri, 10 Dec 2021 09:38:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a361dba9-4f55-42d6-a89a-08d9bbc0d1fa
X-MS-TrafficTypeDiagnostic: PAXPR10MB4640:EE_
X-Microsoft-Antispam-PRVS: <PAXPR10MB46408BDB91424B56DE392748B6719@PAXPR10MB4640.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XhnH8SfMjrcrgmd1klDbzLW6+wGRpJuY38JJgCRLPDnjoQOM/DM8DuRnLIiNc1F4deTp+jCTgK/RzJDKSVN7es7PC+2hUIFx9nCcuMxv8uKPLB6XAQZIm3t0H5uNiPWuLYX/kP4OKf4vKICcKO/esDp0EzynJ3tWFL36Ag2g3MvjN1A1hA3NulZ43wyYnwalSLw5cLcgm2sU8HbSzlsWbSGdk4veVukDTmudgb29vhycDnDqAxwtTRRlCYPisaPOukqHthWK/m0u18pYk4NqWSQjuLNSsbJRJeChFhaw+Y34+8M083TJ3Aafc5hCvMxsivObm0jxWQ7Sqwh6FKNMp+9Lb6VVjJWPfE8HtnFiWVsa3aJCIhOb64kYGDg5zaOOcRqMmAYiNuu2tVJs3f865PuvIih5AlNjBQTo0RYDnas5Z+RB+/w9NBOpMwwRg7U1Wz54+URWXCARb4zYPnT6Y3sk/GY4E9raRSIs7ykMUEMWcrHtnJTihW8woOrBOR2/qfyTS5J9QrebuboyTlfSY8ow7pV7n0xzYRBcExxVxLEoQzpdVRyU8jPhANnutHoQqmCjrbNcUNwP/F8nZ1QWjp1Rv4NEzjIN+afjgA2iEMMqtpDz4uGayROcEHplwjnSk+32G6if1of/NVakXvcRKuB1zKchesDNiL/7NwU6zOT6v01EVdQeyLjYh/2OCJ9eVrV/lPsKi5prMIiHD34MEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(39840400004)(136003)(376002)(346002)(396003)(366004)(316002)(8676002)(8936002)(6496006)(83380400001)(66556008)(66946007)(66476007)(38100700002)(6486002)(1076003)(54906003)(508600001)(4326008)(2906002)(86362001)(30864003)(40140700001)(186003)(5660300002)(9686003)(53546011)(33716001)(6916009)(357404004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1k0Uy9McExFbVFCZDN5MktDM0FYUGY2TGVHRVFxNzd4MHFIUXl1cDhUbHJR?=
 =?utf-8?B?RlhLN3NORXBud3NJTzBNR29JRnNWL1oranplSFU3SDBGSDl6eWVmWWUxLzhF?=
 =?utf-8?B?N3NzdFF6d0djWXRIOFh6ZTUrSmovL0JlZXhmWGZEWWJsTFEzSkU3cCtmck5y?=
 =?utf-8?B?VHZ1Qjlzd2VlQ29jelVmaFlsWnJyMjVQVkE1TnUyYWp1RnpuUVZiQ1cwV21x?=
 =?utf-8?B?am5qWTZTRFJvSCs5MTBHMHV6ejVGdlFnYWdNWTM1eGtGdXhEdGlyUWR0SVFj?=
 =?utf-8?B?dlNmVEppRVFSTWM3QXFhZGMzS1dRb1RlUTBXM1QzNmpuanJuYjNsaUJKKzdv?=
 =?utf-8?B?MU1mNUZFR01lYVBoYlNWYnBhaUJYejFtdllJcDZIY21oa3VydWM0ZDBCek91?=
 =?utf-8?B?eTBLQVM0aWU3RkFLL3M3eTl3eWZsczFGUy9ubDBnbG1DOTFzMXhXZExZOERZ?=
 =?utf-8?B?ODZteC9xMTRwN3U2YnJEMXJxbmtWMVMvTjZwOS8yUW9JL003RUZhcEczMU8r?=
 =?utf-8?B?ZWZhaWQ5Q3Y1MEpXVWlHUVdhRnBLakNidkpIYTdqVk9nb1phd05IUVMrYlRH?=
 =?utf-8?B?MW5uUVZaQmtHTWhrS253bzhKK08rMkpuSlJ3REtpQkEyS2IvaW5hQ1dNdHJY?=
 =?utf-8?B?eVdPYkZJbmtKeU9HS0JhRStvQVcwOStXd3hDUWVScTFsdXd5Nk10THVnY3Vr?=
 =?utf-8?B?WXNib3lPWk5jOXQxdlFjNWRSc1h5QVJZbnVZQStEemRabmtJdE5jTW1tYXpK?=
 =?utf-8?B?bi8xcXFvNTlPU0JhZzVMenUwcDk0NzFyTDA4WFU5RkdTZnZWUlhNallLc1BR?=
 =?utf-8?B?cEFGMXluY1ZIZE5qSW9EZWRhb2d2RE1YTDFOV3hGRWl0QTNZaW8wWVU5S2ta?=
 =?utf-8?B?QnR1NEVKaDQ4QUs2UnlScjFOWUZYODU4ZEp6SmdlQnA4a1k4RkdPbTVzdnRF?=
 =?utf-8?B?ektCNk4yamc1REFZeFI0c1BDV3dla3oyVjJUL2RZOXkrM2Q0RmduVW5EN204?=
 =?utf-8?B?WENPS2FXV1V4czJ5ZEFPZGJwMFZtdkJBVzNtSGhIU0JUY2JwQ3JTdzZBUDJB?=
 =?utf-8?B?dURudmxvY1hDVzNnR2tlUHBsVUF3RXpjVjM2REVqODNHV1VrWGk1YXQvNThv?=
 =?utf-8?B?VXVUWVdMS3NFVjMrVEwycWZ4L2lyOHlkYWdQTllzVEV3Z0ovWkRZNStqMDRa?=
 =?utf-8?B?KzNNd292MHZpRGdFeWVhNUNyZWNVVjdVVmx1RTV2ODUzRm1xR3FoRTlOK0ZT?=
 =?utf-8?B?LzJ6azEzWXZMdUo0cml2SWdFZ2Y4Z3dzSGNVem9VaUozRVVFQVRDVUJtUlpN?=
 =?utf-8?B?bERyMzJrSURwaGtHUkJKamp0MEZZYTh1ZksycER6dTVqREFRQithUWdQZ3B1?=
 =?utf-8?B?cGVGYjdONmJXdk1NbG13a2V5UUprODY3Z1h1YW44OWx4QkFqcEU1OEdONGNv?=
 =?utf-8?B?UkM1bFlrVlVranRldnBuSTA4cVI3Z0JGWXJNYm53SG5xNDJITDVDbERURnpK?=
 =?utf-8?B?RVJPM2JHSWdjbkcwbThDL1RTM1BqSGU0MEhZSi9ORFlmWnFsUlVoZWJ0bDEr?=
 =?utf-8?B?R25VWVZIbWFGVDZ5emVyRHh5ZGdxUHRuck9ORWZrMkFUQ21CaFdFbjc2RFll?=
 =?utf-8?B?QVRPamtuaVZXUWVCS3hka2g2cU9yRUdPRVhHaHNNL2Z4UU5oU0tKcnlDdGQz?=
 =?utf-8?B?czN4VHczc1hRZ094N0hUaDV1ZTIrUy9PNGVIUWVqQklnUlNVOUxHNFBMYUtO?=
 =?utf-8?B?dWY1ZUtyVENNNnFDVHpGNVJ4VVFSMWlBYUhYQTFvUFdoTXBEVUlaZnVKYTdU?=
 =?utf-8?B?bnREQWI5K0toWUxCb096aHQ1a2srY0RBT2tVVDBTOXp0dUlkQkNxUWRIb2NK?=
 =?utf-8?B?WFppQ2pETTViVlR3eDhtdmZaZDN3cWk0Y3VPalhaNzliSGJZME5nV0YxY1pC?=
 =?utf-8?B?bm8vQ216TW42eTBYYnVFK3orVzIzVjhHRWR3ZGwvbmY5UVVjS1BWWFdjTjYx?=
 =?utf-8?B?YWhPWHh4dktwN1FYaFZDK1pSY3VDaHZBMFBkUS9RbUZnNDRRU0pSZERDOUgy?=
 =?utf-8?B?YW4zVy9IRFd1Vmc0ckZrOEFUNTE5VDBLZEh3bzZ4OGkzTkhCTGt5ZVdiNEpH?=
 =?utf-8?B?a3RQeTNsRDNMVngrNSt2LysyR1VlcjhvdHV3dzVVby9QdDZ3dVdPZGlxQkdK?=
 =?utf-8?B?NWEyeWhDS2xSSDU3RWF3NGRFV2ZvZDFOVzdyT1hjOE9vNG51OEo1OHAyLzFx?=
 =?utf-8?B?WjFFWWVoejJoZkdpQWxyOUZ3T3lQMTE3V2c4TVVYcjMyQ2RaemRaNHhkSVdO?=
 =?utf-8?B?bjYyZ0ppdk5MSkRvWkVocU1SeFdSQ29XdzdSQk5WeGNPZUVYRk9rWHFSQ01x?=
 =?utf-8?Q?c9iesW1FXhC/Ek3U=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a361dba9-4f55-42d6-a89a-08d9bbc0d1fa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 09:38:28.1840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5Hp61cDRN7qjTblTpfqRbLTWwpq7K1q+Ke6ux/RCtF0uBt6CV2rDP7c0+sppM2RsV4Zlpr9nymixhXwcFJqZPWlp+zHj2LZlng1x6jNAKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4640
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09.12.2021 00:11, Eric Sunshine wrote:
>The top-level &&-chain checker built into t/test-lib.sh causes tests to
>magically exit with code 117 if the &&-chain is broken. However, it has
>the shortcoming that the magic does not work within `{...}` groups,
>`(...)` subshells, `$(...)` substitutions, or within bodies of compound
>statements, such as `if`, `for`, `while`, `case`, etc. `chainlint.sed`
>partly fills in the gap by catching broken &&-chains in `(...)`
>subshells, but bugs can still lurk behind broken &&-chains in the other
>cases.
>
>Fix broken &&-chains in `{...}` groups in order to reduce the number of
>possible lurking bugs.
>
>Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>---
>
>diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
>index 1a1a69ad92..bb3de2701a 100755
>--- a/t/t0021-conversion.sh
>+++ b/t/t0021-conversion.sh
>@@ -76,13 +76,13 @@ test_expect_success setup '
> 	git config filter.rot13.clean ./rot13.sh &&
>
> 	{
>-	    echo "*.t filter=rot13"
>+	    echo "*.t filter=rot13" &&
> 	    echo "*.i ident"
> 	} >.gitattributes &&
>
> 	{
>-	    echo a b c d e f g h i j k l m
>-	    echo n o p q r s t u v w x y z
>+	    echo a b c d e f g h i j k l m &&
>+	    echo n o p q r s t u v w x y z &&
> 	    echo '\''$Id$'\''
> 	} >test &&
> 	cat test >test.t &&
>@@ -159,7 +159,7 @@ test_expect_success expanded_in_repo '
> 		printf "\$Id: NoTerminatingSymbolAtEOF"
> 	} >expected-output-crlf &&
> 	{
>-		echo "expanded-keywords ident"
>+		echo "expanded-keywords ident" &&
> 		echo "expanded-keywords-crlf ident text eol=crlf"
> 	} >>.gitattributes &&
>

Wouldn't some of these be better off as heredocs as well?
There are a couple more below. I personally don't much mind either way but 
since you changed quite a few in an earlier commit why not these?

>diff --git a/t/t0069-oidtree.sh b/t/t0069-oidtree.sh
>index 74cc59bf8a..889db50818 100755
>--- a/t/t0069-oidtree.sh
>+++ b/t/t0069-oidtree.sh
>@@ -28,7 +28,7 @@ test_expect_success 'oidtree insert and contains' '
> 	EOF
> 	{
> 		echoid insert 444 1 2 3 4 5 a b c d e &&
>-		echoid contains 44 441 440 444 4440 4444
>+		echoid contains 44 441 440 444 4440 4444 &&
> 		echo clear
> 	} | test-tool oidtree >actual &&
> 	test_cmp expect actual
>@@ -37,11 +37,11 @@ test_expect_success 'oidtree insert and contains' '
> test_expect_success 'oidtree each' '
> 	echoid "" 123 321 321 >expect &&
> 	{
>-		echoid insert f 9 8 123 321 a b c d e
>-		echo each 12300
>-		echo each 3211
>-		echo each 3210
>-		echo each 32100
>+		echoid insert f 9 8 123 321 a b c d e &&
>+		echo each 12300 &&
>+		echo each 3211 &&
>+		echo each 3210 &&
>+		echo each 32100 &&
> 		echo clear
> 	} | test-tool oidtree >actual &&
> 	test_cmp expect actual
>diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
>index 67a3f64c2d..f6f00c7039 100755
>--- a/t/t1006-cat-file.sh
>+++ b/t/t1006-cat-file.sh
>@@ -283,7 +283,7 @@ test_expect_success "--batch-check with multiple sha1s gives correct format" '
>
> test_expect_success 'setup blobs which are likely to delta' '
> 	test-tool genrandom foo 10240 >foo &&
>-	{ cat foo; echo plus; } >foo-plus &&
>+	{ cat foo && echo plus; } >foo-plus &&
> 	git add foo foo-plus &&
> 	git commit -m foo &&
> 	cat >blobs <<-\EOF
>diff --git a/t/t1300-config.sh b/t/t1300-config.sh
>index 9571649c42..516dd8bfa8 100755
>--- a/t/t1300-config.sh
>+++ b/t/t1300-config.sh
>@@ -901,7 +901,7 @@ test_expect_success 'get --expiry-date' '
> 	EOF
> 	: "work around heredoc parsing bug fixed in dash 0.5.7 (in ec2c84d)" &&
> 	{
>-		echo "$rel_out $(git config --expiry-date date.valid1)"
>+		echo "$rel_out $(git config --expiry-date date.valid1)" &&
> 		git config --expiry-date date.valid2 &&
> 		git config --expiry-date date.valid3 &&
> 		git config --expiry-date date.valid4 &&
>diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
>index 17d3cc1405..bbc01aae34 100755
>--- a/t/t1403-show-ref.sh
>+++ b/t/t1403-show-ref.sh
>@@ -78,7 +78,7 @@ test_expect_success 'show-ref --verify -q' '
> test_expect_success 'show-ref -d' '
> 	{
> 		echo $(git rev-parse refs/tags/A) refs/tags/A &&
>-		echo $(git rev-parse refs/tags/A^0) "refs/tags/A^{}"
>+		echo $(git rev-parse refs/tags/A^0) "refs/tags/A^{}" &&
> 		echo $(git rev-parse refs/tags/C) refs/tags/C
> 	} >expect &&
> 	git show-ref -d A C >actual &&
>@@ -148,7 +148,7 @@ test_expect_success 'show-ref --heads, --tags, --head, pattern' '
>
> 	{
> 		echo $(git rev-parse HEAD) HEAD &&
>-		echo $(git rev-parse refs/heads/B) refs/heads/B
>+		echo $(git rev-parse refs/heads/B) refs/heads/B &&
> 		echo $(git rev-parse refs/tags/B) refs/tags/B
> 	} >expect &&
> 	git show-ref --head B >actual &&
>@@ -156,8 +156,8 @@ test_expect_success 'show-ref --heads, --tags, --head, pattern' '
>
> 	{
> 		echo $(git rev-parse HEAD) HEAD &&
>-		echo $(git rev-parse refs/heads/B) refs/heads/B
>-		echo $(git rev-parse refs/tags/B) refs/tags/B
>+		echo $(git rev-parse refs/heads/B) refs/heads/B &&
>+		echo $(git rev-parse refs/tags/B) refs/tags/B &&
> 		echo $(git rev-parse refs/tags/B^0) "refs/tags/B^{}"
> 	} >expect &&
> 	git show-ref --head -d B >actual &&
>diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
>index 67b9cc752f..d2ef0041f9 100755
>--- a/t/t2200-add-update.sh
>+++ b/t/t2200-add-update.sh
>@@ -153,10 +153,10 @@ test_expect_success 'add -u resolves unmerged paths' '
> 			echo "100644 $one 1	$path" &&
> 			echo "100644 $two 2	$path" &&
> 			echo "100644 $three 3	$path"
>-		done
>-		echo "100644 $one 1	path3"
>-		echo "100644 $one 1	path4"
>-		echo "100644 $one 3	path5"
>+		done &&
>+		echo "100644 $one 1	path3" &&
>+		echo "100644 $one 1	path4" &&
>+		echo "100644 $one 3	path5" &&
> 		echo "100644 $one 3	path6"
> 	} |
> 	git update-index --index-info &&
>@@ -173,8 +173,8 @@ test_expect_success 'add -u resolves unmerged paths' '
> 	git add -u &&
> 	git ls-files -s path1 path2 path3 path4 path5 path6 >actual &&
> 	{
>-		echo "100644 $three 0	path1"
>-		echo "100644 $two 0	path3"
>+		echo "100644 $three 0	path1" &&
>+		echo "100644 $two 0	path3" &&
> 		echo "100644 $two 0	path5"
> 	} >expect &&
> 	test_cmp expect actual
>diff --git a/t/t2201-add-update-typechange.sh b/t/t2201-add-update-typechange.sh
>index a4eec0a346..687be974d4 100755
>--- a/t/t2201-add-update-typechange.sh
>+++ b/t/t2201-add-update-typechange.sh
>@@ -97,17 +97,17 @@ test_expect_success modify '
> 		"
> 	} >expect &&
> 	{
>-		cat expect
>-		echo ":100644 160000 $_empty $ZERO_OID T	yonk"
>+		cat expect &&
>+		echo ":100644 160000 $_empty $ZERO_OID T	yonk" &&
> 		echo ":100644 000000 $_empty $ZERO_OID D	zifmia"
> 	} >expect-files &&
> 	{
>-		cat expect
>+		cat expect &&
> 		echo ":000000 160000 $ZERO_OID $ZERO_OID A	yonk"
> 	} >expect-index &&
> 	{
>-		echo "100644 $_empty 0	nitfol"
>-		echo "160000 $yomin 0	yomin"
>+		echo "100644 $_empty 0	nitfol" &&
>+		echo "160000 $yomin 0	yomin" &&
> 		echo "160000 $yonk 0	yonk"
> 	} >expect-final
> '
>diff --git a/t/t4023-diff-rename-typechange.sh b/t/t4023-diff-rename-typechange.sh
>index 47d6f35dcc..7cb9909293 100755
>--- a/t/t4023-diff-rename-typechange.sh
>+++ b/t/t4023-diff-rename-typechange.sh
>@@ -55,7 +55,7 @@ test_expect_success 'cross renames to be detected for regular files' '
>
> 	git diff-tree five six -r --name-status -B -M | sort >actual &&
> 	{
>-		echo "R100	foo	bar"
>+		echo "R100	foo	bar" &&
> 		echo "R100	bar	foo"
> 	} | sort >expect &&
> 	test_cmp expect actual
>@@ -66,7 +66,7 @@ test_expect_success 'cross renames to be detected for typechange' '
>
> 	git diff-tree one two -r --name-status -B -M | sort >actual &&
> 	{
>-		echo "R100	foo	bar"
>+		echo "R100	foo	bar" &&
> 		echo "R100	bar	foo"
> 	} | sort >expect &&
> 	test_cmp expect actual
>@@ -78,7 +78,7 @@ test_expect_success 'moves and renames' '
> 	git diff-tree three four -r --name-status -B -M | sort >actual &&
> 	{
> 		# see -B -M (#6) in t4008
>-		echo "C100	foo	bar"
>+		echo "C100	foo	bar" &&
> 		echo "T100	foo"
> 	} | sort >expect &&
> 	test_cmp expect actual
>diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
>index ebff6c6883..ec5c10d2a0 100755
>--- a/t/t4124-apply-ws-rule.sh
>+++ b/t/t4124-apply-ws-rule.sh
>@@ -233,7 +233,7 @@ test_expect_success 'blank at EOF with --whitespace=fix (1)' '
> 	test_write_lines a b c >one &&
> 	git add one &&
> 	test_write_lines a b c >expect &&
>-	{ cat expect; echo; } >one &&
>+	{ cat expect && echo; } >one &&
> 	git diff -- one >patch &&
>
> 	git checkout one &&
>diff --git a/t/t4150-am.sh b/t/t4150-am.sh
>index 2aaaa0d7de..103cd39148 100755
>--- a/t/t4150-am.sh
>+++ b/t/t4150-am.sh
>@@ -116,7 +116,7 @@ test_expect_success setup '
> 		git format-patch --stdout first | sed -e "1d"
> 	} | append_cr >patch1-crlf.eml &&
> 	{
>-		printf "%255s\\n" ""
>+		printf "%255s\\n" "" &&
> 		echo "X-Fake-Field: Line One" &&
> 		echo "X-Fake-Field: Line Two" &&
> 		echo "X-Fake-Field: Line Three" &&
>diff --git a/t/t4212-log-corrupt.sh b/t/t4212-log-corrupt.sh
>index 03b952c90d..0244888a5a 100755
>--- a/t/t4212-log-corrupt.sh
>+++ b/t/t4212-log-corrupt.sh
>@@ -20,10 +20,10 @@ test_expect_success 'fsck notices broken commit' '
>
> test_expect_success 'git log with broken author email' '
> 	{
>-		echo commit $(cat broken_email.hash)
>-		echo "Author: A U Thor <author@example.com>"
>-		echo "Date:   Thu Apr 7 15:13:13 2005 -0700"
>-		echo
>+		echo commit $(cat broken_email.hash) &&
>+		echo "Author: A U Thor <author@example.com>" &&
>+		echo "Date:   Thu Apr 7 15:13:13 2005 -0700" &&
>+		echo &&
> 		echo "    foo"
> 	} >expect.out &&
>
>diff --git a/t/t5316-pack-delta-depth.sh b/t/t5316-pack-delta-depth.sh
>index 759169d074..df524f7b6d 100755
>--- a/t/t5316-pack-delta-depth.sh
>+++ b/t/t5316-pack-delta-depth.sh
>@@ -57,8 +57,11 @@ test_expect_success 'create series of packs' '
> 		git commit -m $i &&
> 		cur=$(git rev-parse HEAD^{tree}) &&
> 		{
>-			test -n "$prev" && echo "-$prev"
>-			echo $cur
>+			if test -n "$prev"
>+			then
>+				echo "-$prev"
>+			fi &&
>+			echo $cur &&
> 			echo "$(git rev-parse :file) file"
> 		} | git pack-objects --stdout >tmp &&
> 		git index-pack --stdin --fix-thin <tmp || return 1
>diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
>index 1892d6615a..01468ce6d8 100755
>--- a/t/t5510-fetch.sh
>+++ b/t/t5510-fetch.sh
>@@ -71,7 +71,7 @@ test_expect_success "fetch test for-merge" '
> 	main_in_two=$(cd ../two && git rev-parse main) &&
> 	one_in_two=$(cd ../two && git rev-parse one) &&
> 	{
>-		echo "$one_in_two	"
>+		echo "$one_in_two	" &&
> 		echo "$main_in_two	not-for-merge"
> 	} >expected &&
> 	cut -f -2 .git/FETCH_HEAD >actual &&
>diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
>index 9d440e2821..c69cfd5c64 100755
>--- a/t/t5515-fetch-merge-logic.sh
>+++ b/t/t5515-fetch-merge-logic.sh
>@@ -191,17 +191,17 @@ do
> 		cp "$expect_r" expect_r &&
> 		convert_expected expect_r sed_script &&
> 		{
>-			echo "# $cmd"
>-			set x $cmd; shift
>-			git symbolic-ref HEAD refs/heads/$1 ; shift
>-			rm -f .git/FETCH_HEAD
>+			echo "# $cmd" &&
>+			set x $cmd && shift &&
>+			git symbolic-ref HEAD refs/heads/$1 && shift &&
>+			rm -f .git/FETCH_HEAD &&
> 			git for-each-ref \
> 				refs/heads refs/remotes/rem refs/tags |
> 			while read val type refname
> 			do
> 				git update-ref -d "$refname" "$val"
>-			done
>-			git fetch "$@" >/dev/null
>+			done &&
>+			git fetch "$@" >/dev/null &&
> 			cat .git/FETCH_HEAD
> 		} >"$actual_f" &&
> 		git show-ref >"$actual_r" &&
>diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
>index 05a58069b0..b68ec22d3f 100755
>--- a/t/t5562-http-backend-content-length.sh
>+++ b/t/t5562-http-backend-content-length.sh
>@@ -63,7 +63,7 @@ test_expect_success 'setup' '
> 	hash_next=$(git commit-tree -p HEAD -m next HEAD^{tree}) &&
> 	{
> 		printf "%s %s refs/heads/newbranch\\0report-status object-format=%s\\n" \
>-			"$ZERO_OID" "$hash_next" "$(test_oid algo)" | packetize_raw
>+			"$ZERO_OID" "$hash_next" "$(test_oid algo)" | packetize_raw &&
> 		printf 0000 &&
> 		echo "$hash_next" | git pack-objects --stdout
> 	} >push_body &&
>diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
>index b87ca06a58..1131503b76 100755
>--- a/t/t5570-git-daemon.sh
>+++ b/t/t5570-git-daemon.sh
>@@ -194,7 +194,7 @@ test_expect_success 'hostname cannot break out of directory' '
>
> test_expect_success FAKENC 'hostname interpolation works after LF-stripping' '
> 	{
>-		printf "git-upload-pack /interp.git\n\0host=localhost" | packetize_raw
>+		printf "git-upload-pack /interp.git\n\0host=localhost" | packetize_raw &&
> 		printf "0000"
> 	} >input &&
> 	fake_nc "$GIT_DAEMON_HOST_PORT" <input >output &&
>diff --git a/t/t5571-pre-push-hook.sh b/t/t5571-pre-push-hook.sh
>index b043a279f1..80e86d8284 100755
>--- a/t/t5571-pre-push-hook.sh
>+++ b/t/t5571-pre-push-hook.sh
>@@ -114,7 +114,7 @@ test_expect_success 'push to URL' '
>
> test_expect_success 'set up many-ref tests' '
> 	{
>-		nr=1000
>+		nr=1000 &&
> 		while test $nr -lt 2000
> 		do
> 			nr=$(( $nr + 1 )) &&
>diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
>index 04885d0a5e..97f10905d2 100755
>--- a/t/t7513-interpret-trailers.sh
>+++ b/t/t7513-interpret-trailers.sh
>@@ -156,7 +156,7 @@ test_expect_success 'with config option on the command line' '
> 		Acked-by: Johan
> 		Reviewed-by: Peff
> 	EOF
>-	{ echo; echo "Acked-by: Johan"; } |
>+	{ echo && echo "Acked-by: Johan"; } |
> 	git -c "trailer.Acked-by.ifexists=addifdifferent" interpret-trailers \
> 		--trailer "Reviewed-by: Peff" --trailer "Acked-by: Johan" >actual &&
> 	test_cmp expected actual
>diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
>index 5bb302b1ba..ee4fdd8f18 100755
>--- a/t/t8002-blame.sh
>+++ b/t/t8002-blame.sh
>@@ -97,7 +97,7 @@ test_expect_success 'set up abbrev tests' '
> 	test_commit abbrev &&
> 	sha1=$(git rev-parse --verify HEAD) &&
> 	check_abbrev () {
>-		expect=$1; shift
>+		expect=$1 && shift &&
> 		echo $sha1 | cut -c 1-$expect >expect &&
> 		git blame "$@" abbrev.t >actual &&
> 		perl -lne "/[0-9a-f]+/ and print \$&" <actual >actual.sha &&
>-- 
>2.34.1.307.g9b7440fafd
>
