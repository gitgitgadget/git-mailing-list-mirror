Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43572EB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 21:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjFZVYS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 17:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFZVYR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 17:24:17 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2081.outbound.protection.outlook.com [40.92.19.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B94B1
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 14:24:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ht7sNEKHyjTOH8v8Z8ltppw+tAuUYvuLZ7vlPDFzFT3neA2nV/WHnCDVjLd56IjsOA06DthxTxvCffQHgijFqKisgcXEcZPUMO/UIaLjONBnWIu2cDX1mZ9sZJBv0Njdz7aPlDbfi5l/NwFV6M+vHSZtzdGtg9W/HUUsZfceSlzyrO03AivzzQcXAlQ9RaJv+PWCaKf/Vhine74y0oz+ZtSaEieZTwUjwLthJrSpkt8aLnDByY0qPlddZIHcCX2O0wsuQeI1sim927DQflaxpY7s0LiY51nMp2wg2zeTh/mp0KIbcRCJBEoUUPw25qr0KwiLHH9FSrFgVxTmRv6eKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcbpmJN++Eksv/RdqhJQZx5qcGY1FABZRtsGUPRkT/Q=;
 b=Ow++r/5e44WBsDLYHnnYczpWXCDywGeVkiwaK3BF9qAqaRqWUkWmFGHpUYYYYLU2o55rXDrGKEUanNWcq6++XiqoGLwL09FxvVr09RVRK9MxxBkaW0ODAhyPjyg2REuSN704oXxAnxiMeOtGaxVXuycIiboajBkBBM1VzSQzQTNVvgujoyBhbaprPDqeuDBUEOFBfFIH3poE2Mg3SPHMz7RrRCcEZg8poXfrXeX7mVWkhAs51dsXGndNJNNzVqnGVrOwYJ/Q3lAGQ1dsSAq6i96ixlFr+d/naAIDuNen4VKwh8b4aM1e8MGleqokIQYsu5rH4uMTr+lpDT2+40HDRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcbpmJN++Eksv/RdqhJQZx5qcGY1FABZRtsGUPRkT/Q=;
 b=PoNGIR5KHFsP+sWqKm93VGCxg0wG5hbK+5I6thejJ/CmpLhKfE0Yi1C5j8j/LfwwG+e0hTrRPNdph1KdRWjNOjh99TFtgvwahQjFfrgIS/jEbEfHYhN0pdNOnoIjgyHmdDeYKZBVEAnR/KFyeS2IrewSLFN2vhjn/69lKi94tCT3JGTDhg9D4LcNOZBgXYheP0zyNT79vNdV6B3l7u6Tb1WOjyFN6CMNZQYcH/ONXMupsbzsUWiD7bJb8W87bRDZWbhRePoWo4VQg/M1IAY8uhuHuIzrXHWyuAvJbOVAIblRZ9SCNaVDssCaGaboG5q5yLQpJKBt8lYabU58DnTi9w==
Received: from PH8P223MB0699.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:1ca::15)
 by BN0P223MB0040.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:15f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 21:24:13 +0000
Received: from PH8P223MB0699.NAMP223.PROD.OUTLOOK.COM
 ([fe80::4759:a244:d2d0:3ff6]) by PH8P223MB0699.NAMP223.PROD.OUTLOOK.COM
 ([fe80::4759:a244:d2d0:3ff6%7]) with mapi id 15.20.6521.023; Mon, 26 Jun 2023
 21:24:13 +0000
From:   Benjamin Stein <benji_stein@hotmail.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bug: fetch with deepen shortens history
Thread-Topic: Bug: fetch with deepen shortens history
Thread-Index: AQHZqHR9sgS2ms3/kku5Uykr0OUHyA==
Date:   Mon, 26 Jun 2023 21:24:13 +0000
Message-ID: <PH8P223MB06996E110EF25C386AA314E19F26A@PH8P223MB0699.NAMP223.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [nqzmFFmWtgnhMnyJhx7ZgnIihM4FCVi2]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8P223MB0699:EE_|BN0P223MB0040:EE_
x-ms-office365-filtering-correlation-id: 7cec96a3-d85c-4650-7687-08db768bb046
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O3Gf8kbp2nO0ccJw7T/+enEFqNE49N7AEr4aY+e5KmMtjfaDXNBpXeE8ZlJ+PtNEOb6tkzgJ2+3Qzk+1y/8z8i7lEMkj19VrxBkm8kO74BWNOAX2NS2DLI7y+/cK3Vhm2irO1U0kRtD3SkngVnDqj8xNqHBvzTkBC1tkXPDO4jvHzkWURc3zMRI7JXvU5gwk8nzSZJYfXML5L29LYKzhTxSZhSKQ+NRkInWgGZihsnunfr5z0OU+ZbETtESlsoTqY57PQRarS+2hy6ZuuG0iMJ5SzdAazUwV9HM0fHtxPTqxTctxg7bHh94/1D4W6FXc3QRKyiaTPMJkkR8r5CCebjW0kTpJtblt2eqiPRHSgsBo9R9PMD93/2CwVk05ClMg86wtO0dLtnu7pCvcgIP8Ee1VUsBaQ19Voap6t+rNPQZJxOnMF62WGc1gM2fIIr/Dm4RdioNvipJQ5gHM8zYxo83fuufBGjXUkbEgXkbJm+TFGO8E9bLpsura5V/86AK6tzwS3PXBWbsPEWHeOIs7ajpL/nWoHIIwK8j6annOKh1ar/VxnnjtbL0+GlY4+PjS
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gMBVH/KNfLRDich2D/VLme4NQutxLiEABFr8nO1vrFru/z6PYF+KZ9olmr?=
 =?iso-8859-1?Q?d2nFNm6COGwMF0qTzRVFzd7TEm9P8Cblf59qlNNeIRLCtrNz28t9PI6bW+?=
 =?iso-8859-1?Q?QNgfIzdkVpTNjZrHgrm2NRCC300r6rXnZUbbwPUxVqiiCRPu2B5MS9iYQZ?=
 =?iso-8859-1?Q?7p+oXtxm95ooN4mbljPH0OHFBZoa9vjTGWvKD+NrTwmNt81xGZ9UupmgLh?=
 =?iso-8859-1?Q?EBTgUrrkMvndMGUCTdhIv0sSEYrL8tkRDxdwlKVy9fkXNZhlV963D9wc49?=
 =?iso-8859-1?Q?pZZUnsugK1x8OZKQ1RTUPvxCc+zXCzfrTGBA6TiSDjE5GgJU872SIMi1fh?=
 =?iso-8859-1?Q?T4dhWXzHm0fxIWhRJjwB1RquPojB4mhXDjRrXxkqwIlpo3/2Wydsutizqm?=
 =?iso-8859-1?Q?kV7ATWC7n72yetgOGUP0pIABgiUqmE+DH7S29NBHnEeMN7mePUOM4dQ7YN?=
 =?iso-8859-1?Q?L1lJVTdxIWnCx2WRbqOfpAZ1C+tc7/nzbZn+JyoeF3mVATp1Korgjrze03?=
 =?iso-8859-1?Q?+sd9J2FQ3HG2SXFxQZj6kwZvJ9UHZEjZs3UhhZZyZ/mSxoFxO3TZzKf1FM?=
 =?iso-8859-1?Q?pHCiU5aQDsDIGO1anyHjsWBE1VZ3dz/b1kGuTBfJRiPAanINJDoKgIZVg4?=
 =?iso-8859-1?Q?mQ6BJxpo81LQX+YScTNPNGXg8Bj4AqGEwAo7DHkqvjtPmfmxdI1hDjM/eq?=
 =?iso-8859-1?Q?810cMp0bpQUC0pE+V4QNAKCmiMpWOxO1il5MpzMjIF3+3/lTYPiQRdOVLx?=
 =?iso-8859-1?Q?Wp44rntBoSAHbDlifVZnaZbK2l8hC7/BB1cifZ6xfUMZwVXqqoRwbz73Hf?=
 =?iso-8859-1?Q?8iYtnb/dZFiLYGNvRaQ38cMdhwnTT9GkswcF9YyDvqDd9WO3nYjwGa/bzF?=
 =?iso-8859-1?Q?jtp51bY5X5ihOt7KAxiWcIhVMiSoQq5lvczhgmaiVrYpMUgaNQHgykZGF1?=
 =?iso-8859-1?Q?83aryN+V44f98YIYgZF35dDvVPLSSX7uCIbH4bBvu9VpSbZhc2EsL6fswg?=
 =?iso-8859-1?Q?p7fAoA1bbh3lHiAGCXQlCeZKVVm/7nzdii3w8e7xwoiQgBWg9CKaTKdio+?=
 =?iso-8859-1?Q?n86cG7lfk/q2EB379uN9kijO7XK0mXogQJ1w6GZRqyofC0LCMsd95Z1neB?=
 =?iso-8859-1?Q?LsKdvcrLhV7GivU7i383+3wuGjdQbgigJ83MiAsjj9QLHBWzeSc8Q0KWC4?=
 =?iso-8859-1?Q?1hv70HWWr+eJhuABAOg4/XJlWFle/D4zu1M7cZWGXGKwn21SASwiK4/dKn?=
 =?iso-8859-1?Q?ZaQRYXsGPI95TVMlDEtA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-1ff67.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8P223MB0699.NAMP223.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cec96a3-d85c-4650-7687-08db768bb046
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 21:24:13.2415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0P223MB0040
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello git gurus,=0A=
=0A=
Here's an atypical bug report for you. I'm sorry for not starting with the =
template, but the context/setup are longer than felt useful in that format.=
=0A=
=0A=
I have what I believe to be a (relatively) simple, reproducible test case (=
repo setup/steps below) around shallow checkouts at merge commits and deepe=
ning where the behavior is quite surprising - I end up with a smaller histo=
ry after a fetch operation than when I started!=0A=
=0A=
I've tried this on multiple OSes (Linux, Mac/Darwin), shells (zsh, bash) an=
d various git versions ranging from 2.40.1 to 2.34.1, but I suspect it's ol=
der than that.=0A=
=0A=
Scenario:=0A=
I'm using GitHub actions to look through some commit history and generate a=
 report of commits relative to another branch. The specifics aren't super i=
mportant, just that I start off in a shallow repo (depth=3D1) because (1) t=
hat's what GHA drops me into by default, and (2) since this is a large mono=
-repo I don't want to fetch all history every time - so I want to minimize =
the amount of data fetched.=0A=
So I used `fetch --shallow-exclude=3Dother-branch HEAD` to get the relevant=
 commits, and ran into my bug: when I do an extra `fetch --deepen` I end up=
 with only a single commit in history instead of the N I had right before t=
he call. If that's not super clear, I think the reproduction steps below sh=
ould help.=0A=
=0A=
Even more confusingly, if I check out a merge commit into trunk (the defaul=
t) it misbehaves, but if I instead start out on the branch I'm inspecting, =
the same sequence of commands works correctly! This detail threw me for a l=
ong time as I tried to understand why behavior after a merge wasn't consist=
ent.=0A=
=0A=
My hunch is that this has to do with .git/shallow and the way some of the S=
HAs are coalescing when histories intersect/are combined, but I'm not too f=
amiliar with the inner workings of shallow. I even tried running the same s=
equence of steps with various combinations of --update-shallow on the fetch=
es, but that doesn't seem to address the underlying issue of history shorte=
ning.=0A=
=0A=
I hope that's all clear. If I can give more detail, definitely let me know,=
 and I'm happy to try and explore some solutions, but I'm not certain where=
 to begin.=0A=
I'm also not sure if it's an issue on the client or server - since I was in=
itially testing with GitHub - but in my reduced example everything is local=
.=0A=
=0A=
Thanks for your time and help with this!=0A=
=0A=
-Benji=0A=
=0A=
=0A=
------ requisite bugreport answers ------=0A=
=0A=
Thank you for filling out a Git bug report!=0A=
Please answer the following questions to help us understand your issue.=0A=
=0A=
What did you do before the bug happened? (Steps to reproduce your issue)=0A=
See setup below.=0A=
In my shallow checkout, I ran:=0A=
    git log --oneline | wc -l =3D> N commits of history.=0A=
Then I ran=0A=
    git fetch --deepen=3D1 <branch>=0A=
Followed by=0A=
    git log --oneline | wc -l =3D> now just one commit.=0A=
=0A=
What did you expect to happen? (Expected behavior)=0A=
I expected to see N+1 commits of history because I deepened by 1.=0A=
=0A=
What happened instead? (Actual behavior)=0A=
I instead had just one commit of history.=0A=
=0A=
What's different between what you expected and what actually happened?=0A=
I expected not to have my local history shortened by ~N commits despite usi=
ng --deepen instead of --depth.=0A=
=0A=
Anything else you want to add:=0A=
See additional notes/steps in this email and attached script to reproduce=
=0A=
=0A=
=0A=
[System Info]=0A=
git version:=0A=
git version 2.40.1=0A=
cpu: x86_64=0A=
no commit associated with this build=0A=
sizeof-long: 8=0A=
sizeof-size_t: 8=0A=
shell-path: /bin/sh=0A=
uname: Linux 6.2.6-76060206-generic #202303130630~1681329778~22.04~d824cd4 =
SMP PREEMPT_DYNAMIC Wed A x86_64=0A=
compiler info: gnuc: 11.3=0A=
libc info: glibc: 2.35=0A=
$SHELL (typically, interactive shell): /bin/zsh=0A=
=0A=
=0A=
[Enabled Hooks]=0A=
not run from a git repository - no hooks to show=0A=
(it's irrelevant, my example starts from nothing, so no hooks)=0A=
=0A=
=0A=
------- bug-setup.sh ----- (better to to run in chunks, rather than all at =
once, but provided for convenience)=0A=
=0A=
set -x=0A=
# Setup working folder for easy cleanup=0A=
mkdir git-test && cd git-test=0A=
=0A=
# Setup sample repo=0A=
mkdir source-repo && cd source-repo=0A=
git init=0A=
git branch -m trunk=0A=
for i in {01..05}; do echo "start${i}" >> start; git add start; git commit =
-m "start${i}"; done=0A=
git branch old-checkpoint=0A=
for i in {01..10}; do echo "new${i}" >> new; git add new; git commit -m "ne=
w${i}"; done=0A=
git checkout -b feature HEAD~2=0A=
for i in {01..03}; do echo "feature${i}" >> feature; git add feature; git c=
ommit -m "feature${i}"; done=0A=
git checkout trunk=0A=
git merge --no-edit feature=0A=
cd ..=0A=
sleep 1=0A=
=0A=
=0A=
# Checkout shallow clone at feature branch - this works as desired=0A=
git clone --no-local source-repo --depth=3D1 --branch feature shallow-clone=
-feature=0A=
cd shallow-clone-feature=0A=
git remote set-branches --add origin '*'=0A=
git fetch origin --shallow-exclude=3Dold-checkpoint feature=0A=
git log --oneline origin/feature | wc -l # 11, expected=0A=
git fetch --deepen=3D1 origin feature=0A=
git log --oneline origin/feature | wc -l # 12, also as expected=0A=
cd ..=0A=
sleep 1=0A=
=0A=
=0A=
# Checkout shallow clone at merge commit - this illustrates the bug=0A=
git clone --no-local source-repo --depth=3D1 --branch trunk shallow-clone-m=
erge=0A=
cd shallow-clone-merge=0A=
git remote set-branches --add origin '*'=0A=
git fetch origin --shallow-exclude=3Dold-checkpoint feature=0A=
git log --oneline origin/feature | wc -l # 11, expected=0A=
git fetch --deepen=3D1 origin feature=0A=
git log --oneline origin/feature | wc -l # 1, unexpected=0A=
=0A=
# Wait, what? Let's try that again=0A=
git fetch origin --shallow-exclude=3Dold-checkpoint feature=0A=
git log --oneline origin/feature | wc -l # 11, still as expected=0A=
git fetch --deepen=3D1 origin feature=0A=
git log --oneline origin/feature | wc -l # 13, different this time. Unexpec=
ted.=0A=
cd ..=0A=
sleep 1=0A=
=0A=
=0A=
# What if we expand depth first?=0A=
git clone --no-local source-repo --depth=3D1 --branch trunk shallow-clone-w=
ith-depth=0A=
cd shallow-clone-with-depth=0A=
git remote set-branches --add origin '*'=0A=
git fetch --depth=3D2 origin feature=0A=
git fetch origin --shallow-exclude=3Dold-checkpoint feature=0A=
git log --oneline origin/feature | wc -l # 11, expected=0A=
git fetch --deepen=3D1 origin feature=0A=
git log --oneline origin/feature | wc -l # 1, still unexpected=0A=
cd ..=0A=
sleep 1=0A=
=0A=
=0A=
# It turns out the depth query sometimes works if I also manually include H=
EAD, but still strangely.=0A=
# If I use depth=3D2, it's fine, but if I keep depth=3D3 it's not.=0A=
git clone --no-local source-repo --depth=3D1 --branch trunk shallow-clone-w=
ith-depth=0A=
cd shallow-clone-with-depth=0A=
git remote set-branches --add origin '*'=0A=
git fetch --depth=3D3 origin HEAD feature # it works if I use or include HE=
AD, but *not* if I include old-checkpoint=0A=
git fetch origin --shallow-exclude=3Dold-checkpoint feature=0A=
git log --oneline origin/feature | wc -l # 11, expected=0A=
git fetch --deepen=3D1 origin feature=0A=
git log --oneline origin/feature | wc -l # 4, different from before, still =
wrong=0A=
cd ..=0A=
sleep 1=0A=
=0A=
# If we start with deepen, instead=0A=
git clone --no-local ./source-repo --depth=3D1 --branch trunk shallow-clone=
-deepen=0A=
cd shallow-clone-deepen=0A=
git remote set-branches --add origin '*'=0A=
git fetch --deepen=3D1 origin HEAD feature # this also works if we use feat=
ure=0A=
git fetch origin --shallow-exclude=3Dold-checkpoint feature=0A=
git log --oneline origin/feature | wc -l # 11, expected=0A=
git fetch --deepen=3D1 origin feature=0A=
git log --oneline origin/feature | wc -l # 12, that's finally correct=0A=
cd ..=0A=
sleep 1=0A=
=0A=
# manually clear everything out by running=0A=
# cd .. && rm -rf git-test=
