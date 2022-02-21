Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE74C4332F
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 09:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350666AbiBUJvd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:51:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351283AbiBUJuB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 04:50:01 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62D834B94
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 01:22:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoUqIV0Y/BcTh/3vcmbEIA5s48XA+PVQ3QWLKVnm/3BqGJCbpBRD6WbnW9US6RgTkJeAb0Cp3lADT1mp3rQ2EVESB8IS8UPphNcKaeHWbgbaZ8Vbh010XYXfCKJhtfv0MKu053p/jwZxvxtw/neoFv3D8hY4gwJZ6XlqG9JYj5Si379eRdJ5/YOCkjkBP/cTJKumq9PcWOyDNFwhfBAnjUXFb2FIu5FX6lxag/DL05RaRPaFqiyeqyCIoWQQ72yhwplSDUwTlejqB9OHL7DvdscoNyGCUxplljYTW1BocdcEdIxaHM6L4HhkNK75qp4NW+oNgCJTtrZ1/j1M6wiDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=objzFP6yLqDxNjsKD7D5LHupMJP1lQl1DJyLPczaFsg=;
 b=V90XVJTbxO67yjRkPM4vYVQA1cWbxjSNAZu12rArQerIidSqtrMQMI2VrGAdBmNvZxETMjMTpxcaK2wRAr00bAM8a4mrcSb2aU0LV/zko/SrzYeL4lterJRxZFwQ5N0FT8RGltqgsVG7MosL/weU1n6O+bvP/Z9Z0STM1ZKTzkwuEdCTDpAyPB6k2b9fmKxHj9cWhCMkLR1YL3PdbQipMKhtvFDs2/w2Y/NfwgHWWESngsGm2HHBs/D6m3L2iFUWvFqAcHEIfdMNyHN2zcdBAZkiFe1xUgvjhTI01oDdhXES9VFGIKvCUasBkQt/UOhb4m04A8L5giYtYZ9bUCwsyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=objzFP6yLqDxNjsKD7D5LHupMJP1lQl1DJyLPczaFsg=;
 b=VBTav/+j+r8OLRFA0nqsMrCWRw25KXLoIYYPPj2nPFCP3f2t+/hYzw5Yxnqzo+h+e1NczMSA8EF2YnCtaSL9lsWpUqSzGYo88c+f8e554UzyEbymFPrtFeL0h6gheE+mCKpqL+YPIvQeC68cZ5m2Mc4BxpNjtIHctnwZPY+pQI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by HE1PR1001MB1035.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Mon, 21 Feb
 2022 09:22:35 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::116e:6242:98da:22ba]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::116e:6242:98da:22ba%7]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 09:22:35 +0000
Date:   Mon, 21 Feb 2022 10:22:34 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Henning Schild <henning.schild@siemens.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gpg-interface: fix for gpgsm v2.3
Message-ID: <20220221092234.6kg66c3tuo2pya2a@fs>
References: <20220203123724.47529-1-fs@gigacodes.de>
 <Yfw0kapgSSWO3Pyx@pobox.com>
 <20220207105240.dk443kcozynlonpp@fs>
 <YgFK+F6Ks8FnN5Q6@pobox.com>
 <20220209083351.dsoxnhhme3lracck@fs>
 <YgPpsJ1UCEI0a4b6@pobox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YgPpsJ1UCEI0a4b6@pobox.com>
X-ClientProxiedBy: AS9PR06CA0142.eurprd06.prod.outlook.com
 (2603:10a6:20b:467::35) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a80da507-360a-4a4e-394a-08d9f51bb224
X-MS-TrafficTypeDiagnostic: HE1PR1001MB1035:EE_
X-Microsoft-Antispam-PRVS: <HE1PR1001MB10359AEEF8B82E1A63D1E447B63A9@HE1PR1001MB1035.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GpFEg8mRezSNyrsHiEb8TePCy+5XDCR7wFjncCNYLBXyavMqR/9djzUM1LtURO7ZsUtBMwRVCovPQja9BzL3WpJgOWYQd2YM9ZDs4CH8j3ob0F9z/u6dKC3VgpAGGLJB7XPpPVaullgps4fJGH3KdRRYd72lTpoPMTSWSRucwdNWg/WG1FSyLyqdOlWec2g5jYzXgV8B+7AD65RroULT9OZH8SWQpohdZ6hE2+IOtVBjTKCA3UCVjW6ncYEwHR8LPu3fvFBOrxoRDEC5fAGQkrToQ2E4UANroqhKhSv5un5YXo1s4DWA1q98WtD/KOlBwl+PoH2mwozbdviDpMUNXHkvuQKvXc1yXYJLdmCFUX3uPppGeQA7QET+0HIyiMn8d3ysjuQYBwrRT2aoEvYjSQysy85aW/AZ3IN5Y7+czvMvKokCzvgpUJdLyU9aZnhwD87zKVz4fH+A4WKt7eAzjGoc8POpiLsbVgorma0Z6Of7WAr6v3ZVe1mAgEoD9cwh05xPs15T+Cu5AZjZKJd+w0A7iaQOO1cF08fPDKUpJHtFfD4C1qHDauH0MYD5f9yytLecpcVDBI5/Nzzc6UTPPG+K5i17nM9NLCfOWOUe/LGfwTEAy67vqzikdx67b+Cqk3LHiyvFEPdOhMkUYGWC8YAbekMnrP8KAqlY/3EWE3uZYj6+pB34cGy94wSLhW5amPaoyz6Ny9e1uondo14xvG3oCG3tSd5M5Cqf3ZDogf0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(39830400003)(136003)(346002)(376002)(366004)(396003)(66476007)(66946007)(66556008)(2906002)(8936002)(9686003)(6486002)(53546011)(966005)(8676002)(508600001)(4326008)(38100700002)(6512007)(6506007)(86362001)(5660300002)(316002)(33716001)(1076003)(186003)(26005)(83380400001)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnBpSyt0c2EveFFwSUhxMTF6dkZrVi9zaG9wRHBpSUk2amMrQzNzVk0zWE9R?=
 =?utf-8?B?aThXVmhKbVREekRLdTN4bGRMWWJhNkt2VHR4cm5LYVlFVUdDdElKanpSSG9i?=
 =?utf-8?B?ajcvVlJDazNGbTdZT2lZc3RVdVJCWTNiaWNLSTZ4UURCMitrbm9qTlFCUlNE?=
 =?utf-8?B?WmsrZjJZYTBKY1NsUDM1YXVnMFEyL0lGWUg2b3cxK3NpR0NxcEd0TWplUTUy?=
 =?utf-8?B?R3J0cG5lSUJncnVvSmlvTG1vckdxWWFGc3dPT1B6ZzlOVFRscExRc01iUGR2?=
 =?utf-8?B?QmxlcHRFQjhWRTN4ek5OaWJ4dXltREJuOUhVMjJ2NVFKVkhzc1RkYVpBZ1M0?=
 =?utf-8?B?cDBuVHBINlpsQ3E0dGQvaGVNbWlxNmFCS0lhTTdrS2lJMDBiU0xXOFUyRm9V?=
 =?utf-8?B?NUk4c1U5YWNoYTRKOVJTTTNIa1ZGVFlZNGNiYWtPcWhBL3p3Q1V0VkpDWGJX?=
 =?utf-8?B?YmM0R1krWFFjUVN0RlVCTFFPQXlUNWNTMTcvelZINVpySGt5SkF2V0VTNlZI?=
 =?utf-8?B?d3Vzd0UyazRMV0NYNGlFcnlIYmZSM2JLeE5abHhhRmxHdU0rM2RMRXF6Tno5?=
 =?utf-8?B?RU5URWlxWktEOEEwbXhaelJ6UXlTMGVnbGNhbk9DMC9lMUNuejUyMk5yeW5z?=
 =?utf-8?B?ZlFHKzVHc05OU0NoMnJRVDRsRkR2L1JKRHlkM2dvbHBuUkUxRGNTaW5ZcSsr?=
 =?utf-8?B?NzQ0Q0dNVVlFc0NnMWNuWHNxVThoMlUvZm8veGpEZ0c1ZkNEK2MzWWc0VElh?=
 =?utf-8?B?RytRK2NZdyt3K3JLL3BmU1RNd000Y2pVa3ViRzJwSTEzWnRSM1Q0STBEWkV4?=
 =?utf-8?B?dTlXMG1pdHRrRjZUN2tBZTRRbCs3aGZyNnhwNHRsa3ZQMHkrWWYyYUhsN3RZ?=
 =?utf-8?B?YUJzNUkzNTV3VlNreGtORy9Ba0plV1VJcnEzZGd1Q0g0Z3N6cFNkQ3lDYW5m?=
 =?utf-8?B?MmpNMU12WUxyaE9YeEJHUHBZcVArbkJmU1Zua240SjRNVk05U2NveEtoTTN4?=
 =?utf-8?B?aGVyWWcrSW1YZjN4MStLM2M0cjdPZDVsSmFkSXF4cmRUNEs1NkRNWXp1M2k1?=
 =?utf-8?B?dmJUOFVRdVEwYWRTb0VLa0YzTjljc29IZHcwYjZSWEFhSUhORTFXMWRtaUQz?=
 =?utf-8?B?c0xHT21KbTY5OGRnVXpPSTNmeDZrSG9oSDMySVdmOEtrZkM1QW1WUUpuZTkx?=
 =?utf-8?B?dEU4Vmc2UmtOY1VaMkM2YVpQcWJNWEhzVlNXRTg4aVhzS3dJRXVlR2M3bGNL?=
 =?utf-8?B?TzdnUkl2Znp1N3k3cklhMzliRi84YmpFSXN6bWtwUGxNL1FqbVNXc3doRTlh?=
 =?utf-8?B?RkdtSEJlQmd0NURrVUV0Z2FjdE0zM05yNGNvNTdqaWNoT1A0eksxajFiWGlP?=
 =?utf-8?B?cGlNQ1hOSktiZ0R3ZnI2S2hJc3BsYkd5aXhGdEZyQ3p6U3puTE1POHpjWG1Y?=
 =?utf-8?B?eVR6UFgyaHlVSC96WWdHanZXbEJjcktvTlp3YjZZRThsKzNwampuLzM5YXRi?=
 =?utf-8?B?WHRudkkwOUNZbE9MSndzMjBVb1BWK0sxUlBLRk9oM1ZiTzViQUliZ3lhcTZ3?=
 =?utf-8?B?S1FXd0U2VXp3dGxrZ3pOQkRuNUdUaHRQUS9FNk5pdFk1UUNRdUY3NFVLbS91?=
 =?utf-8?B?eFM4dGxkdm9hblVScWdBOHFlNVFuZGZnaGF1WmNFQU5lU3BxMG0weVl3LzJG?=
 =?utf-8?B?ZWxkd3dNcmdhUlpxaFl0d1BHanZWcUE1YUZyQkcySEVTMkFzWGM4bU4rcWhX?=
 =?utf-8?B?ZWNocU05V3NYeGoza2JZUUN5NXhYRnU3SkVaZVVod3ZSaHB2NG1waFZaM1lM?=
 =?utf-8?B?NkVIajdES0IwSDMxR3RiN1NVVzBTdHM5RDdLVXBkZCtFcWgwMUJvU2hPRHd4?=
 =?utf-8?B?UjJYdG1QRk5ZQzlFTFUzcVZHQ1dkcHBxSi9GT3FTMzNQNkhudFFneHFzdWN2?=
 =?utf-8?B?bjVVaG5rSVl2elpoQ2JzOHByb2lnMDBGQ3RENlRvckd6MHA0TkZ0RDZHVy9W?=
 =?utf-8?B?bXFRZi92NGtSY2pEWSt6UXB1ZHRtRGRYNnQvbnhWTkZ3djYvN2lTNlRvWm1X?=
 =?utf-8?B?SVcwNjloN2dxWUxaZWY0OUNZblZ2cU8xSkg4M2E5bitCZDJNV2NmMDhjRThB?=
 =?utf-8?B?WnFaQXNOdyt6Y28yUnpJOTZWSUlnR0tNTkE0SXcxKzRoSGpPUy9hZnVtT2pv?=
 =?utf-8?B?TTBlS3FGZk1jelpXNUN6SWhxY2c3WHVYTWpuY0M3RXY3MWxVTm0vZHB5SmxS?=
 =?utf-8?Q?SL9SCF4LFUE4eyg6krUiPdvtsCFkNCmAmm0BiD00/w=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a80da507-360a-4a4e-394a-08d9f51bb224
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 09:22:35.2213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0XtPv7IaKIeQ7hyH2x92ENiG3Pdl/VFkDDv6mwjR4nXebZjFtBDIIeGGzu1nK0vyy94c3spb9skZ9D1fdidG54p8EB8jjSZtMLMyaLfkc68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR1001MB1035
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09.02.2022 11:20, Todd Zullinger wrote:
>Fabian Stelzer wrote:
>> On 07.02.2022 11:38, Todd Zullinger wrote:
>>> How did it fail for you?  It passes all the tests when I've
>>> run it against Fedora and RHEL-based hosts.  If it's flaky
>>> on other systems, that would put a damper on doing it this
>>> way.  Though it _should_ work.
>>
>> Sorry for the delays, I'm a bit busy with other things at the moment.
>
>No apologies needed.  This is something I worked on back in
>November and had yet to send to the list, so I'm the last
>person to rush another. :)
>
>> I did get an interactive popup asking if I would like to
>> trust the key when I ran the t4202 test. This never
>> happened with the old variant.
>
>Interesting.  I do have a patch in my gnupg-2.3 series to
>reload the gpg agent after changing the trustlist, as the
>changes were not picked up prior to that.  In my case, I was
>running the tests in an environment where gpg could not
>prompt me.  (It also seems like we should try harder to have
>the test suite reject such prompts).
>

Yes, gpg-agent in general can be problematic for the tests. I'm not familiar 
enough with gpg but I don't know if we can get by without it?

>--- 8< ---
>Subject: [PATCH] t/lib-gpg: reload gpg components after updating trustlist
>
>With gpgsm from gnupg-2.3, the changes to the trustlist.txt do not
>appear to be picked up without refreshing the gpg-agent.  Use the 'all'
>keyword to reload all of the gpg components.  The scdaemon is started as
>a child of gpg-agent, for example.
>
>We used to have a --kill at this spot, but I removed it in 2e285e7803
>(t/lib-gpg: drop redundant killing of gpg-agent, 2019-02-07).  It seems
>like it might be necessary (again) for 2.3.
>
>Signed-off-by: Todd Zullinger <tmz@pobox.com>
>---
>
>Notes:
>    An alternative to doing this dance with the trustlist.txt and having to
>    kill and/or reload the gpg-agent to pick up the change right after the
>    import in each test might be to make this part of the steps used when
>    adding/updating/removing certificates in t/lib-gpg.
>
>    If not as a one-time affair when a cert is added/update/removed, then
>    perhaps as a step taken by/in t/lib-gpg.sh only once.  It could populate
>    a gpghome to be copied into the trash dir for each test which used
>    gpg/gpgsm.  I haven't measured the effect of the extra reload precisely,
>    but I'm sure it's not free.
>
>    (For what it's worth, it didn't add any noticeable amount of time to the
>    full builds/test runs I made while working on this, so it's a seemingly
>    small cost, at least.)
>
>    Also, hello Henning,
>
>    Way back, in February 2019¹, when I submitted 2e285e7803 to remove the
>    "redundant" killing of the gpg-agent, you said:
>
>    > Killing the agent once should be enough, i remember manually killing
>    > it many times as i was looking for a way to generate certs and trust
>    > (configure gpgsm for the test). That is probably why i copied it over
>    > in the first place.
>
>    As I wrote this patch to partially restore the gpg-agent killing (now
>    just a reload), I thought this might have been the sort of issue that
>    you hit while testing.
>
>    It could be unrelated, but it sounds quite similar to what I found with
>    gnupg-2.3 when trying to get it to pick up the trustlist.txt changes.  I
>    thought you might at least enjoy seeing it come back around.  :)
>
>    ¹ <20190208093324.7b17f270@md1za8fc.ad001.siemens.net>
>
> t/lib-gpg.sh | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
>index 6bc083ca77..38e2c0f4fb 100644
>--- a/t/lib-gpg.sh
>+++ b/t/lib-gpg.sh
>@@ -75,6 +75,7 @@ test_lazy_prereq GPGSM '
> 	gpgsm --homedir "${GNUPGHOME}" -K --with-colons |
> 	awk -F ":" "/^fpr:/ {printf \"%s S relax\\n\", \$10}" \
> 		>"${GNUPGHOME}/trustlist.txt" &&
>+	(gpgconf --reload all || : ) &&
>
> 	echo hello | gpgsm --homedir "${GNUPGHOME}" >/dev/null \
> 	       -u committer@example.com -o /dev/null --sign -
>
>--- 8< ---

This patch fixes it for me.

>
>I have another patch which changes the earlier gpgconf call
>which kills gpg-agent to kill all gpg daemons, as there are
>some others which could potentially interfere with the
>tests:
>
>--- 8< ---
>Subject: [PATCH] t/lib-gpg: kill all gpg components, not just gpg-agent
>
>The gpg-agent is one of several processes that newer releases of GnuPG
>start automatically.  Issue a kill to each of them to ensure they do not
>affect separate tests.  (Yes, the separate GNUPGHOME should do that
>already. If we find that is case, we could drop the --kill entirely.)
>
>In terms of compatibility, the 'all' keyword was added to the --kill &
>--reload options in GnuPG 2.1.18.  Debian and RHEL are often used as
>indicators of how a change might affect older systems we often try to
>support.
>
>    - Debian Strech (old old stable), which has limited security support
>      until June 2022, has GnuPG 2.1.18 (or 2.2.x in backports).
>
>    - CentOS/RHEL 7, which is supported until June 2024, has GnuPG
>      2.0.22, which lacks the --kill option, so the change won't have
>      any impact.
>
>Signed-off-by: Todd Zullinger <tmz@pobox.com>
>---
> t/lib-gpg.sh | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
>index d675698a2d..2bb309a8c1 100644
>--- a/t/lib-gpg.sh
>+++ b/t/lib-gpg.sh
>@@ -40,7 +40,7 @@ test_lazy_prereq GPG '
> 		#		> lib-gpg/ownertrust
> 		mkdir "$GNUPGHOME" &&
> 		chmod 0700 "$GNUPGHOME" &&
>-		(gpgconf --kill gpg-agent || : ) &&
>+		(gpgconf --kill all || : ) &&
> 		gpg --homedir "${GNUPGHOME}" --import \
> 			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
> 		gpg --homedir "${GNUPGHOME}" --import-ownertrust \
>--- 8< ---
>
>I have the series in the gpg-misc-fixes branch:
>
>    https://github.com/tmzullinger/git/commits/gpg-misc-fixes
>
>(That series does differ in that it has `string_list_split()`
>instead of the simpler `strbuf_addch(&gpg_status, '\n');` to
>fix the gpgsm parsing.)
>
>Iff you think it would be useful or helpful, I can post that
>series.

I have prepared the patch with the simple strstr() matching I can post in a 
bit. I would add your two gpg test lib patches to it if thats ok?

Thanks

>
>Thanks,
>
>-- 
>Todd
