Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84348C12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 19:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6589B613BE
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 19:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhGNTOW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 15:14:22 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:37332 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229735AbhGNTOV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 15:14:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626289889; h=Content-Type: Content-Transfer-Encoding:
 MIME-Version: References: In-Reply-To: Message-ID: Date: Subject: Cc:
 To: From: Sender; bh=BGbG5s5p9lxVkiFtQ+6pJz7YtH/jdTkCn5Eizp8rnns=; b=BeVpBDBwIQz0flAdMrlGxOxwq2loH2c19HuwFV1QepE5RUO+gI68GQBfchezhry9oFWqq1Qu
 1q6HgaicNgpZVJy4BbAReRI46ReYPujFuTbuFN8EUahoxEUvdnzZRfIQpqdvr0f42scLNcEI
 Merhi6eImgPMtmlDKWAGZzi6iqQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyJjNzk3NCIsICJnaXRAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 60ef36dc25e56632789a8398 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 14 Jul 2021 19:11:24
 GMT
Sender: mfick=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 98CD9C4360C; Wed, 14 Jul 2021 19:11:24 +0000 (UTC)
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E3631C433F1;
        Wed, 14 Jul 2021 19:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E3631C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <ttaylorr@github.com>, Sun Chao <16657101987@163.com>,
        Taylor Blau <me@ttaylorr.com>,
        Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] packfile: freshen the mtime of packfile by configuration
Date:   Wed, 14 Jul 2021 13:11:21 -0600
Message-ID: <12435060.NHVMl2pYiE@mfick-lnx>
User-Agent: KMail/5.2.3 (Linux/4.4.0-208-generic; KDE/5.36.0; x86_64; ; )
In-Reply-To: <877dhs20x3.fsf@evledraar.gmail.com>
References: <pull.1043.git.git.1625943685565.gitgitgadget@gmail.com> <YO8XrOChAtxhpuxS@nand.local> <877dhs20x3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, July 14, 2021 8:19:15 PM MDT =C6var Arnfj=F6r=F0 Bjarmason wr=
ote:
> The best way to get backups of git repositories you know are correct are
> is to use git's own transport mechanisms, i.e. fetch/pull the data, or
> create bundles from it.=20

I don't think this is a fair recommendation since unfortunately, this canno=
t=20
be used to create a full backup. This can be used to back up the version=20
controlled data, but not the repositories meta-data, i.e. configs, reflogs,=
=20
alternate setups...

=2DMartin

=2D-=20
The Qualcomm Innovation Center, Inc. is a member of Code=20
Aurora Forum, hosted by The Linux Foundation

