Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BECFC3526C
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D765F23A79
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbgLHUQL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 15:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731109AbgLHUNV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 15:13:21 -0500
Received: from mail-oo1-xc4a.google.com (mail-oo1-xc4a.google.com [IPv6:2607:f8b0:4864:20::c4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55717C0613D6
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 12:12:32 -0800 (PST)
Received: by mail-oo1-xc4a.google.com with SMTP id o65so1638419ooo.8
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 12:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc:content-transfer-encoding;
        bh=zDyFMfok8W8nSsvfJ2PtBMwfPeD4xqOTr7P4gSlhp2I=;
        b=dT3f9BzHsXNx29ftD7FVp8MhZqA/K6ykE5XzpSMJf8gDts7P8Xk2a+1NadNiKV8E09
         ZYuNi9SvgoiDe9vpt4r/jzq62V1wyN3991F7md8SoJdXrPjcg++hWxb1Ck4Ev2sukfO4
         +xbr4oco/3mN+92eflCT1JNEpBLAWmcrBa8pjsUav3OCtMJMDaddWD3dcUXoPLZsRlSP
         rv5aN9pDbYpdKlIPczI95xapeoQAUkPQEDC1IGHKYlFpmp3AA8YhSdWAB3U8aPp/7/Z1
         vhfcfVh/uIBDUyTeWRAChtjGL74r1lw55wneZk1AQE1LJYyLARs/QoPx5ffaI10Hm+xs
         S4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=zDyFMfok8W8nSsvfJ2PtBMwfPeD4xqOTr7P4gSlhp2I=;
        b=Peak9LtyZGBevvyNpzbm0dn3LxksbMWUQuCQP18wUO5TPpCSTyFC18sRbCNcO+6Vgs
         NPlGOxwFcB0L1r9q1tgK3fMqY7+gIos6c1mjoF4322Yu2BwgNbVVMvCMIBqDbrYDKoAC
         1FTXxtr0ni4L2mnARcKCHG6j47K+pjS6/r2+n5DGfMf+/Crv57q8OIHwUZjy/NfrXWxf
         bu4y43L+whhOxPgMWC1SXCmillLGw4qbg59rqORHCWjJIudlYC5OmkYzQA+GayzmhI2h
         9m697PzM5r3bEP6Se3K+dMBKlbmndHwE/vh816dDVlSS7zw/F3BpEoOwWN88KwNb/kmy
         EOKg==
X-Gm-Message-State: AOAM533BVxqACe5Wl6n0j03SSaApqgARkrAn2AZf7jTlCuz2wFZNAuVk
        TJ8P0OxytiTwi62G+8ZGfFucqSHfL/vJaeuN6vLw
X-Google-Smtp-Source: ABdhPJwbvVzVkffilQkK153MKE/eLhyPRZvuhFV4U1lJc8IJNPJHqtJO/lnoiuEtUS32jaP4jTXHhau3Sih5asNe30LV
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:f30a:: with SMTP id
 c10mr4451380ybs.514.1607453743219; Tue, 08 Dec 2020 10:55:43 -0800 (PST)
Date:   Tue,  8 Dec 2020 10:55:38 -0800
In-Reply-To: <xmqq7dpt82l4.fsf@gitster.c.googlers.com>
Message-Id: <20201208185538.973044-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq7dpt82l4.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: Re: Cloning empty repository uses locally configured default branch name
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
>=20
> > Has anyone looked into solutions for this? Both protocol v0 and v2 do
> > not send symref information about unborn branches (v0 because, as
> > protocol-capabilities.txt says, "servers SHOULD include this capability
> > for the HEAD symref if it is one of the refs being sent"; v2 because
> > a symref is included only if it refers to one of the refs being sent).
> > In protocol v2, this could be done by adding a capability to ls-remote
> > (maybe, "unborn"), and in protocol v0, this could be done either by
> > updating the existing "symref" capability to be written even when the
> > target branch is unborn (which is potentially backwards incompatible) o=
r
> > introducing a new capability which is like "symref".
>=20
> Thanks for looking into this (I think this came up again today
> during my reviews of some topic).
>=20
> It would be a backward incompatible change to add to v0, but at this
> point shouldn't we be leaving v0 as-is and move everybody to v2?

That makes sense.

> If it is a simple and safe enough change, though, saying "why not"
> is very tempting, though.

I'll look into how simple and safe it is.

> > A small issue is that upload-pack protocol v0 doesn't even write the
> > blank ref line ("000...000 capabilities^{}") if HEAD points to an unbor=
n
> > branch, but that can be fixed as in the patch below.
>=20
> I think the codepaths we have today in process_capabilities() and
> process_dummy_ref() (both in connect.c) would do the right thing
> when it sees a blank ref line even when nothing gets transported,
> but I smell that the rewrite of this state machine is fairly recent
> (say in the past few years) and I do not offhand know if clients
> before the rewrite of the state machine (say in v2.18.0) would be OK
> with the change.  It should be easy to check, though.

Yes - I backported my patch to v2.17.0 and it works:

  $ GIT_TRACE_PACKET=3D1 ~/git/bin-wrappers/git ls-remote "file://$(pwd)/em=
pty"
  10:49:33.474111 pkt-line.c:80           packet:  upload-pack> 00000000000=
00000000000000000000000000000 capabilities^{}\0multi_ack thin-pack side-ban=
d side-band-64k ofs-delta shallow deepen-since deepen-not deepen-relative n=
o-progress include-tag multi_ack_detailed agent=3Dgit/2.17.0.dirty
  10:49:33.474182 pkt-line.c:80           packet:  upload-pack> 0000
  10:49:33.474243 pkt-line.c:80           packet:          git< 00000000000=
00000000000000000000000000000 capabilities^{}\0multi_ack thin-pack side-ban=
d side-band-64k ofs-delta shallow deepen-since deepen-not deepen-relative n=
o-progress include-tag multi_ack_detailed agent=3Dgit/2.17.0.dirty
  10:49:33.474315 pkt-line.c:80           packet:          git< 0000
  10:49:33.474320 pkt-line.c:80           packet:          git> 0000
  10:49:33.474358 pkt-line.c:80           packet:  upload-pack< 0000
