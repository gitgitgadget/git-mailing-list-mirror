Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35E5C433EF
	for <git@archiver.kernel.org>; Sun,  5 Dec 2021 11:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhLELkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 06:40:21 -0500
Received: from mail-eopbgr20046.outbound.protection.outlook.com ([40.107.2.46]:21478
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232600AbhLELkV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 06:40:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAaqOKrzyHZeppbLL8bS4mSf8BI5qUVwaxb11KRXjUC8UliycAvM/KaA1QFFHTo2atBzYIu9AiEw4TXxpxILpCNVsJHxMwcQhtq5pItnWwzYp+y3b7e1/utTi/JzVa6f2mRpzCkmjbMT70q3+J3/6mTARMul5xOftSmoE7bNEi+S0eYPJfng513cV3vImSIRdOWpzp42P2pmJuSACgBe8pdvecn7ul7f038Yb3eY9V533jzua1hN4kG3qFtpvNDkyuy+TBo0qz7yvUi11mRBqFl9nd5WJ0VBgftYFru55bOhLlGdzlCUOzl09DCR7D/ZF+BhCdeq37fKquR1TswNEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqJ/RxZ2umx5kus/AL3LNlVmZ4c9z0HpUwj4cw9pXPM=;
 b=c5l580ugZHrTsNvZSLSrgcH3X/qyopKoVvpQZIPlL5h6+XU0e1ONnTTP74aUNB2D311vc/g5swrc5tWQq+akuh+Hjj/EZ8tN0gjc0yShTzzgvfXs8uUzCsKpQH+sNqaFsX6F3FJ7I4ksLYzUVWyoLXx5tZplsk4mpV4nsPBpvDvOrt/SP+LPff0owDU/V+72MCjLgTQKEh/fWVG0JmIkVGuILlGkm3u2b1fmPv17Ag3o7B9T9Fl4ZC2cjwxZzMIO2rZnYoWBM9yi6sgd4G+27qGtuGjoUxtiTPmUCrymxY7QYaHwz+jUoRxPubn3w7xOXHfrvZc7H11oWfRy9AVIhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqJ/RxZ2umx5kus/AL3LNlVmZ4c9z0HpUwj4cw9pXPM=;
 b=Ch23z66RFz5XkRA/4XYcntoFE3I97mACNIFka3wfWJMlY2aFOQpCWcYRaDPcufEN8uE5K5VqEWzx54qgJLPA/97cKCK9D6t3vQARk1gXaW7Yu02OV3xfNEIuahpd4eMfp2Jf0lYIIpSXH3iHqciLup1kUmAkDkwaeDVTpmi+pes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4158.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Sun, 5 Dec
 2021 11:36:52 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Sun, 5 Dec 2021
 11:36:52 +0000
Date:   Sun, 5 Dec 2021 12:36:50 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Git SSH/GPG signing flags and config
Message-ID: <20211205113650.33hndvacye2fjwkh@fs>
References: <20211128125704.4twinfd3wriwdntz@fs>
 <xmqqzgpn50l6.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqzgpn50l6.fsf@gitster.g>
X-ClientProxiedBy: AM6P194CA0103.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:8f::44) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2a02:908:178:20a0:1f30:d184:2751:e10d) by AM6P194CA0103.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:8f::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Sun, 5 Dec 2021 11:36:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6455e40a-f9c6-4ea3-1191-08d9b7e3880b
X-MS-TrafficTypeDiagnostic: PR3PR10MB4158:
X-Microsoft-Antispam-PRVS: <PR3PR10MB4158C03D7B8D84B1B30C9380B66C9@PR3PR10MB4158.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /VEyT0lsQFiQe8FPr7NdLpqTWPVZ4kNh1ns9p07QQOPmVJLVRk/EhT1xcXc73wtO8Fxjk1KiPt41KefWcNuMk/ApVqPf/99f+SOAGsq0kETy5WHTSIHWxLodfU349bwcb7OZtSVZ3jNT0u1yJKRCchr+dUK24PPGTnR450K7vdbX+DldMIeMtuA3U0EI7uBisJ9Mf5SFbbB2d1VxzLTrUELB3TNpSgFRHymQIhmuKKNOPmr9iGNFTHbFciUe7EEHFgMxPPwbLjuOB0r0DWdUUEeWtwqlkVJE9eXOOd2rn4F6LvJ7HBiHW5JpW1Th3nOSU5gkTilfPQlbR2SezVkHXETWSahV+hP2l7mLkRd/xCfEejakAe+kK/X1hEI5DryyCek78GG1Md5q2pTdEavX82gVWTGKd/BZjq+8wZ6flRIjTId3szL7IKfN+UY3qFR3TL2GGKHtghBSws0FFnL2Cgu65wwywd7DPECT4yGwuf8z4mkQ843viG+H/uvAe5emj4oXHv6dRggBOFpnG9ATq+V3N1jOXUMYFERn9it7kQlnNq48pJ0j10BC9YS2HlHyfPDuvJeomT8yP/KwPHZjN6auEzD8XslPkxJmfsCtr0hSQTccZdTSNvUyhptGMy4QHpxsI14T05gojSBC2TOatQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(136003)(376002)(396003)(346002)(366004)(39830400003)(66476007)(316002)(83380400001)(66946007)(86362001)(66556008)(53546011)(1076003)(186003)(5660300002)(6496006)(6916009)(38100700002)(508600001)(33716001)(4326008)(9686003)(8936002)(2906002)(6486002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1RPeU5HQzNTUjhGcmtXY1JFa1kxZ2dDNk5NaUhiMFEwV01uVTB4NHRuYjVX?=
 =?utf-8?B?dEJoZ0hxbi9MeHNSQVB0aldVaWxZZmR4K3FTNVZtb1k0em9PZEo2ZXFTWHRr?=
 =?utf-8?B?SDFvR2tCS3pJMHc1WnFXY3RiSTFmL29SRFBacGlXZktuWWRneXl2QzI5WlFL?=
 =?utf-8?B?MlVTNTJQcHZvTzA5RjYvUFhPTEtQVmdYMGRWU1I5US9IM2VIVllsd2FrQ0tW?=
 =?utf-8?B?R1pra2I2MzBucFBTeS9WUXNNcmtpSHAxNXl1dHNxenhRL2NPQ1VXQUFqMERw?=
 =?utf-8?B?b1NJY0pZcTluODlUVWluYjBsRDdNTW1WckNKSU1TMzdLdzR2UHpIV0ExRnB2?=
 =?utf-8?B?d1c3NW9PU1hXSU5nQ1QwMkZaZDBsc0RqOHpaZW9PWEQ1V29oSWFNbkRKTWRz?=
 =?utf-8?B?R0x4N0xnTnVQejNVSXZaZnRQdkpuUWJTT0VxTFRFbVFyVEJEZmVobjdseGVP?=
 =?utf-8?B?MVk1b3BPbTVYbmdhOGZzRkQ5Y2U2ZXZ4VjJFV3BNSU1PRFZvdGFQTE5xdlpM?=
 =?utf-8?B?L0RTNm9oeVpBRWJ2TGNZblFYZzhpdUtMRmljREcvdm5jSVdicUVuSmI0STdJ?=
 =?utf-8?B?Z0MvYnlIRno4UE5ZMklnSTJNWUJpc1UrR3N1cXFIZEErcnVkOTlaOWZWcHhF?=
 =?utf-8?B?NzhDY1JiMVBLM2V0T1BCcHVmN241NllVSG1UOTV0Q21tTEtaUm9ZSytsWHlI?=
 =?utf-8?B?clgwRWJCTnlYT2s5MXJQeGI2NzNnTnFhbjJMVmY1clIxVEN3RE5YQ3FaVkQ0?=
 =?utf-8?B?dUJzWHVZWjNWY2d0OUh2Y0NPUFl4RzBwTlJlUWl0UUtCZWEzYWtkUGdWaytU?=
 =?utf-8?B?ZFJhanhiNUtTM3hxZVNibXNka0RaTlVIenpXOGN4V3k4eCsyUGMvLzlPYUxQ?=
 =?utf-8?B?MUhVR0VyOHNHSkhxUkx0ZWdnL0trMm9kbkM0dmwyR2U5czJPdXpQQ1VhK3lP?=
 =?utf-8?B?eGMza2Y1TG4ydmZQU3dDWHpPc1ljUUIzQmtMaXQrcVV4VU13VDNxeDY3Vno1?=
 =?utf-8?B?elVPQ2t4alhEZ2cxbnJFNXAvQUFPZ0JIbUJxeStEMzJpOU9qS08xWk5RZENi?=
 =?utf-8?B?Nk0zbTAwUE1pTWhraW8vZVFzbFRXdHRjN1I5MjNVL3Y2SDA1TXBLdGdkOVJs?=
 =?utf-8?B?aTlGTS83T3B6ajhMalpvRGl4bmRYNnZlVURvK1grL0pYWVpMb0xlRnppRDVG?=
 =?utf-8?B?M1QxdjduK1JiQXVtWGlrRXgyUHJiRllHUVpjZksycDcxcmVZWVYwSVp5cjBk?=
 =?utf-8?B?QU84dGZ0VEcxSGhTVTZCb3lWSVFUM1ZnWllMVjNneUVaQ3BBUzBHbHVsRkxj?=
 =?utf-8?B?UWJtZ2F4T2kwUFRYOHcrV1VFbnBlL21aNWhaMHFaRmk5RTVycXBLZkh5bXBw?=
 =?utf-8?B?WXFxNzRuL2pZQkFBM25EWFdvUFNzbnQ3eWZoWGQ0R0tMN2RuVzhLcVUwaXVy?=
 =?utf-8?B?Z1I2ODVLMnhpQ0tSS0NwbGo4OFd1aXpqczRUUkcwY21JVDhhZGxIZkhwMHVE?=
 =?utf-8?B?SlNTVnVXdTgyQjlhd0tqdUNYSTRaajQ0N3VVREkrMjJUZjByWkpvNlNWRzBz?=
 =?utf-8?B?NkR1K3BvTnF5K1JLZU1JZTZxT0hsQ2psblJBcEZjdUlySWh1TzZrcUJIWEFJ?=
 =?utf-8?B?RHFOZThOc29IWVdOeHFJbXFNUXNaOCt1L0ZqbmZzOThBU1RYOS8zNEswRUFJ?=
 =?utf-8?B?K0trYXViRkRpKzFUbzloRnpoSGlsNXJhL2JqK0ZhcjhHU0NXQ0VQOFBvdFNV?=
 =?utf-8?B?ZEtBTUFJdjYrSWdidldpMFJqZVZrMUtGd3M4RTIzcFY1bXRNdG1OK3dDSU5n?=
 =?utf-8?B?c1ZJaHNNV1hoRExJbGRDQ3dRVWFOb1lhQk1idnhBbHpxREtiSHVaeHRHd09m?=
 =?utf-8?B?TE91a2lIc3Evek5BZUZqdXBSQnNKTXBtL2I3dFdxbE92Mlptd2N4UlIreXIx?=
 =?utf-8?B?THNTbnh5d2h6N21vRWo0czRrSVZhUHVLSEJEQXN1d1BGOXFnOXU2ZzNmV29H?=
 =?utf-8?B?ODE1cWZzQjFkMnh5aUl2QkN3OGVWZWZqOHdVVWdVcFd0TWFVUW9mQy9qMFd3?=
 =?utf-8?B?ejRFTWlNOHdFSTZPZ0t1d1VGTXpMU1dSc2tnMkxMQUF6WG56Mm5HOHhKQS8y?=
 =?utf-8?B?Q1JaQi9CRld6SzM0Si9FblB5d3VjNzBZeTF6UW1OWUN2K3F3MnFQdk5aYnY1?=
 =?utf-8?B?U0pNcUpndTk3LzlheUpWbHhqSWZ4cSs3UXdaQVpGeWp0M2NOemdOcUc0aGw3?=
 =?utf-8?B?azdEaTdpNm9mNEVBamlXY21oZW1JVWZlNmY5aHhNM3NWVGFmc1hIQkdZc01h?=
 =?utf-8?B?dDBlN3QzMXJ0dnpwZWhMWXIvWEkvVU9VSkNSWW01WWNhTVZBbFpBRlpwbVNn?=
 =?utf-8?Q?6TYefC6oCN8fpmVw=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6455e40a-f9c6-4ea3-1191-08d9b7e3880b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2021 11:36:51.9055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dZReCCSQt8/JbPhU2YdRJBXnZrbXIiSA5usWoIrnmBwl98/nEKYvBThLo1UXGCsOyCy55rS77B6hK3nfaiwVbUhcR4c2cS+kqXntn4pKXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4158
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28.11.2021 15:20, Junio C Hamano wrote:
>Fabian Stelzer <fs@gigacodes.de> writes:
>
>> Hi everyone,
>> the `signing git objects with ssh` series was released with 2.34 and
>> i'd like to thank everyone for your support and the good reviews!
>> I think it would be beneficial now to adjust some of the wording in
>> flags and the config. Currently everything is configured via gpg.* and
>> all the `please sign this` flags are named --(no-?)gpg-sign.
>> I would be in favor of a more generic flag independent of the signing
>> mechanism. Adding something like `--ssh-sign` would suggest that you'd
>> be able to switch signing format with it which i think would not be
>> terribly useful. If you need to use multiple signing mechanism those
>> would usually be configured per repository and can easily be done with
>> an `includeif gitdir:` in your config.
>> Therefore i would suggest just adding a generic `--(no-?)sign` to all
>> the commands that support gpg-sign right now. The only problem i see
>> is a conflict with `--signoff` so i'm open to other naming ideas. The
>> same goes for the config. `sign.` as an alias to `gpg.` would work
>> well with the current settings.
>> Let me know what you think and i could prepare a first patch for one
>> command to see what the alias / config / docs change could look like.
>
>I do share your worry about --sign to be confused with the sign-off
>procedure, and that was why the original used --gpg-sign.  We are
>extending "gpg" part because "gpg" is not the only cryptographic
>signing protocol we support, so perhaps --crypto-sign would still be
>in the orginal spirit of "This is different from the sign-off, but
>is a cryptographic signature, but it is a mouthful.
>
Even if it's a bit much, including the word crypto makes it quite clear what 
the flag does. This is how this could look for `git commit`. I would do 
something similar for the `gpg.` configs and alias them with `cryptoSign.`
If this diff is acceptable i can prepare a patch series for all the commands 
and the config. Not sure if we want to mark the gpg options as deprecated.  
The problem is that the flags could imply that gpg is used even if another 
format is configured.

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 6c60bf98f9..67fc77dc1b 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -387,13 +387,18 @@ changes to tracked files.
  	default commit message.
  
  -S[<keyid>]::
+--crypto-sign[=<keyid>]::
+--no-crypto-sign::
  --gpg-sign[=<keyid>]::
  --no-gpg-sign::
-	GPG-sign commits. The `keyid` argument is optional and
+	Cryptographically sign commits. The `keyid` argument is optional and
  	defaults to the committer identity; if specified, it must be
-	stuck to the option without a space. `--no-gpg-sign` is useful to
+	stuck to the option without a space. `--no-crypto-sign` is useful to
  	countermand both `commit.gpgSign` configuration variable, and
-	earlier `--gpg-sign`.
+	earlier `--crypto-sign`.
+	`--(no-)gpg-sign` is a compatibility alias and has no effect on which
+	cryptographic format will be used. This is determined by the
+	configuration variable cryptoSign.format (see linkgit:git-config[1]).
  
  \--::
  	Do not interpret any more arguments as options.
diff --git a/builtin/commit.c b/builtin/commit.c
index 883c16256c..2c789ff6f9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1639,8 +1639,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
  		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
  		OPT_CLEANUP(&cleanup_arg),
  		OPT_BOOL(0, "status", &include_status, N_("include status in commit message template")),
-		{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
+		{ OPTION_STRING, 'S', "crypto-sign", &sign_commit, N_("key-id"),
+		  N_("cryptographically sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+		{ OPTION_STRING, 0, "gpg-sign", &sign_commit, N_("key-id"),
  		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+
  		/* end commit message options */
  
  		OPT_GROUP(N_("Commit contents options")),

