Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232FCC07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 08:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0600761183
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 08:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240672AbhGOIXL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 04:23:11 -0400
Received: from mail-vi1eur05on2063.outbound.protection.outlook.com ([40.107.21.63]:12001
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232568AbhGOIXL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 04:23:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9goAd8l2M+Ulu0VccyQoa0/Ot9GaGL8n6wFHdxXBJnJ2JofhWPN8AyO1dY1HjMl0j/K4qXS9hMf5KUas1gqlfu+FJcAsrLybCFcZbFPulH7h51XKC7ssw++zwcILX2HTY8KocXsUMH9uBsBtsg4PRf7tM5ZnSbKippCdomGRuKerwB+UU9ABh8yxyhLR7N9kK0nT8CGUPaNQjmAXLhfnzdLSczh2POkN4aowYMvIwXuIuKh/zRb3PmoevsPr6IjKyjREn6x2y08z5EN3/et2lqW289WTg08upGjxq+5bkOJlieQXeTSLf24h3clzCBBlQ/tySzVKZi2nwQb2ihLXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xujtMeHpohS34ENXxxDUNhlLLfOX8CK07tbesve7izs=;
 b=kzo/ABlSEvktiLvEEzf45Y3M181v23rbA61ZOZMEWVQJZPd41Cw5L2aHcSDaGyTySXeqJba3QjYdKC0yClZ04B5PySnHTJqkc6wZ5wviP8EHsgYEObNZAZaMHfnWjxeDCwqd6HpCZEo4EOPN7ZvFytvAnC0eI8zLpOwDOuHFNurfUsFtti6g/pDPuSIXHKF3WA41kYcwF3Ux1d61tym/uuZxidPiZlxdwCFQr8UCJdGcjwCvIwR0TyhuRvyxDsCIbnRYLhdF+Ywbfzn8T2AyVVlUJWEPxyStfDvKjAunic6YO2z2327k3qtGJLyttMkC5+FNxtV9534gPAEj9XEahA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xujtMeHpohS34ENXxxDUNhlLLfOX8CK07tbesve7izs=;
 b=oce6ot5pPS2GkSXL5wb0ygbQl99epojW8kTbsknzZXrZYolWDww/OrOgY9yoPGLD+rED5Vw+0pN3x1ZNqbyoTLQW3yggBQZCXsREFqUXNg1c/LxHynLn1Rx+QU7DaIAZYvFYmHq+986g+8sxDYf7bj/GrTSBsjVE+8zV2tGzClM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4272.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 08:20:15 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa%4]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 08:20:15 +0000
Subject: Re: [PATCH v3 1/9] Add commit, tag & push signing via SSH keys
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
 <390a8f816cda0574cabe49e9f88ae1803142fb51.1626264613.git.gitgitgadget@gmail.com>
 <xmqqlf68wyfa.fsf@gitster.g>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <d851e0ed-775c-b2de-ea40-c915781d8869@gigacodes.de>
Date:   Thu, 15 Jul 2021 10:20:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <xmqqlf68wyfa.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PR1P264CA0026.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::13) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8] (2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8) by PR1P264CA0026.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19f::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 08:20:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6da22fed-919c-467c-559c-08d947695fea
X-MS-TrafficTypeDiagnostic: PR3PR10MB4272:
X-Microsoft-Antispam-PRVS: <PR3PR10MB4272A489B2713C09B3FA893DB6129@PR3PR10MB4272.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qF/9VwJ+ovmwgvCHV66er7bVwGP20+i9SScr7K/B5mRt3BcYw6q+hrTGU8wfhphJGoRY9GPR3Cp1RDVEtq98xT2b2XVhd/IgprmSmOVeJwsFNKkrQL5VdT0Kgzms7X2un7AHP8IKNhok2VhZe/NB3R6yzdkYRPyw2GNgmZWSP1+uyUknom8hd7if1qxrDKBm4y4aa8qnnJZhS5GnrcUIgJht94BiiqUWqa0sGHsIW5c+thhoJQcrCGDgaSvIuHNO4YjFyTQ1aWVDEVMpJixISopgzBfxq8dOFQ87/TAetyFbFGv/xSe9s1gK3S4rlldM9AJt4xAaPbezhwbUyfugss7LvIDHiDvq8tyYp/ATAtYQBlGSyZKoUXQQ8pZcpluJZdy8spNbJfrk270zsH7SWJKFBbX/PR32J5uJJpl4CGM4I7UcZvoJvVOPmYw3FBVT0D4KVGtZ7o3kcJLCUnei6Tdlc4grGIdm/TqnUwX7NWIjFAf8jTxStZToMIiDQ2t0dor2EtjVM8Pxt8D7fwZyCIHevw/NA/6E3cs+BDl/g6RiVc0hxLwlSn/B25kxWhsXj3Gh1jXbsYYpZFr7z3lOB7Fz2eYOSGEAw92nXziLmpzEr4CaZuWL00MdsjotRe8n+h24vfEMEm/NXS8tyLhap4/h5NheCK2kSFQHDkmapUxiQddAA/SEtoF6UDZWBDuhTSohV1hMDUvzEmNvCUw4+nOmeYWi92OIafQFoBpMnitZsycni7frSLN08qCyx4gz/iCf9bCNDWugG+x6Ff7zYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(136003)(39830400003)(396003)(36756003)(52116002)(31686004)(8936002)(2906002)(66556008)(66946007)(8676002)(478600001)(2616005)(5660300002)(66476007)(53546011)(966005)(38100700002)(7416002)(186003)(86362001)(54906003)(316002)(6486002)(30864003)(83380400001)(31696002)(110136005)(4326008)(45980500001)(43740500002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVZxTno1WEt6bU1SOXd5bGYvSVZyTzBGb2l2K0c0T0FFaXBDL2hNa2h1RER2?=
 =?utf-8?B?Z3k0NGFvb0VrMXFqMnZXaDBNZ1l5VmxuR3MvOXJJUjlIN1o5dG50U2RyZHIv?=
 =?utf-8?B?cERwVmQvY0VxOWJFbHA3TXBDcG9VOU93KytHWlRyRTdzazhjWE1HYmt3UjJE?=
 =?utf-8?B?SHZuMzA2Vlh3N0FVUG5PVWNxVzloUnhBZTNpVnhESHVBUmhvYU5Eb0NEYjc2?=
 =?utf-8?B?VWpJVFQ3UmR5azIvbDZQb3NwM1hocnlERUgxQzhJbktZak56QWhyV2pNRzNT?=
 =?utf-8?B?Q1AxOFZWd2orVDdJdE95ckZMK2NsSFNtZE1tQitxZWZDMzF3WktFSFZtVm45?=
 =?utf-8?B?TE1HWXJqMktnaEVFVVN4RUs3T2lzdnRSWDlJVGx6alFuUkJyVll2WG84SVhK?=
 =?utf-8?B?SlBLdEFSZmYwclJJNHhUN3ptSmJ5dzJ2ZVM1a3FxZkY5Mng2M2czME5ZZmd0?=
 =?utf-8?B?VXlBdGw4WUQ4UXdJR2VkazFIblcvVG90ZlYyWDZFemZsbHJ3U3dYQW04bUtT?=
 =?utf-8?B?enRCTDM0djdIZVc4STVPYlpSekdyWG8xYlZsRmpXU1ZkdW5UWko1ZG9xQmVD?=
 =?utf-8?B?NzY2Y2JKTEY1dlVCellKLzVneTVyMEtlbEw2TEJSTDAvYWt6YUwvOS9KcVV2?=
 =?utf-8?B?dUdqTk9PN05WSGlhS1JZRHd6WXUwSDZCd21uTjJ6dUgwRFNpT2JZU3VncXZj?=
 =?utf-8?B?dGRQR3o1ODlOb3o1UkF6UGVGK29ZUG15U1M3anlZSnBTRHRRc25xa3Z5bWht?=
 =?utf-8?B?Z29CbExMTVFjUU0vakxDK1VuUUpQa2d1bjRzamgvaURFUFIzT2ZnVC9EUHRO?=
 =?utf-8?B?Z1BWS3BGWk5rK3pNektWVmFCUDF6UW1VZE0rK1JyRC9HbFgvZDZ6YnhVZ21x?=
 =?utf-8?B?ejFHdDVpRmE0YkFvSWF4MVBiQXBiNGEzM0FIbWF3M1R1MVliOEpSclhnVFlv?=
 =?utf-8?B?T05oRGtyQ0FPYmhPSlpCenBpdGwraWZDNnh5QXAwS0lKU3VRMzJONy92UzEv?=
 =?utf-8?B?U0V2RjFTaG0zUzVKUVo4K2o2Rldja3hWZWxJTWxKYUZUd2VnTFdDZ2Jma2ht?=
 =?utf-8?B?VGVrbzE1aDM2NTNzRk4zQzdJblB3T09sSjI1SU0yczRLTnc1aFozd2tDZ3c1?=
 =?utf-8?B?YTd0dHV2QUJCUTJ3MVRLcDFpMVVBSWJ1SFcvaUVvRGVzMVlGV2RQVmVlazhI?=
 =?utf-8?B?emE0a3RVOXlsVTM1b2xCK2xhZWtCREExdnpreUxYUTI1bjF4QXpHaGJ5ZDgv?=
 =?utf-8?B?SWpaMGxqRjBDMW91ak01U0F1QjdhVzZoSVM1bktqQkx2OGlXOVpobHZaMWhj?=
 =?utf-8?B?cDZ1R1B6STNJSVRXWFpOVDRWNHMrZWZXRHM3dWd4TTROOWlyQzl6QVc1ZU5o?=
 =?utf-8?B?S2FGQzZOQmRESE9TK3RaWlFzeG9lOFc4MjRxL05wOTEyMnF1ekRITmdHdldL?=
 =?utf-8?B?eHR1RW5pc0o3aUdxSXFIbFhUN1ptZ3Jjbzd1MXhDNmRWUDZ2a1RqK1greUhq?=
 =?utf-8?B?VHFJTWo1QjRrRUZGUUtGeUduS2Ixc295RVYyMG5rbm5MQ0JJeW9KdGo1OXFK?=
 =?utf-8?B?b3ZuNndrbVNnS3BtbDdYR2I0MThMQXY3cXFVdUFmeGtMNzk5VGZadFVHbVJG?=
 =?utf-8?B?cldYNUdFdVZzOUpHT3ZOZmRxQ1VOTGJ3M0hmVDFnVnc0aTREVUVvblFyM1Vt?=
 =?utf-8?B?T1lnQzN3N1FyQkcrdEU5SzdjQVNKZDRqK1NiK3dLQzVEK3VlR3NtUmJ1aXdN?=
 =?utf-8?B?cm1UczBma0RZT25adTlmd2tDK3cwMVM2Z3FMTzdwQkFINExNOWsvbVVjeVFk?=
 =?utf-8?B?UkxYeFFEZWJKV1MvMm9oNElGQWQ3QzZsR2ZRbVQ4TGRzZjhveitSaTZyb01Q?=
 =?utf-8?Q?0zStnt8/17KQE?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da22fed-919c-467c-559c-08d947695fea
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 08:20:15.6992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWc1d9TZB18fzHIOJCDQD8+XWoWEowCnhDKuaug1qeVS6hIHSNxXoCV2ek+8dT8LUqZC6x7xu7vr76FXHX4xMizgmT85U3W/Xam761hKGrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4272
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 14.07.21 20:19, Junio C Hamano wrote:
> "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Fabian Stelzer <fs@gigacodes.de>
>> Subject: [PATCH v3 1/9] Add commit, tag & push signing via SSH keys
> If you chose "ssh signing:" as the common prefix for the series, use
> it consistently with this step, too.
done
>
>> Openssh v8.2p1 added some new options to ssh-keygen for signature
>> creation and verification. These allow us to use ssh keys for git
>> signatures easily.
>>
>> Start with adding the new signature format, new config options and
>> rename some fields for consistency.
> OK.
>
>> This feature makes git signing much more accessible to the average user.
>> Usually they have a SSH Key for pushing code already. Using it
>> for signing commits allows us to verify not only the transport but the
>> pushed code as well.
> Drop this paragraph or at least tone it down.  It may hold true only
> around your immediate circle but it is far from clear and obvious.
> I'd expect more people push over https:// than ssh://.
>
> We do not really require a new feature to make much more accessible
> for wide average user---making it just a bit more accessible to
> folks in your immediate circle is perfectly fine, as long as you are
> not harming other people ;-)
i will redo the first commit with your suggestions from below only doing 
preperation for the upcoming change and then rewrite the commit message 
to reflect this as well.
>
>> In our corporate environemnt we use PIV x509 Certs on Yubikeys for email
>> signing/encryption and ssh keys which i think is quite common
> Upcase "I".
>
>> (at least for the email part). This way we can establish the correct
>> trust for the SSH Keys without setting up a separate GPG Infrastructure
>> (which is still quite painful for users) or implementing x509 signing
>> support for git (which lacks good forwarding mechanisms).
>> Using ssh agent forwarding makes this feature easily usable in todays
>> development environments where code is often checked out in remote VMs / containers.
>> In such a setup the keyring & revocationKeyring can be centrally
>> generated from the x509 CA information and distributed to the users.
> All of the above promises a wonderful new world, but what is left
> unclear is with this step alone how much of the new world we already
> gain.  When you ask others to read and understand your code, please
> give them a bit more hint to guide them what to expect and where you
> are taking them next.
>
>> diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
>> index 0f66818e0f8..1d7b64fa021 100644
>> --- a/fmt-merge-msg.c
>> +++ b/fmt-merge-msg.c
>> @@ -527,10 +527,10 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
>>   			len = payload.len;
>>   			if (check_signature(payload.buf, payload.len, sig.buf,
>>   					 sig.len, &sigc) &&
>> -				!sigc.gpg_output)
>> +				!sigc.output)
>>   				strbuf_addstr(&sig, "gpg verification failed.\n");
>>   			else
>> -				strbuf_addstr(&sig, sigc.gpg_output);
>> +				strbuf_addstr(&sig, sigc.output);
> These are "rename some fields for consistency" the proposed log
> message promised.  Makes sense, as you are taking the sigc structure
> away from pgp/gpg dependency.
>
>> diff --git a/gpg-interface.c b/gpg-interface.c
>> index 127aecfc2b0..3c9a48c8e7e 100644
>> --- a/gpg-interface.c
>> +++ b/gpg-interface.c
>> @@ -8,6 +8,7 @@
>>   #include "tempfile.h"
>>   
>>   static char *configured_signing_key;
>> +const char *ssh_allowed_signers, *ssh_revocation_file;
> Very likely these want to be file-scope statics?
true
>
>>   static enum signature_trust_level configured_min_trust_level = TRUST_UNDEFINED;
>>   
>>   struct gpg_format {
>> @@ -35,6 +36,14 @@ static const char *x509_sigs[] = {
>>   	NULL
>>   };
>>   
>> +static const char *ssh_verify_args[] = {
>> +	NULL
>> +};
> A blank line is missing from here.
>
>> +static const char *ssh_sigs[] = {
>> +	"-----BEGIN SSH SIGNATURE-----",
>> +	NULL
>> +};
>> +
>>   static struct gpg_format gpg_format[] = {
>>   	{ .name = "openpgp", .program = "gpg",
>>   	  .verify_args = openpgp_verify_args,
>> @@ -44,6 +53,9 @@ static struct gpg_format gpg_format[] = {
>>   	  .verify_args = x509_verify_args,
>>   	  .sigs = x509_sigs
>>   	},
>> +	{ .name = "ssh", .program = "ssh-keygen",
>> +	  .verify_args = ssh_verify_args,
>> +	  .sigs = ssh_sigs },
>>   };
>>   
>>   static struct gpg_format *use_format = &gpg_format[0];
>> @@ -72,7 +84,7 @@ static struct gpg_format *get_format_by_sig(const char *sig)
>>   void signature_check_clear(struct signature_check *sigc)
>>   {
>>   	FREE_AND_NULL(sigc->payload);
>> -	FREE_AND_NULL(sigc->gpg_output);
>> +	FREE_AND_NULL(sigc->output);
>>   	FREE_AND_NULL(sigc->gpg_status);
>>   	FREE_AND_NULL(sigc->signer);
>>   	FREE_AND_NULL(sigc->key);
>> @@ -257,16 +269,15 @@ error:
>>   	FREE_AND_NULL(sigc->key);
>>   }
>>   
>> -static int verify_signed_buffer(const char *payload, size_t payload_size,
>> -				const char *signature, size_t signature_size,
>> -				struct strbuf *gpg_output,
>> -				struct strbuf *gpg_status)
>> +static int verify_gpg_signature(struct signature_check *sigc, struct gpg_format *fmt,
>> +	const char *payload, size_t payload_size,
>> +	const char *signature, size_t signature_size)
>>   {
> What is this hunk about?  The more generic name "verify-signed-buffer"
> is rescinded and gets replaced by a more GPG/PGP specific helper?
>
> You'd need to help readers a bit more by explaining in the proposed
> log message that you shifted the boundary of responsibility between
> check_signature() and verify_signed_buffer()---it used to be that
> the latter inspected the signed payload to see if it a valid GPG/PGP
> signature before doing GPG specific validation, but you want to make
> the former responsible for calling get_format_by_sig(), so that you
> can dispatch a totally new backend that sits next to this GPG
> specific one.
>
>>   	struct child_process gpg = CHILD_PROCESS_INIT;
>> -	struct gpg_format *fmt;
>>   	struct tempfile *temp;
>>   	int ret;
>> -	struct strbuf buf = STRBUF_INIT;
>> +	struct strbuf gpg_out = STRBUF_INIT;
>> +	struct strbuf gpg_err = STRBUF_INIT;
>>   
>>   	temp = mks_tempfile_t(".git_vtag_tmpXXXXXX");
>>   	if (!temp)
>> @@ -279,29 +290,28 @@ static int verify_signed_buffer(const char *payload, size_t payload_size,
>>   		return -1;
>>   	}
>>   
>> -	fmt = get_format_by_sig(signature);
>> -	if (!fmt)
>> -		BUG("bad signature '%s'", signature);
>> -
>>   	strvec_push(&gpg.args, fmt->program);
>>   	strvec_pushv(&gpg.args, fmt->verify_args);
>>   	strvec_pushl(&gpg.args,
>> -		     "--status-fd=1",
>> -		     "--verify", temp->filename.buf, "-",
>> -		     NULL);
>> -
>> -	if (!gpg_status)
>> -		gpg_status = &buf;
>> +			"--status-fd=1",
>> +			"--verify", temp->filename.buf, "-",
>> +			NULL);
> What is going on around here?  Ahh, an unnecessary indentation
> change is fooling the diff and made the patch unreadable.  Sigh...
>
>>   	sigchain_push(SIGPIPE, SIG_IGN);
>> -	ret = pipe_command(&gpg, payload, payload_size,
>> -			   gpg_status, 0, gpg_output, 0);
>> +	ret = pipe_command(&gpg, payload, payload_size, &gpg_out, 0,
>> +				&gpg_err, 0);
> What is this change about?  Is it another unnecessary indentation
> change?  Please make sure you keep distraction to your readers to
> the minimum.
>
>> @@ -309,35 +319,36 @@ static int verify_signed_buffer(const char *payload, size_t payload_size,
>>   int check_signature(const char *payload, size_t plen, const char *signature,
>>   	size_t slen, struct signature_check *sigc)
>>   {
>> -	struct strbuf gpg_output = STRBUF_INIT;
>> -	struct strbuf gpg_status = STRBUF_INIT;
>> +	struct gpg_format *fmt;
>>   	int status;
>>   
>>   	sigc->result = 'N';
>>   	sigc->trust_level = -1;
>>   
>> -	status = verify_signed_buffer(payload, plen, signature, slen,
>> -				      &gpg_output, &gpg_status);
>> -	if (status && !gpg_output.len)
>> -		goto out;
>> -	sigc->payload = xmemdupz(payload, plen);
>> -	sigc->gpg_output = strbuf_detach(&gpg_output, NULL);
>> -	sigc->gpg_status = strbuf_detach(&gpg_status, NULL);
>> -	parse_gpg_output(sigc);
>> +	fmt = get_format_by_sig(signature);
>> +	if (!fmt) {
>> +		error(_("bad/incompatible signature '%s'"), signature);
>> +		return -1;
>> +	}
>> +
>> +	if (!strcmp(fmt->name, "ssh")) {
>> +		status = verify_ssh_signature(sigc, fmt, payload, plen, signature, slen);
>> +	} else {
>> +		status = verify_gpg_signature(sigc, fmt, payload, plen, signature, slen);
>> +	}
> OK, so get_format_by_sig() now is used to dispatch to the right
> backend.  Which sort of makes sense, but ...
>
>   * "ssh" is the newcomer; it has no right to come before the
>     battle-tested existing one.
>
>   * If we are dispatching via "fmt" variable, we should add
>     fmt->verify() method to each of these formats, so that we don't
>     have to switch based on the name.
>
> IOW, this part should just be
>
> 	fmt = get_format_by_sig(signature);
> 	if (!fmt)
> 		return error(_("...bad signature..."));
> 	fmt->verify_signature(sigc, fmt, payload, plen, signature, slen);
i did put ssh first to keep the default with gpg and only needing to 
match the new format. But the fmt->fn variant is much better. For 
signing as well.
>   
>> +	if (status && !sigc->output)
>> +		return !!status;
>> +
>>   	status |= sigc->result != 'G';
>>   	status |= sigc->trust_level < configured_min_trust_level;
> By the way, there is no verify_ssh_signature() function defined at
> this step [1/9], so this won't compile from the source at all.
> Please make sure that each step builds and passes tests.
I was thinking about this one when i split up the patch. I was not sure 
if that was required and didn't want to add synthetic changes (that 
would only appear between the diffs) just for the split.
>
> If I were doing this patch, I probably would NOT do anything related
> to "ssh" in this step.  Probably just doing
>
>   - rename gpg_* variables to generic names in codepaths that _will_
>     become generic in future steps (like "check_signature()"
>     function);
>
>   - introduce verify_signature member to the fmt struct;
>
>   - hoist get_format_by_sig()'s callsite to check_signature() from
>     its callee.
>
> would be sufficient amount of work for the first step.  Call that a
> preliminary refactoring and clean-up.
>
> And then in the second and subsequent steps, you may start adding
> additional code to support ssh signing, including the new instance
> of fmt that has verify_ssh_signature() as its verify_signature
> method, etc.
>
> Introducing ssh_allowed_signers and ssh_revocation_file at this step
> is way premature.  Nobody uses them in this step, the code that uses
> them is already referenced but missing (hence the code does not
> build), so they are only there to frustrate readers wondering what
> they are for and how they will be used.
>
> Thanks.
