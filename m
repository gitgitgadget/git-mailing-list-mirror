Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C183C433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 09:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A149613B3
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 09:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhD3J5L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 05:57:11 -0400
Received: from mail-bn8nam12on2084.outbound.protection.outlook.com ([40.107.237.84]:48097
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231544AbhD3J5G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 05:57:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUQY6fP9Q4KkovJM0YNgMBTQzLqKMenJNI30HxqY2tg/+WbRK8ThXYlJhax0Tqi0ztZcAD1NElPOkEjpsNikrdEXQuQ+iBrmtUCzwxOIMfhnoHEye1jfwsK7N5tST/4xMw4ao/Ze8mqEcGmDgkWSQJ83XLWMlWrLqkmDsfnHok1onlTxIQOrC1xdzWOOUmmdCh33cKJkIvPGDDt1j/03jWNO2g8S7W0/yOXfZew4MhzhgF068kBPuTsINKaNTDd0V/9uR0jrjWfyrpkqIeP8d0AuRFqhH1Z5f6GVQ5rrkUEuk8OyJONIe4NQtKFKwCeEc3WdHfqJX1BMyxolA44OsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2q7rxoiwsjs3zxYLR+KtDLr4SG9l6ek/DK8aLFnDUY4=;
 b=RdyWLpA0cMdvRqEiUc2EqNdRTXwxgGLedVQB+45LgmMf/Ul86GTHcFS7MCun1cfHKfpuESwNBVmdfbY8Oth/9fUlVTKoFiBxxfubZzyugyU9P8JrQjCPR3bdzqNySpbLG7wIDHUXd0B6eLDZxmUjVJNkL41p0fyMMNmEDbTS269wr/uDN9DXKoL1obagmKWkDf3ha1hICsHNBWx3eRr+6qfPyySOHIgs8jM13oqpbeymtQ/if0Bp/hiemt3HgTZWZ6W6CDNnrg0FRxCpJy8hxkxfOCEKbk3Qji/1WSUxQ12NndYza707ehkfwtcKN2aF1xDTWDfrIPUx4XhmIjLbYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jci.com; dmarc=pass action=none header.from=jci.com; dkim=pass
 header.d=jci.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jci.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2q7rxoiwsjs3zxYLR+KtDLr4SG9l6ek/DK8aLFnDUY4=;
 b=fo11tzvrbEdTCbdzEHlKQ+w2odSE8KlYMI5w5XwpllThVkTl95SgnvH/MNK8yyr2dvOx1Rh6NQe7uUHuWT+omNDN7+2ONf859pGKhjaCJ2F2VTFILyOSvpZIWpHaumG3lPjeVbZfoCtE2hK2OBW3ljzNuO8jx//sz5IzSljkbxg=
Received: from CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM (2603:10b6:923:1::27) by
 CY4P132MB0106.NAMP132.PROD.OUTLOOK.COM (2603:10b6:923:48::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.24; Fri, 30 Apr 2021 09:56:12 +0000
Received: from CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM
 ([fe80::d43e:67c3:2daf:41ec]) by CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM
 ([fe80::d43e:67c3:2daf:41ec%8]) with mapi id 15.20.4065.034; Fri, 30 Apr 2021
 09:56:12 +0000
From:   Jeremy Faith <jeremy.faith@jci.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: bug:git-check-ignore exit status is wrong for negative patterns
 when -v option used
Thread-Topic: bug:git-check-ignore exit status is wrong for negative patterns
 when -v option used
Thread-Index: AQHXO4AUDQX8jTZiwE6IhVGEoYJRi6rJhO2RgAIDcT+AAK5sf4AAhQ7D
Date:   Fri, 30 Apr 2021 09:56:11 +0000
Message-ID: <CY4P132MB00883DC8ABC72790A15C9630855E9@CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM>
References: <CY4P132MB00885C970ACF5A277F06E40385419@CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM>
        <xmqqfszac25x.fsf@gitster.g>
        <CY4P132MB00885F00AAA46BCFAC76881B855F9@CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM>,<xmqq5z04fwoz.fsf@gitster.g>
In-Reply-To: <xmqq5z04fwoz.fsf@gitster.g>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6be01c0c-f9b3-4dc4-af0b-a82110cc37cd_Enabled=True;MSIP_Label_6be01c0c-f9b3-4dc4-af0b-a82110cc37cd_SiteId=a1f1e214-7ded-45b6-81a1-9e8ae3459641;MSIP_Label_6be01c0c-f9b3-4dc4-af0b-a82110cc37cd_SetDate=2021-04-30T09:56:11.071Z;MSIP_Label_6be01c0c-f9b3-4dc4-af0b-a82110cc37cd_Name=Internal;MSIP_Label_6be01c0c-f9b3-4dc4-af0b-a82110cc37cd_ContentBits=0;MSIP_Label_6be01c0c-f9b3-4dc4-af0b-a82110cc37cd_Method=Standard;
authentication-results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=jci.com;
x-originating-ip: [82.24.136.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c629252f-c134-4313-a1b5-08d90bbe2fa8
x-ms-traffictypediagnostic: CY4P132MB0106:
x-microsoft-antispam-prvs: <CY4P132MB01062B6AFF0AEA2667E30285855E9@CY4P132MB0106.NAMP132.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6wwpwQr7wcLCHfGStJKhDBipByh+iPJJPDXAfzn2j509BMw0fmmbOx9hvwH1hCm31qL9xGpCSVPEhkf2pu1FwmOMwnDPD+EGWaYUi/+dP0isUMLiDm+Zpg6k7Yw6B53cZAy5QhLPx+AAVbKm9k4kClLhjfUfHF3YAbZwoL0DYzPBcgyOF1WpZYJx2sHnEejvctfhafknsRL4+82i6UG6Zz68gp40xNS8mdIOUZykTDZo7HU72HRqh0Sgss8Tz8dK7yY1mS3iZPei+wvXCphxeBc+Gm0VqrnHk6ytbFnves0yW9u8G82uEThMH3LaZ1IIRpFFwmxjaiBWb91WfJffIRlkTSH306eCHxycX7ZZBLDQsRFNeSO+/JW+tkefaPp6Im0wk2XKsH/tls6QycX9BgLi/+VpK7rJzyLjLkGuZd6QJfW22S58Kt/isq65g3Q5+m7zk7bPbIIqQIRxd3w7MDGRZ8eOrgOr7VR5SichoB/CNwTgxqhY1K+HzC9wue322qaXbr5UczidlQmf12IFDL++n8DYn/K8l1bKbxUn2L1zFBTbfn9LSu25RpnyXX4wbllGbNgGF3RgE27M9hrw5D0DZ46xn5RPzvjSaoDI8HM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(33656002)(316002)(26005)(38100700002)(186003)(122000001)(66946007)(6916009)(86362001)(71200400001)(55016002)(52536014)(9686003)(7696005)(8936002)(6506007)(478600001)(8676002)(53546011)(2906002)(66446008)(44832011)(5660300002)(64756008)(76116006)(66556008)(66476007)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?F6NpJeL8+WfTd1oVRcVHoBMEIH2l9ft4EhN3Z+l7HcM2lF5h3IXzXS9tVy?=
 =?iso-8859-1?Q?MU3s/+CqGWUOBe5JQpo5UEb/zeVonOW7B8D9aLH1fKXoWyCXr1A7w8eDCv?=
 =?iso-8859-1?Q?ftNhihbLqYfR+JMlGxNyKbS0Rht1kH/TZG2lc62guHZ2eRO8Lcncvi5fbT?=
 =?iso-8859-1?Q?ltDRCMHhWHpxcbw3uh05s2OWwsU91LZ868Tz7KOTdnp1In1zHzCCUZkdOV?=
 =?iso-8859-1?Q?w/Qlr97halwdFoVEBR/iMryBHF7Wtp3JJBBBmlV1Pu1OCrkg6RUEdqLi+N?=
 =?iso-8859-1?Q?uk6kHuxW1YtxCw1DlItRJBKCOs4FbzDNomc+GxGqyBcymip03GkUrKE8Nu?=
 =?iso-8859-1?Q?JipJeGD/zNepEbitTelYw+OeoyxCTptUJyoyJzkw2FrTVOOLs2fLWYVdwD?=
 =?iso-8859-1?Q?0OsFfboe8LTKp7Hq+S2f68UZ4NXfMgMpOyWauwlcY14Y2YZMhrbUn9cnY5?=
 =?iso-8859-1?Q?1O2ie2F2k8kvbmNvqgySh20WjMdMyqzni1Q/IHsMkCtSEE6tzjBaMT4PdU?=
 =?iso-8859-1?Q?bzL0dmvaZOi54s8pmZ/fVJ4w1b7m0p5ZHvkoo/Ude0tyQsNQJ68ZlNNjku?=
 =?iso-8859-1?Q?MBdx3jTI5wlyKnYkPREv4fsKREfVrB1QkG6ZJVfNjmdyb43mnM4dxhZZEr?=
 =?iso-8859-1?Q?0LYRlFTNnuhxarVy5RFiBssqDQYi3DJDnfiVRyo0Mt9pTsje3BE815FSpP?=
 =?iso-8859-1?Q?wvsiv4cZFPbsxUs8xyjGfEEODIMBstFl5XG2cpGAQnnUjFvuF8E68N5FtB?=
 =?iso-8859-1?Q?QHcCFh6dK2BlxvKV2gfxOBtjR+MGaiOikBEPG8eHrt977AXikIuZcXnNFI?=
 =?iso-8859-1?Q?/No7LlaX5sIdk3zb0sbV3LALJyz860nD4amvbAVsg2NRv400fC/Ar6+NTi?=
 =?iso-8859-1?Q?6FmX6rm45LM/2IthkZVaouAEdwxxQaE2NGC/JYVckBkmcfgSVmmN1HkKhW?=
 =?iso-8859-1?Q?cTkfCwAmFAqVxqjItWeBZgX1oxrTevqAi+1HtURzJ+beZpb+VaYFi54uT4?=
 =?iso-8859-1?Q?hmz0uXSddqTU5qGIsSwBzSqk3H4eMwPDFVPDO1xnrsG7A3J+F1c19lUt1n?=
 =?iso-8859-1?Q?bxK2C0kQmVP0l4qSADlLPhxmfwdDQluGsORw7J8SlAuxHsaeMdWOlG+POx?=
 =?iso-8859-1?Q?S6QvddR4r1xkA+GX3/y3R5Fe/88a1nYvnK2Q7jWfXiBprdulWRfCWxEVUi?=
 =?iso-8859-1?Q?/DHP3x20/dqFDF0ixNHhe1bTK9/RkMsv8cuyyLG1M7KnsqQcYv/+f7gWJk?=
 =?iso-8859-1?Q?KElk3hcq3cfn32DRB9RpPpyZ6UX7+5kfAmJTA2w3Rv60AMzmIK8pgSIfZJ?=
 =?iso-8859-1?Q?/awf4rNXdcLZ7QWofGEXFAIJ9qY04vSmoPyhvh/LyuiJUms=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: jci.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c629252f-c134-4313-a1b5-08d90bbe2fa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2021 09:56:11.9498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a1f1e214-7ded-45b6-81a1-9e8ae3459641
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d3dHqWNKt2a3CZkDul6gcQ0LP1X6kXu5aEwe/XgyavuXc7NBkElKPOWZBWJT/dS6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P132MB0106
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30 April 2021 01:22 Junio C Hamano <gitster@pobox.com> wrote:=0A=
=0A=
>Jeremy Faith <jeremy.faith@jci.com> writes:=0A=
>=0A=
>> man git-check-ignore states:-=0A=
>> EXIT STATUS=0A=
>> -----------=0A=
>> 0::=0A=
>>        One or more of the provided paths is ignored.=0A=
>> 1::=0A=
>>        None of the provided paths are ignored.=0A=
>> 128::=0A=
>>        A fatal error was encountered.=0A=
>>=0A=
>> So my change matches what the manual states.=0A=
=0A=
>That is part of what I meant by "understandable, given the history".=0A=
=0A=
>The above description is _wrong_ ever since it was introduced, along=0A=
>with check-ignore, at 368aa529 (add git-check-ignore sub-command,=0A=
>2013-01-06).  It should have said "has/have entry that affects it in=0A=
>the gitignore/exclude files" instead of "is/are ignored".  After=0A=
>all, that is what the tool was written to do, i.e. to help debugging=0A=
>the gitignore/exclude files.=0A=
>=0A=
>    git-check-ignore(1)=0A=
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
>=0A=
>    NAME=0A=
>    ----=0A=
>    git-check-ignore - Debug gitignore / exclude files=0A=
>=0A=
>Having said all that.=0A=
>=0A=
>It is a misunderstanding that check-ignore is a tool to learn if a=0A=
>path is or is not ignored, but the misunderstanding is so widespread.=0A=
>=0A=
>I wonder if we can repurpose the command to "match" the=0A=
>misunderstanding, without hurting existing users, by=0A=
>=0A=
> (1) updating the one-liner description of the command in the=0A=
>     documentation;=0A=
=0A=
> (2) keep the EXIT STATUS section as-is; and=0A=
>=0A=
> (3) adjust the code to exit with status that reflects if there was=0A=
>     at least one path that was ignored (not "that had an entry in=0A=
>     the gitignore/exclude files that affected its fate").=0A=
=0A=
If I understand correctly:-=0A=
  (2) requires no change=0A=
  (3) I believe my one line change does this=0A=
=0A=
Which just leaves (1) where current line is=0A=
   git-check-ignore - Debug gitignore / exclude files=0A=
I think with the exit status operating as documented this description still=
=0A=
works i.e. check-ignore can be used to test if the .gitignore/exclude files=
=0A=
are working as desired.=0A=
=0A=
The longer Description is:=0A=
  DESCRIPTION=0A=
       For each pathname given via the command-line or from a file via=0A=
       --stdin, check whether the file is excluded by .gitignore (or other=
=0A=
       input files to the exclude mechanism) and output the path if it is=
=0A=
       excluded.=0A=
Which matches the exit status meaning as is.=0A=
=0A=
>That certainly is a backward compatible change, but I suspect that=0A=
>we may be able to sell it as a bugfix, taking advantage of the=0A=
>documentation bug you quoted above.  Of course, people do not read=0A=
>documentation, so scripts that used to use the command in the way it=0A=
>was intended to be used (as opposed to "the way it was documented")=0A=
>will still get broken with such a change, though.=0A=
=0A=
I'm not sure how the old exit status could be used in a useful way but you =
are=0A=
correct there is a chance that some existing scripts depend on it.=0A=
=0A=
I was originally confused by the exit status when using git versions 1.8.3.=
1=0A=
and 2.25.1. With these versions check-ignore returned 0 when a matching=0A=
pattern was found, it did not matter if it was a positive or negative patte=
rn.=0A=
This did not match the exit status documented in the man page so I thought =
my=0A=
.gitignore patterns were not working when they were.=0A=
Perhaps I should stop reading man pages...=0A=
=0A=
I then tried the same patterns on an up to date version of git built from a=
=0A=
a git clone and found that without -v it returned the exit status as the ma=
n=0A=
page states but with -v the older exit status was given.=0A=
The commit that changed the exit status was 7ec8125 from 2020-02-18, first=
=0A=
release that included this commit was 2.26.=0A=
=0A=
So in 2.26 the exit status without -v was changed, maybe accidentally, in a=
=0A=
way that made it match the man page. But this commit broke scripts(that=0A=
do not use -v) that depend on exit status. My change extends the breakage t=
o=0A=
scripts that do use -v. On the other hand scripts written that expect the=
=0A=
exit status to match the man page will be fixed!=0A=
=0A=
I'm not sure what the best course of action is but at least with my change=
=0A=
the exit status matches the man page(even with -v).=
