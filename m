Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43983C63697
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0027020719
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4flhKlV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbgKWTno (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 14:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729521AbgKWTnn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 14:43:43 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD68C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 11:43:43 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id 64so6412377wra.11
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 11:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ooyt5UeXv4n7FY/z7++9prBcThQVRntnqCzM49J2X1E=;
        b=h4flhKlV79mGNCmZLpUmpDRTOtcs1VAjiAHQBb2JI39apc0J9VQXP2Ko/JJr12cM7F
         idRu1Iy3F0LupIxNfdZgWXzwWZfp1Edd0XgDcc9+Htt1gCji1ihV33XGZbqO1j1L3RQO
         xmy5vxNnj+jovPNEYReUp2r49LBip3wm1nuS5exBu+VNxyy0i++nSeny8jSfFy15YCfv
         1qzdNL506g7pmC+FOTl7DqK1MfVilqFw+XT+BSU5qYHJ+RJWmkl4dHMk1dbEDNOp74pn
         6kXQwbznJuPoQGDnniIl0pYQCiTK5lmLAqCz1/YEls7jJdIbC8CJ0O1PUHTApwZkoshY
         oWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ooyt5UeXv4n7FY/z7++9prBcThQVRntnqCzM49J2X1E=;
        b=RjTrBe6ZY+Os7l+Mmetp5bXkKiWJ8vaSIz06ywXkV/ZghRfgU+xCGFQYxATFHqhH4/
         H0gyopcd6QVR5V7JgzDzdMclpxBpzq7nnKhzfYjtRQAAv6Svp+XVnMiehMhmSkmB7OOU
         lzZDJ8aVKeMG4PdcrlJo1yLNyCuKZoJyAl5fGpIfzBGFCRhOGH82nTLNXgouUvw3YXXi
         OVG3hk3KnuHt/wuEFf2pHe9si1q/Q0NbpgAVdtBmiazCEKkX8YfuWDLpCHJ17ja1YcmF
         /RJPBT0AXbzkfc29juLFc5+7NioPWaS9ENRgPiufDUyuBkQXvo4yS/LCI5grXYqM/txh
         83PA==
X-Gm-Message-State: AOAM533qK/syN2khtpZ5E1VUlSMKHN3FJ24dQp0ygUmN03xE1TZxvKyj
        7vJSvxag+NWh8AhuRDuYNYR/yxpLh1EeTYGq/L0=
X-Google-Smtp-Source: ABdhPJxuHvtU8/C9sDrpMxRfSggeBqWnLEIshwvd34Y26N/DgnWRBhzscp3wEk26MBTjqFw11QasoxL962J/klI7iw4=
X-Received: by 2002:a5d:474f:: with SMTP id o15mr1344282wrs.100.1606160621965;
 Mon, 23 Nov 2020 11:43:41 -0800 (PST)
MIME-Version: 1.0
References: <742df4c2-2bc5-8a4b-8de1-cd5e48718398@redhat.com>
In-Reply-To: <742df4c2-2bc5-8a4b-8de1-cd5e48718398@redhat.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 23 Nov 2020 13:43:31 -0600
Message-ID: <CAMP44s2rhOXfqmyd-rUUmzjsbqq9juf1HNsd32aO-Qcd-m0QNw@mail.gmail.com>
Subject: Re: Pick the right default and stop warn on `git pull`
To:     =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 9:17 AM V=C3=ADt Ondruch <vondruch@redhat.com> wrot=
e:

> While I understand that the merge after `git pull` is probably not the
> best strategy (as explained in [1]), asking people to change their
> configuration to choose their default strategy with every `git pull` is
> not any better. Please select any strategy considered more appropriate
> and stop warning me. I know I could change my configuration, but I'll
> change it just if I want to differ from defaults. I don't need to be
> told that I am using wrong default. I'd like to keep my trust in Git
> upstream, but this is was not trustworthy decision IMO.

Indeed.

This is why I sent patches to change the "git pull" default to merge
the remote branch, but only if it's a fast-forward. If it's not, then
the user would have to either merge, or rebase.

https://lore.kernel.org/git/1398988808-29678-1-git-send-email-felipe.contre=
ras@gmail.com/

This is the best sensible default.

Cheers.

--=20
Felipe Contreras
