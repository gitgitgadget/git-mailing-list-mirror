Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B146DC001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 20:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbjHHUJL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjHHUIq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 16:08:46 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A955FDFF
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 11:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1691520055; x=1692124855; i=tboegi@web.de;
 bh=5+zFRMqEtEmk4EktTEQBAZxeTskhszrDyK8tBAzCfoc=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=aKLUXlku+G6UI/6xr/iinbXUMVq4f6KSzmjUXdOrpbp+m/ffyFpQtWZbxxHYGb6+P4msrSh
 tigsZmWjEU8qWmLHy/lqE1Kng0jZQZuAwdg655xD15RzV8CoiAzdnVk6bU95BHkemzTki+U0G
 382RtoqqAnEJzY21cEvOzvSHoNilOzDn28huIS1KsXEZytmuILvpav9CMWjkZMhkLGeec/9bX
 CvUaA+/TsF8CppC3xXD+8z1+y4TYN7JoTu3aN6/16WPFWeqMrswS+KH5jYMgToByydrLXbVYr
 v/p+oRzCjNsjQ7KWveAW8oEoLSrY4Ro/s1+kwXaseAMYQLTYyk3g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbCE0-1pwIkJ1zRI-00bU3h; Tue, 08
 Aug 2023 20:40:55 +0200
Date:   Tue, 8 Aug 2023 20:40:54 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sebastian Thiel via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Sebastian Thiel <sebastian.thiel@icloud.com>
Subject: Re: [PATCH] fix `git mv existing-dir non-existing-dir`*
Message-ID: <20230808184054.cjhiboifschkwuoz@tb-raspi4>
References: <pull.1561.git.1691506431114.gitgitgadget@gmail.com>
 <xmqqy1il77wp.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy1il77wp.fsf@gitster.g>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:81bgvblDvwcLAyQiyVB0rJddGE2oBD9fjSI4VngTVribSZIanM2
 yzEjTFBj8L6WLNEBwwHCaMuNE0yFU0VhWPm01y0B6piAIFyauacIx0VJkpHOgbjfDriy35D
 qYn7coJanB/jT1PtZeCSf83Xby2Kz1hOUq2Y3Ft3P1ARcgGo2jBVlX7zjYO+w8r6WTvhjtA
 FHet2Nk6vKdvQKEZJA5IA==
UI-OutboundReport: notjunk:1;M01:P0:l0GpdjmOMuM=;sIlOPAX1zcJ1JY2hReFQZXyAECg
 XpcCXKwtmpi+bn0ZuhCGcR50A6+IRle3ME5+VSDETmdl5vvrTidYa6+ZkaOHyuRGhGpbVn77L
 laV/2bgqwTRHIn4pYnzkFSq06jnxloale2qTVJusHe0fU3nZepXQXFWZ0/g95ZqzVQvvdG1j0
 b2PCR3aKtfoT1RIVcTxIsskcq+/gDzWx1EA57qu2OFq42cmIGfGMUx90mTu2E9Dnwt+S/8Gep
 YEJAtv/+AosE+oGuhHF46DCkEy/kP/l3sbKLlybDvSHp59/sXbOoSve3BKqR7Bqx6VS1QvJcz
 5RoaH1wZdRhHiqVbbVK1/prll5SVBb9dh+8syRQLNcHTokPi+i48TDlmKE7plVm/hoEZDNJE8
 HnkwCPw0rs/mx/SND966SwSwA/+ij3JH+fSBMllIp6yO2CqX+SN24YQ4l7vypdJsce5QANBWX
 5q6MU8LP7yYS5GCoJNGymoabHfthUmGzQC5fRyahC//MJpGKq24kLwKv8JQskUTO6lc8ADNBe
 1Ivb/zpFIt7+jGkGeMX/eCptlYe1BEg/P+qX9Psx58dMyzJGrPcDqE2NhEwCX+J/SI70mOUf8
 NLVjAC49hu/Tpm5LS6jVwWDhQpFXbPBuytnXwBPXdF67o2mB2ap8e2KJSGpIp4XVMmOYBJzUJ
 RaoBByw/6YHrs6tN2bRwUlNt1KJSwIktWoPcYVb+9HEEc0PD0djl+GD6S3p8oQeb6v0ipRVLS
 V8BNtmVGD5wWjln/U25A6RyNjtR5AIngLS9FtG77ZmOrWbp2tHmPOGcTNfhBXOM84lCpWPxHt
 WBgXSZa/2Xy02OIn7HthVoR5Cg60McviLL169pMSFqI3SL1kgFxpWV/D25OpEwRFZEkc1h7g5
 pw/sILk+IHQuwrQN949zAiVm4hwH6Yz3FKcR20YRTWxyUTWtngDCfh4yf4xu6n7dODBAgI+98
 dx3qog==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2023 at 10:36:54AM -0700, Junio C Hamano wrote:
> "Sebastian Thiel via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Sebastian Thiel <sebastian.thiel@icloud.com>
> >

The patch makes sense to me, Junio's comments included.

> Shouldn't it do something similar to
>
>     $ mv D1 D2

Couldn't resist to test it ;-)

The result would be
 renamed: D1/file1 -> D2/D1/file1


