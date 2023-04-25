Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABC8C77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 09:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjDYJ2Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 05:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjDYJ2W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 05:28:22 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn20820.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1a::820])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DBB49C9
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 02:28:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1hEopmoMLrg/gcunsQflWQfEs4iliWKrPWp638jpDzIOLY+7w48zVGFZ3UPfViAmzILoB4zZVxg6bqcBPVZZwLJQ2nNdlCcFPKJqdntfsLxeeiey0QtQIZiFO03Aus5/5VHfGpfO1HPZuZJayvEibF8iFzx4AzMLPsvMbeui0Hv8Rt/WUX2unhbwDwgUfXE4kfgCNProY0Ly+9LxC1c2aRg/nVI+6WC+qKZwGTo7NyhaAgajqGOe2D04JfWpsE05+joga4XxIodwi5OZrx8DLmASdpqcfb72Env+W2t2UFVBcwLTOK+/7i2Td1QPVOXta6iUmEzdHrBVHJFshziFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+cyHyHvmaSj+DvpT3IJxlIhBZrv35U8sOEeD2zvtVE=;
 b=bBZTw+cR7FmgZ36GOkmfLm1HW9CE4BaoHa/ROELYpQiULmJAvTNJw+AiQY7xlnmJRw+ajVdFzt3PfHflOEfOBIsbJI6e+AkbmHiDlGMPsIm3wf7oJxTyH4nAAflFNptkoRdaTmbTkGq7dOmVWf+FQeRN33f4/AmM6MSAzK0ag9GAd8FVI4WNd9gi32BLDIcBydQItVuYx9kKZyIJ2Hj98vzC60NO68Ad19pdFYDwA5Lvp1HpciaxnlO3Xf6bdZnCBCJYA3h1YgSLzZFtO34ia7+w/2RZZ0JXGrG8Ez/61nxrLEyzkOBfTj1pRFS/mmaXrlpY8nSUbHTq24WH9jFBcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+cyHyHvmaSj+DvpT3IJxlIhBZrv35U8sOEeD2zvtVE=;
 b=F/3XB2BL+EdCNJyp2Hx6iE3YVqBS4/kMDcv+814wQC7Ap8BaSrYyi11oIoLSlLx6sYx2AG88wE+0POCok8ag3GXLrMo92rbCw3ZdhREfjYtOEXK3i6Xw3OnKMESWDDkQfneky18gqWOV3cEUlXQZWkc4ZY9IE6AqBAXJUClJ1JkstOiJE4xq3kuJipYtADDetpryud3ab3gBgot/f+KYO8OQMermp41I5rRok+kZPDVwskpn4gqqTxBThwSJMEIh34VtBZTxaBPu9/csm37/6GLGMxd2y6vDDANiIPiZDXuNoM7tL0F85qOrcMxMKrk/nMUHKoJukxdbek2lp4st1Q==
Received: from DB9PR09MB6506.eurprd09.prod.outlook.com (2603:10a6:10:303::20)
 by VI1PR09MB6784.eurprd09.prod.outlook.com (2603:10a6:800:1d7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 09:28:13 +0000
Received: from DB9PR09MB6506.eurprd09.prod.outlook.com
 ([fe80::d979:c542:1713:21cf]) by DB9PR09MB6506.eurprd09.prod.outlook.com
 ([fe80::d979:c542:1713:21cf%5]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 09:28:13 +0000
From:   i o <lvsil4@outlook.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Proposal: adding --soft and --mixed options to git checkout
Thread-Topic: Proposal: adding --soft and --mixed options to git checkout
Thread-Index: AQHZdqGqIJFOd4OKQ0OsGknYTVP2y686+2AAgACnapU=
Date:   Tue, 25 Apr 2023 09:28:13 +0000
Message-ID: <DB9PR09MB6506FD114211F3806C48954AB0649@DB9PR09MB6506.eurprd09.prod.outlook.com>
References: <PA4PR09MB65161C38AEFBC07B3D7A1C62B0679@PA4PR09MB6516.eurprd09.prod.outlook.com>
 <6446f5824dd5d_cd6129459@chronos.notmuch>
In-Reply-To: <6446f5824dd5d_cd6129459@chronos.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [eflEMeSz1/dRnoRaaDtl3LJXNuBumcrB]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR09MB6506:EE_|VI1PR09MB6784:EE_
x-ms-office365-filtering-correlation-id: 333e5d08-174c-4220-fda3-08db456f64a1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4SwKX740FzADAUftXxdoGiDEcxSZ6vaSyRxOPnu/VIuAlrLwGoGBXuZxKBcf0AAj5+PDIMuuEO6I4cZSENI7IpyOFm1P1j99Qqd4p8ZL/r/TZQ3gJnh+geMeufu5vyYObmyTtsAMlWgf4DLoM1ljhxloQ1vUUeAJg3lrXA429iE8WnvwWLOvprQzZ8jisKXrK7fP0khp+cKeNP1sTptn/ZJ4YDAvAGu4P+7SZMQveBBoEMd/YDtrZFFScqWVM5JgyFx0/FVB4tQv4nlW4t5Fh6D7+S/mfDH8IUrKHG7dMnq/13hOWJbchmrvLKPFp0wAXBmwDLMK2K0zducNf4AUtxQQVhgyIY15Xj8VEEvD9q/H69xwszv6ibhA0rBNybbiIh99hIHS/DHoXiF6FE+xjf9Y90XSfx7+NaO8owJ+T0c5wu5Q/QvPCEiHsiYyCCJy9KXtJQhnCMeGIrbhuXzo3JsXOpI9+VTN94dJGpdhsjlwVr6Aunq1Zq6KReLH7lbt+kfx0NRIRrXRTNmcXhLAz0N4wZKcUtLM5Y7WQwmDUjNSRCN7znLIxbrCofNknuu2q91OkfEHmeHjq/zZY0UJiZ0mpWGwsOFGxsXVFlQVfmU=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DLKYVU097DQKU7BisdrZ/A5hyF9Fx3DqBhKFo7y7gughcbCuaZ8GZpKABr?=
 =?iso-8859-1?Q?YSY+mCQ//plUc93fP+Wv71nLmlOaAbmVkYp2n7GFAKzRs3RSvIVhHO+HAE?=
 =?iso-8859-1?Q?u6KQ0BWnOdnIFXa8+sV8oKOd/HDatiX4lBQc77tDVH4jrhaJsKZNWOJhQV?=
 =?iso-8859-1?Q?Oy5Lvc9TqaUt4iq8FofG7LmWfeGXIzWjAHgb9wiffIw039xVXjACyaTH3G?=
 =?iso-8859-1?Q?oiCyrzH92qmy0eOGuHeE6J9K4UjnAO5sIIzJFzSCWSGAa80rNs5i6Sw3vH?=
 =?iso-8859-1?Q?UYAqmuoUoo5vvj58yzsgzdkf+OMIYBW0oxSJfDrNBUgqhB+3x7JRHOF40x?=
 =?iso-8859-1?Q?WDrCWLuYgfO1Lx9eQcyDiTsaL9jq3VyLA12jHP4+CCltgG+6b96WFeIMjB?=
 =?iso-8859-1?Q?Z0p/B9zWvBCgfgHjcDpzSCOm+QAXwlMo53Aft/ybzeTfuwteVRmGNjZGyi?=
 =?iso-8859-1?Q?C76TWYEVqQ5Lvepf5SpL72oxIRuzR+Z1In0gAPxXT3njCJgPkskNWBuPqh?=
 =?iso-8859-1?Q?ZHCLGWGbOC/qivXVgysfFD/GWoKeygz/DZL/u9Xbtg2kC66a3OacOQoryF?=
 =?iso-8859-1?Q?vdcibQIaPXgsGMzb3YDZXjpNFQ/12svrlyYYLcn6GNxvERMTIzwLC0IRKh?=
 =?iso-8859-1?Q?2PsKOh1DRnTricXnHpTHt5so2KLmLmO6C+CDtebwbjTt/mPCMyN+f+trot?=
 =?iso-8859-1?Q?8HfMT3igPg7ZhRPiDr+fkzkz78CTae/KXhhGfbi5eALEbb/gBdmVuxovYb?=
 =?iso-8859-1?Q?nEU7Z1rZPihNv+ViSE30XGcAUx6e66WrempRPrn2ZW03iyec3QPPmQmZBU?=
 =?iso-8859-1?Q?MsXkMoFYWdgi8IdUEgQmXdbdR3wvM0ZGjIKKbGXNV93TNqWTn2SB6dcqGd?=
 =?iso-8859-1?Q?Kmk0OHH8o7euH3ia6girXB7R4TSfqT+nn/bhnJXVEDSqMEzUO1osaaFCNn?=
 =?iso-8859-1?Q?VuGK8iLzCCvm6zSd0/nQFhXrOWlTLl/IqiEUWOPKCE2YNFFHSxBwWpL9m8?=
 =?iso-8859-1?Q?40/OaZkUPS3HRDp8doj/7bB+j1R5si0ssKPVnkbXzo0k13JihU6ijorKOW?=
 =?iso-8859-1?Q?Qox5Gq99Ki2ywO/NC1TplkdxePiYQcrvU1LpgGD4AnUcexUGF3Q2odqKtF?=
 =?iso-8859-1?Q?oIybskEKhZhyXjpc3/XnzlfOmqHsa9d8wfMxaF+qsl7dwti9xXLuxpB8HI?=
 =?iso-8859-1?Q?5PE+gEcnhR7i1lSv78RGeHYXIcEZL7vxWxZ4UqIBnDIgM1NLgh04RgGZQA?=
 =?iso-8859-1?Q?AWTstre93elXdCw9Rgmg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR09MB6506.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 333e5d08-174c-4220-fda3-08db456f64a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 09:28:13.4668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB6784
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras wrote:=0A=
> In my opinion it's pretty clear `--soft` and `--mixed` were terrible name=
s and=0A=
> I suggested in the past to rename them to `--no-stage` and `--stage` [1].=
 We=0A=
> should not repeat those mistakes with `git checkout`.=0A=
=0A=
No problem with renaming, but this might also be an oppurtunity to reconsid=
er the meaning of the two options to incorporate `--keep-index`. Maybe `--n=
o-stage` should mean 'switch HEAD and the working tree but leave the stagin=
g area' (i.e. the equivalent of `--keep-index`), and `--no-work` should mea=
n 'switch HEAD and the staging area but leave the working tree' (i.e. the e=
quivalent of `--mixed`). `--soft` could then be achieved by combining these=
 options: `--no-stage --no-work`, but it could be a worthwhile convenience =
to add a separate option for that (just moving the HEAD), so maybe `--head`=
 or something like that.=0A=
=0A=
> In my mind the whole point of `git checkout` is to update the work-tree, =
if the=0A=
> command is not going to do that, then I don't think it should be `git=0A=
> checkout`.=0A=
=0A=
I suppose something similar could also be said about `git reset` though? Ma=
ybe this would support the general move away from those legacy commands tow=
ards the new set of commands, so putting these new options in `git switch` =
instead seems reasonable.=
