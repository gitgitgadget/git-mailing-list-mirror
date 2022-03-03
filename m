Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E61C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 11:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbiCCLwH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 06:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiCCLwF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 06:52:05 -0500
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10044.outbound.protection.outlook.com [40.107.1.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9774F94FD
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 03:51:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfB+5A2SceduHi/EiTHXzUFgmIBuJ4jmUs2V/u1E0KTp3TxD1MSHuxeHzPGwSWDgrzlpMXUGppE+ytwALvK9PXB1hVlorEBPVfp5Iae5YjYqzLTb3aP04AwHsbCmsI2+a/mlEMciTWL5FR0P8T4qxlH+aVwkjVn0C0L8iXiK3LPyW0xaQzTYF6w7JzTtuUlCCUWb3Z8FxdMxo7vNAWJxhZvVHG1kUWHjNmtGrWYb1bccutp/+TyQIZ/fGY2OanCPBv5eqn4uOuJNTNdxEs1A6GjktnoUFpFPF6Pfwu5k1gknNcA4UWdWN+8ivvRFiHc3ztTe6UCwg5DfMvIDvz3Q5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jts/lLl/Wz4eGD9ozS19xmt1bBwTCN/lgt7tLWIRCUE=;
 b=VQrZcxeuoigqO452ZOYnFR+DHxw7a7MzA/aWbE1kFNjAQbLbRPlPoCG4c2+Ef8FKshENALuB8ZHv369TkD7XsCFSbJuhYQR6a2O4MG84lydqHLo+fQX82x6yBQDXEbsPunSP/GVql57Eaj/tgLTk51fBqw0pdI0EVa2yzlQthxpZs24Y4ld12UNtj0fqZeVUrEsAbXfbYcStQvoFNiQUtzSDPyjJguBqEE15BeIwglK6CVrfBaBCAM3BKrIH3Z60aJSU1RjNfEt92nQmcMrZGbTvzN3nykDxG7Kce4cFwzxuHgu7eC1a9YEl7QHIVR1ZCLOyzBY7FEIdkSYrE0MHqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jts/lLl/Wz4eGD9ozS19xmt1bBwTCN/lgt7tLWIRCUE=;
 b=dHQ9zDB3Nz3zYYm29Ba7Z3GhvaR/PhaEsrAOhtxqwGRhzGXekdFmb1dQSBlNEy3V+0Xs5VBv9KLqQb6UHs5KUJJBY65g8X33O7ePpNY4bcOKiGG4cheTydDOTju48tOYjW24MTv5T+mttcsUQlciqdK63QyAYzNqeTp9V24SmHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by HE1PR1001MB1356.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 3 Mar
 2022 11:51:15 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::116e:6242:98da:22ba]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::116e:6242:98da:22ba%8]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 11:51:15 +0000
Date:   Thu, 3 Mar 2022 12:51:14 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Henning Schild <henning.schild@siemens.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v3 1/3] gpg-interface/gpgsm: fix for v2.3
Message-ID: <20220303115114.7pbnggjccku44wqa@fs>
References: <20220224100628.612789-1-fs@gigacodes.de>
 <20220302090250.590450-1-fs@gigacodes.de>
 <xmqqh78gkvsm.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqh78gkvsm.fsf@gitster.g>
X-ClientProxiedBy: AM7PR02CA0008.eurprd02.prod.outlook.com
 (2603:10a6:20b:100::18) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf14abc2-f59f-429b-437e-08d9fd0c1f00
X-MS-TrafficTypeDiagnostic: HE1PR1001MB1356:EE_
X-Microsoft-Antispam-PRVS: <HE1PR1001MB13566CBE7856428545066BD6B6049@HE1PR1001MB1356.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rn8fFW6P3fbyrGLWW0MjQYHsURJ/WWmaghpt6qtRCJRy1lwlYeC1sGZh3npWgTBGt+xn5ZPMXlGozOfbyXzxS5LB1JD3mVIrEE4io3g3rS/ut1SGliEtkGIBWsoNuvL+6w1Z1yD5sErqG2Khbpo0D9Pp6KBFM6P3+hHkfU8gTBi0tQA8w/1fROjvEnmFs+MRIIam4ivsAdn6ncYTasX7g+hDAh6pnalKZSfttC3iB69xDcz4RpVgf4OrctFJQymSQkpAKBuXDU1z3g1TagBRirDgSI2QmSdedNFNtSC/UJcKCLvimOE2rwI7/68DWlIJ/oUGNwLj0vxOUOOdwr2cO4C3RaZW7aUxla0Ui+D/xUCeZdqDuENW5FoEPmqdbPrapo1OSF5zW0PiUe1Q3+DIkX9adLBF6rbQG/epyR3zNLa7iw0wKHiEyrapyTcdSc45XgzKpGjSmB1+9eyWqdVXzXZoq/z/eORDXnhigE+LCWDN0aBUsyQcFljUDOGn6kEi8GAHNuKRUDe3hfKG58zPkgCsrryaXYi2k462K/eLNBV7ZlpCmlNdq3C/S9QBs3VzcwmLpSa3Rc0FMVR8hIQMDd6W35Mpkd1ThfrQmNHt/zOMNKcS1ExWHcXVkYnb7q9EioXCDHceCu0FKxJzK6b9+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(39830400003)(346002)(136003)(396003)(366004)(376002)(83380400001)(6512007)(6506007)(26005)(186003)(53546011)(9686003)(6916009)(1076003)(33716001)(86362001)(2906002)(4326008)(316002)(38100700002)(66946007)(66476007)(8676002)(54906003)(66556008)(6486002)(5660300002)(508600001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0dUcG9QWEJnbDZkS1NnNUc2Wm5WRUpjTHNjL3E3RzJtWDViNmFwYVJGWnN1?=
 =?utf-8?B?NU85enI0aEVUVlJwM1FRQkJkRnJqL01vZm82SDlBNitXZzNicUhXdUFWZ2Q2?=
 =?utf-8?B?dVE3bmVHYnlPWDliRDN2VWhrZ2ovVytDY29kWGVoN1RjcWMrNDI4UEdqNnNa?=
 =?utf-8?B?eldWekVnd1ZKNjExMnpqc0NwZkg3SmJtM2Urb2hpSkV6SVQ5R29pSzlyU0Rl?=
 =?utf-8?B?SFBqaGlnaUNlZHJmS2VzQ3BOY1NJemhnbXpPQWdYSjQwdUFXTFBIdDNTd2Q0?=
 =?utf-8?B?Qkw2OUU4SjFFZ0l4YXBXVGQ0dVBqQVJvOGZ3dk5oSjRZZU9aS1FmYS9vQ0k5?=
 =?utf-8?B?VWdzT3h4cWlMcHNYNzlhSlJKMzIzUW5nbWVqMlkwcWpScEswZVo4Z1o2N0ds?=
 =?utf-8?B?SWhHRjlYUjVNNldYcDhmbjFJOWIvdmc5cysxYXoyUE9lcE1CVk05R2g5bWlX?=
 =?utf-8?B?YVFSQkJTZjZwT29OVVcwb1hmU2EwWUJVLzVjZHRpYWNSeUV3MUhHeWsrRkFv?=
 =?utf-8?B?WVVPa3hzRTV2bFNtbUdqb1l6VDl1L1c2QzZBRVl5QTMyZjJwQ2Y5R2hxdTVC?=
 =?utf-8?B?akY3WkFSZEllNlJTWGxTVU5kWkhyL1V3Qjg4RnZ4ZjVMbVErQ05LcHVOT2lZ?=
 =?utf-8?B?eVJTQ09HRzhRUWh3dVFzaU16RDRRRWJxTDZtUHp3dmt5Z2g5emRkOG43dytO?=
 =?utf-8?B?NmF4Y1BsMWt6b2dxM3h6T21oR3JHVlNzc1RTS1haaVNrTTRSZlJyR2N6emtZ?=
 =?utf-8?B?Wk9aVFVtbG9Ea2IyaTVMSlp6VHhZZ2tyNGIzKy9tZWVwNDhCR096K3UxL1RR?=
 =?utf-8?B?ZFpRR0N5ZDZwZFJPaU1kTTJJc25EVlozVW0yMUordXJwd3dUNktxTzVOY25u?=
 =?utf-8?B?SzBOWFAzQ0xyTklqc0FXOUsrL0Q5cHFOVEp6Y3c5NDV5WEkwdlB1M2xOK2w0?=
 =?utf-8?B?OVl1L3Q5QXFWL2V1akt0dUxwZURvcnpmTTQ3bmd2cWh6cmdBM1I2Nm9EQTZu?=
 =?utf-8?B?QTJLTXRKSTJHbkltZDlKcDJYNS9HOUx3dm94UHNEREg1RFpnUkdHN3BFRFlG?=
 =?utf-8?B?enQzQzl1QUpmWkNKNi9tT1h3L0QrSEx5Yk5yTkFIRFM0STEzMEhta25CUjZl?=
 =?utf-8?B?Q3dQT20rUndvNkQ3QzRjWElySFBoL01ZK3RJUTQrc0RsUHlpaXRLWmt3V0d2?=
 =?utf-8?B?NHlxeHBmemlZeE1oYm1hZU1XMzJWRXFMTkxYNTUyc0pWeUlyNFN4dk1QQTR6?=
 =?utf-8?B?ZWdjbktpZlQyMG1XMy9FcVVibkdJNkZpbW5sTlgvYzdMUkFsTGJqZDhmbmZ5?=
 =?utf-8?B?ZUd5ZHlZVWdXMDl3bkpkNWdBa2xleGhWUmRybUhKc09SSGViMERuV2h5dU9S?=
 =?utf-8?B?bkZjOFljMmVjUDlyUVFLbjRiVVdVb29RN3pPMlVsVHhrOEFpQWtRbjErRXR3?=
 =?utf-8?B?TW16RGZKbEdUTEFBNkxoQTlEYVpLelVqSFl4ZFFUeFhTaHRFYVN4c25IUjU2?=
 =?utf-8?B?S1VySitXWGtRNlVoUzZRNlR5MzZGL1NJbVBEam56eGQ5MCt1VWRVb29CODRZ?=
 =?utf-8?B?djNKeGdxQ05xd0ZlYVhaeDIvcjc0UnBMRGhkVWVTQjQ4M0l2bTdpeEJLM092?=
 =?utf-8?B?cW8xZ2wvSHJORXpjT1VXN2sza08vb3RFaGg0U0Vha0tXWHRabnk1NFplamV0?=
 =?utf-8?B?RWpGcmFaQm05TGkvQXRmTFIxYWJUVmoxa2F3Rzc3bWc5cCtKRlg3SFJrTDRM?=
 =?utf-8?B?NnV1djJ6eW9HWUw4UVpPNmRIZ0lTOE1TcXFwYjdnV1dCV1hWcC9PSDVrUEk0?=
 =?utf-8?B?YWxNS2pXK2RQUlNrT21ZdXB5VEpWY0dBQjRHY25BbXo5TmtRWnpvQXRaK0V1?=
 =?utf-8?B?WDFPa0hYakZab2xiODU2M1prNTJ3VVlkMUF0TndIbldmdGlUQ2F0NGsrcFcx?=
 =?utf-8?B?dzFVNnU3cFZaYzNjK2F6UkMwd2lrM2xCcDAxWlZxTUFCY2Y5dm1GWElac29Z?=
 =?utf-8?B?Tk5pUEJJeFJsQ2wwMGRhdk1hSS81ZUxKUkI2MTJFMEM5VWQwRll0MXUzcjUz?=
 =?utf-8?B?aUl3RUMwdVBWOTUvWk4rL0svbTF4bkVTUEVFcHZQN1hCd2tVNjdnRndWYlIw?=
 =?utf-8?B?cGlJSzNWWWxLTGFhZzJKc0VQVEpQUUgxNUlyZFVSMGh1T09pNlI1amhYbngr?=
 =?utf-8?B?NVA2dFB1Zmg4ZVNsU3RyNXZKZFRqRUtnMXZsQllhTmIrV2xXSVlvU05laTdz?=
 =?utf-8?Q?TvzpEL6BMcubj7w8LR70LRp1w4MJja/4tuAmaC9alw=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cf14abc2-f59f-429b-437e-08d9fd0c1f00
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 11:51:15.2743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfvzKRn8Wd5TG1VWDA4UmVtL/yAUQsVxbskoEYSlIgx/AfZMu6lSGjP9iSs891FFj1fXxzaZOxJX/W7qdRvpYCthYoIBV1TBX//eiwjRgzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR1001MB1356
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02.03.2022 11:18, Junio C Hamano wrote:
>Fabian Stelzer <fs@gigacodes.de> writes:
>
>> Checking if signing was successful will now accept '[GNUPG]:
>> SIG_CREATED' on any beginning of a line. Not just explictly the second
>> one anymore.
>
>"the second or subsequent one", I would think, but the code change
>looks correct anyway.
>
>> Switch to gpg's `--with-colons` output format to make
>> parsing more robust.  This avoids issues where the
>> human-readable output from gpg commands changes.
>
>Does this refer only to how parsing in tests is done?

If only refers to the test prerequisite actually. I'll update the message.

>
>> Adjust error messages checking in tests for v2.3 specific output changes.
>
>Does this refer only to the change to 4202 where "failed to find
>the" and the colon after "certificate" are made optional, so that
>the regexp can read messages from both pre- and post-2.3 versions?
>
>> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
>> index 3e7ee1386a..6bc083ca77 100644
>> --- a/t/lib-gpg.sh
>> +++ b/t/lib-gpg.sh
>> @@ -72,12 +72,10 @@ test_lazy_prereq GPGSM '
>>  		--passphrase-fd 0 --pinentry-mode loopback \
>>  		--import "$TEST_DIRECTORY"/lib-gpg/gpgsm_cert.p12 &&
>>
>> -	gpgsm --homedir "${GNUPGHOME}" -K |
>> -	grep fingerprint: |
>> -	cut -d" " -f4 |
>> -	tr -d "\\n" >"${GNUPGHOME}/trustlist.txt" &&
>> +	gpgsm --homedir "${GNUPGHOME}" -K --with-colons |
>> +	awk -F ":" "/^fpr:/ {printf \"%s S relax\\n\", \$10}" \
>> +		>"${GNUPGHOME}/trustlist.txt" &&
>
>The old iteration had (fpr|fingerprint) which appeared as if it were
>catering to both pre- and post-2.3 versions, but "with colons", all
>versions we care about would say "fpr" and that is the reason why we
>no longer have such an alternative here?  Just checking my
>understanding.

Correct. The `with-colons` always uses fpr pre and post 2.3

>
>> -	echo " S relax" >>"${GNUPGHOME}/trustlist.txt" &&
>
>This removal is because...?  I do not recall seeing the explanation
>in the proposed log message.

Switching to awk allows us to integrate this trailing info into the awk 
expression itself making this extra echo unnecessary.

>
>>  	echo hello | gpgsm --homedir "${GNUPGHOME}" >/dev/null \
>>  	       -u committer@example.com -o /dev/null --sign -
>>  '
>> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
>> index 55fac64446..d599bf4b11 100755
>> --- a/t/t4202-log.sh
>> +++ b/t/t4202-log.sh
>> @@ -2037,7 +2037,7 @@ test_expect_success GPGSM 'log --graph --show-signature for merged tag x509 miss
>>  	git merge --no-ff -m msg signed_tag_x509_nokey &&
>>  	GNUPGHOME=. git log --graph --show-signature -n1 plain-x509-nokey >actual &&
>>  	grep "^|\\\  merged tag" actual &&
>> -	grep "^| | gpgsm: certificate not found" actual
>> +	grep -Ei "^| | gpgsm:( failed to find the)? certificate:? not found" actual
>>  '
>
>OK.  It might be easier to read if we give two expressions
>separately and say "we can take either of these", i.e.
>
>	# the former is from pre-2.3, the latter is from 2.3 and later
>	grep -e "^| | gpgsm: certificate not found" \
>	     -e "^| | gpgsm: failed to find the certificate: not found" \
>	     actual
>
>Thanks for working on this update.

Easy enough. Initially I used a subshell and 2 grep calls but this is 
obviously easier. I prefer the static strings over the regex as well.

I'll send a new patch probably tomorrow and try to improve the commit 
message.

Thanks
