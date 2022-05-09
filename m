Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A94CC433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 22:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiEIWqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 18:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiEIWqM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 18:46:12 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2100.outbound.protection.outlook.com [40.92.90.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A081C12DF
        for <git@vger.kernel.org>; Mon,  9 May 2022 15:42:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxkB7QAmOiRUBwoJBCVw8lbHIpV6BOqTOvxxPNXjj41Pr3ZVxso0xVVKkVMgLUKYfBNjLn5sRUSJT9BfIocilYHifKz3Q54xavMgDxp/d/ZckY2jdVoZDhRyw8yoU2XMW19k4XEO2W/fge2jjoY8rmi/s6O7HnTYcE8Efur5mlI7R4xe0mo/h/AYk2ek3exHe687EWmipTrgvwk9uPosTH7AVqERSGv+JELWBumi+ABKDy8kfcVc9n0GhFmxncZVy6zHaMAAzYHEVmdOb/2sAzFTkwyhzkSUQIeH6Dvn/TDffBYIpE/+a752mOnrLOpD19+6bjvl0eBr37PUYB56iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rltGnZkfql4DSBCqL1/9tBEj/u6Zh/nTGrDpDv94Ta0=;
 b=CMsYyvmx0WWBqWNuC+fkU8oMxK3PS3Jo73LZ+UP1RVTIj/6VAPV4mMlPJQer9YAMZmkml3O4bX1R5dkg9KPW+P+0TeepuAY6HOZ8koPXQQV6pGBDtJUfqeXJojFqNT2dbp0Vh74yr6d3jqHO/EwzvTENtz6ns80R67BRvrKtXIq8rOAiWrxsPlK8HYBUGgIbjd2DUBRhZBUaw4v0euDi5pQg/OhQ2nsiv6o6xVBeVRvVdKjp0A+D+Biw8SVqIe1xeBHHxSpadg1iq8nOBCGZIZ8VvJveKBYs0lImuD/ocX2D+rS18L8QJeme1k1JIItaK/uGJj+InafzVLuscjSDGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=msn.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rltGnZkfql4DSBCqL1/9tBEj/u6Zh/nTGrDpDv94Ta0=;
 b=iWn9mNmF1zCb64efZosJlvZtZUDOdm9Tp7AI+A4oIosCnL2vvD1AhRK9WBbs7G9sVwacFuMwwNW7ijRZ+oA9Y6sQXrguN+SQjhGRMbvGgVlP0Q5x4LF62hIWBzpXQgc0xBOnrrpAy9Xa9g1rYDOMOSDXmqssgqSepjYlUYgfdLf/GDtv/m49zYXeoQ765qhpzBsJjbHDwG1HCdQqO4pxN8L3PXHO8am52F+Q9NVMMdnbkQ2Mjy++b8KaRlS+PWS/ZLe/o+ydrLOWU9rpm0zkKVolM2FCM7c1VyCSNcouCvVbqIqtVt/ffLUk51FwErN92r3GPfGhVnYlNERXiCLLDA==
Received: from VI1PR0402MB2877.eurprd04.prod.outlook.com (2603:10a6:800:b5::7)
 by PA4PR04MB7869.eurprd04.prod.outlook.com (2603:10a6:102:c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 22:42:15 +0000
Received: from VI1PR0402MB2877.eurprd04.prod.outlook.com
 ([fe80::2cf5:ca8a:8d48:361a]) by VI1PR0402MB2877.eurprd04.prod.outlook.com
 ([fe80::2cf5:ca8a:8d48:361a%6]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 22:42:14 +0000
From:   Timo Funke <timoses@msn.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Weird behaviour of git diff-index in container
Thread-Topic: Weird behaviour of git diff-index in container
Thread-Index: AQHYY/XheX7PZkm8R025WK6mhDZHOw==
Date:   Mon, 9 May 2022 22:42:14 +0000
Message-ID: <VI1PR0402MB28779C7A41783472B2EF6823BFC69@VI1PR0402MB2877.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 936eb8ca-97b9-4249-e660-ffb581d8d73f
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [j7FivsxQYriHXK36bQ2DuIs/0AT8vqmM]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b369af8c-a858-421f-6692-08da320d2a15
x-ms-traffictypediagnostic: PA4PR04MB7869:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GjZred1zx8uumGoHAB4g2VPtidL1EJLEoj0dhPk/pDqTIbTV1r/QaV7q9IbtS18c/gCZhzSZjEMjzW47bWVxz30dnOHlcS9EYy1/0Xy5qBWiLmqNwdwpjfSqVKqgNF5t+2h3cUr6kHwVMOZpJZmDg2sct7Qftw1hyBdB+M8yiR+fXA5YQvJofpAKHVE8qjrQv+I0gLKFJ7qFaeEiL9II8BlKYMdcvwpUwFFFplUoOJRCudoS4J3GrH1Q5I+enJMmZpD+tXzZ+lY8tCH8mkBwJBvvGqmE4oEPQsoGw+9wTEvC2gfDyJSUuWt005s5UldPPPgq2OOCeXb2blCETqOftS2K5EFTBhP+AK7XzbxKkxTsj8Tn5VG+A89yKkFVT086/+TBe1NuZ8AWRaVYKaspA+SP7A4Bmq0KSd+ucm1dj3f6AaAWovBVcnIucs3B/i50Fo/jxC+Kus0qx1wAC4TDQzx3ixRS1+CT21jzQWVBEvnboj8xL7Ac53+IlBKVigPxaPpRSQ93qKjUhkm5Y4X9G6GJgPadx+tqTm3G/JOMNBlCTr9jzx+ZYJrgXAriMsmpGGl39FOVqQgXl0xZSkgVm9KjknPjMMigwxfaJfglfx53AGF0m6f7Ugcto6B8ONKpBAKGUSWQkm6JWZzT5RM2v6c80zAePIdwCqvwfWC1e4nek1/xSe+f2LlnTxpp5vUM
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WpASEqZyt7jTZ+6VyLOpdDYd5VGvkFJNQKMKPdK+1usksyfJREG87KQ7bJ?=
 =?iso-8859-1?Q?z7T2kARHF/4OILZf6ctfHf5I23X4HE84QiUdQRaxGEnH6sKCBn94I5Ukx0?=
 =?iso-8859-1?Q?2EeTuaD96SFvhvuZTUJLPbfBygtNtg+3yjt9KUv5AtO9dRUni12fKKYSpG?=
 =?iso-8859-1?Q?7HEcf38rZkEHfHYmx1wiu2Bk7H4WXMU+QnEE9BykajcbIXca5TcT3iJlE+?=
 =?iso-8859-1?Q?F9tBsofmAxfvA2uWGE7x1iJuGa1RGM9ExTUFgm+nq1rkrmkETW+KjyPiu8?=
 =?iso-8859-1?Q?6/Bul64gfrdZtPWsyZIWl8YjjItuUe06NQgw2/x7D75QApHQGMEABICoeI?=
 =?iso-8859-1?Q?3TqVjeBjvhSO+GBcfT7FZdivrCsT32tZLithWD6+EDt2WEdvesxQF9QCpM?=
 =?iso-8859-1?Q?SBsjIDnVHQxpK+/hkYtRtpf/OWHbZeqC/aB6HeqjGiwTSXUMqYcIDToj7s?=
 =?iso-8859-1?Q?MQwVRz8uIwIrRkfmpM9kB0AMwxqa0tv0zOUQgjQxGlyXLC8DuHISTKearO?=
 =?iso-8859-1?Q?JFMpKP9Vo30Gm3Hut3zgyeeA6/cpXjptiDoPd7oanr2kepFt0wXoU8Km3K?=
 =?iso-8859-1?Q?nLRGpfJUz5rNFDs2Y2ho0l8W2E6tfMiX6oCC5IlW8rJkLhdQloN+lbv8SV?=
 =?iso-8859-1?Q?OIhIi6ryrz4niy0PzNXnWcjJhcywVaz6EL9GjyLjG3BhslC0/yi1OJgBEf?=
 =?iso-8859-1?Q?Gjn+pAIJaaRidYHuzBYM5vMZSO2Z5vLtHr8jXfKZcBMuI+VpigpEtEy2+x?=
 =?iso-8859-1?Q?W/AZqvNh19TWUdgArU4o7nFSrlIsdfeWZb2uZO/PhXdJ/svgrHI/HTjjxE?=
 =?iso-8859-1?Q?kmnffsbLXkDDJx9oim0EpLgpvFhKtfZuM5Clww3TcTxNGJisZ4CevB73C4?=
 =?iso-8859-1?Q?IBCNeB/Nc+SohI6Pq32jabTte3HL6+HPLDVh1PYVXdkK2heNik/bJmCfTj?=
 =?iso-8859-1?Q?rx1BGHCq8f5nxaCam2zEfIViSzfG+51uhNGMrNOrFmoJWbyedN+Ll6siep?=
 =?iso-8859-1?Q?o8v2ptsXEdetnZUsOAsOUBDy9Y20HzR5tVt/FtQp50PqPC4JNPUovX1wFL?=
 =?iso-8859-1?Q?1Y11WDiRqHkrgFpQmIR2wlFo0jUX7SMJmxIvFeHp2O8zUxoSwO2tmvQuPO?=
 =?iso-8859-1?Q?uScxaj53+nxhxj18/RdZ7wlypwBmXZWHGyYoAURXoN0uRp9NW8BvobNyzE?=
 =?iso-8859-1?Q?/MlXVKmN0fixch9F4RGzffaJ2BjtDOuUrT8jG1GWvWZ6nBAQFnTjsEZ/ut?=
 =?iso-8859-1?Q?xUb1KsuIfL9N80gLkt5h59Z1W/vmop5oSXzLzOrR+Yqbcza9T0mFuq5Agr?=
 =?iso-8859-1?Q?zKpckZtLnhPvVkPJKd59inVmjL0/vQQaef+Y+mirno6VUwlxXLYFBEINxI?=
 =?iso-8859-1?Q?2nbal/XfsnZ1lTNUNQ/FUflYkJ0FbNnCZy1oon7o07U0pGnBp4SmXCFR52?=
 =?iso-8859-1?Q?mOGbd9AFfsWZscMUnNTWvYUomjPRRP5hWBVBfA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-03a34.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB2877.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b369af8c-a858-421f-6692-08da320d2a15
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 22:42:14.7887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7869
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)=0A=
=0A=
mkdir test=0A=
cd test=0A=
git init=0A=
touch test=0A=
git add test=0A=
git commit -m 'init'=0A=
podman run --rm -it -v `pwd`:/git:z --entrypoint sh docker.io/alpine=0A=
> container# apk add git=0A=
> container# cd /git=0A=
> container# git diff-index --quiet HEAD -- ; echo $?=0A=
1=0A=
> container# git diff-index --quiet HEAD -- ; echo $?=0A=
1=0A=
> container# git status=0A=
On branch master=0A=
nothing to commit, working tree clean=0A=
> container# git diff-index --quiet HEAD -- ; echo $?=0A=
0=0A=
=0A=
=0A=
What did you expect to happen? (Expected behavior)=0A=
`git diff-index --quiet HEAD -- ; echo $?` should return `0`=0A=
even without executing `git status`.=0A=
=0A=
What happened instead? (Actual behavior)=0A=
Without executing `git status` `git diff-index --quiet HEAD -- ; echo $?`=
=0A=
will repeatedly print `1`.=0A=
=0A=
What's different between what you expected and what actually happened?=0A=
It is odd that `git diff-index --quiet HEAD -- ; echo $?` prints=0A=
different results depending on whether `git status` was executed.=0A=
=0A=
Anything else you want to add: Perhaps this has to do with running git in a=
 container?=0A=
=0A=
=0A=
[System Info]=0A=
git version:=0A=
git version 2.34.2=0A=
cpu: x86_64=0A=
no commit associated with this build=0A=
sizeof-long: 8=0A=
sizeof-size_t: 8=0A=
shell-path: /bin/sh=0A=
uname: Linux 4.18.0-348.20.1.el8_5.x86_64 #1 SMP Thu Mar 10 20:59:28 UTC 20=
22 x86_64=0A=
compiler info: gnuc: 10.3=0A=
libc info: no libc information available=0A=
$SHELL (typically, interactive shell): <unset>=0A=
=0A=
=0A=
[Enabled Hooks]=0A=
not run from a git repository - no hooks to show=
