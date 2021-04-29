Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D86C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 14:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E3C661186
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 14:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbhD2O10 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 10:27:26 -0400
Received: from mail-mw2nam12on2068.outbound.protection.outlook.com ([40.107.244.68]:37280
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233862AbhD2O1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 10:27:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ji93M6aqQ0XUhSflOWZ4wxXr4fCpKVluDicIet3Kl+Ej5qu6BwKwszzuY79rH8IJrDaJGFrYU6dQbmH2NiUQr+xrGAJ3HO9Ob2ft3FFk7Yilhnkt/yVINhcsoWN+nMt9y0UKXGj2PjpydJIGQJ+lxjX+UGi3USnGiRs+Ru5qoirUzxxX5lY3s5EJXwGUY/YPGus/4Qa3+IJNyq4DldpbowE1zlcfmroyygj3O4cXQqR/SBXqUnfWU9vUcCwmOF5IXG8T0M47R0+kRAmcFjjLHP+PTdv/3snegxgDfiFpf2CsKO/r/nNzEAHNYNrdbDU8QzBXrj5YW7eoKXRZBla6nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pm3Tv5jZnMHqvj+wArwiZdBu+3UiQM6dnwFgFsVfvIQ=;
 b=SdX0SHoHTm4ShAy7Dim/yrAixcDECJaMa5ILW/GRsdlgc695Ggh8mNm9QEqxSlLRexqmZQlsd24mc9xI6bcvm/gfhT+9vq7vFmlKRMvi3oPo3IgFbDy8OAJrsNNALi1y/gXUYkqPPWetn4s1c4rc+0DMtGFwK7ppEIFdhC0v5Xpqlvjn1STIQO3yrl5E8hQ3w4GKFMVMzFDqJcEgVXVcunk5oJkgmC/iHfIsGVXQggVsQvtQaJMhZtSCpLog8B51luodljP5CHkjKt4htdlk6S3YRC0zayYN965WsgJMu8qgZMlsNxE4S+UuaWYdPRys7N6EwTHhVkIwy3sJOWZ2SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jci.com; dmarc=pass action=none header.from=jci.com; dkim=pass
 header.d=jci.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jci.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pm3Tv5jZnMHqvj+wArwiZdBu+3UiQM6dnwFgFsVfvIQ=;
 b=zQO7TAj067xXSW6vpmN9ACyjCfCanRBfVuJ+kHUXebMy65ytSLCOUvJ96o2mF+6pERO4qu7CH/hiqvM+VfO7F31EH8SGERNeL/TFk9COf9NLIZ2wAExjVEM+quQ7TPg8SQOra/3oI3NsYa/InLv7N/CiHx710hGMBNYootc64ro=
Received: from CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM (2603:10b6:923:1::27) by
 CY4P132MB0105.NAMP132.PROD.OUTLOOK.COM (2603:10b6:923:48::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.26; Thu, 29 Apr 2021 14:26:38 +0000
Received: from CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM
 ([fe80::d43e:67c3:2daf:41ec]) by CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM
 ([fe80::d43e:67c3:2daf:41ec%8]) with mapi id 15.20.4065.032; Thu, 29 Apr 2021
 14:26:38 +0000
From:   Jeremy Faith <jeremy.faith@jci.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
CC:     Git Users <git@vger.kernel.org>
Subject: Re: bug:git-check-ignore exit status is wrong for negative patterns
 when -v option used
Thread-Topic: bug:git-check-ignore exit status is wrong for negative patterns
 when -v option used
Thread-Index: AQHXO4AUDQX8jTZiwE6IhVGEoYJRi6rJdMkAgAIZgjM=
Date:   Thu, 29 Apr 2021 14:26:38 +0000
Message-ID: <CY4P132MB0088FC0DEE457E49EA21266F855F9@CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM>
References: <CY4P132MB00885C970ACF5A277F06E40385419@CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM>,<3ea4e4c8-9723-4af6-5f07-9141c3001986@gmail.com>
In-Reply-To: <3ea4e4c8-9723-4af6-5f07-9141c3001986@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6be01c0c-f9b3-4dc4-af0b-a82110cc37cd_Enabled=True;MSIP_Label_6be01c0c-f9b3-4dc4-af0b-a82110cc37cd_SiteId=a1f1e214-7ded-45b6-81a1-9e8ae3459641;MSIP_Label_6be01c0c-f9b3-4dc4-af0b-a82110cc37cd_SetDate=2021-04-29T14:26:37.473Z;MSIP_Label_6be01c0c-f9b3-4dc4-af0b-a82110cc37cd_Name=Internal;MSIP_Label_6be01c0c-f9b3-4dc4-af0b-a82110cc37cd_ContentBits=0;MSIP_Label_6be01c0c-f9b3-4dc4-af0b-a82110cc37cd_Method=Standard;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=jci.com;
x-originating-ip: [82.24.136.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03f5d90a-4a50-4571-cc4a-08d90b1accd0
x-ms-traffictypediagnostic: CY4P132MB0105:
x-microsoft-antispam-prvs: <CY4P132MB0105AF663019E8C39BB7EDFA855F9@CY4P132MB0105.NAMP132.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kp9fC8yrVGCrM4MjQoEUCOFjIqHRrTYdqFHXpasjTceBPsUhtG18TE+eYO+lF+9DOcytZAJXCiW9RAaJRL40BkVhEHxBgaAJ3EZgRQD9mEvkHfKIbEztz7jP1GFzLTrr1/2sBuw2zxVCJrtQCTMHOiR2E8/DtWOU2+FCFs91cd2sWl+OYsg4UNTH6TNf3H03EK5TR0tIISvTol37jbsySZIVCjEGfCO6Mx2Lj/6IFghh0WXs/jjucvKjAOk6KyaUtS2ZDgL0uVKLbbcZldaZNEOQZMSChjYKNW/+8UB/ivYiwWz19BDEDcgr+rQMH6Mq5ANnCz9LecZZ1asg7q4pgZC1upOpqOX/cz9qH299Ne5Cy0QgfByhQF0bBfF6NTw9eAe0cMbnM6rpzHJMWSnvqsPIGL7ZNy/bKAbvYAoEHnw/iHVYp4ZFB816Y9kVphoRhPM8UdU8snnwAOUc/3pvR88wBbteLCcyo+6dGH5PnZlrxdehOLMJA5aP6c8OJzdpipWM5kL6hUqnYfla9GfVR0L72hieKw1s7Y7FigNa7NFr15ScZKGFxSs3WF9G5jqUR30VbnfpBYKnf7lfryRrV00XXZYyY27sFNkCiSnoZY0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(76116006)(26005)(44832011)(71200400001)(66476007)(66946007)(64756008)(66556008)(6506007)(66446008)(2906002)(478600001)(4326008)(86362001)(8936002)(52536014)(33656002)(5660300002)(8676002)(186003)(122000001)(316002)(38100700002)(6916009)(55016002)(7696005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?RyJiYfG6ImtHlylSUQpB0MKB+R59/gGCtY0bqVIk//oxji/EedebZYlPxR?=
 =?iso-8859-1?Q?ehTTSxtKWMksFugteVp8JPRNLf/Umvg/5Y0T5yfgOe6pJJ2KtD6zjpGWsD?=
 =?iso-8859-1?Q?ThnBLoIZR2v1hRBr2l8hiMpdAQJz80c2HM8nG8RNOWtR8DGSgqyPWOE4ey?=
 =?iso-8859-1?Q?RB7AqeLJ4LggYZ2TDQZ6axoGtJfv3aPfGx3yL2XFihGANBdymv/62fz+HH?=
 =?iso-8859-1?Q?Dnp3KMZ3HPxFB19NhedGvtTwvZlsHjYpUIdBKaisuba4abMp7yn43FjaOa?=
 =?iso-8859-1?Q?UJFlHhduFEmPEnOv+JbLsQVavjOZ9Iu+oRt2rrj+BlGtN73FPVxBGZAyx3?=
 =?iso-8859-1?Q?RbVB6OwjUn3hMg2resy+eos4fZemHQFPz3mtp7XZbCXAfAX9dXJmJMp7kK?=
 =?iso-8859-1?Q?QQC9KyAUqnwg93kn3mkyFd+lb8YDibeA+CYSVB/BbU0m7wkQZhl0DeZlAd?=
 =?iso-8859-1?Q?jbqDSxBjhOBRHbiROvEv4iEoItFa7LtWdXKwUeJKexujy9DXz4Z2JqZgYZ?=
 =?iso-8859-1?Q?QvURon0bCbF2gP7pRErXSuU5B9TV5hT2B0oid8isqh2o3l/YSfUar5xmC9?=
 =?iso-8859-1?Q?tYwQWsoowZpN4kYiqDkH5YU+BuGrMZqy+ODoKtIDSTDq+tz3+ffFzJHOQk?=
 =?iso-8859-1?Q?W+Cv0k8ZOZ2WZWm1RAVx/G79GjDjBqMVKS/KSKWR9PN7CTA8tFGL7xg1mp?=
 =?iso-8859-1?Q?Vn4moRhVnKXnCBEVyknTmMOl50h6mDzlIIY7iCxs+24YvX8zXomlrw+iPq?=
 =?iso-8859-1?Q?Kgx4dVaz2okuw9o47d83/1VjfE579yMQg/zFnVvbiXRAH3w3PyT4c/Oc6T?=
 =?iso-8859-1?Q?r6KyacYUrsXWzKW3/6UH3Zu8++VsITGxiZoQxeAyg3OOIqQrk3Pwynec6A?=
 =?iso-8859-1?Q?moAToawNTdsnp1cEISspc96ezpf8jEFTIAqAtAFkivKBkXuEkRf/g3XSc7?=
 =?iso-8859-1?Q?S0eWNFJ/oFfjMx3KuBsYIT9ZIFZMA/9ixf15TkiO67ZywWda9migoJPD48?=
 =?iso-8859-1?Q?YyUJH81MGEmsfR7jZVxUqgYwPITXhPtkMr5E1nhuTvrwx0GijHHYn0n1Z2?=
 =?iso-8859-1?Q?1VHn7AvG5ibZpF4tnyeypw1uE3Bs3ec9UZuiLlbvByG1FiGaJeTL/nHEK6?=
 =?iso-8859-1?Q?f7skNsqqNmVlrn3I1NqFSCkcmTfBwhz8S9s/GdiTVi8wGuxm5VwW9/G2Gb?=
 =?iso-8859-1?Q?2A/WMdNOMDVWPx98wIFpF+Zw+B8vf3DlPg/3Twvte7ouWsP7CfJRHsUR9R?=
 =?iso-8859-1?Q?HryioZicjFF5X6W3lbN+DfwRVpyqtTHY/C0g4+brI/m8TvArSMXIy6FOTr?=
 =?iso-8859-1?Q?+7XAAn4X5hpRU0TqlaBWy8WxIP8FNFPwz05UZEQXxFQo07c=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: jci.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f5d90a-4a50-4571-cc4a-08d90b1accd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 14:26:38.2617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a1f1e214-7ded-45b6-81a1-9e8ae3459641
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zwktI6GP8AKBIvA+fvT9EkjpH1P3OoWS2NCsui6szpKWKmLOjcp3cfUgbVb9ooVn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P132MB0105
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

on 28 April 2021 07:15 Bagas Sanjaya <bagasdotme@gmail.com> wrote:=0A=
=A0=0A=
>On 27/04/21 23.30, Jeremy Faith wrote:=0A=
>> Hi,=0A=
>> =0A=
>> git version 2.31.1.362.g311531c9de=0A=
>> git-check-ignore=0A=
>> When a negative pattern is the last .gitignore match the -v option cause=
s the exit status to be 0 rather than the expected 1.=0A=
>> e.g say .gitignore contains=A0 one line: !hello=0A=
>> git check-ignore hello #outputs nothing=0A=
>> echo $?=A0 #shows correct exit status=3D1 i.e None of the provided paths=
 are ignored.=0A=
>> but=0A=
>> git check-ignore -v hello #output is next line=0A=
>> .gitignore:4:!hello=A0=A0 hello=0A=
>> echo $?=A0 #shows wrong exit status=3D0 i.e. One or more of the provided=
 paths is ignored=0A=
>> =0A=
>> Following change seems to fix it for me=0A=
>> --- a/builtin/check-ignore.c=0A=
>> +++ b/builtin/check-ignore.c=0A=
>> @@ -114,7 +114,7 @@ static int check_ignore(struct dir_struct *dir,=0A=
>>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }=0A=
>>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!quiet && (pattern || show_non_ma=
tching))=0A=
>>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 output_pattern(pathsp=
ec.items[i].original, pattern);=0A=
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pattern)=0A=
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pattern && !(pattern->flags & PATTERN_=
FLAG_NEGATIVE))=0A=
>>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 num_ignored++;=0A=
>>=A0 =A0 =A0 =A0 =A0 }=0A=
>>=A0 =A0 =A0 =A0 =A0 free(seen);=0A=
 =0A=
>I tried to apply this patch from the mbox, but it was corrupted, so I had =
to=0A=
>manually write the changes above. I tested that with your reproduction cas=
e and=0A=
>it worked as expected.=0A=
=0A=
>But anyway, please send the proper patch and (preferentially) with the tes=
t=0A=
>consisting of the reproduction case.=0A=
=0A=
>Thanks.=0A=
=0A=
Sorry I just posted the output of 'git diff' previously but I cut off the f=
irst 2 lines by mistake.=0A=
I'm not sure what is required as a test script.=0A=
=0A=
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c=0A=
index 3c652748d5..223cc6a1ef 100644=0A=
--- a/builtin/check-ignore.c=0A=
+++ b/builtin/check-ignore.c=0A=
@@ -114,7 +114,7 @@ static int check_ignore(struct dir_struct *dir,=0A=
                }=0A=
                if (!quiet && (pattern || show_non_matching))=0A=
                        output_pattern(pathspec.items[i].original, pattern)=
;=0A=
-               if (pattern)=0A=
+               if (pattern && !(pattern->flags & PATTERN_FLAG_NEGATIVE))=
=0A=
                        num_ignored++;=0A=
        }=0A=
        free(seen);=
