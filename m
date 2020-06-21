Return-Path: <SRS0=gxdb=AC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D11C433DF
	for <git@archiver.kernel.org>; Sun, 21 Jun 2020 00:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92C072225B
	for <git@archiver.kernel.org>; Sun, 21 Jun 2020 00:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="fmA5hP4n";
	dkim=pass (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="jCS/eWbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgFUAVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Jun 2020 20:21:02 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:6286 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728520AbgFUAVB (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 20 Jun 2020 20:21:01 -0400
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05L0Hm6U019247;
        Sat, 20 Jun 2020 20:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=yed6G2FvBgJtBo+O/SxLguoFRU481oYvZADasB53yQo=;
 b=fmA5hP4n5b2B9+d3sihdNCYZ+T5A6Es6TRwNfYK8IjU+RTdfpGfEpQwDmz+UMG7DqdHK
 6ZrXqsV2MIxgnsyNBr4NA2IZhQvnjDDTAzIPQGz1Mn1JmQBOOqm1ZW4QW5hR/qU/axSH
 DGPm8V47O+XoWhXlCJfXKpdQY4n32DYbItJUVE8lESxS5Ez0nNit3XSXeP4wgoJsbUZe
 biX1X/hx88NybM4eHRaK74NofTVviR8avJRbGeXlqa5KgaGVYL13T3M5IPqB4bh2VhUI
 Cog7I7fwKz+mNfz9E7lCUgvC+LxWXZ2iD/Ryz8p55XgOkgJe95XghP2MaBNVyXmQuSTY KA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 31sdsj100n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Jun 2020 20:20:50 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05L0Ec2t028640;
        Sat, 20 Jun 2020 20:20:49 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-00154901.pphosted.com with ESMTP id 31sd3dpmxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Jun 2020 20:20:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIQkxixgLZ6SjWzQvJZcXH7MlzuwHBzSOEDeLleIVnkfCOOjeCfWKgZcKkAMNNnDFMutgcLTxKhOLOe0pxOk9NshKdOkBXYOhgwNIokFZ8kXLnrRXs4QMZ6pmP5GWF6kP5+J0LwYwScD4Am/tgnGgHL+AafonvzEn5oTLlfMMhnWo5SBmmShnam3iCgGht/moSpo7UN21gadg9JyVN6+6Q9qwowhr3eOhULQryCyJJxlDxRrTW5Mi853jWCFmWbFcNVavkFrZ7g4uOPwATsPudlcesMc3WosXHOkd/6nF/jImis5dkK6DkQXcZR+REL5aN6zFoMZKMZ0Xqco1zYbQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yed6G2FvBgJtBo+O/SxLguoFRU481oYvZADasB53yQo=;
 b=L1+NI3ZV28NDqo2IaDsVpJthx9QeWTSIv+FOxU/s6yzwpFZXQrZBFAnuK3wfFmSH2bCyAHUYywArBXP/8Qj+hvQu+eOLK8afQg/7AsvVyr3JFQqthsKYNvJyAT66yMA9aCH6Fgvif2iGMuextupm8+FQsmmhkQXqWm2nWUxDzlz5Y3bF0Q8ZRlsFAJtjP8AHFDK3Xvt5KInYt2U+XSsYQaDkuMGEY0d41Bo24WaBYm2uC+bZJkb21O755KwLhlalJrzCe/wJ5N5dDfOdQKScQCMH/RhoYjA+RTag3TuCR8bzgC1J8+/J7MbIwpDZeGjhftpJyAwKUyd1sQ9NziTiGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yed6G2FvBgJtBo+O/SxLguoFRU481oYvZADasB53yQo=;
 b=jCS/eWbJWirh67E85XV4kJozrsENX5hjDkwxyEgzUPOLOMeNF9etMXoJwo58pUIDKLDO+t09C9T/UvKf+uKzDxU65CL0/vJgc/GxX1f2beynNGvYJvByTn0GRB8MYJJEoi1Fb4NnNzcbvWWFVMNCskp5AbZh/bKACc0tUItzOF4=
Received: from BY5PR19MB3400.namprd19.prod.outlook.com (2603:10b6:a03:181::26)
 by BYAPR19MB2727.namprd19.prod.outlook.com (2603:10b6:a03:f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Sun, 21 Jun
 2020 00:20:46 +0000
Received: from BY5PR19MB3400.namprd19.prod.outlook.com
 ([fe80::2008:3bcd:b8ea:126b]) by BY5PR19MB3400.namprd19.prod.outlook.com
 ([fe80::2008:3bcd:b8ea:126b%5]) with mapi id 15.20.3109.026; Sun, 21 Jun 2020
 00:20:46 +0000
From:   "Curtin, Eric" <Eric.Curtin@dell.com>
To:     Christian Couder <christian.couder@gmail.com>
CC:     demerphq <demerphq@gmail.com>,
        Konstantin Tokarev <annulen@yandex.ru>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Geary, Niall" <Niall.Geary@dell.com>,
        "rowlands, scott" <Scott.Rowlands@dell.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        "Coveney, Stephen" <Stephen.Coveney@Dell.com>
Subject: Re: Collaborative conflict resolution feature request
Thread-Topic: Collaborative conflict resolution feature request
Thread-Index: AQHWQMCn0onLmOAyQEGi/GXRui4z8qjWdTOAgAAG3/+AAE1tgIAAJXiKgAEnG4CAAVRHkIAEpDkAgAAFwVaAAA7mb4AADcuAgAGCAsCAAgXwAIAAfiut
Date:   Sun, 21 Jun 2020 00:20:46 +0000
Message-ID: <BY5PR19MB3400DC6B6065C1FFF2ED289890990@BY5PR19MB3400.namprd19.prod.outlook.com>
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com>
 <BY5PR19MB3400AE170C9F5FF501D27B18909E0@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD0aoNQNcNJytJBazoKj0jvWwykntHHgnYoCBXr6OmGOnQ@mail.gmail.com>
 <xmqqa716zs7w.fsf@gitster.c.googlers.com> <30661592138737@mail.yandex.ru>
 <BY5PR19MB34007DEED68D13003C614F5F909C0@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CANgJU+WfW4mKotMwFS+2Kaq1pDysgJutJ2NhUvyvGgowk8JXsg@mail.gmail.com>
 <BY5PR19MB3400CD5482C8837E41DFEAF2909B0@BY5PR19MB3400.namprd19.prod.outlook.com>
 <BY5PR19MB34004D9F72F6B66376F8E986909B0@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CANgJU+V7MUC85n-=_yQG05w6MOmSG_ZvmQBJVTk2qRyk=7giZQ@mail.gmail.com>
 <BY5PR19MB34000FB239B2B7BD996A17C790980@BY5PR19MB3400.namprd19.prod.outlook.com>,<CAP8UFD2t6OVFWjm76oy=+Fgo1UUepwHTpOWM8vmCYzs9hSy_ug@mail.gmail.com>
In-Reply-To: <CAP8UFD2t6OVFWjm76oy=+Fgo1UUepwHTpOWM8vmCYzs9hSy_ug@mail.gmail.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=dell.com;
x-originating-ip: [2a02:8084:90c0:f380:44b7:3ad6:4553:4340]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2400cd23-af48-4e56-f728-08d81578f18d
x-ms-traffictypediagnostic: BYAPR19MB2727:
x-ld-processed: 945c199a-83a2-4e80-9f8c-5a91be5752dd,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR19MB2727E9669789A51A31D4C6B190960@BYAPR19MB2727.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04410E544A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8COLY4JFuGs5bxgIEBZUNiNyDrfNRIY9tuVDmCn510+OQCoheRuLEx6QN7AbP6+KttTbQru/KnTav6QUptdLaHdKO6Z+pmb8uHwIMA56X5pvpQEoSDv+XC1Fsw8HaTu/UI56V/BZRn040UVA55PUIUMl0HkcU3T0ULBvR9CXotABLKZAtJfH/zoffrPqcBO10rmdyz56Ev6rDaFMEr1xchFyslhmgKv0TcN5hRqT2oTa9WWw+rvo3esQQkknz/JLfQ32VfCQiiDYIAiFowsHaT3JHxrkHUHo9PbKBG21ztls4VNmPO7RJWDNnUaN9TNoYJ0sjOcmX+Q/NC8SCBXyiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR19MB3400.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(346002)(136003)(366004)(376002)(39860400002)(66556008)(478600001)(7696005)(186003)(33656002)(91956017)(76116006)(66946007)(66476007)(64756008)(66446008)(54906003)(6506007)(107886003)(9686003)(786003)(55016002)(316002)(5660300002)(86362001)(83380400001)(4326008)(52536014)(8936002)(2906002)(6916009)(8676002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: b4Zz0sI3ip9wp6dNg4oTjOxqZpmlRn7FgoWxLR9rqTMbmbEX86qyuXEH0Jfde+ZIGwDm0eIftbq7Bx9hUfNiIreVtVGLux7rEydPYJxyW2YvqQseoJ27hFkxIFtxawgVsODUFrGZMgrIZ70+9DwVzvcEXCWS4qU91tRrO8uUzf2/bZ4KRingtSAct9mnZyljlTdbCF+4W/ZnuxccIqk1wFwOOE/0Ha9a5sLbYYI4fzKY+w5jAE1xWScVUYn7H9hb6MWn24UeRGY82UAvwqIS20rdxIOj9HCARIGiN0NHp0izGHUNdHdbBBpC79Y08GzL7lkUYtCiyWzR5VLRvDisKqLcS+swywqmVriTKgtyRxRIjHi3lRemXZKNJ8wWPrPJjGP1d0lDnXEWAfxPKJ/3Yk283blnTcQDJg0wcX0IYqHr3XScW/YwdopuyxQEoAx73z92m+g/CoELXBAXS5eAoWvz72JfRJ5PT0E0v6uY3fM3xmQK9hfgGhq0ea9xDfhx+QDt/p0cE6L/zvgVlhMLgQZPUkDIuSesvIJ2QkOwU9uv3IbNfLzGE67aj9Yt+AED
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2400cd23-af48-4e56-f728-08d81578f18d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2020 00:20:46.3568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: evYa6O61nH1DLzo5tdXu8amHVO8L5mvZ9Wwxpaqix+1IiLG+JAf39A6Dm+8/peBmpwABWGEkZyNlU9CB2qV2IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR19MB2727
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-20_16:2020-06-19,2020-06-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 cotscore=-2147483648 malwarescore=0 phishscore=0 suspectscore=1
 impostorscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006210000
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006210000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I think it could be an interesting feature to add to Git, as I agree=0A=
> that some people often have this kind of issues with conflicts.=0A=
>=0A=
> What could perhaps work is to develop a new command, maybe called `git=0A=
> conflict` with subcommands for example to load, save and maybe push,=0A=
> fetch and resolve partial resolutions of conflicts. The conflicts=0A=
> could perhaps be stored as commits in the "refs/conflicts/" ref=0A=
> namespace.=0A=
=0A=
Yes and actually the more I read about things like `git rerere`, most of th=
e=0A=
components are already there in git. What this concept kind of is, is a=0A=
pushable git rerere cache. A workflow could be something like:=0A=
=0A=
git merge/rebase # fails with conflicts, maybe a prompt that to tell the us=
er that some conflict resolutions have already been pushed=0A=
git rerere pop/apply # apply the already pushed conflicts=0A=
# fix your conflict with whatever technique or tool you prefer=0A=
git rerere create # commit your rerere (stash uses the term create) writing=
 a message explaining why you resolved this conflict in a certain way=0A=
git push # or maybe `git rerere push` so the next user can "git fetch/git m=
erge/etc." and work on the conflict resolution=0A=
=0A=
And maybe add some other git stash like commands like show/list.=0A=
So other users can see who solved what conflict and why that decision was=
=0A=
made. I'm using terms like pop/apply/create just to be consistent with stas=
h=0A=
also. The reason I make that a manual step and not an automatic step like=
=0A=
git rerere tends to do, is that existing users of git won't be aware of the=
se=0A=
automated conflict resolutions and I'm sure many people won't like these=0A=
being applied automatically by default.=0A=
=0A=
Admittedly I don't use git stash for temporary local changes, I just use=0A=
commits and branches, amend them, delete them etc. as I see fit. But I=0A=
think the concept is very similar, these are not complete buildable commits=
.=0A=
=0A=
But I think you're right Chris if we start from scratch and call it `git co=
nflict`=0A=
(although I was thinking of maybe `git resolve` or `git re`, since rerere a=
lready=0A=
abbreviates resolution to just re) we don't have to worry about backwards=
=0A=
compatibility with existing commands designed for a different purpose=0A=
like rerere. I'm not too worried about the naming as long as the workflow=
=0A=
is easy to use.=0A=
=0A=
I might fly this by my lecturers as a research project. What do you think C=
hris=0A=
and Junio? I'd be happy to send you patches of the work in progress as it's=
=0A=
going along if you guys would be happy to see them?=0A=
=0A=
Regards,=0A=
=0A=
Eric Curtin=0A=
=0A=
Software Engineer=0A=
Ovens Campus,=0A=
Cork,=0A=
Ireland=0A=
=0A=
Dell EMC=0A=
