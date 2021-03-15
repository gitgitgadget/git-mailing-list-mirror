Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F396C41620
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 16:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E65D364EE9
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 16:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbhCOQBQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 12:01:16 -0400
Received: from mxo2.dft.dmz.twosigma.com ([208.77.212.182]:52059 "EHLO
        mxo2.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbhCOQAu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 12:00:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTP id 4Dzh3N5X09z8sfc;
        Mon, 15 Mar 2021 16:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=twosigma.com;
        s=202008; t=1615824048;
        bh=AXSl4asU6KDfEL8WTAqCv3guly0aiKSFCUp9ZbV3vvo=;
        h=From:To:CC:Subject:Date:References:From;
        b=WcegfuznmstOZJFQzqXCB8TnjJdvPY7weZh7ppCdWe6xt62z1OsxhfbZCSH7GxyEq
         FfmMbYxJtqWBgfwju92ePmuRdzPu3wzPyIrzz2oKF02NWIO7FMI5nPwdFUuRcHjMRf
         PltAT3ZvR1w/oArskY2SaBFo/jrWdZ9hAy7fAAsRjo1Q+oxzl1Md/Ja7z63XKCVU6c
         5yUaQGqagFFOkJBcguKVLDjhh6bCsCmoRNO8zBzyoinyOnqLSeY9l4021UFgZi4aYB
         mgIEWK2CPNcdiiLtoC1WmO8HN90dQ3+7Oy8lU/o3MLQX8RACgw4Z2Dj+gq2AMRKQRT
         NhLpIXJmiCVDg==
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rXBR8lCvyH37; Mon, 15 Mar 2021 16:00:48 +0000 (UTC)
Received: from exmbdft8.ad.twosigma.com (exmbdft8.ad.twosigma.com [172.22.2.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTPS id 4Dzh3N4z4Gz8scy;
        Mon, 15 Mar 2021 16:00:48 +0000 (UTC)
Received: from EXMBDFT11.ad.twosigma.com (172.23.162.14) by
 exmbdft8.ad.twosigma.com (172.22.2.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 15 Mar 2021 16:00:48 +0000
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 EXMBDFT11.ad.twosigma.com (172.23.162.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 15 Mar 2021 16:00:48 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1497.012; Mon, 15 Mar 2021 16:00:48 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
CC:     Git Mailing List <git@vger.kernel.org>
Subject: Re: slow object packing during push
Thread-Topic: slow object packing during push
Thread-Index: AdcVJlVNhy4BoRPbT22BeCkXYnHixw==
Date:   Mon, 15 Mar 2021 16:00:48 +0000
Message-ID: <d23fa1d9c0a24241a1b9fe33744cf7eb@exmbdft7.ad.twosigma.com>
References: <38b99459158a45b1bea09037f3dd092d@exmbdft7.ad.twosigma.com>
 <87eegohvwi.fsf@evledraar.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.23.160.43]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/9/21 9:14 PM, =C6var Arnfj=F6r=F0 Bjarmason wrote:=0A=
> On Tue, Mar 09 2021, David Turner wrote:=0A=
>=0A=
>> I have a large, funny repository that has very slow pushes unless I=0A=
>> set pack.usebitmaps=3Dfalse to false.=0A=
> Good to see you on-list again! :)=0A=
=0A=
Thanks!=0A=
=0A=
>> First, a description of the repo: it's about 175GB, and was created by c=
ombining about 40,000 smaller repositories.  Historically, these repos were=
 submodules of one meta repository[2].  I have stitched together the submod=
ules, and this is the repository in which the stitching was done - that is,=
 it contains all of the objects from the smaller repos, plus all of the obj=
ects from the meta repository, plus the newly-created trees & commits for t=
he stitched repositories.  As new commits come into the meta repository (wh=
ich have gitlinks to new submodule commits), we fetch from the meta reposit=
ory (8s - it would be 2s if we were fetching into a normal clone without al=
l of the other stuff), and the submodules (up to 10s per and embarrassingly=
 parallel). Then we stitch (~0s), and push to the stitched "unity" reposito=
ry (~2 minutes!!!).  The entire repo fits in RAM (yes, all 175G) and is in =
fact in the disk cache (I prewarmed the cache before testing anything).  =
=0A=
>>=0A=
>> The vast majority of the time appears to be spent in git pack-objects, a=
nd in particular in the stack trace in [1].  If I set pack.usebitmaps=3Dfal=
se, the push only takes 10s.   This seems like pack bitmaps are a severe pe=
ssimization for my purposes.  This is true even immediately after a repack =
(that is, almost all of the objects are in one giant pack, except the newly=
-fetched ones).  I also tried setting up pack islands - one for each smalle=
r repo, one for the stitched commits, and one for commits from the meta rep=
o.  I'm not sure if this is necessary, but it's definitely not sufficient (=
my current config has it turned on, because I didn't feel like repacking ag=
ain after testing it, and I tested it before testing pack.usebimaps). =0A=
>> [snip]=0A=
> Without having carefully re-read it, I believe this issue is the same as=
=0A=
> what I reported here in 2019, and I think you'll find the resulting=0A=
> discussion intresting:=0A=
> https://lore.kernel.org/git/87zhoz8b9o.fsf@evledraar.gmail.com/=0A=
>=0A=
> Having skimmed it, I think you're probably omitting that this is a bare=
=0A=
> repo you're pushing from, and thus you're running into the combination=0A=
> of repack.writeBitmaps being true by default on bare repos, and=0A=
> pack.useBitmaps being true everywhere (but having no effect by default=0A=
> unless you have a bare repo, unless you manually make bitmaps blah=0A=
> blah).=0A=
>=0A=
> One of the semi-conclusions from the above thread was that we mostly=0A=
> turned this on thinking that bare ~=3D server that accepts pushes, and=0A=
> bitmaps are known to be worse (but not always!) for when you're pushing=
=0A=
> *from* your repo.=0A=
=0A=
Thanks, that does explain it.  We should probably consider a default=0A=
that bitmaps aren't used on pushes.=0A=
=0A=
