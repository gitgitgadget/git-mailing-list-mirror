Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A31CC12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6137611AD
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbhGNUXd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 16:23:33 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:63379 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230341AbhGNUXc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 16:23:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626294040; h=Content-Type: Content-Transfer-Encoding:
 MIME-Version: References: In-Reply-To: Message-ID: Date: Subject: Cc:
 To: From: Sender; bh=lvzYQUZ2cujUew3GclDfSqwk09dxEEg9SmsJQLWdjJo=; b=gBshuNytepI/jLizDlW5YPEdU8Z8qp7tb5DwHNrhMcH7JmsLQ3UjWyk310/Zk7H3y3RPl4cj
 5OppiC9nMtRv7bRZ1MYdL7apcroKPnsIWoZxCOxvVGFL6QF3CrxOinx9k4kayrqaKJy/UsPB
 AZqZr0+JszY5jDgsFz3uz49Cl0A=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyJjNzk3NCIsICJnaXRAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60ef471296a66e66b2d48f27 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 14 Jul 2021 20:20:34
 GMT
Sender: mfick=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 907FEC384A2; Wed, 14 Jul 2021 20:20:34 +0000 (UTC)
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E46ADC3849E;
        Wed, 14 Jul 2021 20:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E46ADC3849E
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <ttaylorr@github.com>, Sun Chao <16657101987@163.com>,
        Taylor Blau <me@ttaylorr.com>,
        Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] packfile: freshen the mtime of packfile by configuration
Date:   Wed, 14 Jul 2021 14:20:31 -0600
Message-ID: <3112447.ymCj9SdLpg@mfick-lnx>
User-Agent: KMail/5.2.3 (Linux/4.4.0-208-generic; KDE/5.36.0; x86_64; ; )
In-Reply-To: <87v95czn7q.fsf@evledraar.gmail.com>
References: <pull.1043.git.git.1625943685565.gitgitgadget@gmail.com> <12435060.NHVMl2pYiE@mfick-lnx> <87v95czn7q.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, July 14, 2021 9:41:42 PM MDT you wrote:
> On Wed, Jul 14 2021, Martin Fick wrote:
> > On Wednesday, July 14, 2021 8:19:15 PM MDT =C6var Arnfj=F6r=F0 Bjarmaso=
n wrote:
> >> The best way to get backups of git repositories you know are correct a=
re
> >> is to use git's own transport mechanisms, i.e. fetch/pull the data, or
> >> create bundles from it.
> >=20
> > I don't think this is a fair recommendation since unfortunately, this
> > cannot be used to create a full backup. This can be used to back up the
> > version controlled data, but not the repositories meta-data, i.e.
> > configs, reflogs, alternate setups...
>=20
> *nod*
>=20
> FWIW at an ex-job I helped systems administrators who'd produced such a
> broken backup-via-rsync create a hybrid version as an interim
> solution. I.e. it would sync the objects via git transport, and do an
> rsync on a whitelist (or blacklist), so pickup config, but exclude
> objects.
>=20
> "Hybrid" because it was in a state of needing to deal with manual
> tweaking of config.
>=20
> But usually someone who's needing to thoroughly solve this backup
> problem will inevitably end up with wanting to drive everything that's
> not in the object or refstore from some external system, i.e. have
> config be generated from puppet, a database etc., ditto for alternates
> etc.
>=20
> But even if you can't get to that point (or don't want to) I'd say aim
> for the hybrid system.
>=20
> This isn't some purely theoretical concern b.t.w., the system using
> rsync like this was producing repos that wouldn't fsck all the time, and
> it wasn't such a busy site.
>=20
> I suspect (but haven't tried) that for someone who can't easily change
> their backup solution they'd get most of the benefits of git-native
> transport by having their "rsync" sync refs, then objects, not the other
> way around. Glob order dictates that most backup systems will do
> objects, then refs (which will of course, at that point, refer to
> nonexisting objects).
>=20
> It's still not safe, you'll still be subject to races, but probably a
> lot better in practice.

It would be great if git provided a command to do a reliable incremental=20
backup, maybe it could copy things in the order that you mention?

However, most people will want to use the backup system they have and not a=
=20
special git tool. Maybe git fsck should gain a switch that would rewind any=
=20
refs to an older point that is no broken (using reflogs)? That way, most=20
backups would just work and be rewound to the point at which the backup=20
started?

=2DMartin

=2D-=20
The Qualcomm Innovation Center, Inc. is a member of Code=20
Aurora Forum, hosted by The Linux Foundation


=2DMartin

=2D-=20
The Qualcomm Innovation Center, Inc. is a member of Code=20
Aurora Forum, hosted by The Linux Foundation


=2D-=20
The Qualcomm Innovation Center, Inc. is a member of Code=20
Aurora Forum, hosted by The Linux Foundation

